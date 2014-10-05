package org.spindle.dcrawl.items.weapons {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.items.weapons.bullets.IceBullet;
import org.spindle.dcrawl.items.weapons.effects.Freeze;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class MagicIceAttack extends RangeWeapon{
		public function MagicIceAttack():void {
			
			maxFireRateVal = 40;
			maxBulletLength = 30;
			maxBulletSpeed = 2;		
			damage = 1;
			upgradeLevel = 6;
			
			spritemap.add("toBePicked", [GraphicUtils.getTile(14, 7),GraphicUtils.getTile(14, 8)], 2, true);

            spritemap.add("goingLeft", [GraphicUtils.getTile(13, 13)], 0, false);
            spritemap.add("goingRight", [GraphicUtils.getTile(13, 12)], 0, false);
            spritemap.add("goingUp", [GraphicUtils.getTile(13, 15)], 0, false);
            spritemap.add("goingDown", [GraphicUtils.getTile(13, 14)], 0, false);

            spritemap.add("goingLeftShoot", [GraphicUtils.getTile(14, 13)], 0, false);
            spritemap.add("goingRightShoot", [GraphicUtils.getTile(14, 12)], 0, false);
            spritemap.add("goingUpShoot", [GraphicUtils.getTile(14, 15)], 0, false);
            spritemap.add("goingDownShoot", [GraphicUtils.getTile(14, 14)], 0, false);

            spritemap.add("goingLeftS", [GraphicUtils.getTile(13, 13)], 0, false);
            spritemap.add("goingRightS", [GraphicUtils.getTile(13, 12)], 0, false);
            spritemap.add("goingUpS", [GraphicUtils.getTile(13, 15)], 0, false);
            spritemap.add("goingDownS", [GraphicUtils.getTile(13, 14)], 0, false);
			
            spritemap.play("toBePicked");
			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "pickable";
			
			bulletClass = IceBullet;
			effects.push(Freeze)
		}	
	}
}
