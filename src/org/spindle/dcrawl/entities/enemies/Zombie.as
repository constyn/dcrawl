package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Zombie extends Enemy {

		public function Zombie(px : uint, py : uint) {
			super(px, py)
			body = BodyGraphicHelper.buildBody(6, 23, 15);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 10;
            vo.speed = 2;
		}	
	}
}
