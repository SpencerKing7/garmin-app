import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Lang;

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    private var _groups as Array<Symbol> = [:lamp1, :lamp2, :wall, :wallflower, :sleep];

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as Symbol;

        // Group item — build and push submenu
        var i = 0;
        while (i < _groups.size()) {
            if (_groups[i] == id) {
                var submenu = new WatchUi.Menu2({:title => item.getLabel()});
                if (id == :sleep) {
                    submenu.addItem(new WatchUi.MenuItem("Start", null, :start, {}));
                    submenu.addItem(new WatchUi.MenuItem("Stop",  null, :stop,  {}));
                } else {
                    submenu.addItem(new WatchUi.MenuItem("On",  null, :on,  {}));
                    submenu.addItem(new WatchUi.MenuItem("Off", null, :off, {}));
                }
                WatchUi.pushView(submenu, new SubMenuDelegate(id), WatchUi.SLIDE_LEFT);
                return;
            }
            i++;
        }

        // Direct-action item
        var url = Config.ENDPOINT_URLS[id];
        if (url == null) { return; }
        Communications.makeWebRequest(
            url, null,
            {:method => Communications.HTTP_REQUEST_METHOD_GET,
             :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON},
            method(:onResponse)
        );
    }

    function onResponse(responseCode as Number, data as Dictionary or String or Null) as Void {
        WatchUi.showToast(responseCode == 200 ? "Success!" : "Error: " + responseCode, {:duration => 1000});
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

}
