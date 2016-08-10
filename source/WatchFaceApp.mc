using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class WatchFaceApp extends App.AppBase
{
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state) {
    }

    function onStop(state) {
    }

    function getInitialView() {
        return [new WatchFaceView()];
    }

    function onSettingsChanged(){
        Ui.requestUpdate();
    }
}