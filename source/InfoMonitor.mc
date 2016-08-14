using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang;

module InfoMonitor{

	function drawArcMoveBar(dc,move_bar,move_bar_max,x,y,color,arc_width){
	    var angle_move = move_bar*360/move_bar_max;
	   	dc.setPenWidth(arc_width);
		dc.setColor(color,Gfx.COLOR_TRANSPARENT);
	    
    	if(angle_move>0){
       		dc.drawArc(x,y,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-angle_move.toLong()+90)%360);   
       	}
	}
	
	function drawArcStep(dc,steps,stepGoal,x,y,color,arc_width){
	    var angle_step = steps*360/stepGoal;
	   	dc.setPenWidth(arc_width);
		dc.setColor(color,Gfx.COLOR_TRANSPARENT);

    	if(angle_step>0){
       		dc.drawArc(x,y,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-angle_step.toLong()+90)%360);   
       	}
	}
	
	function drawIconText(dc,text,x,y,text_color,icon){
	   	dc.setColor(text_color, Gfx.COLOR_TRANSPARENT);
	   	var text_width = dc.getTextWidthInPixels(""+text,Gfx.FONT_SMALL);
        dc.drawText(x+icon.getWidth()/2-text_width/2+7, y+2, Gfx.FONT_SMALL, text, Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawBitmap(x-icon.getWidth()/2-text_width/2,y-icon.getHeight()/2,icon);
	}
	
	function drawIconDistance(dc,distance,x,y,text_color,distance_icon){
		var distanceStr;
		var metric = Sys.getDeviceSettings().distanceUnits;
		if (metric==Sys.UNIT_METRIC) {
			if(distance/100000.0>=1){
				distanceStr=Lang.format("$1$km", [(distance/100000.0).format("%.2f")]);
			}else{
				distanceStr=Lang.format("$1$m", [(distance/100).format("%d")]);
			}
		}else{
			if(distance/160934>=1){
				distanceStr=Lang.format("$1$M", [(distance/160934.0).format("%.2f")]);
			}else{
				distanceStr=Lang.format("$1$ft", [(distance/30.42).format("%d")]);
			}
		}
		InfoMonitor.drawIconText(dc,distanceStr,x,y,text_color,distance_icon);
	}
}