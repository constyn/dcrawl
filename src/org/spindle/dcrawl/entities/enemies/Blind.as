package org.spindle.dcrawl.entities.enemies {
import net.flashpunk.FP;

import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
	 * @author cornel
	 */
	public class Blind extends Enemy {

		private var oldPX:int;
		private var oldPY:int;
		private var isFollowing:Boolean;
		
		
		public function Blind(px : uint, py : uint) 
		{
			super(px, py)
			body = BodyGraphicHelper.buildBody(10, 19, 15);
			graphic = body;
			
			body.play("goingRight");
			setHitbox(8, 8);
			
			vo.damage = 1;
			vo.health = 1;
            vo.speed = 3;
		}
		
		override protected function switchDirection():void
		{
			var currentAnim:String = "";
			switchDirectionCountdown = 20 + 40 * FP.random;			
			
			var pX:int = FP.world.getInstance("player").x;
			var pY:int = FP.world.getInstance("player").y;			
			 
			isFollowing = ((oldPX != pX || oldPY != pY) && oldPX != 0 && oldPY != 0)
			vo.direction = getDirection(pX, pY, x, y, isFollowing);
				
			oldPX = pX;
			oldPY = pY;
				
			switch (vo.direction) {
				case 0:
					currentAnim = "goingRight"
					break;
				case 1:
					currentAnim = "goingLeft"					
					break;
				case 2:
					currentAnim = "goingDown"
					break;
				case 3:
					currentAnim = "goingUp"
					break;
			}
			
			body.play(currentAnim);
		}
		
		override public function update() : void {
			super.update();
			
			if (isFollowing)
			{				
				body.color = 0xff0000;
				body.tinting = .9
			}
		}
		
		
	}
}
