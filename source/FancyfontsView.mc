using Toybox.Application.Properties;
using Toybox.Graphics;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.WatchUi;

import Toybox.Lang;


class FancyfontsView extends WatchUi.WatchFace {

    private const _fancyfonts = new Fancyfonts();

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }


    function onShow() {
    }


    function onUpdate(dc) {

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        var time = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

        // Debug: set time to the widest values (may depend on the actual font)
        if (DEBUG) {
            time.hour = 12;
            time.min = 00;
        }

        _fancyfonts
            .forTime(time)
            .draw(dc);

    }

}