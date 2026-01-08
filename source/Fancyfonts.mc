using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;

import Toybox.Lang;


class Fancyfonts {

    private static const DEFAULT_WIDEST_HOURS_TEXT = "Twelve";
    private static const DEFAULT_WIDEST_MINUTES_TEXT = "Twenty eight";
    private static const DEFAULT_WIDEST_HOURS_DIGITS = "10";
    private static const DEFAULT_WIDEST_MINUTES_DIGITS = "55";
    private static const DEFAULT_GAP_TEXT = " ";
    
    private static const HOUR_WORDS = [ // TODO load from resources
        "Twelve",
        "One",
        "Two",
        "Three",
        "Four",
        "Five",
        "Six",
        "Seven",
        "Eight",
        "Nine",
        "Ten",
        "Eleven"
    ];

    private static const DEFAULT_HOURS_FONT = Graphics.FONT_MEDIUM;
    private static const DEFAULT_MINUTES_FONT = Graphics.FONT_MEDIUM;

    private static const DEFAULT_HOURS_COLOR = Graphics.COLOR_WHITE;
    private static const DEFAULT_MINUTES_COLOR = Graphics.COLOR_ORANGE;


    private var _time as System.ClockTime;
    private var _hoursFont = DEFAULT_HOURS_FONT as Graphics.FontType;
    private var _minutesFont = DEFAULT_MINUTES_FONT as Graphics.FontType;
    private var _hoursColor = DEFAULT_HOURS_COLOR as Graphics.ColorType;
    private var _minutesColor = DEFAULT_MINUTES_COLOR as Graphics.ColorType;
    private var _gapText = DEFAULT_GAP_TEXT as String;


    function initialize() {
        _time = System.getClockTime();
    }

    function forTime(time as System.ClockTime) as Fancyfonts {
        _time = time;
        return self;
    }

    function draw(dc as Graphics.Dc) as Fancyfonts {

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerY = height / 2;

        var hoursWidth = dc.getTextWidthInPixels(DEFAULT_WIDEST_HOURS_TEXT, _hoursFont);
        var minutesWidth = dc.getTextWidthInPixels(DEFAULT_WIDEST_MINUTES_DIGITS, _minutesFont);
        var gapWidth = dc.getTextWidthInPixels(DEFAULT_GAP_TEXT, _minutesFont);

        var totalWidth = hoursWidth + minutesWidth + gapWidth;

        var hoursX = (width - totalWidth) / 2;
        var gapX  = hoursX + hoursWidth;
        var minutesX = gapX + gapWidth;

        dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(gapX, centerY, _hoursFont, HOUR_WORDS[_time.hour % 12], Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawText(gapX, centerY, _minutesFont, _gapText, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(minutesX, centerY, _minutesFont, _time.min.format("%02d"), Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        return self;
    }

}