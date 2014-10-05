package org.spindle.dcrawl.items.weapons.bullets {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.items.weapons.effects.Burn;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class FlamingBowBullet extends Bullet {
		public function FlamingBowBullet(vo:BulletVO) : void {					
			super(vo); 		
			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "bullet";
			
			addGraphic(new Burn().spritemap)	
			switch(vo.dir) {
				case Constants.EAST :
					spritemap.add("anim", [GraphicUtils.getTile(17, 2), GraphicUtils.getTile(17, 3)], 15, true);	
					break;
				case Constants.WEST :
					spritemap.add("anim", [GraphicUtils.getTile(18, 2),GraphicUtils.getTile(18, 3)], 15, true);
					x--;
					break;
				case Constants.NORTH :
					spritemap.add("anim", [GraphicUtils.getTile(17, 4),GraphicUtils.getTile(17, 5)], 15, true);
					y--;
					break;
				case Constants.SOUTH :
					spritemap.add("anim", [GraphicUtils.getTile(18, 4),GraphicUtils.getTile(18, 5)], 15, true);
					y++;
					break;
			}
			
			spritemap.play("anim");
		}
	}
}
