package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Rat extends Enemy {

		public function Rat(px : uint, py : uint) {
			super(px, py)
			body = BodyGraphicHelper.buildBody(6, 19, 10);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 5;
		}	
	}
}
