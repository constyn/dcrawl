package org.spindle.dcrawl.entities.enemies {
import net.flashpunk.FP;
import net.flashpunk.graphics.Spritemap;
import org.spindle.dcrawl.entities.behavior.Flying;
import org.spindle.dcrawl.entities.behavior.IBehavior;
import org.spindle.dcrawl.entities.behavior.Moving;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.entities.player.Player;
import org.spindle.dcrawl.items.types.Triggerable;
import org.spindle.dcrawl.items.weapons.RangeWeapon;
import org.spindle.dcrawl.items.weapons.bullets.Bullet;
import org.spindle.dcrawl.items.weapons.bullets.Explosion;

/**
 * @author cornel
 */
public class Enemy extends SpritedItem {

    public var vo:EnemyVO;

    protected var LAG:uint = 3;
    protected var switchDirectionCountdown:uint = 1;
    protected var body:Spritemap;
    protected var health:Number;
    protected var weapon:RangeWeapon;
	protected var behavior:IBehavior;

    private var shootAnim:Number = 0;

    private var _triggerOnKill:Triggerable;

    public function Enemy(px:uint, py:uint) {
        x = px * Constants.TILE_SIZE;
        y = py * Constants.TILE_SIZE;

        type = "enemy";

        vo = new EnemyVO();
		
		behavior = new Flying(this, vo);
    }

    override public function update():void {	
		behavior.move();

        var collBullet:Bullet = Bullet(collide("bullet", x, y))
        if (collBullet && collBullet.origin is Player) {
            vo.health -= collBullet.damage
            vo = collBullet.appplyEffect(vo)
            if (!collBullet.solidBullet)
                collBullet.destroy();
        }
        else if (collBullet is Explosion) {
            removeMe();
        }

        vo.applyEffects(this);
        if (vo.effectArray.length == 0) {
            body.color = 0x000000
            body.tinting = 0;
        }
        else {
            body.color = vo.tint
            body.tinting = vo.tintAlpha
        }

        if (vo.health <= 0) {
            if (_triggerOnKill) {
                trace("Triggering", _triggerOnKill);
                _triggerOnKill.trigger(this);
                _triggerOnKill = null;
            }
            world.remove(this);
        }
    }

    public function updateDirection():void {
        var currentAnim:String = "";
        switch (vo.direction) {
            case 0:
                currentAnim = "goingRight"
                break;
            case 1:
                currentAnim = "goingLeft"
                break;
            case 2:
                currentAnim = "goingDown"
                break;
            case 3:
                currentAnim = "goingUp"
                break;
        }

        if (shootAnim == 0) {
            body.play(currentAnim);
            if (weapon) {
                weapon.spritemap.play(currentAnim + 'Shoot');
            }
        } else {
            shootAnim--;
            body.play(currentAnim + 'Shoot');
            weapon.spritemap.play(currentAnim);
        }

        if (weapon) {
            RangeWeapon(weapon).origin = this;
            weapon.spritemap.play(currentAnim + 'Shoot');
            weapon.fire(x, y, vo.direction)
        }
    }


    public function set triggerOnKill(value:Triggerable):void {
        _triggerOnKill = value;
    }

    public function get damage():Number {
        return vo.damage;
    }
	
	
}
}
