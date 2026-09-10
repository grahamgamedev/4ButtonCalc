import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ButtonCalcConverterView extends WatchUi.View {
    var Inputln as String = "0";
    var options as Array<String> = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    var currentIndex as Number = 2;

    var conversionType as String = "";
    var fromUnit as String = "";
    var toUnit as String = "";

    function initialize(type as String, from as String, to as String) {
        View.initialize();
        conversionType = type;
        fromUnit = from;
        toUnit = to;
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        Inputln = "0";
        options = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
        currentIndex = 2;
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        if (key == WatchUi.KEY_ENTER) {
            Inputln += 0;
            setOptions();
  
        } else if (key == WatchUi.KEY_MENU) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);

        } else if (key == WatchUi.KEY_DOWN) {
            currentIndex = (currentIndex - 1 + options.size()) % options.size();
            Inputln = Inputln.substring(0, Inputln.length() - 1) + options[currentIndex];

        } else if (key == WatchUi.KEY_UP) {
            currentIndex = (currentIndex + 1 + options.size()) % options.size();
            Inputln = Inputln.substring(0, Inputln.length() - 1) + options[currentIndex];
            

        } else if (key == WatchUi.KEY_ESC) {
            if (Inputln.length() > 1) {
                Inputln = Inputln.substring(0, Inputln.length() - 1);
                setOptions();
            }
            else {
                WatchUi.popView(WatchUi.SLIDE_DOWN);
            }
        }

        // Convert the input value to the target unit
        var result = convertUnits(Inputln);

        var inputUnit = units.shortUnits[conversionType][fromUnit];
        var resultUnit = units.shortUnits[conversionType][toUnit];

        // Draw background
        dc.setColor(backgroundcolor, backgroundcolor);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        // Draw text on screen
        dc.setColor(accentcolor, backgroundcolor);
        dc.drawText(dc.getWidth() / 2, 30, Graphics.FONT_SMALL, "4Button Calc", Graphics.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getTextDimensions(Inputln, Graphics.FONT_MEDIUM)[0], dc.getHeight() / 2 - 13, Graphics.FONT_SMALL, inputUnit, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(dc.getWidth() - 20 , dc.getHeight() / 2 + 27, Graphics.FONT_SMALL, resultUnit, Graphics.TEXT_JUSTIFY_RIGHT);
        
        dc.setColor(textcolor, backgroundcolor);
        dc.drawText(0, dc.getHeight() / 2 - 20, Graphics.FONT_MEDIUM, Inputln, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(dc.getWidth() - 20- dc.getTextDimensions(resultUnit, Graphics.FONT_SMALL)[0], dc.getHeight() / 2 + 20, Graphics.FONT_MEDIUM, result, Graphics.TEXT_JUSTIFY_RIGHT);
        
        dc.drawLine(0, dc.getHeight() / 2 + 22, dc.getWidth(), dc.getHeight() / 2 + 22);
        dc.drawLine(0, dc.getHeight() / 2 + 60, dc.getWidth(), dc.getHeight() / 2 + 60);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // Set the available input options based on the previous input value
    function setOptions() as Void {
        if (Inputln.length() > 1) {
                System.println("Removed minus sign from input options");
                options = [".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 1;
            
            if (Inputln.find(".") != null) {
                System.println("Removed decimal point from input options");
                options = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 0;
            }
            else {
                System.println("Restored all operations except minus sign");
                options = [".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 1;
            }
        } else {
            System.println("Restored all operations");
            options = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
            currentIndex = 2;
        }
    }

    function convertUnits(number as String) as String {
        // Remove trailing operators from the input number
        var n = number;
        while (n.length() > 0) {
            var lastChar = n.substring(n.length() - 1, n.length());
            if (lastChar.equals("+") || lastChar.equals("-") || lastChar.equals("X") || lastChar.equals("/") || lastChar.equals(".")) {
                n = n.substring(0, n.length() - 1);
            } else {
                break;
            }
        }
        if (n.length() == 0) {
            return "0";
        }

        var fromFactor = units.conversions[conversionType][fromUnit];
        var toFactor = units.conversions[conversionType][toUnit];
        var result = n.toFloat() * fromFactor / toFactor;
        if (units.offsetConversions[conversionType] != null) {
            var fromOffset = units.offsetConversions[conversionType][fromUnit];
            var toOffset = units.offsetConversions[conversionType][toUnit];
            result -= fromOffset + toOffset;
        }

        var resultStr = result.format("%.3f"); // Format the result to 3 decimal places

        // Trim trailing zeros
        while (resultStr.length() > 0 && resultStr.substring(resultStr.length() - 1, resultStr.length()).equals("0")) {
            resultStr = resultStr.substring(0, resultStr.length() - 1);
        }      

        // Remove trailing decimal point if present
        if (resultStr.length() > 0 && resultStr.substring(resultStr.length() - 1, resultStr.length()).equals(".")) {
            resultStr = resultStr.substring(0, resultStr.length() - 1);
        }            
        return resultStr;
    }
}