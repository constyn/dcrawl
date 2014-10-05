package org.spindle.dcrawl.items.weapons.bullets {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class BasicBowBullet extends Bullet {
		public function BasicBowBullet(vo:BulletVO) : void {					
			super(vo)
			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "bullet";
			switch(vo.dir) {
				case Constants.EAST :
					spritemap.add("anim", [GraphicUtils.getTile(13, 2),GraphicUtils.getTile(13, 3)], 14, true);					
					break;
				case Constants.WEST :
					spritemap.add("anim", [GraphicUtils.getTile(14, 2),GraphicUtils.getTile(14, 3)], 14, true);
					x--;
					break;
				case Constants.NORTH :
					spritemap.add("anim", [GraphicUtils.getTile(13, 4),GraphicUtils.getTile(13, 5)], 14, true);
					y--;
					break;
				case Constants.SOUTH :
					spritemap.add("anim", [GraphicUtils.getTile(14, 4),GraphicUtils.getTile(14, 5)], 14, true);
					y++;
					break;
			}
			
			spritemap.play("anim");
		}
	}
}
