package org.spindle.dcrawl.items.weapons.effects 
{
import org.spindle.dcrawl.abstract.SpritedItem;

/**
	 * ...
	 * @author taires
	 */
	public class BasicEffect extends SpritedItem
	{
		public var duration:int = 1;
		public var speedMod:Number = 1;
		public var damageMod:Number = 1;
		public var extraDamage:Number = 0;
		public var tint:uint = 0xff0000;
		public var tintAlpha:Number = .5;	
		public var hasAnimation:Boolean;
	}
}