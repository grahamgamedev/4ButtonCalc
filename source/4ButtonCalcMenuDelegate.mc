import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import units;

var state = "Main";
var conversionType as String = "";
var fromUnit as String = "";
var toUnit as String = "";

class ButtonCalcMenuDelegate extends WatchUi.Menu2InputDelegate {
    
    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        System.println("Selected item: " + item.getLabel());
        if (item.getLabel().equals("Calc")) {
            WatchUi.pushView(new ButtonCalcView(), new ButtonCalcDelegate(), WatchUi.SLIDE_UP);

        } else if (item.getLabel().equals("Unit Converter")) {
            pushView("Converter", units.conversionTypes);

        } else if (state.equals("Main")) {
            conversionType = item.getLabel();
            var conversionData = (units.unitTypes)[conversionType];
            if (conversionData != null) {
                state = "From";
                pushView("From", conversionData);
            }

        } else if (state.equals("From")) {
            fromUnit = item.getLabel();
            var conversionData = (units.unitTypes)[conversionType];
            System.println("Conversion data: " + conversionData.toString());
            if (conversionData != null) {
                var toUnits = [];
                for (var j = 0; j < conversionData.size(); j++) {
                    if (conversionData[j] != fromUnit) {
                        toUnits.add(conversionData[j]);
                    }
                }
                state = "To";
                pushView("To", toUnits);
            }

        } else if (state.equals("To")) {
            toUnit = item.getLabel();
            WatchUi.pushView(new ButtonCalcConverterView(conversionType, fromUnit, toUnit), new ButtonCalcDelegate(), WatchUi.SLIDE_UP);
        }

        System.println("State: " + state);
        WatchUi.requestUpdate();
    }

    function onBack() as Void {
        if (state.equals("From")) {
            state = "Main";
        } else if (state.equals("To")) {
            state = "From";
        }
        WatchUi.popView(WatchUi.SLIDE_DOWN);
        WatchUi.requestUpdate();
    }  

    function pushView(Title as String, item as Array<String>) as Void {
        var menu;
        var menudelagate;
        menu = new Menu(50, backgroundcolor, Title);
        menudelagate = new ButtonCalcMenuDelegate();
     
        for (var i = 0; i < item.size(); i++) {
            var itemKey = :item1; 
            if (i == 0) {
                itemKey = :item1;
            } else if (i == 1) {
                itemKey = :item2;
            } else if (i == 2) {
                itemKey = :item3;
            } else if (i == 3) {
                itemKey = :item4;
            } else if (i == 4) {
                itemKey = :item5;
            } else if (i == 5) {
                itemKey = :item6;
            } else if (i == 6) {
                itemKey = :item7;
            }

            menu.addItem(new $.CustomItem(itemKey, item[i]));
            }
            WatchUi.pushView(menu, menudelagate, WatchUi.SLIDE_UP);
    }

}