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
	
	private function SetDefaultDates():void{
		// Note - the Date class copes with negative values. So if the date is 02.02.2008, 
		// and we tell it to subtract three from the month (i.e. data.month = -1) then it 
		// knows to change to 02.11.2007 (i.e. the previous year).
		const saturday:uint = 6;
				var Today:Date    = new Date();		var FromDate:Date = new Date();		var previousSaturday:Date = new Date();
		
		var daysAferSaturday:int = Today.day - saturday;
		if (daysAferSaturday < 1) daysAferSaturday += 7;
		previousSaturday.date = previousSaturday.date - daysAferSaturday;

        dfPaymentTo.selectedDate = Today;		dfPaymentTo.UpdateSAPDateField();		FromDate.month = Today.month - 2;		dfPaymentFrom.selectedDate = FromDate;		dfPaymentFrom.UpdateSAPDateField()	}	private function SelectRequestor():void{
        for (var i:int = 0; i< requestors.length; i++){	      	
        	if(requestors[i].data == SelectedRequestor){
        		comboRequestorRequestor.selectedIndex = i;
        		return;
        	}
        }
    	comboRequestorRequestor.selectedIndex = 0;
    	SelectedRequestor = requestors[0].data;
	}
	
	private function PopulatePage():void{
		 		
    	lowout =  xmlalldata.PAGELOWVAL.toString();
		highout = xmlalldata.PAGEHIGHVAL.toString();
		}
		
		 
	
	private function PopulateRequestor():void{
		
        var xmlRequestorLength:int  = xmlalldata.REQUESTOR.item.length();

        requestors = new Array();

        var i:Number=0;

        for (i=0; i< xmlRequestorLength; i++){
            var value:String = xmlalldata.REQUESTOR.item[i].REQUESTOR.toString();
            var key:String = xmlalldata.REQUESTOR.item[i].REQUESTOR.toString();                         
            requestors.push({label: value, data: key});
		}
    }

<!--	private function SelectKostl():void{
        for (var i:int = 0; i< costCentres.length; i++){	      	
        	if(costCentres[i].data == SelectedKostl){
        		comboKostlKostl.selectedIndex = i;
        		return;
        	}
        }
    	comboKostlKostl.selectedIndex = 0;
    	SelectedKostl = costCentres[0].data;
	}  -->
	
	private function PopulateKostl():void{
		
        var xmlcostCentreLength:int  = xmlalldata.COST_CENTRES.item.length();

        costCentres = new Array();

        var i:Number=0;

        for (i=0; i< xmlcostCentreLength; i++){
            var value:String = xmlalldata.COST_CENTRES.item[i].KOSTL.toString();
            var key:String = xmlalldata.COST_CENTRES.item[i].KOSTL.toString();                         
            costCentres.push({label: value, data: key});
		}
    } 
	
	private function buildDropdownList(list:XMLList,blanks:Boolean):Array{
		var arrayValues:Array = new Array();
		var currentValue:valueForDropdown;
		var i:int;
		var item:XML;
		for each(item in list.item){
			currentValue = new valueForDropdown();
		
			currentValue.data  = item.DATA.toString();
			currentValue.label = item.LABEL.toString();
		
			if (blanks || currentValue.label!="") arrayValues[i] = currentValue;
				i++;
		}
		return arrayValues;
	}
