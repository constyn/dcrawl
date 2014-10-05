package org.spindle.dcrawl.utils {
import net.flashpunk.graphics.Spritemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.DCrawl;

/**
 * @author cornel
 */
public class BodyGraphicHelper {

    internal var sprite:Spritemap = new Spritemap(DCrawl.TILES, Constants.TILE_SIZE, Constants.TILE_SIZE);

    public function BodyGraphicHelper(lx:uint, ly:uint) {
        sprite.add("goingRight", [GraphicUtils.getTile(ly, lx), GraphicUtils.getTile(ly + 1, lx), GraphicUtils.getTile(ly, lx), GraphicUtils.getTile(ly + 2, lx)], 10, true);
        sprite.add("goingLeft", [GraphicUtils.getTile(ly, lx + 1), GraphicUtils.getTile(ly + 1, lx + 1), GraphicUtils.getTile(ly, lx + 1), GraphicUtils.getTile(ly + 2, lx + 1)], 10, true);

        sprite.add("goingDown", [GraphicUtils.getTile(ly, lx + 2), GraphicUtils.getTile(ly + 1, lx + 2), GraphicUtils.getTile(ly, lx + 2), GraphicUtils.getTile(ly + 2, lx + 2)], 10, true);
        sprite.add("goingUp", [GraphicUtils.getTile(ly, lx + 3), GraphicUtils.getTile(ly + 1, lx + 3), GraphicUtils.getTile(ly, lx + 3), GraphicUtils.getTile(ly + 2, lx + 3)], 10, true);

        sprite.add("goingRightShoot", [GraphicUtils.getTile(ly + 3, lx)], 0, false);
        sprite.add("goingLeftShoot", [GraphicUtils.getTile(ly + 3, lx + 1)], 0, false);
        sprite.add("goingDownShoot", [GraphicUtils.getTile(ly + 3, lx + 2)], 0, false);
        sprite.add("goingUpShoot", [GraphicUtils.getTile(ly + 3, lx + 3)], 0, false);

        sprite.add("goingRightS", [GraphicUtils.getTile(ly, lx)], 0, false);
        sprite.add("goingLeftS", [GraphicUtils.getTile(ly, lx + 1)], 0, false);
        sprite.add("goingDownS", [GraphicUtils.getTile(ly, lx + 2)], 0, false);
        sprite.add("goingUpS", [GraphicUtils.getTile(ly, lx + 3)], 0, false);


        sprite.play("goingRightS");
    }

    public function get graphics():Spritemap {
        return sprite;
    }

    public static function buildBody(lx:uint, ly:uint, frameRate:uint = 10):Spritemap {
        var sprite:Spritemap = new Spritemap(DCrawl.TILES, Constants.TILE_SIZE, Constants.TILE_SIZE);
        sprite.add("goingRight", [GraphicUtils.getTile(ly, lx), GraphicUtils.getTile(ly + 1, lx), GraphicUtils.getTile(ly, lx), GraphicUtils.getTile(ly + 2, lx)], frameRate, true);
        sprite.add("goingLeft", [GraphicUtils.getTile(ly, lx + 1), GraphicUtils.getTile(ly + 1, lx + 1), GraphicUtils.getTile(ly, lx + 1), GraphicUtils.getTile(ly + 2, lx + 1)], frameRate, true);
        sprite.add("goingDown", [GraphicUtils.getTile(ly, lx + 2), GraphicUtils.getTile(ly + 1, lx + 2), GraphicUtils.getTile(ly, lx + 2), GraphicUtils.getTile(ly + 2, lx + 2)], frameRate, true);
        sprite.add("goingUp", [GraphicUtils.getTile(ly, lx + 3), GraphicUtils.getTile(ly + 1, lx + 3), GraphicUtils.getTile(ly, lx + 3), GraphicUtils.getTile(ly + 2, lx + 3)], frameRate, true);

        sprite.add("goingRightShoot", [GraphicUtils.getTile(ly + 3, lx)], 0, false);
        sprite.add("goingLeftShoot", [GraphicUtils.getTile(ly + 3, lx + 1)], 0, false);
        sprite.add("goingDownShoot", [GraphicUtils.getTile(ly + 3, lx + 2)], 0, false);
        sprite.add("goingUpShoot", [GraphicUtils.getTile(ly + 3, lx + 3)], 0, false);

        sprite.add("goingRightS", [GraphicUtils.getTile(ly, lx)], 0, false);
        sprite.add("goingLeftS", [GraphicUtils.getTile(ly, lx + 1)], 0, false);
        sprite.add("goingDownS", [GraphicUtils.getTile(ly, lx + 2)], 0, false);
        sprite.add("goingUpS", [GraphicUtils.getTile(ly, lx + 3)], 0, false);


        sprite.play("goingRightS");
        return sprite;
    }

}
}
