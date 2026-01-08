using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;

import Toybox.Lang;


class Fancyfonts {

    private static const DEFAULT_WIDEST_HOURS_TEXT = "Twelve";
    private static const DEFAULT_WIDEST_MINUTES_DIGITS = "55";
    private static const DEFAULT_GAP_TEXT = " ";
    private static const DEFAULT_VERTICAL_SHIFT_FACTOR = 0.95;
    private static const DEFAULT_VERTICAL_GAP_FACTOR = 1.3;

    private static const DEFAULT_SHOW_DATE = true;

    private static const DEFAULT_DATE_FONT = Application.loadResource(Rez.Fonts.Date);
    private static const DEFAULT_HOURS_FONT = Application.loadResource(Rez.Fonts.Acme);
    private static const DEFAULT_MINUTES_FONT = Application.loadResource(Rez.Fonts.Acme);
    private static const TIME_FONTS = [
        {
            :name => "Acme", 
            :font => Application.loadResource(Rez.Fonts.Acme)
        },
        {
            :name => "Asimovian", 
            :font => Application.loadResource(Rez.Fonts.Asimovian)
        },
        {
            :name => "Berkshire Swash", 
            :font => Application.loadResource(Rez.Fonts.BerkshireSwash)
        },
        {
            :name => "Gloria Hallelujah", 
            :font => Application.loadResource(Rez.Fonts.GloriaHallelujah)
        },
        {
            :name => "Philosopher", 
            :font => Application.loadResource(Rez.Fonts.Philosopher)
        },
        {
            :name => "Epunda Slab", 
            :font => Application.loadResource(Rez.Fonts.EpundaSlab)
        },
        {
            :name => "Cormorant Unicase", 
            :font => Application.loadResource(Rez.Fonts.CormorantUnicase)
        },
        {
            :name => "Poetsen One", 
            :font => Application.loadResource(Rez.Fonts.PoetsenOne)
        },
        {
            :name => "Turret Road", 
            :font => Application.loadResource(Rez.Fonts.TurretRoad)
        },
        {
            :name => "Grenze Gotisch", 
            :font => Application.loadResource(Rez.Fonts.GrenzeGotisch)
        },
        {
            :name => "Megrim", 
            :font => Application.loadResource(Rez.Fonts.Megrim)
        },
        {
            :name => "Sniglet", 
            :font => Application.loadResource(Rez.Fonts.Sniglet)
        },
        {
            :name => "Yusei Magic", 
            :font => Application.loadResource(Rez.Fonts.YuseiMagic)
        },
        {
            :name => "Croissant One", 
            :font => Application.loadResource(Rez.Fonts.CroissantOne)
        },
        {
            :name => "Quintessential", 
            :font => Application.loadResource(Rez.Fonts.Quintessential)
        },
        {
            :name => "Dyna Puff", 
            :font => Application.loadResource(Rez.Fonts.DynaPuff)
        },
        {
            :name => "Love Ya Like A Sister", 
            :font => Application.loadResource(Rez.Fonts.LoveYaLikeASister)
        },
        {
            :name => "Limelight", 
            :font => Application.loadResource(Rez.Fonts.Limelight)
        },
        {
            :name => "Unifraktur Maguntia", 
            :font => Application.loadResource(Rez.Fonts.UnifrakturMaguntia)
        },
        {
            :name => "SUSE", 
            :font => Application.loadResource(Rez.Fonts.SUSE)
        },
        {
            :name => "Fondamento", 
            :font => Application.loadResource(Rez.Fonts.Fondamento)
        },
        {
            :name => "Amatic SC", 
            :font => Application.loadResource(Rez.Fonts.AmaticSC)
        },
        {
            :name => "Lobster Two", 
            :font => Application.loadResource(Rez.Fonts.LobsterTwo)
        },
        {
            :name => "Changa", 
            :font => Application.loadResource(Rez.Fonts.Changa)
        },
        {
            :name => "Unica One", 
            :font => Application.loadResource(Rez.Fonts.UnicaOne)
        },
        {
            :name => "Tenor Sans", 
            :font => Application.loadResource(Rez.Fonts.TenorSans)
        },
        {
            :name => "Stack Sans Notch", 
            :font => Application.loadResource(Rez.Fonts.StackSansNotch)
        },
        {
            :name => "Special Elite", 
            :font => Application.loadResource(Rez.Fonts.SpecialElite)
        },
        {
            :name => "Rammetto One", 
            :font => Application.loadResource(Rez.Fonts.RammettoOne)
        },
        {
            :name => "Merienda", 
            :font => Application.loadResource(Rez.Fonts.Merienda)
        },
        {
            :name => "Macondo", 
            :font => Application.loadResource(Rez.Fonts.Macondo)
        },
        {
            :name => "Italiana", 
            :font => Application.loadResource(Rez.Fonts.Italiana)
        },
        {
            :name => "Jura", 
            :font => Application.loadResource(Rez.Fonts.Jura)
        },
        {
            :name => "Handlee", 
            :font => Application.loadResource(Rez.Fonts.Handlee)
        },
        {
            :name => "Delius", 
            :font => Application.loadResource(Rez.Fonts.Delius)
        },
        {
            :name => "Caveat Brush", 
            :font => Application.loadResource(Rez.Fonts.CaveatBrush)
        },
        {
            :name => "Amaranth", 
            :font => Application.loadResource(Rez.Fonts.Amaranth)
        }
    ];
    
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

    private static const DAY_WORDS = [ // TODO load from resources
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ];

    private static const MONTH_WORDS = [ // TODO load from resources
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ];

    private static const DEFAULT_HOURS_COLOR = Graphics.COLOR_WHITE;
    private static const DEFAULT_MINUTES_COLOR = Graphics.COLOR_ORANGE;
    private static const DEFAULT_DATE_COLOR = Graphics.COLOR_DK_GRAY;


    private var _time = Gregorian.info(Time.now(), Time.FORMAT_SHORT) as Gregorian.Info;
    private var _hoursColor = DEFAULT_HOURS_COLOR as Graphics.ColorType;
    private var _minutesColor = DEFAULT_MINUTES_COLOR as Graphics.ColorType;
    private var _dateColor = DEFAULT_DATE_COLOR as Graphics.ColorType;
    private var _showDate = DEFAULT_SHOW_DATE as Boolean;


    function initialize() {
    }

    function forTime(time as Gregorian.Info) as Fancyfonts {
        _time = time;
        return self;
    }

    function draw(dc as Graphics.Dc) as Fancyfonts {

        // TODO: set based on properties
        // var fonts = _getFonts(_time.sec % TIME_FONTS.size());
        var fonts = _getFonts(TIME_FONTS.size() - 1);
        var hoursFont = fonts[:hours];
        var minutesFont = fonts[:minutes];

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerY = (DEFAULT_VERTICAL_SHIFT_FACTOR * height / 2).toNumber();

        // var hoursDimensions = dc.getTextDimensions(DEFAULT_WIDEST_HOURS_TEXT, hoursFont);
        // var hoursWidth = hoursDimensions[0];
        // var hoursHeight = hoursDimensions[1];
        var hoursWidth = dc.getTextWidthInPixels(DEFAULT_WIDEST_HOURS_TEXT, hoursFont);
        var minutesWidth = dc.getTextWidthInPixels(DEFAULT_WIDEST_MINUTES_DIGITS, minutesFont);
        var gapWidth = dc.getTextWidthInPixels(DEFAULT_GAP_TEXT, minutesFont);

        var totalWidth = hoursWidth + minutesWidth + gapWidth;

        var hoursX = (width - totalWidth) / 2;
        var gapX  = hoursX + hoursWidth;
        var minutesX = gapX + gapWidth;

        var hour = _timeToHour(_time);
        var minutes = _timeToMinutes(_time);

        dc.setColor(_hoursColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(gapX, centerY, hoursFont, hour, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        
        dc.setColor(_minutesColor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(minutesX, centerY, minutesFont, minutes, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

        if (_showDate) { // TODO get from properties
            var dateFont = fonts[:date];
            var dateX = hoursX + totalWidth;
            // var dateY = (centerY + DEFAULT_VERTICAL_GAP_FACTOR * hoursHeight).toNumber();
            var dateY = (DEFAULT_VERTICAL_GAP_FACTOR * centerY).toNumber();
            var date = _timeToDate(_time);
            dc.setColor(_dateColor, Graphics.COLOR_TRANSPARENT);
            dc.drawText(dateX, dateY, dateFont, date, Graphics.TEXT_JUSTIFY_RIGHT | Graphics.TEXT_JUSTIFY_VCENTER);
        }

        return self;

    }

    private static function _getFonts(index as Number) as Dictionary<Symbol, Graphics.FontType> {
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