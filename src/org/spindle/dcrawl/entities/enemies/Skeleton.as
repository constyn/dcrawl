package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.items.weapons.BasicBow;
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Skeleton extends Enemy {
		
		public function Skeleton(px : uint, py : uint) {
			super(px, py)
			body = BodyGraphicHelper.buildBody(2, 23, 15);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 5;
            vo.speed = 1.5;
			
			weapon = new BasicBow();
			addGraphic(weapon.spritemap);
		}	
	}
}
