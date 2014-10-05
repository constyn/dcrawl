package org.spindle.dcrawl.rooms {
import net.flashpunk.Entity;
import net.flashpunk.World;

import org.spindle.dcrawl.KnownTypes;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.entities.enemies.Blind;
import org.spindle.dcrawl.items.deco.Spawner;
import org.spindle.dcrawl.items.neutral.Explode;
import org.spindle.dcrawl.items.neutral.PressurePlate;

/**
	 * @author cornel
	 */
	public class StandStillRoom extends EnemyRoom {

		private var enemyPlate:PressurePlate;
		private var blinds:Array;

		public function StandStillRoom(world:World, config:Object) {
			super(world, config);
			roomInfo.numEnemies = 4;
		}

		override public function trigger(by:Entity = null):void {
			super.trigger(by);
			
			if (by is PressurePlate) {
				world.add(new Explode(enemyPlate));
				roomInfo.enemy = Item.randomIntervalFrom(0, KnownTypes.enemyTypes.length - 1);
				var positions:Array = [[0,0],[0,1],[1,0],[1,1]]
				for (var i:int = 0; i < positions.length; i++) {
					var spawner:Spawner = new Spawner(spawn);
					var posX:int = Math.max(1, (roomInfo.width - 1) * positions[i][0])
					var posY:int = Math.max(3, (roomInfo.height - 1) * positions[i][1])
					spawner.setPositionOnTile(roomInfo.x + posX, roomInfo.y + posY);
					world.add(spawner);
				}			
			}
		}
		
		override protected function prepareRoom():void {
			
			triggerDoors();
			var plate:PressurePlate;
			enemyPlate = new PressurePlate([this], true);
			enemyPlate.setPositionOnTile(roomInfo.x + roomInfo.width / 2, roomInfo.y + roomInfo.height / 2);
			world.add(enemyPlate);
		}

		override protected function spawn(by:Item):void {
			var blind:Blind = new Blind(0, 0);
			blind.triggerOnKill = this;
			blind.setPosition(by.x, by.y);
			world.add(blind);		
		}
	}
}
