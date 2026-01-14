using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

import Toybox.Lang;


class Fancyfonts {

    private static const DEFAULT_GAP_TEXT = " ";
    private static const DEFAULT_VERTICAL_SHIFT_FACTOR = 0.95;
    private static const DEFAULT_VERTICAL_GAP_FACTOR = 1.3;
    private static const DEFAULT_SECONDS_WIDTH = 1;
    private static const DEFAULT_SECONDS_LENGTH_FACTOR = 0.2;

    private static const DEFAULT_DATE_FONT = Application.loadResource(Rez.Fonts.Date) as Graphics.FontType;
    private static const DEFAULT_HOURS_FONT = Application.loadResource(Rez.Fonts.Acme) as Graphics.FontType;
    private static const DEFAULT_MINUTES_FONT = Application.loadResource(Rez.Fonts.Acme) as Graphics.FontType;

    private static const HOUR_WORDS = Application.loadResource(Rez.JsonData.HourNames) as Array<String>;
    private static const DAY_WORDS = Application.loadResource(Rez.JsonData.DayNames) as Array<String>;
    private static const MONTH_WORDS = Application.loadResource(Rez.JsonData.MonthNames) as Array<String>;

    private static const DEFAULT_HOURS_COLOR = Graphics.COLOR_WHITE;
    private static const DEFAULT_MINUTES_COLOR = Graphics.COLOR_ORANGE;
    private static const DEFAULT_DATE_COLOR = Graphics.COLOR_DK_GRAY;
    private static const DEFAULT_SECONDS_COLOR = Graphics.COLOR_DK_RED;


    private var 
        _time = Gregorian.info(Time.now(), Time.FORMAT_SHORT) as Gregorian.Info;

    private var
        _hoursColor = DEFAULT_HOURS_COLOR as Graphics.ColorType,
        _minutesColor = DEFAULT_MINUTES_COLOR as Graphics.ColorType,
        _dateColor = DEFAULT_DATE_COLOR as Graphics.ColorType,
        _secondsColor = DEFAULT_SECONDS_COLOR as Graphics.ColorType;
    // private var _showDate = DEFAULT_SHOW_DATE as Boolean;


    function initialize() {
    }


    function forTime(time as Gregorian.Info) as Fancyfonts {
        _time = time;
        return self;
    }

    function draw(dc as Graphics.Dc) as Fancyfonts {

        var showDate = PropertyUtils.getPropertyElseDefault(DATE_PROPERTY_ID, DATE_PROPERTY_DEFAULT);
        var showSeconds = PropertyUtils.getPropertyElseDefault(SECONDS_PROPERTY_ID, SECONDS_PROPERTY_DEFAULT);

        var fonts = _getFonts();
        var hoursFont = fonts[:hours];
        var minutesFont = fonts[:minutes];

        var width = dc.getWidth();
        var height = dc.getHeight();

        if (showSeconds) {
            var seconds = _time.sec;
            var angle = 90 - (seconds / 60.0 * 360).toNumber();
            var radius = ((width < height) ? width : height) / 2;
            var secondsLength = (DEFAULT_SECONDS_LENGTH_FACTOR * radius).toNumber();
            var secondsRadius = radius - secondsLength / 2;
            var secondsWidth = DEFAULT_SECONDS_WIDTH;
            dc.setColor(_secondsColor, Graphics.COLOR_TRANSPARENT);
            dc.setPenWidth(secondsLength);
            dc.drawArc(width / 2, height / 2, secondsRadius, Graphics.ARC_CLOCKWISE, angle + secondsWidth, angle - secondsWidth);
            // dc.setPenWidth(1);
        }

        var maxHoursWidth = 0;
        for (var i = 0; i < HOUR_WORDS.size(); ++i) {
            var word = HOUR_WORDS[i];
            var hourWidth = dc.getTextWidthInPixels(word, hoursFont);
            if (hourWidth > maxHoursWidth) {
                maxHoursWidth = hourWidth;
            }
        }

        var maxMinutesWidth = 0;
        for (var i = 0; i < 10; ++i) {
            var digit = i.format("%d");
            var minutesWidth = dc.getTextWidthInPixels(digit, minutesFont);
            if (minutesWidth > maxMinutesWidth) {
                maxMinutesWidth = minutesWidth;
            }
        }
        maxMinutesWidth *= 2;
        
        var gapWidth = dc.getTextWidthInPixels(DEFAULT_GAP_TEXT, minutesFont) / 2;

        var totalWidth = maxHoursWidth + maxMinutesWidth + gapWidth;
        var hourRight = (width - totalWidth) / 2 + maxHoursWidth;
        var minutesLeft = hourRight + gapWidth;

        var centerY = (showDate) ? (DEFAULT_VERTICAL_SHIFT_FACTOR * height / 2).toNumber() : height / 2;

        var hour = _timeToHour(_time);
        var minutes = _timeToMinutes(_time);
        var minutesRight = minutesLeft + dc.getTextWidthInPixels(minutes, minutesFont);

        dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(hourRight, centerY, hoursFont, hour, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(minutesLeft, centerY, minutesFont, minutes, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        if (showDate) {
            var dateFont = fonts[:date];
            var dateY = (DEFAULT_VERTICAL_GAP_FACTOR * centerY).toNumber();
            var date = _timeToDate(_time);
            dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(minutesRight, dateY, dateFont, date, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        return self;

    }

    private static function _getFonts() as Dictionary<Symbol, Graphics.FontType> {
        var index = PropertyUtils.getPropertyElseDefault(FONT_PROPERTY_ID, FONT_PROPERTY_DEFAULT);
        if (index < 0 or index >= TIME_FONTS.size()) {
            return {
                :hours => DEFAULT_HOURS_FONT, 
                :minutes => DEFAULT_MINUTES_FONT,
                :date => DEFAULT_DATE_FONT
            };
        }
        var fonts = TIME_FONTS[index];
        return {
            :hours => fonts[fonts.hasKey(:hours) ? :hours : :font],
            :minutes => fonts[fonts.hasKey(:minutes) ? :minutes : :font],
            :date => fonts.hasKey(:date) ? fonts[:date] : DEFAULT_DATE_FONT
        };
    }

    private function _timeToHour(time as Gregorian.Info) as String {
        return HOUR_WORDS[time.hour % 12];
    }

    private function _timeToMinutes(time as Gregorian.Info) as String {
        return time.min.format("%02d");
    }

    private function _timeToDate(time as Gregorian.Info) as String {
        var day = DAY_WORDS[time.day_of_week - 1];
        var month = MONTH_WORDS[time.month - 1];
        return day + ", " + time.day + " " + month;
    }



}