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
	
	function drawArcStep(dc,steps,stepGoal,x,y,color,colorGoal,arc_width){
	    var angle_step = steps*360/stepGoal;
	
		if(steps>=stepGoal){
			dc.setPenWidth(arc_width);
			dc.setColor(colorGoal,Gfx.COLOR_TRANSPARENT);
			dc.drawArc(x,y,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,90);
		}
		if( steps!=stepGoal && angle_step>0){
			dc.setPenWidth(arc_width+1);
			dc.setColor(color,Gfx.COLOR_TRANSPARENT);
       		dc.drawArc(x,y,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-angle_step.toLong()+90)%360);   
       	}
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
		Utils.drawIconText(dc,distanceStr,x,y,text_color,distance_icon);
	}
}