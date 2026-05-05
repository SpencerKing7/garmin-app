import Toybox.Application;
import Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var menu = new WatchUi.Menu2({:title => "Actions"});
        menu.addItem(new WatchUi.MenuItem("Action 1", null, :action1, {}));
        menu.addItem(new WatchUi.MenuItem("Action 2", null, :action2, {}));
        menu.addItem(new WatchUi.MenuItem("Action 3", null, :action3, {}));
        return [menu, new MenuDelegate()];
    }

}

function getApp() as App {
    return Application.getApp() as App;
}
