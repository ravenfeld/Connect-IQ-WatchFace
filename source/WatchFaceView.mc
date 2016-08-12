using Toybox.WatchUi as Ui;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Activity as Act;
using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class WatchFaceView extends Ui.WatchFace{
	hidden var cx;
    hidden var cy;
    hidden var settings;
    hidden var active;
    hidden var text_width_hour_10;
    hidden var text_width_hour_1;
    hidden var text_width_point;
	hidden var text_width_minute;
	hidden var text_width_second;
	hidden var text_height_hour;
	hidden var text_height_second;
	hidden var text_y_second;
	hidden var start_x_active_hour_10;
	hidden var start_x_active_hour_1;
	hidden var start_x_sleep_hour_10;
	hidden var start_x_sleep_hour_1;
	hidden var text_color;
	hidden var calorie_icon_white;
	hidden var calorie_icon_black;
	hidden var step_icon_white;
	hidden var step_icon_black;
	hidden var distance_icon_white;
	hidden var distance_icon_black;
		
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
    
    function onShow(){
        calorie_icon_white = Ui.loadResource(Rez.Drawables.CalorieIconWhite);
    	calorie_icon_black = Ui.loadResource(Rez.Drawables.CalorieIconBlack);

    	step_icon_white = Ui.loadResource(Rez.Drawables.StepIconWhite);
    	step_icon_black = Ui.loadResource(Rez.Drawables.StepIconBlack);
    	
    	distance_icon_white = Ui.loadResource(Rez.Drawables.DistanceIconWhite);
    	distance_icon_black = Ui.loadResource(Rez.Drawables.DistanceIconBlack);
    }
    
    function onHide(){
    	
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
    	var arc_type =  App.getApp().getProperty("arc_type");
    	var info_top = App.getApp().getProperty("info_top");
    	var info_bottom = App.getApp().getProperty("info_bottom");
    	var display_second = App.getApp().getProperty("second_display");
    	var date_type =  App.getApp().getProperty("date_type");
    	
    	var battery = Sys.getSystemStats().battery;
    	var battery_low =  App.getApp().getProperty("battery_low");
    	
    	var battery_percentage = App.getApp().getProperty("battery_percentage");
    	
    	var bgk_color = getBackgroundColor(dc);
    	dc.setColor(bgk_color,bgk_color);
    	
    	if(bgk_color==Gfx.COLOR_BLACK){
    		text_color=Gfx.COLOR_WHITE;
    	}else{
    		text_color=Gfx.COLOR_BLACK;
    	}
    	
    	var shade_color = getColorShade();
        dc.clear();

        var moment = Time.now();
        var info_date = Gregorian.info(moment, Time.FORMAT_MEDIUM);
        
        drawHour(dc,info_date,shade_color,info_bottom,active&&display_second);
    
		var y;
		if(info_top == 0){
			y = cy-text_height_hour/2-27;
			Date.drawDate(dc,info_date,cx,y,text_color,date_type);
		}else if( info_top == 1){
			y = cy-text_height_hour/2-15;
			Battery.drawIcon(dc,battery,battery_low,cx,y,text_color,battery_percentage);
		}else if (info_top == 2 && settings.phoneConnected){
			y = cy-text_height_hour/2-15;
			PhoneConnected.drawIcon(dc,cx,y,text_color);
		}else if(info_top == 3){
			y = cy-text_height_hour/2-15;
			var calorie_icon;
			if(bgk_color==Gfx.COLOR_BLACK){
				calorie_icon = calorie_icon_white;
			}else{
				calorie_icon = calorie_icon_black;
			}
			InfoMonitor.drawIconText(dc,ActivityMonitor.getInfo().calories,cx,y,text_color,calorie_icon);
		}else if(info_top == 4){
			y = cy-text_height_hour/2-15;
			var step_icon;
			if(bgk_color==Gfx.COLOR_BLACK){
				step_icon = step_icon_white;
			}else{
				step_icon = step_icon_black;
			}
			InfoMonitor.drawIconText(dc,ActivityMonitor.getInfo().steps,cx,y,text_color,step_icon);
		}else if(info_top == 5){
			y = cy-text_height_hour/2-15;
			var distance_icon;
			if(bgk_color==Gfx.COLOR_BLACK){
				distance_icon = distance_icon_white;
			}else{
				distance_icon = distance_icon_black;
			}
		
			InfoMonitor.drawIconDistance(dc,ActivityMonitor.getInfo().distance,cx,y,text_color,distance_icon);
		}
		
		
		if(info_bottom == 0){
			if(arc_type==3){
				y = 192;
			}else{
				y = 185;
			}
			var x = 40;
       		Altimeter.draw(dc,x,y,text_color,text_color,shade_color);	
		}else if( info_bottom == 1){
			y = cy+text_height_hour/2;
			Date.drawDate(dc,info_date,cx,y,text_color,date_type);
		}else if(info_bottom ==2){
			y = cy+text_height_hour/2+20;
			Battery.drawIcon(dc,battery,battery_low,cx,y,text_color,battery_percentage);	
		}else if (info_bottom == 3 && settings.phoneConnected){
			y = cy+text_height_hour/2+20;
			PhoneConnected.drawIcon(dc,cx,y,text_color);
		}else if(info_bottom == 4){
			y = cy+text_height_hour/2+20;
			var calorie_icon;
			if(bgk_color==Gfx.COLOR_BLACK){
				calorie_icon = calorie_icon_white;
			}else{
				calorie_icon = calorie_icon_black;
			}
			InfoMonitor.drawIconText(dc,ActivityMonitor.getInfo().calories,cx,y,text_color,calorie_icon);
		}else if(info_bottom == 5){
			y = cy+text_height_hour/2+20;
			var step_icon;
			if(bgk_color==Gfx.COLOR_BLACK){
				step_icon = step_icon_white;
			}else{
				step_icon = step_icon_black;
			}
			InfoMonitor.drawIconText(dc,ActivityMonitor.getInfo().steps,cx,y,text_color,step_icon);
		}else if(info_bottom == 6){
			y = cy+text_height_hour/2+20;
			var distance_icon;
			if(bgk_color==Gfx.COLOR_BLACK){
				distance_icon = distance_icon_white;
			}else{
				distance_icon = distance_icon_black;
			}
			
			InfoMonitor.drawIconDistance(dc,ActivityMonitor.getInfo().distance,cx,y,text_color,distance_icon);
		}
		
		if(arc_type<3){
       		var arc_width =  App.getApp().getProperty("arc_width");
      
       		if(arc_type == 0){
       			Battery.drawArc(dc,battery,battery_low,cx,cy,getColorArc(),arc_width);
       		}else if (arc_type == 1) {
        		InfoMonitor.drawArcStep(dc,ActivityMonitor.getInfo().steps,ActivityMonitor.getInfo().stepGoal,cx,cy,getColorArc(),arc_width);
        	}else if (arc_type == 2) {
        		InfoMonitor.drawArcMoveBar(dc,ActivityMonitor.getInfo().moveBarLevel,ActivityMonitor.MOVE_BAR_LEVEL_MAX,cx,cy,getColorArc(),arc_width);
        	} 	
       	}       	
    }
            
    function drawHour(dc,info_date,shade_color,info_bottom,display_second){
        var text_y_hour;
        if(info_bottom==0){
        	text_y_hour = cy-12;
        }else{
        	text_y_hour = cy;
        }
        var text_width_hour;
        var start_x;
        if(settings.is24Hour || (info_date.hour-12)>=10 ||info_date.hour==0){
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
		Date.drawHour(dc,info_date,start_x,text_y_hour,[text_width_hour,text_width_point,text_width_minute],[text_height_hour,text_height_second],settings.is24Hour,[text_color,shade_color], display_second);	 
    }
    
    function getColorShade(){
        var shade_color =  App.getApp().getProperty("shade_color");
		if (shade_color == 1) {
        	return Gfx.COLOR_BLUE;
        }else if (shade_color == 2) {
        	return Gfx.COLOR_DK_BLUE;
        }else if (shade_color == 3) {
        	return Gfx.COLOR_GREEN;
        }else if (shade_color == 4) {
        	return Gfx.COLOR_DK_GREEN;
        }else if (shade_color == 5) {
        	return Gfx.COLOR_LT_GRAY;
        }else if (shade_color == 6) {
        	return Gfx.COLOR_DK_GRAY;
        }else if (shade_color == 7) {
        	return Gfx.COLOR_ORANGE;
        }else if (shade_color == 8) {
        	return Gfx.COLOR_PINK;
        }else if (shade_color == 9) {
        	return Gfx.COLOR_PURPLE;
        }else if (shade_color == 10) {
        	return Gfx.COLOR_RED;
        }else if (shade_color == 11) {
        	return Gfx.COLOR_DK_RED;
        }else if (shade_color == 12) {
        	return Gfx.COLOR_YELLOW;
        }
        return Gfx.COLOR_DK_RED;
    }
    
    function getBackgroundColor(){
        var bgk_color =  App.getApp().getProperty("bgk_color");
        if(bgk_color == 0){
        	return Gfx.COLOR_BLACK;
        }else{
        	return Gfx.COLOR_WHITE;
        }
    }
        
    function getColorArc(){
        var arc_color =  App.getApp().getProperty("arc_color");
        if (arc_color == 1) {
        	return Gfx.COLOR_BLUE;
        }else if (arc_color == 2) {
        	return Gfx.COLOR_DK_BLUE;
        }else if (arc_color == 3) {
        	return Gfx.COLOR_GREEN;
        }else if (arc_color == 4) {
        	return Gfx.COLOR_DK_GREEN;
        }else if (arc_color == 5) {
        	return Gfx.COLOR_LT_GRAY;
        }else if (arc_color == 6) {
        	return Gfx.COLOR_DK_GRAY;
        }else if (arc_color == 7) {
        	return Gfx.COLOR_ORANGE;
        }else if (arc_color == 8) {
        	return Gfx.COLOR_PINK;
        }else if (arc_color == 9) {
        	return Gfx.COLOR_PURPLE;
        }else if (arc_color == 10) {
        	return Gfx.COLOR_RED;
        }else if (arc_color == 11) {
        	return Gfx.COLOR_DK_RED;
        }else if (arc_color == 12) {
        	return Gfx.COLOR_YELLOW;
        }
        return text_color;
    }
   
}