using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

import Toybox.Lang;


class Fancyfonts {

    private static enum ALIGNMENT {
        GAP_ALIGNED,
        LEFT_ALIGNED,
        RIGHT_ALIGNED,
        CENTERED
    }

    private static const
        DEFAULT_GAP_TEXT = " ",
        DEFAULT_VERTICAL_SHIFT_FACTOR = 0.95,
        DEFAULT_VERTICAL_GAP_FACTOR = 1.3,
        DEFAULT_SECONDS_WIDTH = 1,
        DEFAULT_SECONDS_LENGTH_FACTOR = 0.2;

    private static const
        DEFAULT_DATE_FONT = Application.loadResource(Rez.Fonts.Date) as Graphics.FontType,
        DEFAULT_HOURS_FONT = Application.loadResource(Rez.Fonts.Acme) as Graphics.FontType,
        DEFAULT_MINUTES_FONT = Application.loadResource(Rez.Fonts.Acme) as Graphics.FontType;

    private static const
        HOUR_WORDS = Application.loadResource(Rez.JsonData.HourNames) as Array<String>,
        DAY_WORDS = Application.loadResource(Rez.JsonData.DayNames) as Array<String>,
        MONTH_WORDS = Application.loadResource(Rez.JsonData.MonthNames) as Array<String>;

    private static const
        DEFAULT_HOURS_COLOR = Graphics.COLOR_WHITE,
        DEFAULT_MINUTES_COLOR = Graphics.COLOR_ORANGE,
        DEFAULT_DATE_COLOR = Graphics.COLOR_DK_GRAY,
        DEFAULT_SECONDS_COLOR = Graphics.COLOR_DK_RED;


    private var 
        _time = Gregorian.info(Time.now(), Time.FORMAT_SHORT) as Gregorian.Info;

    private var
        _hoursColor = DEFAULT_HOURS_COLOR as Graphics.ColorType,
        _minutesColor = DEFAULT_MINUTES_COLOR as Graphics.ColorType,
        _dateColor = DEFAULT_DATE_COLOR as Graphics.ColorType,
        _secondsColor = DEFAULT_SECONDS_COLOR as Graphics.ColorType;

    private var
        _hourFont = DEFAULT_HOURS_FONT as Graphics.FontType,
        _minutesFont = DEFAULT_MINUTES_FONT as Graphics.FontType,
        _dateFont = DEFAULT_DATE_FONT as Graphics.FontType;

    private var
        _width as Number,
        _height as Number,
        _maxHourWidth as Number or Null,
        _hourWidth as Number or Null,
        _maxMinutesWidth as Number or Null,
        _minutesWidth as Number or Null,
        _gapWidth as Number or Null,
        _totalWidth as Number or Null,
        _centerY as Number;

    private var
        _hourString as String or Null,
        _minutesString as String or Null;


    private var 
        _dc as Graphics.Dc or Null;


    function initialize() {
        var settings = System.getDeviceSettings();
        _width = settings.screenWidth;
        _height = settings.screenHeight;
        _centerY = _height / 2;
    }


    function forTime(time as Gregorian.Info) as Fancyfonts {
        _time = time;
        return self;
    }

    function draw(dc as Graphics.Dc) as Fancyfonts {

        _dc = dc;

        var showDate = PropertyUtils.getPropertyElseDefault(DATE_PROPERTY_ID, DATE_PROPERTY_DEFAULT),
            showSeconds = PropertyUtils.getPropertyElseDefault(SECONDS_PROPERTY_ID, SECONDS_PROPERTY_DEFAULT),
            alignment = PropertyUtils.getPropertyElseDefault(ALIGNMENT_PROPERTY_ID, ALIGNMENT_PROPERTY_DEFAULT);

        if (showSeconds) {
            _drawSeconds();
        }

        var fonts = _getFonts();
        _hourFont = fonts[:hours];
        _minutesFont = fonts[:minutes];
        _dateFont = fonts[:date];

        _maxHourWidth = 0;
        for (var i = 0; i < HOUR_WORDS.size(); ++i) {
            var word = HOUR_WORDS[i],
                hourWidth = dc.getTextWidthInPixels(word, _hourFont);
            if (hourWidth > _maxHourWidth) {
                _maxHourWidth = hourWidth;
            }
        }

        _maxMinutesWidth = 0;
        for (var i = 0; i < 10; ++i) {
            var digit = i.format("%d"),
                minutesWidth = dc.getTextWidthInPixels(digit, _minutesFont);
            if (minutesWidth > _maxMinutesWidth) {
                _maxMinutesWidth = minutesWidth;
            }
        }
        _maxMinutesWidth *= 2;
        
        _gapWidth = dc.getTextWidthInPixels(DEFAULT_GAP_TEXT, _minutesFont) / 2;
        _totalWidth = _maxHourWidth + _maxMinutesWidth + _gapWidth;

        _centerY = (showDate) ? (DEFAULT_VERTICAL_SHIFT_FACTOR * _height / 2).toNumber() : _height / 2;

        _hourString = _timeToHour(_time);
        _hourWidth = dc.getTextWidthInPixels(_hourString, _hourFont);

        _minutesString = _timeToMinutes(_time);
        _minutesWidth = dc.getTextWidthInPixels(_minutesString, _minutesFont);

        switch (alignment) {
            case GAP_ALIGNED:
                _drawGapAligned(showDate);
                break;
            case LEFT_ALIGNED: // Left-aligned
                _drawLeftAligned(showDate);
                break;
            case RIGHT_ALIGNED: // Right-aligned
                _drawRightAligned(showDate);
                break;
            case CENTERED: // Centered
                _drawCentered(showDate);
                break;
            default:
                _drawGapAligned(showDate);
        }


        // var
        //     hourRight = (_width - _totalWidth) / 2 + _maxHourWidth,
        //     minutesLeft = hourRight + _gapWidth,
        //     minutesRight = minutesLeft + dc.getTextWidthInPixels(_minutesString, _minutesFont);

        // dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        // dc.drawText(hourRight, _centerY, _hourFont, _hourString, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        // dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        // dc.drawText(minutesLeft, _centerY, _minutesFont, _minutesString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        // if (showDate) {
        //     var
        //         dateY = (DEFAULT_VERTICAL_GAP_FACTOR * _centerY).toNumber(),
        //         date = _timeToDate(_time);
        //     dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
        //     dc.drawText(minutesRight, dateY, _dateFont, date, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        // }

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


    private function _drawSeconds() {
        var seconds = _time.sec,
            angle = 90 - (seconds / 60.0 * 360).toNumber(),
            radius = ((_width < _height) ? _width : _height) / 2,
            secondsLength = (DEFAULT_SECONDS_LENGTH_FACTOR * radius).toNumber(),
            secondsRadius = radius - secondsLength / 2,
            secondsWidth = DEFAULT_SECONDS_WIDTH;

        _dc.setColor(_secondsColor, Graphics.COLOR_TRANSPARENT);
        _dc.setPenWidth(secondsLength);
        _dc.drawArc(_width / 2, _height / 2, secondsRadius, Graphics.ARC_CLOCKWISE, angle + secondsWidth, angle - secondsWidth);
    }


    private function _timeToHour(time as Gregorian.Info) as String {
        return HOUR_WORDS[time.hour % 12];
    }


    private function _timeToMinutes(time as Gregorian.Info) as String {
        return time.min.format("%02d");
    }


    private function _timeToDate(time as Gregorian.Info) as String {
        var day = DAY_WORDS[time.day_of_week - 1],
            month = MONTH_WORDS[time.month - 1];
        return day + ", " + time.day + " " + month;
    }


    private function _drawGapAligned(showDate as Boolean) {

        var hourRight = (_width - _totalWidth) / 2 + _maxHourWidth,
            minutesLeft = hourRight + _gapWidth,
            minutesRight = minutesLeft + _minutesWidth;

        _dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(hourRight, _centerY, _hourFont, _hourString, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        _dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(minutesLeft, _centerY, _minutesFont, _minutesString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        if (showDate) {
            var dateY = (DEFAULT_VERTICAL_GAP_FACTOR * _centerY).toNumber(),
                date = _timeToDate(_time);
            _dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
            _dc.drawText(minutesRight, dateY, _dateFont, date, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
    }


    private function _drawLeftAligned(showDate as Boolean) {

        var hourLeft = (_width - _totalWidth) / 2,
            minutesLeft = hourLeft + _hourWidth + _gapWidth;

        _dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(hourLeft, _centerY, _hourFont, _hourString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        _dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(minutesLeft, _centerY, _minutesFont, _minutesString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        if (showDate) {
            var dateY = (DEFAULT_VERTICAL_GAP_FACTOR * _centerY).toNumber(),
                date = _timeToDate(_time);
            _dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
            _dc.drawText(hourLeft, dateY, _dateFont, date, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }

    }


    private function _drawRightAligned(showDate as Boolean) {

        var minutesRight = (_width + _totalWidth) / 2,
            hourRight = minutesRight - _minutesWidth - _gapWidth;

        _dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(hourRight, _centerY, _hourFont, _hourString, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        _dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(minutesRight, _centerY, _minutesFont, _minutesString, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);

        if (showDate) {
            var
                dateY = (DEFAULT_VERTICAL_GAP_FACTOR * _centerY).toNumber(),
                date = _timeToDate(_time);
            _dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
            _dc.drawText(minutesRight, dateY, _dateFont, date, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
    }


    private function _drawCentered(showDate as Boolean) {

        var totalWidth = _hourWidth + _minutesWidth + _gapWidth,
            hourLeft = (_width - totalWidth) / 2,
            minutesLeft = hourLeft + _hourWidth + _gapWidth;

        _dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(hourLeft, _centerY, _hourFont, _hourString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        _dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        _dc.drawText(minutesLeft, _centerY, _minutesFont, _minutesString, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        if (showDate) {
            var
                dateY = (DEFAULT_VERTICAL_GAP_FACTOR * _centerY).toNumber(),
                date = _timeToDate(_time);
            _dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
            _dc.drawText(_width / 2, dateY, _dateFont, date, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }

    }


}