package org.spindle.dcrawl.items.weapons.bullets {
import net.flashpunk.Entity;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.entities.enemies.EnemyVO;
import org.spindle.dcrawl.entities.player.Player;
import org.spindle.dcrawl.items.weapons.effects.BasicEffect;

/**
 * @author cornel
 */
	public class Bullet extends SpritedItem {

		protected var vo:BulletVO
		public var ghostBullet:Boolean; //flag that says if the bullet goes through solids
		public var solidBullet:Boolean; // will not be removed when collinding with enmies, ex: true for explosions 
		protected var afterEffectDuration:int;

		public function Bullet(vo:BulletVO):void {
			this.vo = vo;
			afterEffectDuration = 2;
			spritemap.smooth = true;
		}

		override public function update():void {
			if (vo.maxLength-- > 0) {
				switch (vo.dir) {
					case Constants.EAST :
						x += vo.speed;
						break;
					case Constants.WEST :
						x -= vo.speed;
						break;
					case Constants.NORTH :
						y -= vo.speed;
						break;
					case Constants.SOUTH :
						y += vo.speed;
						break;
				}
			} else {
				if (afterEffectDuration-- == 0)
					destroy();
			}

			if (vo.maxLength > 0 && !ghostBullet && collide("solid", x, y)) {
				vo.maxLength = 0;
				collideEffect();			
			}
			
			if (collide("enemy", x, y) && vo.origin is Player){
				vo.maxLength = 0;
				collideEffect();
			}
		}

		protected function collideEffect():void {
			spritemap.active = false;
		}

		public function get damage():Number {
			return vo.damage;
		}
		
		public function get origin():Entity {
			return vo.origin;
		}
		
		public function appplyEffect(eVO:EnemyVO):EnemyVO
		{		
			var effects:Array = [];
			for each(var effClass:Class in vo.effects)
			{
				if (effClass)
				{
					var eff:BasicEffect = new effClass();
					eff.extraDamage = vo.damage * eff.extraDamage;
					effects.push(eff);
				}
			}
			eVO.addEffect(effects)		
			return eVO;
		}
		
		public function destroy():void
		{
			world.remove(this)	
			spritemap.clear();
			spritemap.active = false;
			vo.damage = 0;
			vo.effects = [];
		}
	}
}
