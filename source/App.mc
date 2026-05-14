import Toybox.Application;
import Toybox.WatchUi;

class App extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() as [Views] or [Views, InputDelegates] {
        var menu = new WatchUi.Menu2({:title => "Sleep Control"});
        menu.addItem(new WatchUi.MenuItem("Sleep Start", null, :sleepStart, {}));
        menu.addItem(new WatchUi.MenuItem("Sleep Stop",  null, :sleepStop,  {}));
        return [menu, new MenuDelegate()];
    }

}
