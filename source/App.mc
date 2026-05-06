import Toybox.Application;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.System;

// Close the app after this many milliseconds of inactivity
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
        var menu = new WatchUi.Menu2({:title => "Control Home"});

        menu.addItem(new WatchUi.MenuItem("Sleep",       null, :sleep,      {}));
        menu.addItem(new WatchUi.MenuItem("Living Room", null, :livingRoom, {}));
        menu.addItem(new WatchUi.MenuItem("Lamp 1",      null, :lamp1,      {}));
        menu.addItem(new WatchUi.MenuItem("Lamp 2",      null, :lamp2,      {}));
        menu.addItem(new WatchUi.MenuItem("Wall",        null, :wall,       {}));
        menu.addItem(new WatchUi.MenuItem("Wallflower",  null, :wallflower, {}));
        menu.addItem(new WatchUi.MenuItem("Home Off",    null, :homeOff,    {}));

        resetTimer();
        return [menu, new MenuDelegate()];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
