import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

var key = 0;

class ButtonCalcDelegate extends WatchUi.InputDelegate {
    function initialize() {
        InputDelegate.initialize();
        key = 0;
    }

    function onKey(evt) {
        key = evt.getKey();
        WatchUi.requestUpdate();
        return true;
    }

}

