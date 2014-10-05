package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Worm extends Enemy {

		public function Worm(px : uint, py : uint) {
			super(px, py)
			body = BodyGraphicHelper.buildBody(2, 19, 5);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 5;
		}	
	}
}
