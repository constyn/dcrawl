package org.spindle.dcrawl.items.pickable.upgrades 
{
import org.spindle.dcrawl.items.weapons.effects.Freeze;

/**
	 * ...
	 * @author taires
	 */
	public class FreezeUp extends WeaponUpgrade
	{
		
		public function FreezeUp(utype : uint) {
			super(utype)
			effect = Freeze
			upgradeName = "Winter is comming"
		}
		
	}

}