import Toybox.Application;
import Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var menu = new WatchUi.Menu2({:title => "Control Home"});
        menu.addItem(new WatchUi.MenuItem("Sleep Start",    null, :sleepStart,    {}));
        menu.addItem(new WatchUi.MenuItem("Sleep Stop",     null, :sleepStop,     {}));
        menu.addItem(new WatchUi.MenuItem("Living Room",    null, :livingRoom,    {}));
        menu.addItem(new WatchUi.MenuItem("Home Off",       null, :homeOff,       {}));
        menu.addItem(new WatchUi.MenuItem("Lamp 1 On",      null, :lamp1On,       {}));
        menu.addItem(new WatchUi.MenuItem("Lamp 1 Off",     null, :lamp1Off,      {}));
        menu.addItem(new WatchUi.MenuItem("Lamp 2 On",      null, :lamp2On,       {}));
        menu.addItem(new WatchUi.MenuItem("Lamp 2 Off",     null, :lamp2Off,      {}));
        menu.addItem(new WatchUi.MenuItem("Wall On",        null, :wallOn,        {}));
        menu.addItem(new WatchUi.MenuItem("Wall Off",       null, :wallOff,       {}));
        menu.addItem(new WatchUi.MenuItem("Wallflower On",  null, :wallflowerOn,  {}));
        menu.addItem(new WatchUi.MenuItem("Wallflower Off", null, :wallflowerOff, {}));
        return [menu, new MenuDelegate(menu)];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
