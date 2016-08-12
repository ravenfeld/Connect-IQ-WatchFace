using Toybox.Graphics as Gfx;

module MoveBar{
	function drawArc(dc,move_bar,move_bar_max,x,y,color,arc_width){
	    var angle_move = move_bar*360/move_bar_max;
	   	dc.setPenWidth(arc_width);
		dc.setColor(color,Gfx.COLOR_TRANSPARENT);
	    
    	if(angle_move>0){
       		dc.drawArc(x,y,dc.getHeight()/2-1,Gfx.ARC_CLOCKWISE,90,(360-angle_move.toLong()+90)%360);   
       	}
	}
}