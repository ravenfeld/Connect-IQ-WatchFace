using Toybox.Graphics as Gfx;
using Toybox.Lang;

module Date{
	function drawHour(dc,date,start_x,cy,text_width,text_height,is24Hour,color,display_second){
		var hour;
        if (is24Hour) {
            hour = date.hour;
        } else {
        	hour = date.hour%12;
        	if(hour==0){
        		hour=12;
        	}
        }
        
        var hourString;
        if (hour < 10) {
            hourString = Lang.format("0$1$", [hour]);   
        } else {
            hourString = Lang.format("$1$", [hour]);
        }
        
        var minuteString;
        if (date.min >= 10) {
            minuteString = Lang.format("$1$", [date.min.format("%d")]);
        } else {
            minuteString = Lang.format("0$1$", [date.min.format("%d")]);
        }
                       
        dc.setColor(color[0], Gfx.COLOR_TRANSPARENT);
        dc.drawText(start_x, cy, Gfx.FONT_NUMBER_THAI_HOT, hourString, Gfx.TEXT_JUSTIFY_VCENTER | Gfx.TEXT_JUSTIFY_LEFT);
        
        var start_point=start_x+text_width[0]+2;
        dc.drawText(start_point, cy, Gfx.FONT_NUMBER_THAI_HOT, ":", Gfx.TEXT_JUSTIFY_VCENTER | Gfx.TEXT_JUSTIFY_LEFT);
        
        dc.setColor(color[1], Gfx.COLOR_TRANSPARENT);
        var start_minute=start_point+text_width[1]+2;
        dc.drawText(start_minute, cy, Gfx.FONT_NUMBER_THAI_HOT, minuteString, Gfx.TEXT_JUSTIFY_VCENTER | Gfx.TEXT_JUSTIFY_LEFT);
        
        
        if(display_second){
            var secondString;
        	if (date.sec >= 10) {
            	secondString = Lang.format("$1$", [date.sec.format("%d")]);
        	} else {
            	secondString = Lang.format("0$1$", [date.sec.format("%d")]);
        	}
        	var start_second=start_minute+text_width[2]+4;
        	dc.setColor(color[0], Gfx.COLOR_TRANSPARENT);
        	dc.drawText(start_second, cy-text_height[0]/2+text_height[1]/2+12, Gfx.FONT_NUMBER_MEDIUM, secondString, Gfx.TEXT_JUSTIFY_VCENTER |Gfx.TEXT_JUSTIFY_LEFT);
		}
	}
	
	function drawDate(dc,date,cx,y,text_color,date_type){
    	var dateString;
    	
    	if(date_type == 0){
    		dateString = Lang.format("$1$ $2$", [date.day_of_week.substring(0,3), date.day]);
    	}else if(date_type==1){
    		dateString = Lang.format("$1$ $2$ $3$", [date.day_of_week.substring(0,3), date.day, date.month.substring(0,3)]);
    	}else{
    		dateString = Lang.format("$1$ $2$", [date.day, date.month.substring(0,3)]);
    	}
    	dc.setColor(text_color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(cx, y, Gfx.FONT_SMALL, dateString, Gfx.TEXT_JUSTIFY_CENTER);
    }
}