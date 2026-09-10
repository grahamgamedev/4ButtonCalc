import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

var backgroundcolor;
var textcolor;
var accentcolor;

class ButtonCalcApp extends Application.AppBase {
    
    function initialize() {
        AppBase.initialize();
        if (Properties.getValue("dark_theme")) {
            backgroundcolor = Graphics.COLOR_BLACK;
            textcolor = Graphics.COLOR_WHITE;
        } else {
            backgroundcolor = Graphics.COLOR_WHITE;
            textcolor = Graphics.COLOR_BLACK;
        }

        if (Properties.getValue("accent_color") == 1) {
            accentcolor = Graphics.COLOR_RED;
        } else if (Properties.getValue("accent_color") == 2) {
            accentcolor = Graphics.COLOR_ORANGE;
        } else if (Properties.getValue("accent_color") == 3) {
            accentcolor = Graphics.COLOR_YELLOW;
        } else if (Properties.getValue("accent_color") == 5) {
            accentcolor = Graphics.COLOR_BLUE;
        } else if (Properties.getValue("accent_color") == 6) {
            accentcolor = Graphics.COLOR_PURPLE;
        } else if (Properties.getValue("accent_color") == 7) {
            accentcolor = Graphics.COLOR_PINK;
        } else if (Properties.getValue("accent_color") == 8) {
            accentcolor = Graphics.COLOR_DK_RED;
        } else if (Properties.getValue("accent_color") == 9) {
            accentcolor = Graphics.COLOR_DK_GREEN;
        } else if (Properties.getValue("accent_color") == 10) {
            accentcolor = Graphics.COLOR_DK_BLUE;
        } else if (Properties.getValue("accent_color") == 11) {
            accentcolor = Graphics.COLOR_DK_GRAY;
        } else if (Properties.getValue("accent_color") == 12) {
            accentcolor = Graphics.COLOR_LT_GRAY;
        } else {
            accentcolor = Graphics.COLOR_GREEN;
        }
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        var menu;
        menu = new Menu(50, backgroundcolor, "4Button Calc");
        menu.addItem(new $.CustomItem(:item1, "Calc"));
        menu.addItem(new $.CustomItem(:item2, "Unit Converter"));
        return [menu, new ButtonCalcMenuDelegate()];
    }
}

function getApp() as ButtonCalcApp {
    return Application.getApp() as ButtonCalcApp;
}