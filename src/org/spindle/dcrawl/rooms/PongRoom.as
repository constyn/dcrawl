package org.spindle.dcrawl.rooms {
import net.flashpunk.Entity;
import net.flashpunk.World;

import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.entities.enemies.Enemy;
import org.spindle.dcrawl.entities.enemies.PongPaddle;
import org.spindle.dcrawl.items.deco.Spawner;
import org.spindle.dcrawl.items.neutral.Explode;
import org.spindle.dcrawl.items.neutral.PressurePlate;

/**
 * @author cornel
 */
public class PongRoom extends EnemyRoom {

    private var numPlates = 0;
    private var monitor:PongPaddle;

    public function PongRoom(world:World, config:Object) {
        super(world, config);

    }

    override public function trigger(by:Entity = null):void {
        super.trigger(by);

        if (by is PressurePlate) {
            world.add(new Explode(PressurePlate(by), 2));
            numPlates--;
            if (numPlates == 0) {
                world.add(new Explode(Enemy(monitor)));
                triggerDoors();
            }
        }
    }

    override protected function prepareRoom():void {

        triggerDoors();
        var plate:PressurePlate;

        for (var i = roomInfo.x + 2; i < roomInfo.x + roomInfo.width - 1; i++) {
            for (var j = roomInfo.y + 4; j < roomInfo.y + roomInfo.height - 1; j++) {
                plate = new PressurePlate([this], true);
                plate.setPositionOnTile(i, j);
                world.add(plate);
                numPlates++;
            }
        }

        var spawner:Spawner = new Spawner(spawn);
        spawner.setPositionOnTile(roomInfo.x + roomInfo.width / 2 - 2, roomInfo.y + roomInfo.height / 2 + 2);
        world.add(spawner);
    }


    override protected function spawn(by:Item):void {
        monitor = new PongPaddle(0, 0);
        monitor.moveTo(by.x, by.y);
        world.add(monitor);
    }
}
}
