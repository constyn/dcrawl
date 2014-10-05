package org.spindle.dcrawl.items.pickable.upgrades 
{
	/**
	 * ...
	 * @author taires
	 */
	public class DamageUp extends WeaponUpgrade
	{
		
		public function DamageUp(utype : uint) {
			super(utype)
			damageUp = 1;
			upgradeName = "Damage Up"
		}
		
	}

}