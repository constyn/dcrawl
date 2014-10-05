package org.spindle.dcrawl.rooms {
import net.flashpunk.Entity;
import net.flashpunk.World;

import org.spindle.dcrawl.KnownTypes;
import org.spindle.dcrawl.SoundConstants;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.entities.enemies.Enemy;
import org.spindle.dcrawl.items.deco.Spawner;
import org.spindle.dcrawl.items.types.Triggerable;

/**
 * @author cornel
 */
public class EnemyRoom extends GenericRoom implements Triggerable {


    public function EnemyRoom(world:World, config:Object) {
        super(world, config);
        roomInfo.enemy = Item.randomIntervalFrom(0, KnownTypes.enemyTypes.length - 1);
        roomInfo.numEnemies = Item.randomIntervalFrom(0, 5);
    }

    public override function trigger(by:Entity = null):void {
        super.trigger(by);
        var currentRoom:GenericRoom = this;
        if (by is Enemy) {
            if (--roomInfo.numEnemies == 0) {
                SoundConstants.finished.play();
                triggerDoors();
            }
        }
    }

    protected function spawn(by:Item):void {
        var enemy:Enemy = new KnownTypes.enemyTypes[roomInfo.enemy](0, 0);
        enemy.triggerOnKill = this;
        enemy.setPosition(by.x, by.y);
        world.add(enemy);
    }


    override protected function prepareRoom():void {
        var currentRoom:GenericRoom = this;
        if (roomInfo.numEnemies > 0) {
            triggerDoors();
        }
        for (var e:int = 0; e < roomInfo.numEnemies; e++) {
            var spawner:Spawner = new Spawner(spawn);
            spawner.setPositionOnTile(roomInfo.x + Item.randomIntervalFrom(2, roomInfo.width - 4), roomInfo.y + Item.randomIntervalFrom(3, roomInfo.height - 6));
            world.add(spawner);
        }
    }
}
}
