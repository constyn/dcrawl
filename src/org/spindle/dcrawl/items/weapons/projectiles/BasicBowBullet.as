package org.spindle.dcrawl.items.weapons {
import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class BasicBowBullet extends SpritedItem {
		private var maxLength:int;
		private var dir : int;
		private var speed: Number;

		public function BasicBowBullet(dir : int, maxLength:uint = 100, speed:Number = 2) : void {
					
			graphic = spritemap;
            this.maxLength = maxLength;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "bullet";

			this.dir = dir;
			this.speed = speed;
			switch(dir) {
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

		override public function update() : void {
			if (maxLength-- > 0) {
				switch(dir) {
					case Constants.EAST :
						x+= speed;
						break;
					case Constants.WEST :
						x-= speed;
						break;
					case Constants.NORTH :
						y-= speed;
						break;
					case Constants.SOUTH :
						y+= speed;
						break;
				}
			} else {
				world.remove(this);
			}
		}
	}
}
