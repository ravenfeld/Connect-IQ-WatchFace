using Toybox.Graphics as Gfx;

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
}