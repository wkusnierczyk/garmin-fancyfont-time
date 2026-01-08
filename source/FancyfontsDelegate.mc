using Toybox.Application.Properties;
using Toybox.WatchUi;

import Toybox.Lang;


class FancyfontsDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item) {

        var id = item.getId();

        if (id.equals(FONT_PROPERTY_ID) && item instanceof WatchUi.MenuItem) {
            var currentFont = PropertyUtils.getPropertyElseDefault(FONT_PROPERTY_ID, FONT_PROPERTY_DEFAULT);
            var newFont = (currentFont + 1) % TIME_FONTS.size();
            Properties.setValue(FONT_PROPERTY_ID, newFont);
            item.setSubLabel(TIME_FONTS[newFont][:name]);
        }

    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }

}
