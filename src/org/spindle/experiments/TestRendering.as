/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 9/12/13
 * Time: 9:45 PM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.experiments {
import net.flashpunk.Engine;
import net.flashpunk.FP;
import net.flashpunk.World;

import org.spindle.dcrawl.Constants;

[SWF(width='800', height='600', backgroundColor='#ffffff', frameRate='60')]
public class TestRendering extends Engine {

    [Embed(source='../../../../res/testp.png')]
    public static const TILES:Class;

    //public static const TILES_SPRITE_MAP : Spritemap = new Spritemap(TILES, 16, 16);

    public function TestRendering() {
        super(800, 600, 32, false);

        //FP.randomSeed = 123;
        FP.screen.scale = 2;

        FP.screen.color = 0x000000;
        FP.console.enable();
        FP.console.log("Seed: " + FP.randomSeed)
        //System.setClipboard(FP.randomSeed+"");


        var w:World = new W();

//        var d:TestEntity = new TestEntity(2,2);
//        d.x = 100;
//        d.y = 100;
//
//        w.add(d);
        FP.world = w;


    }


}

}

import flash.display.BitmapData;

import net.flashpunk.FP;
import net.flashpunk.World;
import net.flashpunk.graphics.Spritemap;
import net.flashpunk.graphics.Stamp;
import net.flashpunk.utils.Draw;
import net.flashpunk.utils.Input;
import net.flashpunk.utils.Key;

import org.spindle.dcrawl.Constants;
import org.spindle.dcrawl.utils.GraphicUtils;
import org.spindle.experiments.ColorUtil;
import org.spindle.experiments.TestRendering;

internal class W extends World {
    public var spritemap:Spritemap = new Spritemap(TestRendering.TILES, 640, 480);

    override public function begin():void {
        super.begin();

        var picture:BitmapData = new BitmapData(300, 300, true, 0);
        Draw.setTarget(picture);
        spritemap.add("deco", [GraphicUtils.getTile(18, 18)], 0, false);
        spritemap.play("deco");
        Draw.graphic(spritemap, 0, 0);

        flare(120, 45, picture);

        flare(60, 55, picture);

        addGraphic(new Stamp(picture));
    }

    private function flare(x:uint, y:uint, picture:BitmapData):void {

        var original = picture.getPixel(i,j);

        //picture.setPixel(x,y,0xFF0000);

        var width = 30;
        for (var i = x - width ; i < x + width ; i++) {
            for (var j = y - width ; j < y + width ; j++) {
                var a = Math.abs(x - i);
                a = a * a;
                var b = Math.abs(y - j);
                b = b * b;
                var c = Math.sqrt(a+b);
                if (a + b < width  * width ) {
                    var value = picture.getPixel(i, j);
                    picture.setPixel(i, j, ColorUtil.brightenColor(value, ((width - c) / width) * 50 ));
                }
            }
        }

    }

    override public function update():void {
        if (Input.check(Key.LEFT)) {
            FP.camera.x -= 2
        }

        if (Input.check(Key.RIGHT)) {
            FP.camera.x += 2;
        }

        if (Input.check(Key.UP)) {
            FP.camera.y -= 2;
        }

        if (Input.check(Key.DOWN)) {
            FP.camera.y += 2;
        }
    }

}

