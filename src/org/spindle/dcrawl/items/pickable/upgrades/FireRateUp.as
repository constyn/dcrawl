package org.spindle.dcrawl.items.pickable.upgrades 
{
	/**
	 * ...
	 * @author taires
	 */
	public class FireRateUp extends WeaponUpgrade
	{
		
		public function FireRateUp(utype : uint) {
			super(utype)
			rateUp = 1;
			upgradeName = "Faster!"
		}
		
	}

}