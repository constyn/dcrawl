/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 7/16/13
 * Time: 12:03 AM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.dcrawl.rooms {
import net.flashpunk.graphics.Tilemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.DCrawl;
import org.spindle.dcrawl.abstract.Item;

public class Bridge extends Item {

    private var tile:Tilemap;

    public function Bridge(vertical:Boolean = false) {
        type = Constants.ROOM_TYPE;
        layer = Constants.LAYER_GROUND;
        //setPositionOnTile(px, py);

        if (!vertical) {
            tile = new Tilemap(DCrawl.TILES, Constants.TILE_SIZE * 2, Constants.TILE_SIZE * 4, Constants.TILE_SIZE, Constants.TILE_SIZE);
            tile.setTile(0,0,tile.getIndex(15,5));
            tile.setTile(0,1,tile.getIndex(15,6));
            tile.setTile(0,2,tile.getIndex(15,6));
            tile.setTile(0,3,tile.getIndex(15,7));

            tile.setTile(1,0,tile.getIndex(15,5));
            tile.setTile(1,1,tile.getIndex(15,6));
            tile.setTile(1,2,tile.getIndex(15,6));
            tile.setTile(1,3,tile.getIndex(15,7));

        }
        else {
            tile = new Tilemap(DCrawl.TILES, Constants.TILE_SIZE * 4, Constants.TILE_SIZE * 2, Constants.TILE_SIZE, Constants.TILE_SIZE);
            tile.setTile(0,0,tile.getIndex(13,8));
            tile.setTile(1,0,tile.getIndex(14,8));
            tile.setTile(2,0,tile.getIndex(14,8));
            tile.setTile(3,0,tile.getIndex(15,8));

            tile.setTile(0,1,tile.getIndex(13,8));
            tile.setTile(1,1,tile.getIndex(14,8));
            tile.setTile(2,1,tile.getIndex(14,8));
            tile.setTile(3,1,tile.getIndex(15,8));
        }
        graphic = tile;

    }


}
}
