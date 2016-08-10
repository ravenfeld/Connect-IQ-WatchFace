using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Activity as Act;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class WatchFaceView extends Ui.WatchFace{
	var cx;
    var cy;
    var settings;
    var info;
    var active;
    var text_width_hour_10;
    var text_width_hour_1;
    var text_width_point;
	var text_width_minute;
	var text_width_second;
	var text_height_hour;
	var text_height_second;
	var text_y_hour;
	var text_y_second;
	var start_x_active_hour_10;
	var start_x_active_hour_1;
	var start_x_sleep_hour_10;
	var start_x_sleep_hour_1;
	var display_altimeter;
	
	function initialize() {
        WatchFace.initialize();
    }
    
    function onExitSleep() {
    	active=true;
    	Ui.requestUpdate();
    }

    function onEnterSleep() {
    	active=false;
    	Ui.requestUpdate();
    }
    
    function onLayout(dc) {
    	display_altimeter = App.getApp().getProperty("altimeter");       
        settings = System.getDeviceSettings();

        cx = dc.getWidth() / 2;
        cy = dc.getHeight() / 2;
        if(display_altimeter){
        	text_y_hour = cy-12;
        }else{
        	text_y_hour = cy;
        }
        
        text_width_hour_10 = dc.getTextWidthInPixels("88",Gfx.FONT_NUMBER_THAI_HOT);
        text_width_hour_1 = dc.getTextWidthInPixels("8",Gfx.FONT_NUMBER_THAI_HOT);
        text_width_point = dc.getTextWidthInPixels(":",Gfx.FONT_NUMBER_THAI_HOT);
        text_height_hour = dc.getFontHeight(Gfx.FONT_NUMBER_THAI_HOT);
        text_width_minute = dc.getTextWidthInPixels("88",Gfx.FONT_NUMBER_THAI_HOT);
        text_width_second=dc.getTextWidthInPixels("88",Gfx.FONT_NUMBER_MEDIUM);
        text_height_second = dc.getFontHeight(Gfx.FONT_NUMBER_MEDIUM);
        
      
		
        start_x_active_hour_10=(dc.getWidth()-(text_width_hour_10+text_width_point+text_width_minute+text_width_second))/2;
        start_x_active_hour_1=(dc.getWidth()-(text_width_hour_1+text_width_point+text_width_minute+text_width_second))/2;
        start_x_sleep_hour_10=(dc.getWidth()-(text_width_hour_10+text_width_point+text_width_minute))/2;
        start_x_sleep_hour_1=(dc.getWidth()-(text_width_hour_1+text_width_point+text_width_minute))/2;
    }
    
    
    function onUpdate(dc) {
    	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

                var moment = Time.now();
        info = Gregorian.info(moment, Time.FORMAT_MEDIUM);
        
		drawHour(dc);
		var display_date = App.getApp().getProperty("date");
		if(display_date){
			drawDate(dc);
		}
		
		if(display_altimeter){
			drawMountain(dc);
       		drawAlti(dc);
       	}
       
    }
    
    function drawHour(dc){
        
        var hour;
        if (settings.is24Hour) {
            hour = info.hour;
        } else if (info.hour > 12) {
            hour = info.hour - 12;
        } else if (info.hour == 0) {
            hour = 12;
        } else {
            hour = info.hour;
        }
        
        var secondString;
        if (info.sec >= 10) {
            secondString = Lang.format("$1$", [info.sec.format("%d")]);
        } else {
            secondString = Lang.format("0$1$", [info.sec.format("%d")]);
        }
        
        var minuteString;
        if (info.min >= 10) {
            minuteString = Lang.format("$1$", [info.min.format("%d")]);
        } else {
            minuteString = Lang.format("0$1$", [info.min.format("%d")]);
        }
        var hourString;
        if (settings.is24Hour && hour < 10) {
            hourString = Lang.format("0$1$", [hour]);   
        } else {
            hourString = Lang.format("$1$", [hour]);
        }
        
        var text_width_hour;
        var start_x;
        if(hour>=10){
        	text_width_hour = text_width_hour_10;
        	if(active){
        		start_x=start_x_active_hour_10;
        	}else{
        		start_x=start_x_sleep_hour_10;
        	}
        }else{
        	text_width_hour = text_width_hour_1;
            if(active){
        		start_x=start_x_active_hour_1;
        	}else{
        		start_x=start_x_sleep_hour_1;
        	}
        } 
                
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(start_x, text_y_hour, Gfx.FONT_NUMBER_THAI_HOT, hourString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        
        var start_point=start_x+text_width_hour;
        dc.drawText(start_point, text_y_hour, Gfx.FONT_NUMBER_THAI_HOT, ":", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        
        dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
        var start_minute=start_point+text_width_point;
        dc.drawText(start_minute, text_y_hour, Gfx.FONT_NUMBER_THAI_HOT, minuteString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        
        var display_second = App.getApp().getProperty("second");
        if(active && display_second){
        	var start_second=start_minute+text_width_minute;
        	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        	dc.drawText(start_second, cy-text_height_hour/2+text_height_second/2, Gfx.FONT_NUMBER_MEDIUM, secondString, Graphics.TEXT_JUSTIFY_VCENTER |Graphics.TEXT_JUSTIFY_LEFT);
		}
    }
    
    
    
    function drawDate(dc){
    	var text_hour_height = dc.getFontHeight(Gfx.FONT_NUMBER_THAI_HOT);
    	var dateString = Lang.format("$1$ $2$", [info.day_of_week, info.day]);
    	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(cx, cy-text_hour_height/2-30, Gfx.FONT_SMALL, dateString, Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function drawAlti(dc){
        var actaltitude = 4000;
		var altitudeStr;
		var y = 190;
		var x = 40;
    
        var actInfo = Act.getActivityInfo();
		if (actInfo != null && actInfo.altitude != null) {
			actaltitude = actInfo.altitude;				
		}
		var metric = Sys.getDeviceSettings().elevationUnits;
		if (metric==Sys.UNIT_METRIC) {
			altitudeStr = format("$1$ m", [actaltitude.format("%d")]);
		} else {
			altitudeStr = format("$1$ ft", [actaltitude.format("%d")]);
		}
		var text_width = dc.getTextWidthInPixels(altitudeStr,Gfx.FONT_MEDIUM);
		dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
		dc.drawText(x + 105-text_width/2, y - 26/2, Gfx.FONT_MEDIUM, altitudeStr, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
    }
    
    function drawMountain(dc){
		var y = 190;
		var x = 40;
    
        dc.setColor( Gfx.COLOR_DK_RED,Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, y-23, dc.getWidth(), 26);
        var mountain_1 = [ [x,y], [x+23,y-40],[x+35,y-20], [x+21,y]  ];
        var mountain_2 = [ [x+24,y], [x+45,y-30], [x+65,y]  ];
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.fillPolygon(mountain_1);
        dc.fillPolygon(mountain_2);
    }
}