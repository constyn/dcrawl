package org.spindle.dcrawl.entities.behavior 
{
	import net.flashpunk.Entity;
	import org.spindle.dcrawl.entities.enemies.Enemy;
	import org.spindle.dcrawl.entities.enemies.EnemyVO;
	/**
	 * ...
	 * @author taires
	 */
	public class Flying extends Moving 
	{
		
		public function Flying(ent:Enemy, vo:EnemyVO)
		{
			super(ent, vo);
		}		
		
		override protected function checkCollision(nx:int, ny:int):Boolean
		{
			return 	(ent.collide("wall", nx, ny) is Entity)
		}
		
	}

}