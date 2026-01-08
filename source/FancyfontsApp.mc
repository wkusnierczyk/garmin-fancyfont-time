using Toybox.Application;
using Toybox.WatchUi;


class FancyfontsApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new FancyfontsView() ];
    }

    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

    function getSettingsView() {
        return [ new FancyfontsMenu(), new FancyfontsDelegate() ];
    }

}