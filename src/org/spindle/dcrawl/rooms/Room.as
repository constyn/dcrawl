package org.spindle.dcrawl.rooms {
import net.flashpunk.World;
import net.flashpunk.graphics.Tilemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.DCrawl;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.items.deco.Deco;

/**
 * @author cornel
 */
public class Room extends Item {

    private var tile:Tilemap;

    public function Room(world:World, x:int, y:int, width:int, height:int, roomx:int = 16, roomy:int = 10):void {

        buildRoomTilesAndEntities(world, x, y, width, height, roomx, roomy);
        setPositionOnTile(x, y);
    }

    protected function buildRoomTilesAndEntities(world:World, x:int, y:int, width:int, height:int, roomx:int = 16, roomy:int = 10):void {
        tile = new Tilemap(DCrawl.TILES, (width + 3) * Constants.TILE_SIZE, (height + 3) * Constants.TILE_SIZE, Constants.TILE_SIZE, Constants.TILE_SIZE);
        graphic = tile;

        for (var i = 0; i < width + 3; i++) {
            for (var j = 0; j < height + 3; j++) {
                if (i > 1 && i < width - 1) {
                    if (j == 2 || j == height + 2) {
                        tile.setTile(i, j, tile.getIndex(roomx + 5 + 3 * Math.random(), roomy + 5));
                    } else if (j == 1 || j == height + 1) {
                        if (Math.random() < 0.1) {
                            tile.setTile(i, j, tile.getIndex(roomx + 5 + (Math.random() > 0.5 ? 0 : 1), roomy + 3));
                        } else {
                            tile.setTile(i, j, tile.getIndex(roomx + 5 + 3 * Math.random(), roomy + 4));
                        }
                    } else {
                        tile.setTile(i, j, tile.getIndex(roomx + 1 + 3 * Math.random(), roomy + 1 + 3 * Math.random()));
                    }
                } else {
                    tile.setTile(i, j, tile.getIndex(roomx + 1 + 3 * Math.random(), roomy + 1 + 3 * Math.random()));
                }


                tile.setTile(1, height + 1, tile.getIndex(roomx + 5 + 3 * Math.random(), roomy + 4));
                tile.setTile(1, height + 2, tile.getIndex(roomx + 5 + 3 * Math.random(), roomy + 5));

                tile.setTile(width - 1, height + 1, tile.getIndex(roomx + 5 + 3 * Math.random(), roomy + 4));
                tile.setTile(width - 1, height + 2, tile.getIndex(roomx + 5 + 3 * Math.random(), roomy + 5));

            }
        }

        var entity:Item;
        layer = Constants.LAYER_GROUND;

        for (var i = 2; i < width - 1; i++) {
            entity = new Deco(roomx + 2, roomy + 1, "solid", Constants.LAYER_WALL);
            entity.setPositionOnTile(x + i, y);
            world.add(entity);

            entity = new Deco(roomx + 2, roomy + 6, "solid", Constants.LAYER_WALL);
            entity.setPositionOnTile(x + i, y + height);
            world.add(entity);
        }

        for (var j = 1; j < height; j++) {
            entity = new Deco(roomx + 1, roomy + 2, "solid", Constants.LAYER_WALL);
            entity.setPositionOnTile(x + 1, y + j);
            world.add(entity);

            entity = new Deco(roomx + 5, roomy + 2, "solid", Constants.LAYER_WALL);
            entity.setPositionOnTile(x + width - 1, y + j);
            world.add(entity);
        }

        entity = new Deco(roomx + 1, roomy + 1, "solid", Constants.LAYER_WALL);
        entity.setPositionOnTile(x + 1, y);
        world.add(entity);

        entity = new Deco(roomx + 5, roomy + 1, "solid", Constants.LAYER_WALL);
        entity.setPositionOnTile(x + width - 1, y);
        world.add(entity);


        entity = new Deco(roomx + 1, roomy + 6, "solid", Constants.LAYER_WALL);
        entity.setPositionOnTile(x + 1, y + height);
        world.add(entity);

        entity = new Deco(roomx + 5, roomy + 6, "solid", Constants.LAYER_WALL);
        entity.setPositionOnTile(x + width - 1, y + height);
        world.add(entity);

    }

}
}
