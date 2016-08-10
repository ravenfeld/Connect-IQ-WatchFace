using Toybox.Application as App;

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

}