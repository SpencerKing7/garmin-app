import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;

const INACTIVITY_TIMEOUT_MS = 15000;

class App extends Application.AppBase {

    private var _timer as Timer.Timer = new Timer.Timer();

    function initialize() {
        AppBase.initialize();
    }

    function resetTimer() as Void {
        _timer.stop();
        _timer.start(method(:onTimeout), INACTIVITY_TIMEOUT_MS, false);
    }

    function onTimeout() as Void {
        System.exit();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var menu = new WatchUi.Menu2({:title => "Sleep Control"});
        menu.addItem(new WatchUi.MenuItem("Sleep Start", null, :sleepStart, {}));
        menu.addItem(new WatchUi.MenuItem("Sleep Stop",  null, :sleepStop,  {}));
        resetTimer();
        return [menu, new MenuDelegate()];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
