using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class FancyfontsMenu extends WatchUi.Menu2 {

    function initialize() {

        Menu2.initialize({:title => CUSTOMIZE_MENU_TITLE});

        var showDate = PropertyUtils.getPropertyElseDefault(DATE_PROPERTY_ID, DATE_PROPERTY_DEFAULT);
        addItem(new WatchUi.ToggleMenuItem(
            DATE_MENU_TITLE, 
            null, 
            DATE_PROPERTY_ID, 
            showDate, 
            null
        ));
        
        var showSeconds = PropertyUtils.getPropertyElseDefault(SECONDS_PROPERTY_ID, SECONDS_PROPERTY_DEFAULT);
        addItem(new WatchUi.ToggleMenuItem(
            SECONDS_MENU_TITLE, 
            null, 
            SECONDS_PROPERTY_ID, 
            showSeconds, 
            null
        ));
        
        var fontSelection = PropertyUtils.getPropertyElseDefault(FONT_PROPERTY_ID, FONT_PROPERTY_DEFAULT);
        var fontName = TIME_FONTS[fontSelection][:name];
        addItem(new WatchUi.MenuItem(
            FONT_MENU_TITLE, 
            fontName, 
            FONT_PROPERTY_ID, 
            null
        ));

    }

}
