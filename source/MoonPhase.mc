using Toybox.WatchUi as Ui;

module MoonPhase{

   function getIconSunsetBlack(moment){
   	    var moonDiff = moment.value() - 1439563980;
		var moonAge = ((moonDiff %2551443)/60/60/24).toNumber();
		
		var icon;
		if(moonAge==1){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_1);
		}else if(moonAge==2){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_2);
		}else if(moonAge==3){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_3);
		}else if(moonAge==4){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_4);
		}else if(moonAge==5){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_5);
		}else if(moonAge==6){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_6);
		}else if(moonAge==7){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_7);
		}else if(moonAge==8){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_8);
		}else if(moonAge==9){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_9);
		}else if(moonAge==10){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_10);
		}else if(moonAge==11){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_11);
		}else if(moonAge==12){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_12);
		}else if(moonAge==13){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_13);
		}else if(moonAge==14){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_14);
		}else if(moonAge==15){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_15);
		}else if(moonAge==16){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_16);
		}else if(moonAge==17){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_17);
		}else if(moonAge==18){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_18);
		}else if(moonAge==19){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_19);
		}else if(moonAge==20){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_20);
		}else if(moonAge==21){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_21);
		}else if(moonAge==22){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_22);
		}else if(moonAge==23){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_23);
		}else if(moonAge==24){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_24);
		}else if(moonAge==25){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_25);
		}else if(moonAge==26){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_26);
		}else if(moonAge==27){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_27);
		}else if(moonAge==28){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_28);
		}else{
			icon =  Ui.loadResource( Rez.Drawables.MoonIconBlack_29);
		}
   		return icon;
   }
   
   function getIconSunsetWhite(moment){
   	    var moonDiff = moment.value() - 1439563980;
		var moonAge = ((moonDiff %2551443)/60/60/24).toNumber();
		
		var icon;
		if(moonAge==1){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_1);
		}else if(moonAge==2){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_2);
		}else if(moonAge==3){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_3);
		}else if(moonAge==4){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_4);
		}else if(moonAge==5){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_5);
		}else if(moonAge==6){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_6);
		}else if(moonAge==7){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_7);
		}else if(moonAge==8){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_8);
		}else if(moonAge==9){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_9);
		}else if(moonAge==10){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_10);
		}else if(moonAge==11){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_11);
		}else if(moonAge==12){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_12);
		}else if(moonAge==13){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_13);
		}else if(moonAge==14){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_14);
		}else if(moonAge==15){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_15);
		}else if(moonAge==16){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_16);
		}else if(moonAge==17){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_17);
		}else if(moonAge==18){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_18);
		}else if(moonAge==19){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_19);
		}else if(moonAge==20){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_20);
		}else if(moonAge==21){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_21);
		}else if(moonAge==22){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_22);
		}else if(moonAge==23){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_23);
		}else if(moonAge==24){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_24);
		}else if(moonAge==25){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_25);
		}else if(moonAge==26){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_26);
		}else if(moonAge==27){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_27);
		}else if(moonAge==28){
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_28);
		}else{
			icon =  Ui.loadResource( Rez.Drawables.MoonIconWhite_29);
		}
   		return icon;
   }
}