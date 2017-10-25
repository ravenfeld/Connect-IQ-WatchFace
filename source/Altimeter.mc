using Toybox.Graphics as Gfx;
using Toybox.Activity as Act;
using Toybox.System as Sys;
using Toybox.Lang;

module Altimeter{

	function draw(dc,altitude,y,text_color,mountain_color,bgk_color){
		var altitudeStr;
    
		var metric = Sys.getDeviceSettings().elevationUnits;
		if (metric==Sys.UNIT_METRIC) {
			altitudeStr = Lang.format("$1$m", [altitude.format("%d")]);
		} else {
			altitudeStr = Lang.format("$1$ft", [altitude.format("%d")]);
		}
		var text_width = dc.getTextWidthInPixels(altitudeStr,Gfx.FONT_MEDIUM);
		var text_width_max = dc.getTextWidthInPixels("8888ft",Gfx.FONT_MEDIUM);
		dc.setColor(text_color, Gfx.COLOR_TRANSPARENT);
		var height=dc.getHeight();
		var x = dc.getWidth()/2-(height*0.29+text_width_max+10)/2;
		drawMountain(dc,x,y,mountain_color,bgk_color);
		dc.drawText(dc.getWidth()/4*3-text_width/2-height*0.08, y - height*0.05, Gfx.FONT_MEDIUM, altitudeStr, Gfx.TEXT_JUSTIFY_VCENTER | Gfx.TEXT_JUSTIFY_LEFT);
   
	}
	
	function drawMountain(dc,x,y,mountain_color,bgk_color){
		var height=dc.getHeight();
        dc.setColor(bgk_color,Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, y-height*0.10, dc.getWidth(), height*0.12);
        
        var mountain_1 = [ [x,y], [x+height*0.10,y-height*0.18],[x+height*0.16,y-height*0.09], [x+height*0.095,y]  ];
        var mountain_2 = [ [x+height*0.11,y], [x+height*0.20,y-height*0.14], [x+height*0.29,y]  ];
        dc.setColor(mountain_color, Gfx.COLOR_TRANSPARENT);
        dc.fillPolygon(mountain_1);
        dc.fillPolygon(mountain_2);
    }
}