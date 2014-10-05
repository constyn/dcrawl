package org.spindle.dcrawl.items.weapons {

import net.flashpunk.FP;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.items.weapons.bullets.Bomb;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class BombWeapon extends RangeWeapon{
		
		public function BombWeapon():void {
			spritemap.add("toBePicked", [GraphicUtils.getTile(11, 7)], 0, false);
			spritemap.play("toBePicked");

            spritemap.add("goingLeft", [GraphicUtils.getTile(11, 8)], 0, false);
            spritemap.add("goingRight", [GraphicUtils.getTile(11, 9)], 0, false);
            spritemap.add("goingUp", [GraphicUtils.getTile(11, 10)], 0, false);
            spritemap.add("goingDown", [GraphicUtils.getTile(11, 11)], 0, false);

            spritemap.add("goingLeftShoot", [GraphicUtils.getTile(12, 8)], 0, false);
            spritemap.add("goingRightShoot", [GraphicUtils.getTile(12, 9)], 0, false);
            spritemap.add("goingUpShoot", [GraphicUtils.getTile(12, 10)], 0, false);
            spritemap.add("goingDownShoot", [GraphicUtils.getTile(12, 11)], 0, false);

            spritemap.add("goingLeftS", [GraphicUtils.getTile(11, 8)], 0, false);
            spritemap.add("goingRightS", [GraphicUtils.getTile(11, 9)], 0, false);
            spritemap.add("goingUpS", [GraphicUtils.getTile(11, 10)], 0, false);
            spritemap.add("goingDownS", [GraphicUtils.getTile(11, 11)], 0, false);

			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "pickable";
		}
		
		override public function fire(xOrig:int, yOrig:int, direction:int) : void {			
            trace("Fire!");
            var bomb:Bomb = new Bomb(upgradeLevel+1);
            bomb.setPosition(x,y);
            FP.world.add(bomb);
		}

		override public function get maxFireRate() : int {
			return 60;
		}
	}
}
