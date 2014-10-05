/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 9/12/13
 * Time: 9:54 PM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.experiments {
import net.flashpunk.Entity;
import net.flashpunk.graphics.Spritemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.utils.GraphicUtils;

public class TestEntity extends Entity {

    public var spritemap:Spritemap = new Spritemap(TestRendering.TILES, Constants.TILE_SIZE, Constants.TILE_SIZE);

    public function TestEntity(tilex:uint, tiley:uint, type:String = null, layer:int = 50):void {
        spritemap.add("deco", [GraphicUtils.getTile(tiley, tilex)], 0, false);
        spritemap.play("deco");
        graphic = spritemap;
        layer = layer;
        if (type) {
            this.type = type;
            setHitbox(Constants.TILE_SIZE, Constants.TILE_SIZE);
        }

    }

}
}
