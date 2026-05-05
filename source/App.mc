import Toybox.Application;
import Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var menu = new WatchUi.Menu2({:title => "Control Home"});
        menu.addItem(new WatchUi.MenuItem("Sleep", null, :action3, {}));
        menu.addItem(new WatchUi.MenuItem("Sleep Pause", null, :action4, {}));
        menu.addItem(new WatchUi.MenuItem("Living Room", null, :action2, {}));
        menu.addItem(new WatchUi.MenuItem("Home - Off", null, :action1, {}));
        return [menu, new MenuDelegate(menu)];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
