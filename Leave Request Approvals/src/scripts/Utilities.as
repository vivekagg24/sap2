// ActionScript file
import flash.events.Event;
import HR.generalClasses.*;
	
	private function DateToSAPFormat(sDate:String):String{
		var SAPDate:String = sDate.substr(6,4) + sDate.substr(3,2) + sDate.substr(0,2) 
		return SAPDate;	
	}
	
	private function TimeToSAPFormat(sTime:String):String{
		var SAPTime:String = sTime.substr(0,2) + sTime.substr(3,2) + '00';
		return SAPTime;	
	}