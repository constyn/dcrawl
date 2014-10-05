/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 7/24/13
 * Time: 3:52 PM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.dcrawl.rooms {
import flash.display.BitmapData;
import flash.display.Graphics;
import flash.display.Sprite;

import net.flashpunk.graphics.Stamp;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.EntitiesConstants;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.items.types.Triggerable;

public class FogOfWar extends Item {

    private var room:Triggerable;

    public function FogOfWar(config:Object, room:Triggerable) {
        this.room = room;
        setPositionOnTile(config.x, config.y);
        width = getMultipliedLocation(config.width + 1);
        height = getMultipliedLocation(config.height + 3);


        var sprite:Sprite = new Sprite;
        var g:Graphics = sprite.graphics;

        g.beginFill(0x000000, 0.8);
        g.drawRect(0, 0, width, height);
        g.endFill();

        var bd:BitmapData = new BitmapData(width, height, true, 0);
        bd.draw(sprite);


        var fow:Stamp = new Stamp(bd);
        fow.x = 0;
        fow.y = 0;
        addGraphic(fow);
        type = Constants.FOW;

        setHitbox(width - Constants.TILE_SIZE * 4, height - Constants.TILE_SIZE * 8, -Constants.TILE_SIZE * 2, -Constants.TILE_SIZE * 4);
    }


    override public function update():void {
        if (collide(EntitiesConstants.PLAYER, x, y)) {
            world.remove(this);
            room.trigger(this)
        }
    }
}
}
