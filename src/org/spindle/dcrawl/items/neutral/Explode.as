package org.spindle.dcrawl.items.neutral {
import net.flashpunk.FP;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.SoundConstants;
import org.spindle.dcrawl.abstract.Item;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.utils.GraphicUtils;

/**
 * @author cornel
 */
public class Explode extends SpritedItem {

    private var frame:uint = 0;

    public function Explode(parent:Item, type:uint = 0):void {
        if (type == 0)
            spritemap.add("anim", [
                GraphicUtils.getTile(4, 19),
                GraphicUtils.getTile(4, 20),
                GraphicUtils.getTile(4, 21),
                GraphicUtils.getTile(4, 22),
                GraphicUtils.getTile(4, 23),
                GraphicUtils.getTile(4, 24),
                GraphicUtils.getTile(4, 25),
                GraphicUtils.getTile(4, 26)], 10, true);
        else if (type == 1)
            spritemap.add("anim", [
                GraphicUtils.getTile(3, 19),
                GraphicUtils.getTile(3, 20),
                GraphicUtils.getTile(3, 21),
                GraphicUtils.getTile(3, 22),
                GraphicUtils.getTile(3, 23),
                GraphicUtils.getTile(3, 24),
                GraphicUtils.getTile(3, 25),
                GraphicUtils.getTile(3, 26)], 10, true);
        else if (type == 2)
            spritemap.add("anim", [
                GraphicUtils.getTile(9, 23),
                GraphicUtils.getTile(9, 24),
                GraphicUtils.getTile(9, 25),
                GraphicUtils.getTile(9, 26),
                GraphicUtils.getTile(9, 27),
                GraphicUtils.getTile(9, 28),
                GraphicUtils.getTile(9, 29),
                GraphicUtils.getTile(9, 30)], 10, true);
        spritemap.play("anim");
        graphic = spritemap;
        setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
        x = parent.x;
        y = parent.y;
        layer = parent.layer;
        if (type<2) {
            SoundConstants.explosion.play();
        }


        FP.world.recycle(parent);

    }

    override public function update():void {

        if (++frame > 40) {
            world.remove(this);
        }

    }
}
}
