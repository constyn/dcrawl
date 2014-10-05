package org.spindle.dcrawl.utils {
import org.spindle.dcrawl.Constants;

/**
	 * @author cornel
	 */
	public class GraphicUtils {
		public static function getTile(row : uint, col : uint) : uint {
			if (row < 0 || col < 0) {
				throw new Error("Tile count starts at 1");
			}
			return (row - 1) * 400 / Constants.TILE_SIZE + (col - 1) ;
		}
	}
}
