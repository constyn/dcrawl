package org.spindle.dcrawl.entities.enemies {
import flash.utils.getQualifiedClassName;

import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.weapons.effects.BasicEffect;

/**
	 * @author taires
	 */
	public class EnemyVO extends SpritedItem {
		public var direction:Number = 0;
		public var health:Number;
		private var _speed:Number = 1;
		private var _damage:Number;
		public var tint:uint;
		public var tintAlpha:Number		
		public var effectArray:Array;		
		public var moveLag:uint = 3;
		
		private var speedMod:Number = 1;
		private var dmgMod:Number;
		
		public function EnemyVO() {
			effectArray = [];
		}
		
		public function addEffect(effects:Array):void
		{
			for each (var wEffect:BasicEffect in effects)
			{
				for each (var effect:BasicEffect in effectArray)
					if (getQualifiedClassName(effect) == getQualifiedClassName(wEffect))
						effectArray.splice(effectArray.indexOf(effect), 1)
						
				effectArray.push(wEffect)
			}
		}
		
		public function applyEffects(sp:SpritedItem):void
		{
			speedMod = 1;
			dmgMod = 1;
			for each (var effect:BasicEffect in effectArray)
			{
				if (effect.duration > 0)
				{
					speedMod *= effect.speedMod;
					dmgMod *= effect.damageMod;
					health -= effect.extraDamage;
					tint = effect.tint;
					tintAlpha = effect.tintAlpha;
					effect.duration--;
					
					if(effect.hasAnimation)
						sp.addGraphic(effect.spritemap)
				}
				else
				{
					effectArray.splice(effectArray.indexOf(effect), 1)
				}
			}
			
		}
		
		public function get speed():Number 
		{
			return _speed * speedMod;
		}
		
		public function get damage():Number 
		{
			return _damage * dmgMod;
		}	
		
		public function set damage(value:Number):void 
		{
			_damage = value;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
	}
}
