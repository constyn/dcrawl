package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Ghost extends Enemy {

		public function Ghost(px : uint, py : uint) {
			super(px, py)
			body = BodyGraphicHelper.buildBody(10, 19, 15);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 50;
            vo.speed = 2;
		}	
	}
}
