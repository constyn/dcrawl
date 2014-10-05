/**
 * Created with IntelliJ IDEA.
 * User: cornel
 * Date: 7/25/13
 * Time: 10:23 PM
 * To change this template use File | Settings | File Templates.
 */
package org.spindle.dcrawl {
import net.flashpunk.Sfx;

public class SoundConstants {
    [Embed(source='../../../../res/sounds/soundtrack.mp3')]
    public static const SOUNDTRACK:Class;

    [Embed(source='../../../../res/sounds/doorclose.mp3')]
    public static const DOOR_CLOSE:Class;

    [Embed(source='../../../../res/sounds/finished.mp3')]
    public static const FINISHED:Class;

    [Embed(source='../../../../res/sounds/warp.mp3')]
    public static const WARP:Class;

    [Embed(source='../../../../res/sounds/explosion.mp3')]
    public static const EXPLOSION:Class;

    [Embed(source='../../../../res/sounds/step.mp3')]
    public static const STEP:Class;

    public static const soundtrack:Sfx = new Sfx(SoundConstants.SOUNDTRACK);

    public static const closeDoors:Sfx = new Sfx(SoundConstants.DOOR_CLOSE);
    public static const finished:Sfx = new Sfx(SoundConstants.FINISHED);
    public static const warp:Sfx = new Sfx(SoundConstants.WARP);
    public static const explosion:Sfx = new Sfx(SoundConstants.EXPLOSION);
    public static const step:Sfx = new Sfx(SoundConstants.STEP);
}
}

