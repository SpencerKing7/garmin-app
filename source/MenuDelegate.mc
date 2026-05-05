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

    // Maps menu item ids to their target URLs — swap these for real endpoints
    private var _urls as Dictionary<Symbol, String> = {
        :action1 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=61118ddd-5388-4a16-813d-888a6215cc3a&token=cc8f7fe5-3464-4bd1-ad28-dec0008efc38&response=html",
        :action2 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=bfa6df11-f48a-45b3-a5c0-3fcb2eec66e4&token=3cdee7f1-72c6-4312-a8c8-46a645e6efd4&response=html",
        :action3 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=f6b91afc-999a-47cf-ad15-c9996731411c&token=7707b140-16d9-4cf8-a63d-12bdc232f433&response=html",
        :action4 => "https://www.virtualsmarthome.xyz/url_routine_trigger/activate.php?trigger=ac0e3c07-ab26-4f3e-91ce-e8ab13dbe375&token=82de0075-1131-48ae-bdab-b7629f619e02&response=html"
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
        var url = _urls[id];
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
