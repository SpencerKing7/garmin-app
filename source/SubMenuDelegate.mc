import Toybox.WatchUi;
import Toybox.Communications;
import Toybox.Lang;

class SubMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var _groupId as Symbol;

    function initialize(groupId as Symbol) {
        Menu2InputDelegate.initialize();
        _groupId = groupId;
    }

    private function resolveKey(actionId as Symbol) as Symbol or Null {
        if (_groupId == :sleep)      { return actionId == :start ? :sleepStart : :sleepStop;    }
        if (_groupId == :lamp1)      { return actionId == :on ? :lamp1On      : :lamp1Off;      }
        if (_groupId == :lamp2)      { return actionId == :on ? :lamp2On      : :lamp2Off;      }
        if (_groupId == :wall)       { return actionId == :on ? :wallOn       : :wallOff;       }
        if (_groupId == :wallflower) { return actionId == :on ? :wallflowerOn : :wallflowerOff; }
        return null;
    }

    function onSelect(item as MenuItem) as Void {
        getApp().resetTimer();
        var actionId = item.getId() as Symbol;
        var urlKey = resolveKey(actionId);
        if (urlKey == null) { return; }
        var url = Config.ENDPOINT_URLS[urlKey];
        if (url == null) { return; }
        Communications.makeWebRequest(
            url, null,
            {:method => Communications.HTTP_REQUEST_METHOD_GET,
             :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON},
            method(:onResponse)
        );
    }

    function onResponse(responseCode as Number, data as Dictionary or String or Null) as Void {
        WatchUi.showToast(responseCode == 200 ? "Success!" : "Error: " + responseCode, {:duration => 2000});
    }

    function onBack() as Void {
        getApp().resetTimer();
        WatchUi.popView(WatchUi.SLIDE_RIGHT);
    }

}
