package org.spindle.dcrawl.entities.enemies {
import org.spindle.dcrawl.utils.BodyGraphicHelper;

/**
 * @author cornel
 */
public class Monitor extends Enemy {

    private var dx:int = 1;
    private var dy:int = 1;

    public function Monitor(px:uint, py:uint) {
        super(px, py)
        body = BodyGraphicHelper.buildBody(10, 23, 15);
        graphic = body;

        body.play("goingRight");
        setHitbox(8, 8);

        vo.damage = 1;
        vo.speed = 1;

        vo.health = 99999;
    }


    override public function update():void {

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
        }
    }

}
}
