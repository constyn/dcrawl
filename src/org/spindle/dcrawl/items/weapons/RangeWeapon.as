package org.spindle.dcrawl.items.weapons {
import net.flashpunk.Entity;
import net.flashpunk.FP;

import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.pickable.upgrades.WeaponUpgrade;
import org.spindle.dcrawl.items.types.Upgrade;
import org.spindle.dcrawl.items.types.Weapon;
import org.spindle.dcrawl.items.weapons.bullets.Bullet;
import org.spindle.dcrawl.items.weapons.bullets.BulletVO;

/**
	 * @author cornel
	 */
	public class RangeWeapon extends SpritedItem implements Weapon {
		
		protected var upgrades:Array;
		protected var upgradeLevel:uint = 0;
        protected var maxFireRateVal:uint = 40;
        protected var maxBulletLength:uint = 30;
		protected var maxBulletSpeed:int = 2;	
		protected var damage:Number = .5;
		protected var effects:Array;		
		protected var _origin:Entity;
		
		
		public var bulletClass:Class;
		
		public function RangeWeapon():void {
			upgrades = [];
			effects = [];
		}
		
		public function fire(xOrig:int, yOrig:int, direction:int) : void {						
			var bullet:Bullet = new bulletClass(new BulletVO(_origin, direction,maxBulletLength,maxBulletSpeed, damage, effects));
			bullet.x = xOrig;
			bullet.y = yOrig;
			FP.world.add(bullet);
			
			if (upgradeLevel>0) {
				bullet = new bulletClass(new BulletVO(_origin, direction,maxBulletLength,maxBulletSpeed, damage, effects));
				bullet.x = this.x-4+8*FP.random;
				bullet.y = this.y-4+8*FP.random;
				FP.world.add(bullet);
			} 
			
			if (upgradeLevel>1) {
				bullet = new bulletClass(new BulletVO(_origin, direction,maxBulletLength,maxBulletSpeed, damage, effects));
				bullet.x = this.x-4+8*FP.random;
				bullet.y = this.y-4+8*FP.random;
				FP.world.add(bullet);
			}		
		}

		public function get maxFireRate() : int {
			return maxFireRateVal;
		}
		
		public function set origin(value:Entity):void{
			_origin = value;
		}

		public function upgrade(upgrade:Upgrade) : void {
			upgrades.push(upgrade)			
            maxFireRateVal -= 10 * WeaponUpgrade(upgrade).rateUp;
            maxBulletLength += 10 * WeaponUpgrade(upgrade).rangeUp;
			maxBulletSpeed += .2 * WeaponUpgrade(upgrade).speedUp;
			damage += .5 * WeaponUpgrade(upgrade).damageUp;	
			effects.push(WeaponUpgrade(upgrade).effect)
			
		}
	}
}
