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
	
	private function SelectRequestor():void{
        for (var i:int = 0; i< requestors.length; i++){	      	
        	if(requestors[i].data == SelectedRequestor){
        		comboRequestorRequestor.selectedIndex = i;
        		return;
        	}
        }
    	comboRequestorRequestor.selectedIndex = 0;
    	SelectedRequestor = requestors[0].data;
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
    
	private function SelectKostl():void{
        for (var i:int = 0; i< costCentres.length; i++){	      	
        	if(costCentres[i].data == SelectedKostl){
        		comboKostlKostl.selectedIndex = i;
        		return;
        	}
        }
    	comboKostlKostl.selectedIndex = 0;
    	SelectedKostl = costCentres[0].data;
	}
	
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