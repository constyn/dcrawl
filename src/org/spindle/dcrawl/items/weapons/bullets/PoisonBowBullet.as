package org.spindle.dcrawl.items.weapons.bullets {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class PoisonBowBullet extends Bullet {
		public function PoisonBowBullet(vo:BulletVO) : void {					
			super(vo)
			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "bullet";
			switch(vo.dir) {
				case Constants.EAST :
					spritemap.add("anim", [GraphicUtils.getTile(14, 2),GraphicUtils.getTile(14, 3)], 15, true);					
					break;
				case Constants.WEST :
					spritemap.add("anim", [GraphicUtils.getTile(15, 2),GraphicUtils.getTile(15, 3)], 15, true);
					x--;
					break;
				case Constants.NORTH :
					spritemap.add("anim", [GraphicUtils.getTile(14, 4),GraphicUtils.getTile(14, 5)], 15, true);
					y--;
					break;
				case Constants.SOUTH :
					spritemap.add("anim", [GraphicUtils.getTile(15, 4),GraphicUtils.getTile(15, 5)], 15, true);
					y++;
					break;
			}
			
			spritemap.play("anim");
		}
	}
}
