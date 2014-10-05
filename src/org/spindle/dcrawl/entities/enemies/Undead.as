package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Undead extends Enemy {

		public function Undead(px : uint, py : uint) {
			super(px, py)
			body = BodyGraphicHelper.buildBody(2, 27, 15);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 5;
            vo.speed = 3;
		}	
	}
}
