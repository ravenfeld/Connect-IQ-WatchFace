using Toybox.Graphics as Gfx;
using Toybox.Activity as Act;
using Toybox.System as Sys;
using Toybox.Lang;

module Altimeter{

	function draw(dc,altitude,x,y,text_color,mountain_color,bgk_color){
		var altitudeStr;
    
    	drawMountain(dc,x,y,mountain_color,bgk_color);
    	
		var metric = Sys.getDeviceSettings().elevationUnits;
		if (metric==Sys.UNIT_METRIC) {
			altitudeStr = Lang.format("$1$m", [altitude.format("%d")]);
		} else {
			altitudeStr = Lang.format("$1$ft", [altitude.format("%d")]);
		}
		var text_width = dc.getTextWidthInPixels(altitudeStr,Gfx.FONT_MEDIUM);
		dc.setColor(text_color, Gfx.COLOR_TRANSPARENT);
		dc.drawText(x + 105-text_width/2, y - 24/2, Gfx.FONT_MEDIUM, altitudeStr, Gfx.TEXT_JUSTIFY_VCENTER | Gfx.TEXT_JUSTIFY_LEFT);
   
	}
	
	hidden function drawMountain(dc,x,y,mountain_color,bgk_color){
        dc.setColor(bgk_color,Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, y-23, dc.getWidth(), 26);
        
        var mountain_1 = [ [x,y], [x+23,y-40],[x+35,y-20], [x+21,y]  ];
        var mountain_2 = [ [x+24,y], [x+45,y-30], [x+65,y]  ];
        dc.setColor(mountain_color, Gfx.COLOR_TRANSPARENT);
        dc.fillPolygon(mountain_1);
        dc.fillPolygon(mountain_2);
    }
}