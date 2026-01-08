using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class FancyfontsMenu extends WatchUi.Menu2 {

    function initialize() {

        Menu2.initialize({:title => CUSTOMIZE_MENU_TITLE});

        // var multiOptionSelection = PropertyUtils.getPropertyElseDefault(MULTI_OPTION_PROPERTY, MULTI_OPTION_DEFAULT);
        // var multiOptoinName = MULTI_OPTION_NAMES[multiOptionSelection];
        // addItem(new WatchUi.MenuItem(
        //     MULTI_OPTION_LABEL, 
        //     multiOptoinName, 
        //     MULTI_OPTION_PROPERTY, 
        //     null
        // ));

    }

}
