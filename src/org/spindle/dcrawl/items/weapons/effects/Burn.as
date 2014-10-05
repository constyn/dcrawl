package org.spindle.dcrawl.items.weapons.effects 
{

import org.spindle.dcrawl.utils.GraphicUtils;

/**
	 * ...
	 * @author taires
	 */
	public class Burn extends BasicEffect
	{
		
		public function Burn() 
		{
			duration = 3500;
			extraDamage = .1;
			tint = 0xffcc00;
			tintAlpha = .9;		
			
			spritemap.add("anim", [
                GraphicUtils.getTile(2, 22),
                GraphicUtils.getTile(2, 23),
                GraphicUtils.getTile(2, 24),
                GraphicUtils.getTile(2, 25),
                GraphicUtils.getTile(2, 26),
                GraphicUtils.getTile(2, 27)], 10, true);
			spritemap.play("anim");
			hasAnimation = true;
		}		
	}
}