package org.spindle.dcrawl.items.weapons.bullets {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.items.weapons.effects.Burn;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class FireBullet extends Bullet {
		public function FireBullet(vo) : void {					
			super(vo);
			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE-4, Constants.TILE_SIZE-4,2,2);
			type = "bullet";
			switch(vo.dir) {
				case Constants.EAST :
					spritemap.add("anim", [GraphicUtils.getTile(3, 20),GraphicUtils.getTile(3, 21)], 15, true);
					break;
				case Constants.WEST :
					spritemap.add("anim", [GraphicUtils.getTile(3, 20),GraphicUtils.getTile(3, 21)], 15, true);
					x--;
					break;
				case Constants.NORTH :
					spritemap.add("anim", [GraphicUtils.getTile(3, 20),GraphicUtils.getTile(3, 21)], 15, true);
					y--;
					break;
				case Constants.SOUTH :
					spritemap.add("anim", [GraphicUtils.getTile(3, 20),GraphicUtils.getTile(3, 21)], 15, true);
					y++;
					break;
				case Constants.ALL_DIRECTIONS :
					spritemap.add("anim", [GraphicUtils.getTile(3, 22), GraphicUtils.getTile(3, 23), GraphicUtils.getTile(3, 24), GraphicUtils.getTile(3, 25), GraphicUtils.getTile(3, 26)], 10, true);				
					break;	
			}
			
			spritemap.play("anim");
		}
		
		override protected function collideEffect():void
		{
			spritemap.clear();
			spritemap.active = false;
			
			var vo:BulletVO = new BulletVO();
			vo.dir = Constants.ALL_DIRECTIONS;
			vo.maxLength = 0;
			vo.damage = 0;
			var burnOut:FireBullet = new FireBullet(vo);
			
			burnOut.setPosition(x, y);
			world.add(burnOut);
			burnOut.afterEffectDuration = 25;
		}
		
		override public function appplyEffect(vo:EnemyVO):EnemyVO
		{		
			vo.addEffect(Burn)		
			return vo;
		}
	}
}
