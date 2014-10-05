package org.spindle.dcrawl.rooms {
import net.flashpunk.Entity;
import net.flashpunk.World;

import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.items.deco.Spawner;
import org.spindle.dcrawl.items.neutral.Explode;
import org.spindle.dcrawl.items.neutral.PressurePlate;

/**
 * @author cornel
 */
public class WolfRoom extends EnemyRoom {

    private var numPlates = 0;
    private var monitor:Monitor;

    public function WolfRoom(world:World, config:Object) {
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
        monitor = new Monitor(0, 0);
        monitor.setPosition(by.x, by.y);
        world.add(monitor);
    }
}
}
