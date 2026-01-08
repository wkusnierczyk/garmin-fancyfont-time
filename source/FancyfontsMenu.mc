using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class FancyfontsMenu extends WatchUi.Menu2 {

    function initialize() {

        Menu2.initialize({:title => CUSTOMIZE_MENU_TITLE});

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
