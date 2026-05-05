import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Lang;

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    // Maps menu item ids to their target URLs — swap these for real endpoints
    private var _urls as Dictionary<Symbol, String> = {
        :action1 => "https://example.com/action1",
        :action2 => "https://example.com/action2",
        :action3 => "https://example.com/action3"
    };

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        var id = item.getId() as Symbol;
        var url = _urls[id];
        if (url == null) {
            return;
        }
        Communications.makeWebRequest(
            url,
            null,
            {:method => Communications.HTTP_REQUEST_METHOD_GET},
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
