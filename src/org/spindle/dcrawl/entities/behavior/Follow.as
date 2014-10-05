package org.spindle.dcrawl.entities.behavior 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author taires
	 */
	public class Follow implements IBehavior 
	{
		
		public function Follow() 
		{
			
		}
		
		public function move(ent:Entity):void 
		{
			
		}
		
		private function getDirection(pX:int, pY:int, eX:int, eY:int, moveToPlayer:Boolean):int
		{			
			var dir:int = 0;
			
			if (moveToPlayer){
				if (Math.abs(pX - eX) > Math.abs(pY - eY)){
					if (pX > eX){
						dir = 0;
					}
					else{
						dir = 1
					}
				}
				else{
					if (pY > eY){
						dir = 2;
					}
					else{
						dir = 3;
					}
				}	
			}
			else{
				if (Math.random() > .5){
					if (pX < eX){
						dir = 0;
					}
					else{
						dir = 1
					}
				}
				else{
					if (pY < eY){
						dir = 2;
					}
					else{
						dir = 3;
					}
				}	
				
			}
			
			if(Math.random() > .7 && !moveToPlayer){
				dir = FP.rand(4);
			}
			
			return dir;
		}
		
	}

}