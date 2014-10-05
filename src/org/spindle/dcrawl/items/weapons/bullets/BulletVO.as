package org.spindle.dcrawl.items.weapons.bullets 
{
import net.flashpunk.Entity;

import org.spindle.dcrawl.Constants;

/**
	 * ...
	 * @author taires
	 */
	public class BulletVO 
	{		
		public var maxLength:int;
		public var dir : int;
		public var speed: Number;
		public var damage: Number;
		public var effects: Array;
		public var type: String;
		public var origin: Entity;
		
		public function BulletVO(origin:Entity = null, dir:uint = Constants.ALL_DIRECTIONS, maxLength:int = 0, speed:Number = 0, damage:Number = .5, effects:Array = null):void
		{
			this.origin = origin;
			this.dir = dir
			this.maxLength = maxLength;
			this.speed = speed;
			this.damage = damage;
			this.effects = effects;
		}
	}

}