package org.spindle.dcrawl.items.weapons.bullets {

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
 * @author cornel
 */
public class Bomb extends SpritedItem {

    private var length:uint = 1;

    private var explode:uint = 30;

    public function Bomb(length:uint):void {
        this.length = length;
        spritemap.add("anim", [
            GraphicUtils.getTile(5, 18),
            GraphicUtils.getTile(5, 19),
            GraphicUtils.getTile(5, 20),
            GraphicUtils.getTile(5, 18),
            GraphicUtils.getTile(5, 19)
        ], 10, true);
        spritemap.play("anim");
        graphic = spritemap;
        setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
    }


    override public function update():void {
        if (explode--==0) {
            var uitem:SpritedItem = new Explosion(new BulletVO(null, Constants.ALL_DIRECTIONS, length));
			uitem.setPosition(x,y)
			world.add(uitem);
            world.remove(this);
        }
    }
}
}
