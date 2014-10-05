package org.spindle.dcrawl.items.weapons {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.items.weapons.bullets.PoisonBowBullet;
import org.spindle.dcrawl.items.weapons.effects.Poison;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class PoisonBow extends RangeWeapon{
		
		public function PoisonBow():void {
			spritemap.add("toBePicked", [GraphicUtils.getTile(15, 2)], 0, false);
			spritemap.add("goingLeft", [GraphicUtils.getTile(15, 4)], 0, false);
			spritemap.add("goingRight", [GraphicUtils.getTile(15, 3)], 0, false);
			spritemap.add("goingUp", [GraphicUtils.getTile(15, 6)], 0, false);
			spritemap.add("goingDown", [GraphicUtils.getTile(15, 5)], 0, false);
			
			spritemap.add("goingLeftS", [GraphicUtils.getTile(15, 4)], 0, false);
			spritemap.add("goingRightS", [GraphicUtils.getTile(15, 3)], 0, false);
			spritemap.add("goingUpS", [GraphicUtils.getTile(15, 6)], 0, false);
			spritemap.add("goingDownS", [GraphicUtils.getTile(15, 5)], 0, false);

            spritemap.add("goingLeftShoot", [GraphicUtils.getTile(16, 4)], 0, false);
            spritemap.add("goingRightShoot", [GraphicUtils.getTile(16, 3)], 0, false);
            spritemap.add("goingUpShoot", [GraphicUtils.getTile(16, 6)], 0, false);
            spritemap.add("goingDownShoot", [GraphicUtils.getTile(16, 5)], 0, false);
			
			spritemap.play("toBePicked");			
			graphic = spritemap;
			setHitbox(2, Constants.TILE_SIZE);
			type = "pickable";
			
			bulletClass = PoisonBowBullet;
			effects.push(Poison)
		}
	}
}
