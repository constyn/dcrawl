package org.spindle.dcrawl.abstract {
import net.flashpunk.graphics.Spritemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.DCrawl;

/**
	 * @author cornel
	 */
	public class SpritedItem extends Item {

        public var spritemap : Spritemap = new Spritemap(DCrawl.TILES, Constants.TILE_SIZE, Constants.TILE_SIZE);
		
		public function removeMe():void
		{
			world.recycle(this)
		}
	}
}
