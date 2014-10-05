package org.spindle.dcrawl.items.neutral {
import net.flashpunk.Entity;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.types.Triggerable;
import org.spindle.dcrawl.utils.GraphicUtils;

public class Door extends SpritedItem implements Triggerable {

    private var state:Boolean = true;
    private var aboveTypeEntity:Boolean;

    public function Door(px:uint, py:uint,aboveTypeEntity:Boolean = false) {
        this.aboveTypeEntity = aboveTypeEntity;
        if (!aboveTypeEntity) {
            spritemap.add("doorclosed", [GraphicUtils.getTile(py,px)], 0, false);
            layer = Constants.ON_GROUND;
            type = Constants.SOLID;
        } else {
            spritemap.add("doorclosed", [GraphicUtils.getTile(py,px)], 0, false);
            layer = Constants.LAYER_ABOVE;
            type = Constants.NONE;
        }

        spritemap.add("dooropened", [GraphicUtils.getTile(py,px+1)], 0, false);

        graphic = spritemap;
        setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
        selectState();
    }

    public function trigger(by:Entity = null):void {
        if (!by) {
            state = !state;
            selectState();
        }
    }

    private function selectState():void {
        if (!state) {
            spritemap.play("doorclosed");
            if (!aboveTypeEntity) {
                type = Constants.SOLID;
            }
        } else {
            spritemap.play("dooropened");
            if (!aboveTypeEntity) {
                type = Constants.NONE;
            }
        }
    }
}
}
