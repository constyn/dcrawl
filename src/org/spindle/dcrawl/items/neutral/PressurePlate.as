/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 7/14/13
 * Time: 7:04 PM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.dcrawl.items.neutral {
import net.flashpunk.Entity;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.EntitiesConstants;
import org.spindle.dcrawl.abstract.SpritedItem;
import org.spindle.dcrawl.items.types.Triggerable;
import org.spindle.dcrawl.utils.GraphicUtils;

public class PressurePlate extends SpritedItem implements Triggerable {

    private var trigerables:Array;
    private var on:Boolean = false;

    public function PressurePlate(triggerables:Array, onlyOn:Boolean = false, tilex:uint = 18, tiley:uint = 8) {
        this.trigerables = triggerables;
        spritemap.add("free", [GraphicUtils.getTile(tiley, tilex+1)], 0, false);
        spritemap.add("pressed", [GraphicUtils.getTile(tiley, tilex)], 0, false);
        spritemap.play("free");
        graphic = spritemap;
        layer = Constants.ON_GROUND;
        setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
        type = Constants.TRIGERABLE;
    }

    override public function update():void {

        if (collideTypes(EntitiesConstants.PLAYER, x, y)) {
            if (on==false) {
                for each (var trig:Triggerable in trigerables) {
                    trig.trigger(this);
                }
                spritemap.play("pressed");
                on = true;
            }
        } else if (on) {
            spritemap.play("free");
            on = false;
        }

    }

    public function trigger(by:Entity = null):void {

    }
}
}
