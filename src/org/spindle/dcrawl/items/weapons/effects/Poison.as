package org.spindle.dcrawl.items.weapons.effects 
{
	/**
	 * ...
	 * @author taires
	 */
	public class Poison extends BasicEffect
	{
		
		public function Poison() 
		{
			duration = 250;
			extraDamage = .1;
			tint = 0x00ff00;
			tintAlpha = .5;
		}
		
	}

}