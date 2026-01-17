using Toybox.Application;
using Toybox.Graphics;

import Toybox.Lang;


(:debug)
const
    RELEASE = false,
    DEBUG = true;

(:release)
const
    RELEASE = true,
    DEBUG = false;



// Settings
const 
    CUSTOMIZE_MENU_TITLE = Application.loadResource(Rez.Strings.FontMenuTitle);

const
    DATE_MENU_TITLE = Application.loadResource(Rez.Strings.DateMenuTitle),
    DATE_PROPERTY_ID = "Date",
    DATE_PROPERTY_DEFAULT = true;

const
    SECONDS_MENU_TITLE = Application.loadResource(Rez.Strings.SecondsMenuTitle),
    SECONDS_PROPERTY_ID = "Seconds",
    SECONDS_PROPERTY_DEFAULT = false;

const
    FONT_MENU_TITLE = Application.loadResource(Rez.Strings.FontMenuTitle),
    FONT_PROPERTY_ID = "Font",
    FONT_PROPERTY_DEFAULT = 0;

const
    ALIGNMENT_MENU_TITLE = Application.loadResource(Rez.Strings.AlignmentMenuTitle),
    ALIGNMENT_PROPERTY_ID = "Alignment",
    ALIGNMENT_PROPERTY_DEFAULT = 0;


const TIME_FONTS = [
    {
        :name => "Acme", 
        :font => Application.loadResource(Rez.Fonts.Acme)
    },
    {
        :name => "Amaranth", 
        :font => Application.loadResource(Rez.Fonts.Amaranth)
    },
    {
        :name => "Amatic SC", 
        :font => Application.loadResource(Rez.Fonts.AmaticSC)
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
        :name => "Caveat Brush", 
        :font => Application.loadResource(Rez.Fonts.CaveatBrush)
    },
    {
        :name => "Changa", 
        :font => Application.loadResource(Rez.Fonts.Changa)
    },
    {
        :name => "Cormorant Unicase", 
        :font => Application.loadResource(Rez.Fonts.CormorantUnicase)
    },
    {
        :name => "Croissant One", 
        :font => Application.loadResource(Rez.Fonts.CroissantOne)
    },
    {
        :name => "Delius", 
        :font => Application.loadResource(Rez.Fonts.Delius)
    },
    {
        :name => "Dyna Puff", 
        :font => Application.loadResource(Rez.Fonts.DynaPuff)
    },
    {
        :name => "Epunda Slab", 
        :font => Application.loadResource(Rez.Fonts.EpundaSlab)
    },
    {
        :name => "Fondamento", 
        :font => Application.loadResource(Rez.Fonts.Fondamento)
    },
    {
        :name => "Gloria Hallelujah", 
        :font => Application.loadResource(Rez.Fonts.GloriaHallelujah)
    },
    {
        :name => "Grenze Gotisch", 
        :font => Application.loadResource(Rez.Fonts.GrenzeGotisch)
    },
    {
        :name => "Handlee", 
        :font => Application.loadResource(Rez.Fonts.Handlee)
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
        :name => "Limelight", 
        :font => Application.loadResource(Rez.Fonts.Limelight)
    },
    {
        :name => "Lobster Two", 
        :font => Application.loadResource(Rez.Fonts.LobsterTwo)
    },
    {
        :name => "Love Ya Like A Sister", 
        :font => Application.loadResource(Rez.Fonts.LoveYaLikeASister)
    },
    {
        :name => "Macondo", 
        :font => Application.loadResource(Rez.Fonts.Macondo)
    },
    {
        :name => "Megrim", 
        :font => Application.loadResource(Rez.Fonts.Megrim)
    },
    {
        :name => "Merienda", 
        :font => Application.loadResource(Rez.Fonts.Merienda)
    },
    {
        :name => "Philosopher", 
        :font => Application.loadResource(Rez.Fonts.Philosopher)
    },
    {
        :name => "Poetsen One", 
        :font => Application.loadResource(Rez.Fonts.PoetsenOne)
    },
    {
        :name => "Quintessential", 
        :font => Application.loadResource(Rez.Fonts.Quintessential)
    },
    {
        :name => "Rammetto One", 
        :font => Application.loadResource(Rez.Fonts.RammettoOne)
    },
    {
        :name => "Sniglet", 
        :font => Application.loadResource(Rez.Fonts.Sniglet)
    },
    {
        :name => "Special Elite", 
        :font => Application.loadResource(Rez.Fonts.SpecialElite)
    },
    {
        :name => "Stack Sans Notch", 
        :font => Application.loadResource(Rez.Fonts.StackSansNotch)
    },
    {
        :name => "SUSE", 
        :font => Application.loadResource(Rez.Fonts.SUSE)
    },
    {
        :name => "Tenor Sans", 
        :font => Application.loadResource(Rez.Fonts.TenorSans)
    },
    {
        :name => "Turret Road", 
        :font => Application.loadResource(Rez.Fonts.TurretRoad)
    },
    {
        :name => "Unica One", 
        :font => Application.loadResource(Rez.Fonts.UnicaOne)
    },
    {
        :name => "Unifraktur Maguntia", 
        :font => Application.loadResource(Rez.Fonts.UnifrakturMaguntia)
    },
    {
        :name => "Yusei Magic", 
        :font => Application.loadResource(Rez.Fonts.YuseiMagic)
    }
];

const
    ALIGNMENTS = Application.loadResource(Rez.JsonData.AlignmentNames) as Array<String>;

