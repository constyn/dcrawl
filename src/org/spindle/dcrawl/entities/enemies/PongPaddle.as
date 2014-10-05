package org.spindle.dcrawl.entities.enemies {
import net.flashpunk.Entity;
import net.flashpunk.graphics.Tilemap;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.DCrawl;

/**
 * @author cornel
 */
public class PongPaddle extends Entity {

    private var dx:int = 1;
    private var dy:int = 1;

    public function PongPaddle(px:uint, py:uint) {
        super(px, py)
        
		var tile:Tilemap = new Tilemap(DCrawl.TILES, Constants.TILE_SIZE * 2, Constants.TILE_SIZE * 4, Constants.TILE_SIZE, Constants.TILE_SIZE);
		tile.setTile(0,0,tile.getIndex(15,5));
		tile.setTile(0,1,tile.getIndex(15,6));
		tile.setTile(0,2,tile.getIndex(15,6));
		tile.setTile(0,3,tile.getIndex(15,7));
		
        
        graphic = tile;

		name = "paddle"
    }


    override public function update():void {
/*
        var nx:Number = x + vo.speed * dx;
        var ny:Number  = y + vo.speed * dy;

        if (collide("solid", nx, ny)) {
            if (collide("solid", nx, y)) {
                dx *= -1;
            } else if (collide("solid", x, ny)) {
                dy *= -1;
            } else {
                if (Math.random()>0.5)
                    dx *= -1;
                else
                    dy *= -1;
            }

            if (dx > 0) {
                if (dy>0) {
                    body.play("goingRight");
                } else {
                    body.play("goingUp");
                }
            } else {
                if (dy>0) {
                    body.play("goingLeft");
                } else {
                    body.play("goingDown");
                }
            }

        } else {
            x = nx;
            y = ny;
        }*/
    }

}
}
