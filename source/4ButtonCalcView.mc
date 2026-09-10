import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class ButtonCalcView extends WatchUi.View {
    var Inputln as String = "0";
    var options as Array<String> = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
    var currentIndex as Number = 2;

    function initialize() {
        View.initialize();
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

        // Solve the math expression
        var result = evaluateExpression(Inputln);

        // Replace / with ÷ for display
        var displayInputln = "";
        for (var i = 0; i < Inputln.length(); i++) {
            var char = Inputln.substring(i, i + 1);
            if (char.equals("/")) {
                displayInputln += "÷";
            } else {
                displayInputln += char;
            }
        }

        // Draw background
        dc.setColor(backgroundcolor, backgroundcolor);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        // Draw text on screen
        dc.setColor(accentcolor, backgroundcolor);
        dc.drawText(dc.getWidth() / 2, 30, Graphics.FONT_SMALL, "4Button Calc", Graphics.TEXT_JUSTIFY_CENTER);

        dc.setColor(textcolor, backgroundcolor);
        dc.drawText(0, dc.getHeight() / 2 - 20, Graphics.FONT_MEDIUM, displayInputln, Graphics.TEXT_JUSTIFY_LEFT);
        dc.drawText(dc.getWidth() - 20, dc.getHeight() / 2 + 20, Graphics.FONT_MEDIUM, result, Graphics.TEXT_JUSTIFY_RIGHT);

        dc.drawLine(0, dc.getHeight() / 2 + 22, dc.getWidth(), dc.getHeight() / 2 + 22);
        dc.drawLine(0, dc.getHeight() / 2 + 60, dc.getWidth(), dc.getHeight() / 2 + 60);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    //Set the available input options based on the previous input value
    function setOptions() as Void {
        if (Inputln.substring(Inputln.length() - 2, Inputln.length() - 1).equals(".")) {
                System.println("Removed decimal point from input options");
                options = ["/", "X", "-", "+", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 4;
            }
            else if (Inputln.substring(Inputln.length() - 2, Inputln.length() - 1).equals("/") || Inputln.substring(Inputln.length() - 2, Inputln.length() - 1).equals("X") || Inputln.substring(Inputln.length() - 2, Inputln.length() - 1).equals("+") || Inputln.length() <= 1) {
                System.println("Removed operators from input options");
                options = ["-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 2;
            }
            else if (options.indexOf(".") >= 0) {
                System.println("Restored all operations");
                options = ["/", "X", "-", "+", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 5;
            }
            else {
                System.println("Restored all operations except decimal point");
                options = ["/", "X", "-", "+", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];
                currentIndex = 4;
            }
    }


    function evaluateExpression(expression as String) as String {
        try {
            System.println("Evaluating expression: " + expression);
            // Remove trailing operators
            var expr = expression;
            while (expr.length() > 0) {
                var lastChar = expr.substring(expr.length() - 1, expr.length());
                if (lastChar.equals("+") || lastChar.equals("-") || lastChar.equals("X") || lastChar.equals("/") || lastChar.equals(".")) {
                    expr = expr.substring(0, expr.length() - 1);
                } else {
                    break;
                }
            }

            // Parse tokens and operators
            var tokens = [];
            var currentNum = "";
            var operators = [];
            
            for (var i = 0; i < expr.length(); i++) {
                var char = expr.substring(i, i + 1);
                if (char.equals("+") || char.equals("-") || char.equals("X") || char.equals("/")) {
                    // Check if minus is a negative sign (at start or after an operator)
                    if (char.equals("-") && (currentNum.length() == 0) && (operators.size() > 0 || i == 0)) {
                        currentNum += char;
                    } else if (currentNum.length() > 0) {
                            tokens.add(currentNum.toFloat());
                            currentNum = "";
                            operators.add(char);
                        }
                } else {
                    currentNum += char;
                }
            }
            if (currentNum.length() > 0) {
                tokens.add(currentNum.toFloat());
            }
            
            if (tokens.size() == 0) {
                return "0";
            }
            
            // Process multiplication and division first
            var i = 0;
            while (i < operators.size()) {
                if (operators[i].equals("X")) {
                    tokens[i] = tokens[i] * tokens[i + 1];
                    tokens.remove(tokens[i + 1]);
                    operators.remove(operators[i]);
                } else if (operators[i].equals("/")) {
                    if (tokens[i + 1] == 0) {
                        return "Error";
                    }
                    tokens[i] = tokens[i] / tokens[i + 1];
                    tokens.remove(tokens[i + 1]);
                    operators.remove(operators[i]);
                } else {
                    i++;
                }
            }
            
            // Process addition and subtraction
            var resultVal = tokens[0];
            for (i = 0; i < operators.size(); i++) {
                if (operators[i].equals("+")) {
                    resultVal += tokens[i + 1];
                } else if (operators[i].equals("-")) {
                    resultVal -= tokens[i + 1];
                }
            }
            
            var resultStr = resultVal.toString();
            
            // Trim trailing zeros
            while (resultStr.length() > 0 && resultStr.substring(resultStr.length() - 1, resultStr.length()).equals("0")) {
                resultStr = resultStr.substring(0, resultStr.length() - 1);
            }
            
            // Remove trailing decimal point if present
            if (resultStr.length() > 0 && resultStr.substring(resultStr.length() - 1, resultStr.length()).equals(".")) {
                resultStr = resultStr.substring(0, resultStr.length() - 1);
            }
            
            return resultStr;
        } catch (e) {
            System.println("Error evaluating expression: " + e.toString());
            return "Error";
        }
    }

}