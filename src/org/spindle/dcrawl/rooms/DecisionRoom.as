package org.spindle.dcrawl.rooms {
import net.flashpunk.Entity;
import net.flashpunk.World;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.KnownTypes;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.items.Crate;
import org.spindle.dcrawl.items.deco.Spawner;
import org.spindle.dcrawl.items.neutral.Explode;
import org.spindle.dcrawl.items.neutral.PressurePlate;

/**
 * @author cornel
 */
public class DecisionRoom extends EnemyRoom {

    private var enemyPlate:PressurePlate;
    private var cratePlate:PressurePlate;
    private var openDoorPlate:PressurePlate;

    public function DecisionRoom(world:World, config:Object) {
        super(world, config);
    }

    override public function trigger(by:Entity = null):void {
        super.trigger(by);

        if (by is PressurePlate) {
            world.add(new Explode(enemyPlate));
            world.add(new Explode(cratePlate));
            world.add(new Explode(openDoorPlate));

            if (by == enemyPlate) {
                roomInfo.enemy = Item.randomIntervalFrom(0, KnownTypes.enemyTypes.length - 1);
                roomInfo.numEnemies = 5;
                for (var e:int = 0; e < roomInfo.numEnemies; e++) {
                    var spawner:Spawner = new Spawner(spawn);
                    spawner.setPositionOnTile(roomInfo.x + Item.randomIntervalFrom(2, roomInfo.width - 4), roomInfo.y + Item.randomIntervalFrom(3, roomInfo.height - 6));
                    world.add(spawner);
                }
            } else if (by == openDoorPlate) {
                triggerDoors();
            } else if (by == cratePlate) {
                var item:Item = new Crate(KnownTypes.getRandomOfTypeWParam(KnownTypes.upgrades, Constants.WEAPON_ITEM));
                item.setPositionOnTile(roomInfo.x+3, roomInfo.y + roomInfo.height/2);
                world.add(item);
                triggerDoors();
            }

        }

    }

    override protected function prepareRoom():void {

        var positions:Array = [-2,0,2];
        positions = positions.sort(randomize);

        triggerDoors();
        enemyPlate = new PressurePlate([this], true);
        enemyPlate.setPositionOnTile(roomInfo.x + roomInfo.width / 2 + positions.pop(), roomInfo.y + roomInfo.height / 2);
        world.add(enemyPlate);

        cratePlate = new PressurePlate([this], true);
        cratePlate.setPositionOnTile(roomInfo.x + roomInfo.width / 2 + positions.pop(), roomInfo.y + roomInfo.height / 2);
        world.add(cratePlate);

        openDoorPlate = new PressurePlate([this], true);
        openDoorPlate.setPositionOnTile(roomInfo.x + roomInfo.width / 2 + positions.pop(), roomInfo.y + roomInfo.height / 2);
        world.add(openDoorPlate);

    }

    function randomize ( a : *, b : * ) : int {
        return ( Math.random() > .5 ) ? 1 : -1;
    }
}
}
