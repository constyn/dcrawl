package org.spindle.dcrawl.items.pickable.upgrades 
{
import org.spindle.dcrawl.items.weapons.effects.Poison;

/**
	 * ...
	 * @author taires
	 */
	public class PoisonDamage extends WeaponUpgrade
	{
		
		public function PoisonDamage(utype : uint) {
			super(utype)
			effect = Poison
			upgradeName = "Poison Damage"
		}
		
	}

}