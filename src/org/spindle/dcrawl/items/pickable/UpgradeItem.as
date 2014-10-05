package org.spindle.dcrawl.items.pickable {
import net.flashpunk.graphics.Text;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.types.Pickable;
import org.spindle.dcrawl.items.types.Upgrade;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * @author cornel
	 */
	public class UpgradeItem extends SpritedItem implements Pickable, Upgrade {
		private var toUpgrade : int = -1;
		public var upgradeName:String = "";

		public function UpgradeItem(utype : uint) {
			toUpgrade = utype;
			spritemap.add("anim",[
					GraphicUtils.getTile(2, 19), 
					GraphicUtils.getTile(2, 20), 
					GraphicUtils.getTile(2, 21), 
					GraphicUtils.getTile(2, 20), 
					GraphicUtils.getTile(2, 19)], 
					8, true);
					
			spritemap.play("anim");
			graphic = spritemap;
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
			type = "pickable";		
			var nameText:Text = new Text("upgrade", x, y, {size:7});
			addGraphic(nameText);
		}

		public function upgradeElement() : uint {
		
			return toUpgrade;
		}
	}
}
