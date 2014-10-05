package org.spindle.dcrawl.items.weapons {
import net.flashpunk.FP;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.types.Weapon;
import org.spindle.dcrawl.items.weapons.bullets.BasicMagicBullet;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class MagicAttack extends SpritedItem implements Weapon {
		
		private var upgradeLevel:uint = 0;
        private var maxFireRateVal:uint = 90;
        private var maxBulletLength:uint = 30;
		private var maxBulletSpeed:int = 2;
		
		public function MagicAttack():void {
			spritemap.add("toBePicked", [GraphicUtils.getTile(4, 21)], 0, false);
			spritemap.add("goingLeft", [GraphicUtils.getTile(4, 19)], 0, false);
			spritemap.add("goingRight", [GraphicUtils.getTile(4, 19)], 0, false);
			spritemap.add("goingUp", [GraphicUtils.getTile(4, 19)], 0, false);
			spritemap.add("goingDown", [GraphicUtils.getTile(4, 19)], 0, false);
			
			spritemap.add("goingLeftS", [GraphicUtils.getTile(4, 19)], 0, false);
			spritemap.add("goingRightS", [GraphicUtils.getTile(4, 19)], 0, false);
			spritemap.add("goingUpS", [GraphicUtils.getTile(4, 19)], 0, false);
			spritemap.add("goingDownS", [GraphicUtils.getTile(4, 19)], 0, false);
			
			spritemap.play("toBePicked");			
			graphic = spritemap;
			setHitbox(2, Constants.TILE_SIZE);
			type = "pickable";
		}
		
		public function fire(xOrig:int, yOrig:int, direction:int) : void {			
						
			var bullet:BasicMagicBullet = new BasicMagicBullet(direction,maxBulletLength,maxBulletSpeed);
			bullet.x = xOrig;
			bullet.y = yOrig;
			//world.add(bullet);
			FP.world.add(bullet);
			
			if (upgradeLevel>0) {
				bullet = new BasicMagicBullet(direction,maxBulletLength,maxBulletSpeed);
				bullet.x = this.x-4+8*Math.random();
				bullet.y = this.y-4+8*Math.random();
				FP.world.add(bullet);
			} 
			
			if (upgradeLevel>1) {
				bullet = new BasicMagicBullet(direction,maxBulletLength,maxBulletSpeed);
				bullet.x = this.x-4+8*Math.random();
				bullet.y = this.y-4+8*Math.random();
				FP.world.add(bullet);
			}
			
		}

		public function get maxFireRate() : int {
			return maxFireRateVal;
		}

		public function upgrade() : void {
			upgradeLevel++;
            maxFireRateVal-=20;
            maxBulletLength += 10;
			maxBulletSpeed += .2;
		}
	}
}
