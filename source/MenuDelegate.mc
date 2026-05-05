import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Lang;

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    private var _menu as WatchUi.Menu2;

    private var _indices as Dictionary<Symbol, Number> = {
        :action3 => 0,
        :action4 => 1,
        :action2 => 2,
        :action1 => 3
    };

    function initialize(menu as WatchUi.Menu2) {
        Menu2InputDelegate.initialize();
        _menu = menu;
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as Symbol;
        var idx = _indices[id];
        if (idx != null) {
            _menu.setFocus(idx);
            WatchUi.requestUpdate();
        }
        var url = Config.ENDPOINT_URLS[id];
        if (url == null) {
            return;
        }
        Communications.makeWebRequest(
            url,
            null,
            {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_TEXT_PLAIN
            },
            method(:onResponse)
        );
    }

    function onResponse(responseCode as Number, data as Dictionary or String or Null) as Void {
        var msg;
        if (responseCode == 200) {
            msg = "Success!";
        } else {
            msg = "Error: " + responseCode;
        }
        WatchUi.showToast(msg, null);
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

}
