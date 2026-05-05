import Toybox.Application;
import Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
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

        return [menu, new MenuDelegate()];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
