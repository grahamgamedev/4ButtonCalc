import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;


class Menu extends WatchUi.CustomMenu {
    var Title as String;
   
    public function initialize(itemHeight as Number, backgroundColor as ColorType, title as String) {
        CustomMenu.initialize(itemHeight, backgroundColor, {});
        Title = title;
    }

    // Draw the menu title
    public function drawTitle(dc as Dc) as Void {
        dc.setColor(textcolor, textcolor);
        dc.setPenWidth(3);
        dc.drawLine(0, dc.getHeight() - 2, dc.getWidth(), dc.getHeight() - 2);
        dc.setPenWidth(1);
        dc.setColor(accentcolor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Graphics.FONT_MEDIUM, Title, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }

}

class CustomItem extends WatchUi.CustomMenuItem {
    private var _label as String;

    public function initialize(id as Symbol, text as String) {
        CustomMenuItem.initialize(id, {});
        _label = text;
    }

    // Draw the menu item
    public function draw(dc as Dc) as Void {
        var font = Graphics.FONT_SMALL;
        if (isFocused()) {
            font = Graphics.FONT_LARGE;
        }

        dc.setColor(textcolor, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, font, _label, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.drawLine(0, 0, dc.getWidth(), 0);
        dc.drawLine(0, dc.getHeight() - 1, dc.getWidth(), dc.getHeight() - 1);
    }

    // Get the item label
    public function getLabel() as String {
        return _label;
    }
}