package org.spindle.dcrawl.entities.player {
import flash.events.Event;

import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Spritemap;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.EntitiesConstants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.entities.enemies.Enemy;
import org.spindle.dcrawl.items.pickable.WarriorType;
import org.spindle.dcrawl.items.pickable.upgrades.WeaponUpgrade;
import org.spindle.dcrawl.items.types.Pickable;
import org.spindle.dcrawl.items.types.Triggerable;
import org.spindle.dcrawl.items.types.Upgradable;
import org.spindle.dcrawl.items.types.Upgrade;
import org.spindle.dcrawl.items.types.WarClass;
import org.spindle.dcrawl.items.types.Weapon;
import org.spindle.dcrawl.items.weapons.FlamingBow;
import org.spindle.dcrawl.items.weapons.RangeWeapon;
import org.spindle.dcrawl.items.weapons.bullets.Bullet;
import org.spindle.dcrawl.items.weapons.effects.Enchant;
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
 * @author cornel
 */
public class Player extends Entity {
    public var pmx:int = 0;
    public var pmy:int = 0;
    private var body:Spritemap = BodyGraphicHelper.buildBody(2, 2);
    private var items:Array = [];
    private var currentAnim:String = "goingRight";
    private var weapon:SpritedItem;
    private var warriorClass:SpritedItem;
    private var actualDir:int = 0;
    private var fireRate:int = 0;
    private var health:Number = 10;
    private var isInvulnerable:Boolean;
    private var invTimer:int;
    private var lastDir:int = 0;
    private var speed:Number = 1;
    private var overHeadText:String;
    private var shootFrame:Number = 0;

    public function Player(px:uint, py:uint) {
        x = px * Constants.TILE_SIZE;
        y = py * Constants.TILE_SIZE;

        name = "player"

        graphic = body;
        layer = Constants.LAYER_ENTITIES;
        type = EntitiesConstants.PLAYER;
        setHitbox(8, 8);

        //var defaultWeapon:RangeWeapon = new MagicFireAttack();
        var defaultWeapon:RangeWeapon = new FlamingBow();

        var up:WeaponUpgrade = new WeaponUpgrade(0);
        up.speedUp = 10;
        up.rateUp = 2;
        defaultWeapon.upgrade(up);

        weapon = defaultWeapon;
        RangeWeapon(weapon).origin = this;
        addGraphic(weapon.spritemap);
        items.push(weapon);


        //addGraphic(new Burn().spritemap);
        addGraphic(new Enchant().spritemap);

    }

    override public function update():void {
        var nx:Number = x;
        var ny:Number = y;
        var moved:Boolean = false;
        var classicMovement:Boolean = false;

        if (Input.check(Key.B)) {
            FP.engine.dispatchEvent(new Event("regenerateWorld"));
        }

        if (Input.check(Key.LEFT) || Input.check(Key.RIGHT) || Input.check(Key.UP) || Input.check(Key.DOWN) || Input.check(Key.SPACE))
            classicMovement = true;
        else if (Input.check(Key.A) || Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.D) || Input.mouseDown)
            classicMovement = false;

        if (Input.check(Key.LEFT) || Input.check(Key.A)) {
            nx -= speed;
            if (classicMovement)
                updatePlayerDir("goingLeft", Constants.WEST)
        }
        if (Input.check(Key.RIGHT) || Input.check(Key.D)) {
            nx += speed;
            if (classicMovement)
                updatePlayerDir("goingRight", Constants.EAST)
        }
        if (Input.check(Key.UP) || Input.check(Key.W)) {
            ny -= speed;
            if (classicMovement)
                updatePlayerDir("goingUp", Constants.NORTH)
        }
        if (Input.check(Key.DOWN) || Input.check(Key.S)) {
            ny += speed;
            if (classicMovement)
                updatePlayerDir("goingDown", Constants.SOUTH)
        }

        if (!classicMovement) {
            var xPos:Number = x - world.mouseX;
            var yPos:Number = y - world.mouseY;
            if (xPos > 0) {
                if (Math.abs(yPos) > Math.abs(xPos)) {
                    if (yPos > 0)
                        updatePlayerDir("goingUp", Constants.NORTH)
                    else
                        updatePlayerDir("goingDown", Constants.SOUTH)
                }
                else {
                    updatePlayerDir("goingLeft", Constants.WEST)
                }
            }
            else {
                if (Math.abs(yPos) > Math.abs(xPos)) {
                    if (yPos > 0)
                        updatePlayerDir("goingUp", Constants.NORTH)
                    else
                        updatePlayerDir("goingRight", Constants.SOUTH)
                }
                else {
                    updatePlayerDir("goingRight", Constants.EAST)
                }
            }
        }

        if ((Input.check(Key.SPACE) || Input.mouseDown) && weapon && fireRate == 0) {
            fireWeapon();
        }

        var item:SpritedItem;


        if (shootFrame == 0) {
            if (nx == x && ny == y) {
                body.play(currentAnim + "S");
                for each (item in items)
                    item.spritemap.play(currentAnim + "S");
            } else {
                body.play(currentAnim);
                if (warriorClass)
                    WarriorType(warriorClass).spritemap.play(currentAnim);

                for each (item in items)
                    item.spritemap.play(currentAnim);
            }
        } else {
            shootFrame--;
        }

        pmx = x - nx;
        pmy = y - ny;

        var collideObj:Entity = collide("solid", nx, ny);


        if (collideObj) {
            if (collideObj is Triggerable) {
                Triggerable(collideObj).trigger(this);
            }
        }

        collideObj = collide("pickable", nx, ny);
        if (collideObj) {
            var allowPick:Boolean = true;
            if (collideObj is WarClass) {
                if (!warriorClass) {
                    warriorClass = WarriorType(collideObj);
                    addGraphic(warriorClass.graphic);
                    items.push(warriorClass);
                }
            } else if (collideObj is Weapon) {
                if (weapon) {
                    removeItem(weapon);
                }

                weapon = SpritedItem(collideObj);
                RangeWeapon(weapon).origin = this;
                addGraphic(weapon.spritemap);
                items.push(weapon);
                world.remove(weapon);
            } else if (collideObj is Upgrade) {
                switch (Upgrade(collideObj).upgradeElement()) {
                    case Constants.WEAPON_ITEM :
                        if (weapon == null) {
                            allowPick = false;
                        } else {
                            Upgradable(weapon).upgrade(WeaponUpgrade(collideObj));
                            triggerText(WeaponUpgrade(collideObj).upgradeName)
                        }
                        break;
                }
            }

            if (collideObj is Pickable && allowPick) {
                world.remove(collideObj);
            }
        }

        var oldX:int = x;
        var oldY:int = y;
        if (!collide("solid", nx, ny)) {
            x = nx;
            y = ny;
            moved = true;
        } else if (!collide("solid", x, ny)) {
            y = ny;
            moved = true;
        } else if (!collide("solid", nx, y)) {
            x = nx;
            moved = true;
        }

        var collBullet:Bullet = Bullet(collide("bullet", x, y));
        var enemy:Entity = collide("enemy", x, y);
        if (enemy || (collBullet && collBullet.origin is Enemy)) {

            if (enemy)
                health -= Enemy(enemy).damage;
            else
                health -= Enemy(collBullet.origin).damage;

            if (!isInvulnerable) {
                x = oldX;
                y = oldY;
                isInvulnerable = true;
                invTimer = 20;

                if (body.alpha == .5)
                    body.alpha = 1
                else
                    body.alpha = .5;
            }

            if (collBullet)
                world.remove(collBullet)
        }

        if (isInvulnerable && invTimer-- < 0) {
            isInvulnerable = false;
            body.alpha = 1;
        }

        if (moved) {
            if (x > FP.screen.width / FP.screen.scale) {
                FP.camera.x = x - FP.screen.width / FP.screen.scale;
            }

            if (y > FP.screen.height / FP.screen.scale) {
                FP.camera.y = y - FP.screen.height / FP.screen.scale;
            }
        }

        if (weapon) {
            if (actualDir == Constants.WEST) {
                weapon.x = x - Constants.TILE_SIZE + 2;
            } else if (actualDir == Constants.EAST) {
                weapon.x = x + Constants.TILE_SIZE - 2;
            } else {
                weapon.x = x;
            }
            weapon.y = y;
        }

        if (fireRate > 0)
            fireRate--;
    }

    public function triggerText(str:String):void {
        overHeadText = str;
    }

    public function getTile(row:uint, col:uint):uint {
        if (row < 0 || col < 0) {
            throw new Error("Tile count starts at 1");
        }
        return (row - 1) * 640 / Constants.TILE_SIZE + (col - 1);
    }

    private function fireWeapon():void {
        fireRate = Weapon(weapon).maxFireRate;
        Weapon(weapon).fire(this.x, this.y, actualDir);
        updatePlayerDir(currentAnim, actualDir, true);
    }

    private function removeItem(itemToRemove:SpritedItem, throwOnTheGround:Boolean = true):void {
        SpritedItem(weapon).spritemap.play("toBePicked");
        items.splice(items.indexOf(weapon), 1);
        this.graphic = body;
        for each (var item:SpritedItem in items) {
            addGraphic(item.spritemap);
        }

        if (throwOnTheGround) {
            itemToRemove.roundPositionOnTile(x + (8 * (FP.random > 0.5 ? -1 : 1)), y + (8 * (FP.random > 0.5 ? -1 : 1)));
            world.add(itemToRemove);
        }
    }

    private function updatePlayerDir(anim:String, dir:int, shoot:Boolean = false):void {
        if (dir != lastDir || shoot) {
            currentAnim = anim;
            actualDir = dir;

            var item:SpritedItem;
            if (shoot) {
                shootFrame = 15;
            }
            body.play(currentAnim + (shoot ? "Shoot" : "S"));
            for each (item in items)
                item.spritemap.play(currentAnim + (shoot ? "Shoot" : "S"));

            lastDir = dir;
        }
    }
}
}
