import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Lang;

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    private var _pendingItem as WatchUi.MenuItem or Null = null;

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        var url = Config.ENDPOINT_URLS[item.getId() as Symbol];
        if (url == null) { return; }
        _pendingItem = item;
        Communications.makeWebRequest(
            url, null,
            {:method => Communications.HTTP_REQUEST_METHOD_GET,
             :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON},
            method(:onResponse)
        );
    }

    function onResponse(responseCode as Number, data as Dictionary or String or Null) as Void {
        if (_pendingItem != null) {
            _pendingItem.setSubLabel(responseCode == 200 ? "✓" : "✗");
            _pendingItem = null;
            WatchUi.requestUpdate();
        }
    }

    function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

}
