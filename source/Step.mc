using Toybox.Graphics as Gfx;

module Step{
	function drawArc(dc,steps,stepGoal,x,y,color,arc_width){
	    var angle_step = steps*360/stepGoal;
	   	dc.setPenWidth(arc_width);
		dc.setColor(color,Gfx.COLOR_TRANSPARENT);

    	if(angle_step>0){
       		dc.drawArc(x,y,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-angle_step.toLong()+90)%360);   
       	}
	}
}