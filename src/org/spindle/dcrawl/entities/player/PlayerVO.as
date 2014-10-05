package org.spindle.dcrawl.entities.player {
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.graphics.Spritemap;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.EntitiesConstants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.pickable.WarriorType;
import org.spindle.dcrawl.items.pickable.upgrades.WeaponUpgrade;
import org.spindle.dcrawl.items.types.Pickable;
import org.spindle.dcrawl.items.types.Triggerable;
import org.spindle.dcrawl.items.types.Upgradable;
import org.spindle.dcrawl.items.types.Upgrade;
import org.spindle.dcrawl.items.types.WarClass;
import org.spindle.dcrawl.items.types.Weapon;
import org.spindle.dcrawl.items.weapons.RangeWeapon;
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

    public function Player(px:uint, py:uint) {
        x = px * Constants.TILE_SIZE;
        y = py * Constants.TILE_SIZE;

        graphic = body;
        layer = Constants.LAYER_ENTITIES;
        type = EntitiesConstants.PLAYER;
        setHitbox(8, 8);

        //addGraphic(new Burn().spritemap);
        addGraphic(new Enchant().spritemap);

    }

    override public function update():void {
        var nx:int = x;
        var ny:int = y;
        var moved:Boolean = false;
		var classicMovement:Boolean = false;

		if (Input.check(Key.LEFT) || Input.check(Key.RIGHT) || Input.check(Key.UP) || Input.check(Key.DOWN) || Input.check(Key.SPACE))
			classicMovement = true;
		else if (Input.check(Key.A) || Input.check(Key.W) || Input.check(Key.S) || Input.check(Key.D) || Input.mouseDown)
			classicMovement = false;
			
		if (Input.check(Key.LEFT) || Input.check(Key.A)){
            nx -= 1;
			if (classicMovement)
				updatePlayerDir("goingLeft", Constants.WEST)	
        }
        if (Input.check(Key.RIGHT) || Input.check(Key.D)){
            nx += 1;
			if (classicMovement)
				updatePlayerDir("goingRight", Constants.EAST)	
        }
        if (Input.check(Key.UP) || Input.check(Key.W)){
            ny -= 1;
			if (classicMovement)
				updatePlayerDir("goingUp", Constants.NORTH)	
        }
        if (Input.check(Key.DOWN) || Input.check(Key.S)){
            ny += 1;
			if (classicMovement)
				updatePlayerDir("goingDown", Constants.SOUTH)	
        }
		
		if (!classicMovement)
		{
			var xPos:Number = x - world.mouseX;
			var yPos:Number = y - world.mouseY;
			if (xPos > 0){		
				if (Math.abs(yPos) > Math.abs(xPos)){
					if (yPos > 0) 
						updatePlayerDir("goingUp", Constants.NORTH)				
					else 
						updatePlayerDir("goingDown", Constants.SOUTH)
				}	
				else{
					updatePlayerDir("goingLeft", Constants.WEST)
				}
			}
			else {
				if (Math.abs(yPos) > Math.abs(xPos)){
					if (yPos > 0) 
						updatePlayerDir("goingUp", Constants.NORTH)				
					else 
						updatePlayerDir("goingRight", Constants.SOUTH)				
				}	
				else{
					updatePlayerDir("goingRight", Constants.EAST)
				}
			}
		}

        if ((Input.check(Key.SPACE) || Input.mouseDown) && weapon && fireRate == 0) {
			fireWeapon();
        }		

        var item:SpritedItem;
        if (nx==x && ny==y) {
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

        pmx = x - nx;
        pmy = y - ny;

        var collideObj:Entity = collide("solid", nx, ny);


        if (collideObj) {
            if (collideObj is Triggerable) {
                Triggerable(collideObj).trigger(this);
            }
        }
		
		var collBullet:Bullet = Bullet(collide("bullet", x, y))
		if (collBullet && collBullet.origin is Enemy){			
			vo.health -= collBullet.damage						
			vo = collBullet.appplyEffect(vo)	
			if(!collBullet.solidBullet)
				collBullet.destroy();
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

        var enemy:Entity = collide("enemy", x, y);
        if (enemy) {
            health -= Enemy(enemy).damage;

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
        }

        if (isInvulnerable && invTimer-- < 0) {
            isInvulnerable = false;
            body.alpha = 1;
        }

        if (moved) {
            if (x > FP.screen.width / FP.screen.scale / 2.5) {
                FP.camera.x = x - FP.screen.width / FP.screen.scale / 2.5;
            }

            if (y > FP.screen.height / FP.screen.scale / 2.5) {
                FP.camera.y = y - FP.screen.height / FP.screen.scale / 2.5;
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

    public function getTile(row:uint, col:uint):uint {
        if (row < 0 || col < 0) {
            throw new Error("Tile count starts at 1");
        }
        return (row - 1) * 640 / Constants.TILE_SIZE + (col - 1);
    }

	private function fireWeapon():void
	{
		fireRate = Weapon(weapon).maxFireRate;
        Weapon(weapon).fire(this.x, this.y, actualDir);	
	}	
	
    private function removeItem(itemToRemove:SpritedItem, throwOnTheGround:Boolean = true) {
        SpritedItem(weapon).spritemap.play("toBePicked");
        items.splice(items.indexOf(weapon), 1);
        this.graphic = body;
        for each (var item:SpritedItem in items) {
            addGraphic(item.spritemap);
        }

        if (throwOnTheGround) {
            itemToRemove.roundPositionOnTile(x + (8 * (Math.random() > 0.5 ? -1 : 1)), y + (8 * (Math.random() > 0.5 ? -1 : 1)));
            world.add(itemToRemove);
            trace(itemToRemove.x + " " + itemToRemove.y);
        }
    }
	
	private function updatePlayerDir(anim:String, dir:int):void
	{
		if (dir != lastDir)
		{
			currentAnim = anim;
			actualDir = dir;
			
			var item:SpritedItem;       
            body.play(currentAnim + "S");
            for each (item in items)
                item.spritemap.play(currentAnim + "S");      
		
			lastDir = dir;
		}
	}
}
}
