package org.spindle.dcrawl.items.weapons.effects 
{

import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * ...
	 * @author taires
	 */
	public class Tornado extends BasicEffect
	{
		
		public function Tornado()
		{
			duration = 3500;
			extraDamage = .1;
			tint = 0xffcc00;
			tintAlpha = .9;		
			
			spritemap.add("anim", [
                GraphicUtils.getTile(6, 21),
                GraphicUtils.getTile(6, 22),
                GraphicUtils.getTile(6, 23),
                GraphicUtils.getTile(6, 24),
                GraphicUtils.getTile(6, 25),
                GraphicUtils.getTile(6, 26)], 9, true);
			spritemap.play("anim");
		}		
	}
}