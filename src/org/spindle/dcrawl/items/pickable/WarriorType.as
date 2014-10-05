package org.spindle.dcrawl.items.pickable {

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.types.Pickable;
import org.spindle.dcrawl.items.types.WarClass;
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class WarriorType extends SpritedItem implements Pickable, WarClass {
		
		
		private var wType:int = -1;
		
		public function WarriorType(warriorClass:int):void {
			
			if (warriorClass == 0) {
				spritemap = BodyGraphicHelper.buildBody(2, 5);	
			} else if (warriorClass == 1){
				spritemap = BodyGraphicHelper.buildBody(2, 8);
			} else if (warriorClass == 2){
				spritemap = BodyGraphicHelper.buildBody(6, 5);
			} else if (warriorClass == 3){
				spritemap = BodyGraphicHelper.buildBody(6, 8);
			}
			
			wType = warriorClass;
			graphic = spritemap;
			type = "pickable";
			setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
		}
		
		public function get warriorType() : int {
			return wType;
		}
		
	}
}
