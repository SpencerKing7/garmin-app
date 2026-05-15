import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Lang;

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    private var _pendingItem as WatchUi.MenuItem? = null;

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        getApp().resetTimer();
        _pendingItem = item;
        var url = Config.ENDPOINT_URLS[item.getId() as Symbol];
        if (url == null) { return; }
        Communications.makeWebRequest(
            url, null,
            {:method => Communications.HTTP_REQUEST_METHOD_GET,
             :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON},
            method(:onResponse)
        );
    }

    function onResponse(responseCode as Number, data as Dictionary or String or Null) as Void {
        if (_pendingItem != null) {
            (_pendingItem as WatchUi.MenuItem).setSubLabel(responseCode == 200 ? "Success" : "Failed");
            WatchUi.requestUpdate();
            _pendingItem = null;
        }
    }

    function onBack() as Void {
        getApp().resetTimer();
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }

}
