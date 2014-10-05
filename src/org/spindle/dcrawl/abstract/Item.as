/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 7/13/13
 * Time: 9:56 AM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.dcrawl.abstract {
import net.flashpunk.Entity;
import net.flashpunk.FP;

import org.spindle.dcrawl.Constants;

public class Item extends Entity {
    public function roundPositionOnTile(px:uint, py:uint):void {
        x = Math.round(px / Constants.TILE_SIZE) * Constants.TILE_SIZE;
        y = Math.round(py / Constants.TILE_SIZE) * Constants.TILE_SIZE;
    }

    public function setPositionOnTile(px:uint, py:uint):void {
        x = px * Constants.TILE_SIZE;
        y = py * Constants.TILE_SIZE;
    }

    public static function getMultipliedLocation(val:Number):Number  {
        return val*Constants.TILE_SIZE;
    }

    public function setPosition(px:int, py:int):void {
        x = px;
        y = py;
    }

    public static function getTileLoc(num:Number):uint {
        return Math.round(num / Constants.TILE_SIZE) * Constants.TILE_SIZE;
    }

    public static function randomIntervalFrom(start:int, length:int):int {
        return Math.round(start + FP.random * length);
    }
}
}
