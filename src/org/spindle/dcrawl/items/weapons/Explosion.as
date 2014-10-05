package org.spindle.dcrawl.items.weapons {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class Explosion extends SpritedItem {
		private var frame : uint = 0;
		private var direction : uint;
		private var length : uint;

		public function Explosion(direction : int = Constants.EAST, length : uint = 0) : void {		
			this.direction = direction;
			this.length = length;
			
			spritemap.add("anim", [GraphicUtils.getTile(4, 19), GraphicUtils.getTile(4, 20), GraphicUtils.getTile(4, 21), GraphicUtils.getTile(4, 22), GraphicUtils.getTile(4, 23), GraphicUtils.getTile(4, 24), GraphicUtils.getTile(4, 25), GraphicUtils.getTile(4, 26)], 10, true);
			
			spritemap.play("anim");
			graphic = spritemap;
			
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "bullet";
		}

		override public function update() : void {
			frame++;

			if (frame > 40) {
				world.remove(this);
			}

			if (length > 0 && frame == 10) {
				var newExp : Explosion;

				switch (direction) {
					case Constants.EAST:
						newExp = new Explosion(Constants.EAST, length - 1);
						newExp.setPosition(x + Constants.TILE_SIZE, y);
						break;
					case Constants.WEST:
						newExp = new Explosion(Constants.WEST, length - 1);
						newExp.setPosition(x - Constants.TILE_SIZE, y);
						break;
					case Constants.SOUTH:
						newExp = new Explosion(Constants.SOUTH, length - 1);
						newExp.setPosition(x, y + Constants.TILE_SIZE);
						break;
					case Constants.NORTH:
						newExp = new Explosion(Constants.NORTH, length - 1);
						newExp.setPosition(x, y - Constants.TILE_SIZE);
						break;
					case Constants.ALL_DIRECTIONS:
						newExp = new Explosion(Constants.EAST, length - 1);
						newExp.setPosition(x + Constants.TILE_SIZE, y);
						world.add(newExp);
						newExp = new Explosion(Constants.WEST, length - 1);
						newExp.setPosition(x - Constants.TILE_SIZE, y);
						world.add(newExp);
						newExp = new Explosion(Constants.SOUTH, length - 1);
						newExp.setPosition(x, y + Constants.TILE_SIZE);
						world.add(newExp);
						newExp = new Explosion(Constants.NORTH, length - 1);
						newExp.setPosition(x, y - Constants.TILE_SIZE);
						break;
				}

				world.add(newExp);
			}
		}
	}
}
