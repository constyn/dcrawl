package org.spindle.dcrawl.entities.behavior 
{
	import net.flashpunk.Entity;
	import org.spindle.dcrawl.entities.enemies.Enemy;
	import org.spindle.dcrawl.entities.enemies.EnemyVO;	
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author taires
	 */
	public class Moving implements IBehavior 
	{
		protected var ent:Enemy;
		protected var vo:EnemyVO;		
		
		protected var LAG:uint = 3;
		protected var switchDirectionCountdown:uint = 1;
		
		public function Moving(ent:Enemy, vo:EnemyVO) 
		{
			this.ent = ent;
			this.vo = vo;
		}
		
		public function move():void 
		{
			var nx:Number = ent.x;
			var ny:Number = ent.y;
			if (vo.moveLag-- == 0) {
				switch (vo.direction) {
					case 0:
						nx += vo.speed;
						break;
					case 1:
						nx -= vo.speed;
						break;
					case 2:
						ny += vo.speed;
						break;
					case 3:
						ny -= vo.speed;
						break;
				}
				vo.moveLag = LAG;
			}
			
			if (checkCollision(nx, ny)) {
				switchDirectionCountdown = 1;
			} else {
				ent.x = nx;
				ent.y = ny;
			}		
			
			if (switchDirectionCountdown-- == 0) {
				switchDirection();
			}
		}
		
		protected function checkCollision(nx:int, ny:int):Boolean
		{
			return (ent.collide("solid", nx, ny) is Entity)
		}
		
		protected function switchDirection():void 
		{			
			switchDirectionCountdown = 20 + 40 * FP.random;
			vo.direction = FP.rand(4);
			ent.updateDirection();
		}
		
	}

}