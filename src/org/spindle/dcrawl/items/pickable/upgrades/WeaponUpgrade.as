package org.spindle.dcrawl.items.pickable.upgrades 
{
import org.spindle.dcrawl.items.pickable.UpgradeItem;

/**
	 * ...
	 * @author taires
	 */
	public class WeaponUpgrade extends UpgradeItem
	{
		public var damageUp:Number = 0;
		public var rangeUp:Number = 0;
		public var rateUp:Number = 0;
		public var speedUp:Number = 0;
		public var effect:Class
		
		public function WeaponUpgrade(utype : uint) {
			super(utype)
		}
	}

}