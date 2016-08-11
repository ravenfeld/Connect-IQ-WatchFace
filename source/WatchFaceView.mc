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
	var color_text;
	var color_user;
	var arc_type;
	
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
        settings = System.getDeviceSettings();

        cx = dc.getWidth() / 2;
        cy = dc.getHeight() / 2;
        
        text_width_hour_10 = dc.getTextWidthInPixels("88",Gfx.FONT_NUMBER_THAI_HOT);
        text_width_hour_1 = dc.getTextWidthInPixels("8",Gfx.FONT_NUMBER_THAI_HOT);
        text_width_point = dc.getTextWidthInPixels(":",Gfx.FONT_NUMBER_THAI_HOT);
        text_height_hour = dc.getFontHeight(Gfx.FONT_NUMBER_THAI_HOT);
        text_width_minute = dc.getTextWidthInPixels("88",Gfx.FONT_NUMBER_THAI_HOT);
        text_width_second=dc.getTextWidthInPixels("88",Gfx.FONT_NUMBER_MEDIUM);
        text_height_second = dc.getFontHeight(Gfx.FONT_NUMBER_MEDIUM);
        
      
		
        start_x_active_hour_10=(dc.getWidth()-(text_width_hour_10+text_width_point+text_width_minute+text_width_second+8))/2;
        start_x_active_hour_1=(dc.getWidth()-(text_width_hour_1+text_width_point+text_width_minute+text_width_second+8))/2;
        start_x_sleep_hour_10=(dc.getWidth()-(text_width_hour_10+text_width_point+text_width_minute+4))/2;
        start_x_sleep_hour_1=(dc.getWidth()-(text_width_hour_1+text_width_point+text_width_minute+4))/2;
    }
    
    
    function onUpdate(dc) {
    	display_altimeter = App.getApp().getProperty("altimeter_display");
    	arc_type =  App.getApp().getProperty("arc_type");
    	
    	setBackgroundColor(dc);
    	setColorShade();
        dc.clear();

        var moment = Time.now();
        info = Gregorian.info(moment, Time.FORMAT_MEDIUM);
        
		drawHour(dc);
		
		var info_top = App.getApp().getProperty("info_top");
		if(info_top == 0){
			drawDate(dc);
		}else if( info_top == 1){
			drawBattery(dc);
		}
		
		if(display_altimeter){
			drawMountain(dc);
       		drawAlti(dc);
       	}
       
       	drawArc(dc);  	
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
        
        if(display_altimeter){
        	text_y_hour = cy-12;
        }else{
        	text_y_hour = cy;
        }
        
        var text_width_hour;
        var start_x;
        if(settings.is24Hour || hour>=10){
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
                
        dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
        dc.drawText(start_x, text_y_hour, Gfx.FONT_NUMBER_THAI_HOT, hourString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        
        var start_point=start_x+text_width_hour+2;
        dc.drawText(start_point, text_y_hour, Gfx.FONT_NUMBER_THAI_HOT, ":", Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        
        dc.setColor(color_user, Gfx.COLOR_TRANSPARENT);
        var start_minute=start_point+text_width_point+2;
        dc.drawText(start_minute, text_y_hour, Gfx.FONT_NUMBER_THAI_HOT, minuteString, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
        
        var display_second = App.getApp().getProperty("second_display");
        if(active && display_second){
        	var start_second=start_minute+text_width_minute+4;
        	dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
        	dc.drawText(start_second, cy-text_height_hour/2+text_height_second/2, Gfx.FONT_NUMBER_MEDIUM, secondString, Graphics.TEXT_JUSTIFY_VCENTER |Graphics.TEXT_JUSTIFY_LEFT);
		}
    }
    
    
    
    function drawDate(dc){
    	var dateString;
    	var date_type =  App.getApp().getProperty("date_type");
    	if(date_type == 0){
    		dateString = Lang.format("$1$ $2$", [info.day_of_week.substring(0,3), info.day]);
    	}else{
    		dateString = Lang.format("$1$ $2$ $3$", [info.day_of_week.substring(0,3), info.day, info.month.substring(0,3)]);
    	}
    	dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
        dc.drawText(cx, cy-text_height_hour/2-30, Gfx.FONT_SMALL, dateString, Graphics.TEXT_JUSTIFY_CENTER);
    }
    
    function drawAlti(dc){
        var actaltitude = 4000;
		var altitudeStr;
		var y;
		if(arc_type==3){
			y = 192;
		}else{
			y = 185;
		}
		var x = 40;
    
        var actInfo = Act.getActivityInfo();
		if (actInfo != null && actInfo.altitude != null) {
			actaltitude = actInfo.altitude;				
		}
		var metric = Sys.getDeviceSettings().elevationUnits;
		if (metric==Sys.UNIT_METRIC) {
			altitudeStr = format("$1$m", [actaltitude.format("%d")]);
		} else {
			altitudeStr = format("$1$ft", [actaltitude.format("%d")]);
		}
		var text_width = dc.getTextWidthInPixels(altitudeStr,Gfx.FONT_MEDIUM);
		dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
		dc.drawText(x + 105-text_width/2, y - 24/2, Gfx.FONT_MEDIUM, altitudeStr, Graphics.TEXT_JUSTIFY_VCENTER | Graphics.TEXT_JUSTIFY_LEFT);
    }
    
    function drawMountain(dc){
		var y;
		if(arc_type==3){
			y = 192;
		}else{
			y = 185;
		}
		var x = 40;
    
        dc.setColor( color_user,Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, y-23, dc.getWidth(), 26);
        var mountain_1 = [ [x,y], [x+23,y-40],[x+35,y-20], [x+21,y]  ];
        var mountain_2 = [ [x+24,y], [x+45,y-30], [x+65,y]  ];
        dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
        dc.fillPolygon(mountain_1);
        dc.fillPolygon(mountain_2);
    }
    
    function setColorShade(){
        var user_color =  App.getApp().getProperty("shade_color");
        if(user_color == 0){
        	color_user = Gfx.COLOR_DK_RED;
        }else if (user_color == 1) {
        	color_user = Gfx.COLOR_BLUE;
        }else if (user_color == 2) {
        	color_user = Gfx.COLOR_DK_BLUE;
        }else if (user_color == 3) {
        	color_user = Gfx.COLOR_GREEN;
        }else if (user_color == 4) {
        	color_user = Gfx.COLOR_DK_GREEN;
        }else if (user_color == 5) {
        	color_user = Gfx.COLOR_LT_GRAY;
        }else if (user_color == 6) {
        	color_user = Gfx.COLOR_DK_GRAY;
        }else if (user_color == 7) {
        	color_user = Gfx.COLOR_ORANGE;
        }else if (user_color == 8) {
        	color_user = Gfx.COLOR_PINK;
        }else if (user_color == 9) {
        	color_user = Gfx.COLOR_PURPLE;
        }else if (user_color == 10) {
        	color_user = Gfx.COLOR_RED;
        }else if (user_color == 11) {
        	color_user = Gfx.COLOR_DK_RED;
        }
    }
    
    function setBackgroundColor(dc){
        var bgk_color =  App.getApp().getProperty("bgk_color");
        if(bgk_color == 0){
        	dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        	color_text = Gfx.COLOR_WHITE;
        }else if (bgk_color == 1) {
        	dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_WHITE );
        	color_text = Gfx.COLOR_BLACK;
        }
    }

    function drawArc(dc){
        if(arc_type<3){
        	var arc_width =  App.getApp().getProperty("arc_width");
        	dc.setPenWidth(arc_width);
        	setColorArc(dc); 
        	if(arc_type == 0){
        		drawArcBattery(dc);
        	}else if (arc_type == 1) {
        		drawArcStep(dc);
        	}else if (arc_type == 2) {
        		drawArcActivity(dc);
        	}
        }
    }
    
    function drawArcBattery(dc){
    	var battery = Sys.getSystemStats().battery;
    	var battery_low =  App.getApp().getProperty("battery_low");
    	if(battery<=battery_low){
    		dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    	}
       	var percentage_battery = battery*360/100;
       	if(percentage_battery>0){
       		dc.drawArc(cx,cy,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-percentage_battery.toLong()+90)%360); 
       	}
    }
    
    function drawArcStep(dc){
    	var percentage_step = ActivityMonitor.getInfo().steps*360/ActivityMonitor.getInfo().stepGoal;
    	if(percentage_step>0){
       		dc.drawArc(cx,cy,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-percentage_step.toLong()+90)%360);   
       	}
    }

    function drawArcActivity(dc){
    	var percentage_activity = ActivityMonitor.getInfo().moveBarLevel*360/ActivityMonitor.MOVE_BAR_LEVEL_MAX;
    	if(percentage_activity>0){
       		dc.drawArc(cx,cy,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-percentage_activity.toLong()+90)%360);   
       	}
    }
        
    function setColorArc(dc){
        var user_color =  App.getApp().getProperty("arc_color");
        if(user_color == 0){
        	dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 1) {
        	dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 2) {
        	dc.setColor(Gfx.COLOR_DK_BLUE, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 3) {
        	dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 4) {
        	dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 5) {
        	dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 6) {
        	dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 7) {
        	dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 8) {
        	dc.setColor(Gfx.COLOR_PINK, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 9) {
        	dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 10) {
        	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        }else if (user_color == 11) {
        	dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
        }
    }
    
    function drawBattery(dc){
    	var battery = System.getSystemStats().battery;
    	var width=42;
    	var height=23;
    	var xStart= cx-width/2;
    	var yStart = cy-text_height_hour/2-30;
    	
    	dc.setColor(color_text, Gfx.COLOR_TRANSPARENT);
    	dc.drawRectangle(xStart, yStart, width, height);
        dc.fillRectangle(xStart + width - 1, yStart + 6, 4, height - 12);   
       
        var battery_low =  App.getApp().getProperty("battery_low");
    	if(battery<=battery_low){
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_TRANSPARENT);
        }
        
        var display_perrcentage = App.getApp().getProperty("battery_percentage");
        
        if(display_perrcentage){
            dc.drawText(xStart+width/2 , yStart, Graphics.FONT_TINY, format("$1$%", [battery.format("%d")]), Graphics.TEXT_JUSTIFY_CENTER);
        }else{
        	dc.fillRectangle(xStart + 1, yStart + 1, (width-2) * battery / 100, height - 2);
        }
    }
}