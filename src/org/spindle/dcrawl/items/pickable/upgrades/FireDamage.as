package org.spindle.dcrawl.items.pickable.upgrades 
{
import org.spindle.dcrawl.items.weapons.effects.Burn;

/**
	 * ...
	 * @author taires
	 */
	public class FireDamage extends WeaponUpgrade 
	{
		
		public function FireDamage(utype : uint) {
			super(utype)
			effect = Burn;
			upgradeName = "Burn Them!";
		}
		
		
	}

}