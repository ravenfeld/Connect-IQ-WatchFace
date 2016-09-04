using Toybox.Graphics as Gfx;
using Toybox.Lang;

module Utils{
	
	function drawIconText(dc,text,x,y,text_color,icon){
	   	dc.setColor(text_color, Gfx.COLOR_TRANSPARENT);
	   	var text_width = dc.getTextWidthInPixels(""+text,Gfx.FONT_SMALL);
        dc.drawText(x+icon.getWidth()/2-text_width/2+7, y+2, Gfx.FONT_SMALL, text, Gfx.TEXT_JUSTIFY_VCENTER|Gfx.TEXT_JUSTIFY_LEFT);
		dc.drawBitmap(x-icon.getWidth()/2-text_width/2,y-icon.getHeight()/2,icon);
	}
	
}