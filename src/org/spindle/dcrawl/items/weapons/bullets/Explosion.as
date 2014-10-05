package org.spindle.dcrawl.items.weapons.bullets {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class Explosion extends Bullet{
		private var frame : uint = 0;

		public function Explosion(vo:BulletVO) : void {		
			super(vo);
			spritemap.add("anim", [GraphicUtils.getTile(4, 19), GraphicUtils.getTile(4, 20), GraphicUtils.getTile(4, 21), GraphicUtils.getTile(4, 22), GraphicUtils.getTile(4, 23), GraphicUtils.getTile(4, 24), GraphicUtils.getTile(4, 25), GraphicUtils.getTile(4, 26)], 10, true);
			
			spritemap.play("anim");
			graphic = spritemap;
			
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "bullet";
			solidBullet = true;
		}
		
		override public function update() : void {
			frame++;
			
			if (frame > 40) {
				world.remove(this);
			}
			
			if (vo.maxLength > 0 && frame == 10) {
				var newExp : Explosion;
				
				switch (vo.dir) {
					case Constants.EAST:
						newExp = new Explosion(new BulletVO(origin, Constants.EAST, vo.maxLength - 1));
						newExp.setPosition(x + Constants.TILE_SIZE, y);
						break;
					case Constants.WEST:
						newExp = new Explosion(new BulletVO(origin, Constants.WEST, vo.maxLength - 1));
						newExp.setPosition(x - Constants.TILE_SIZE, y);
						break;
					case Constants.SOUTH:
						newExp = new Explosion(new BulletVO(origin, Constants.SOUTH, vo.maxLength - 1));
						newExp.setPosition(x, y + Constants.TILE_SIZE);
						break;
					case Constants.NORTH:
						newExp = new Explosion(new BulletVO(origin, Constants.NORTH, vo.maxLength - 1));
						newExp.setPosition(x, y - Constants.TILE_SIZE);
						break;
					case Constants.ALL_DIRECTIONS:
						newExp = new Explosion(new BulletVO(origin, Constants.EAST, vo.maxLength - 1)) ;
						newExp.setPosition(x + Constants.TILE_SIZE, y);
						world.add(newExp);
						newExp = new Explosion(new BulletVO(origin, Constants.WEST, vo.maxLength - 1));
						newExp.setPosition(x - Constants.TILE_SIZE, y);
						world.add(newExp);
						newExp = new Explosion(new BulletVO(origin, Constants.SOUTH, vo.maxLength - 1));
						newExp.setPosition(x, y + Constants.TILE_SIZE);
						world.add(newExp);
						newExp = new Explosion(new BulletVO(origin, Constants.NORTH, vo.maxLength - 1));
						newExp.setPosition(x, y - Constants.TILE_SIZE);
						break;
				}

				world.add(newExp);
			}
		}
	}
}
