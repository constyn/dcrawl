package org.spindle.dcrawl.rooms {
import net.flashpunk.Entity;
import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.graphics.Tilemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.DCrawl;
import org.spindle.dcrawl.SoundConstants;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.items.deco.Deco;
import org.spindle.dcrawl.items.deco.InvisibleSolid;
import org.spindle.dcrawl.items.neutral.Door;
import org.spindle.dcrawl.items.types.Triggerable;

/**
 * @author cornel
 */
public class GenericRoom extends Item implements Triggerable {

    private var tile:Tilemap;

    private var doors:Array = [];

    protected var roomInfo:Object;

    public function GenericRoom(world:World, config:Object):void {

        roomInfo = config;
        buildRoomTilesAndEntities(world, config);
        type = Constants.ROOM_TYPE;
        layer = Constants.LAYER_GROUND;
        buildDoors(world, config);
        setPositionOnTile(config.x, config.y);
        //addRandomObstacles(world, config);
    }

    protected function buildRoomTilesAndEntities(world:World, config:Object):void {
        var roomx:uint = config.decoration[0];
        var roomy:uint = config.decoration[1];

        tile = new Tilemap(DCrawl.TILES, (config.width + 3) * Constants.TILE_SIZE, (config.height + 3) * Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE);
        graphic = tile;
        var tileIndex:int;
        for (var i:uint = 0; i < config.width + 1; i++) {
            for (var j:uint = 0; j < config.height + 3; j++) {
                if (j == 1 || j == config.height + 1) {
                    if (FP.random < 0.1) {
                        tileIndex = tile.getIndex(roomx + 5 + (FP.random > 0.5 ? 0 : 1), roomy + 3);
                    } else {
                        tileIndex = tile.getIndex(roomx + 5 + 3 * FP.random, roomy + 4);
                    }
                } else if (j == 2 || j == config.height + 2) {
                    tileIndex = tile.getIndex(roomx + 5 + 3 * FP.random, roomy + 5);
                } else {
                    tileIndex = tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random);
                }

                tile.setTile(i, j, tileIndex);
            }
        }

        for (i = 0; i < config.width; i++) {
            tile.setTile(i, 0, tile.getIndex(roomx + 3, roomy));
            tile.setTile(i, config.height, tile.getIndex(roomx + 3, roomy + 5));
        }

        for (i = 0; i < config.height; i++) {
            tile.setTile(0, i, tile.getIndex(roomx, roomy + 2));
            tile.setTile(config.width, i, tile.getIndex(roomx + 4, roomy + 2));
        }


        tile.setTile(0, 0, tile.getIndex(roomx, roomy));
        tile.setTile(config.width, 0, tile.getIndex(roomx + 4, roomy));
        tile.setTile(0, config.height, tile.getIndex(roomx, roomy + 5));
        tile.setTile(config.width, config.height, tile.getIndex(roomx + 4, roomy + 5));

    }

    protected function buildDoors(world:World, config:Object):void {
        var roomx:uint = config.decoration[0];
        var roomy:uint = config.decoration[1];
        var gates:Array = [];
        var doorsLoc:Array = [];
        if (config.doors[0] == -1 || config.doors[1] == -1) {
            doorsLoc = [Math.round(FP.random * 3), Math.round(FP.random * 3)];

            while (doorsLoc[0] == doorsLoc[1]) {
                doorsLoc[1] = Math.round(FP.random * 3);
            }
        } else {
            doorsLoc = [config.doors[0], config.doors[1]];
        }

        var entity:Item;
        for (var i:uint = 0; i < 2; i++) {
            if (doorsLoc[i] == Constants.EAST || doorsLoc[i] == Constants.WEST) {
                //Random location of door
                //gates.push([doorsLoc[i] == Constants.WEST ? 0 : width, randomIntervalFrom(4, config.height- 8)]);

                //Middle location of door
                gates.push([doorsLoc[i] == Constants.WEST ? 0 : config.width, Math.round((config.height - 1) / 2)]);

                tile.setTile(gates[i][0], gates[i][1] + 1, tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));
                tile.setTile(gates[i][0], gates[i][1] + 2, tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));

                tile.setTile(gates[i][0], gates[i][1], tile.getIndex(roomx + 6, roomy + 5));
                tile.setTile(gates[i][0], gates[i][1] - 1, tile.getIndex(roomx + 5, roomy + 4));
                tile.setTile(gates[i][0], gates[i][1] - 2, tile.getIndex(roomx + 5, roomy + 1));

                tile.setTile(gates[i][0], gates[i][1] + 3, tile.getIndex(roomx + 5, roomy));

                entity = new InvisibleSolid(config.x + gates[i][0], config.y + 3, 1, gates[i][1] - 2);
                world.add(entity);

                entity = new InvisibleSolid(config.x + gates[i][0], config.y + gates[i][1] + 3, 1, config.height - gates[i][1] - 3);
                world.add(entity);

                entity = new Door(roomx + 7, roomy + 1);
                doors.push(entity);
                entity.setPositionOnTile(config.x + gates[i][0], config.y + gates[i][1] + 1);
                world.add(entity);

                entity = new Door(roomx + 7, roomy + 2);
                doors.push(entity);
                entity.setPositionOnTile(config.x + gates[i][0], config.y + gates[i][1] + 2);
                world.add(entity);

                entity = new Bridge(false);
                entity.setPositionOnTile(config.x + gates[i][0] + (doorsLoc[i] == Constants.WEST ? -2 : 1), config.y + gates[i][1]);
                world.add(entity);

                entity = new InvisibleSolid(config.x + gates[i][0] + (doorsLoc[i] == Constants.WEST ? -2 : 1), config.y + gates[i][1], 2, 1);
                world.add(entity);
                entity = new InvisibleSolid(config.x + gates[i][0] + (doorsLoc[i] == Constants.WEST ? -2 : 1), config.y + gates[i][1] + 3, 2, 1);
                world.add(entity);

            } else {
                //Random location of door
                //gates.push([randomIntervalFrom(4, width - 9), doorsLoc[i] == Constants.NORTH ? 0 : height]);

                //Middle location of door
                gates.push([Math.round((config.width - 1) / 2), doorsLoc[i] == Constants.NORTH ? 0 : config.height]);

                tile.setTile(gates[i][0], gates[i][1], tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));
                tile.setTile(gates[i][0], gates[i][1] + 1, tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));
                tile.setTile(gates[i][0], gates[i][1] + 2, tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));

                tile.setTile(gates[i][0] + 1, gates[i][1], tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));
                tile.setTile(gates[i][0] + 1, gates[i][1] + 1, tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));
                tile.setTile(gates[i][0] + 1, gates[i][1] + 2, tile.getIndex(roomx + 1 + 3 * FP.random, roomy + 1 + 3 * FP.random));

                tile.setTile(gates[i][0] - 1, gates[i][1], tile.getIndex(roomx + 6, roomy + 2));
                tile.setTile(gates[i][0] + 2, gates[i][1], tile.getIndex(roomx + 5, roomy + 2));

                entity = new InvisibleSolid(config.x, config.y + gates[i][1], gates[i][0], 3);
                world.add(entity);

                entity = new InvisibleSolid(config.x + gates[i][0] + 2, config.y + gates[i][1], config.width - gates[i][0] - 1, 3);
                world.add(entity);

                entity = new Door(roomx + 8, roomy + 4);
                doors.push(entity);
                entity.setPositionOnTile(config.x + gates[i][0], config.y + gates[i][1] + 2);
                world.add(entity);

                entity = new Door(roomx + 8, roomy + 3, true);
                doors.push(entity);
                entity.setPositionOnTile(config.x + gates[i][0], config.y + gates[i][1] + 1);
                world.add(entity);

                entity = new Door(roomx + 8, roomy + 4);
                doors.push(entity);
                entity.setPositionOnTile(config.x + gates[i][0] + 1, config.y + gates[i][1] + 2);
                world.add(entity);

                entity = new Door(roomx + 8, roomy + 3, true);
                doors.push(entity);
                entity.setPositionOnTile(config.x + gates[i][0] + 1, config.y + gates[i][1] + 1);
                world.add(entity);

                entity = new Bridge(true);
                entity.setPositionOnTile(config.x + gates[i][0] - 1, config.y + gates[i][1] + (doorsLoc[i] == Constants.NORTH ? -2 : 1));
                world.add(entity);

                entity = new InvisibleSolid(config.x + gates[i][0] - 1, config.y + gates[i][1] + (doorsLoc[i] == Constants.NORTH ? -2 : 1), 1, 2);
                world.add(entity);
                entity = new InvisibleSolid(config.x + gates[i][0] + 2, config.y + gates[i][1] + (doorsLoc[i] == Constants.NORTH ? -2 : 1), 1, 2);
                world.add(entity);


            }

            if (doorsLoc.indexOf(Constants.EAST) == -1) {
                entity = new InvisibleSolid(config.x + config.width, config.y + 3, 1, config.height - 3);
                world.add(entity);
            }

            if (doorsLoc.indexOf(Constants.WEST) == -1) {
                entity = new InvisibleSolid(config.x, config.y + 3, 1, config.height - 3);
                world.add(entity);
            }

            if (doorsLoc.indexOf(Constants.SOUTH) == -1) {
                entity = new InvisibleSolid(config.x, config.y + config.height, config.width + 1, 3);
                world.add(entity);
            }

            if (doorsLoc.indexOf(Constants.NORTH) == -1) {
                entity = new InvisibleSolid(config.x, config.y, config.width + 1, 3);
                world.add(entity);
            }
        }
    }

    private function addRandomObstacles(world:World, config:Object):void {
        var item:Item;
        for (var i:uint = 0; i < FP.rand(5); i++) {
            item = new Deco(17 + FP.rand(3), 24 + FP.rand(3), "solid");

            item.setPositionOnTile(config.x + 1 + FP.rand(config.width - 2), config.y + 4 + FP.rand(config.height - 8));

            if (!collideTypes(Item, item.x, item.y)) {
                world.add(item);
            }
        }
    }


    protected function triggerDoors():void {
        for each (var door:Door in doors) {
            door.trigger();
        }
    }

    public function trigger(by:Entity = null):void {
        var currentRoom:GenericRoom = this;
        if (by is FogOfWar) {
            SoundConstants.closeDoors.complete = function ():void {
                prepareRoom();
            }
            SoundConstants.closeDoors.play();
        }
    }

    protected function prepareRoom():void {

    }
}
}
