package org.spindle.dcrawl.items.weapons.effects 
{

import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * ...
	 * @author taires
	 */
	public class Enchant extends BasicEffect
	{
		
		public function Enchant()
		{
			duration = 3500;
			extraDamage = .1;
			tint = 0xffcc00;
			tintAlpha = .9;		
			
			spritemap.add("anim", [
                GraphicUtils.getTile(5, 21),
                GraphicUtils.getTile(5, 22),
                GraphicUtils.getTile(5, 23),
                GraphicUtils.getTile(5, 24),
                GraphicUtils.getTile(5, 25),
                GraphicUtils.getTile(5, 26)], 9, true);
			spritemap.play("anim");
		}		
	}
}