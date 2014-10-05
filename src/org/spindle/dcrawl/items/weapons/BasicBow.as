package org.spindle.dcrawl.items.weapons {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.items.weapons.bullets.BasicBowBullet;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class BasicBow extends RangeWeapon{
		public function BasicBow():void {
			spritemap.add("toBePicked", [GraphicUtils.getTile(11, 2)], 0, false);
			spritemap.add("goingLeft", [GraphicUtils.getTile(11, 4)], 0, false);
			spritemap.add("goingRight", [GraphicUtils.getTile(11, 3)], 0, false);
			spritemap.add("goingUp", [GraphicUtils.getTile(11, 6)], 0, false);
			spritemap.add("goingDown", [GraphicUtils.getTile(11, 5)], 0, false);

            spritemap.add("goingLeftShoot", [GraphicUtils.getTile(12, 4)], 0, false);
            spritemap.add("goingRightShoot", [GraphicUtils.getTile(12, 3)], 0, false);
            spritemap.add("goingUpShoot", [GraphicUtils.getTile(12, 6)], 0, false);
            spritemap.add("goingDownShoot", [GraphicUtils.getTile(12, 5)], 0, false);

            spritemap.add("goingLeftS", [GraphicUtils.getTile(11, 4)], 0, false);
			spritemap.add("goingRightS", [GraphicUtils.getTile(11, 3)], 0, false);
			spritemap.add("goingUpS", [GraphicUtils.getTile(11, 6)], 0, false);
			spritemap.add("goingDownS", [GraphicUtils.getTile(11, 5)], 0, false);
			
			spritemap.play("toBePicked");			
			graphic = spritemap;
			setHitbox(2, Constants.TILE_SIZE);
			type = "pickable";
			
			bulletClass = BasicBowBullet;
		}
	}
}
