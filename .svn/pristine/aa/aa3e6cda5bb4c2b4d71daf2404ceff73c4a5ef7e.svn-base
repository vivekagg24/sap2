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
    
	private function SelectCostCentre():void{
       for (var i:int = 0; i< costCentre.length; i++){	      	
        	if(costCentre[i].data == SelectedCostCentre){
        		comboCostCentre.selectedIndex = i;
        		return;
        	}
        }
    	comboCostCentre.selectedIndex = 0;
    	SelectedCostCentre = costCentre[0].data; 
	}
	
	private function PopulateCostCentre():void{
		
        var xmlCostCentreLength:int  = xmlalldata.COSTCENTRE.item.length();

        costCentre = new Array();

        var i:Number=0;

        for (i=0; i< xmlCostCentreLength; i++){
            var value:String = xmlalldata.COSTCENTRE.item[i].COST_CENTRE.toString();
            var key:String = xmlalldata.COSTCENTRE.item[i].COST_CENTRE.toString();                         
            costCentre.push({label: value, data: key});
		}
    } 
    
	private function SelectAction():void{
        for (var i:int = 0; i< action.length; i++){	      	
        	if(action[i].data == SelectedAction){
        		comboAction.selectedIndex = i;
        		return;
        	}
        }
    	comboAction.selectedIndex = 0;
    	SelectedAction = action[0].data;
	}
	
 	private function PopulateAction():void{
        action = new Array();

        var value:String = "All"; //xmlalldata.ACTION.item[i].ACTION.toString();
        var key:String = ""; //xmlalldata.ACTION.item[i].ACTION.toString(); 
		action.push({label: value, data: key});
        value = "Approved"; //xmlalldata.ACTION.item[i].ACTION.toString();
        key = "APPROVED"; //xmlalldata.ACTION.item[i].ACTION.toString(); 
		action.push({label: value, data: key});
        value = "Rejected"; //xmlalldata.ACTION.item[i].ACTION.toString();
        key = "REJECTED"; //xmlalldata.ACTION.item[i].ACTION.toString();                                                             
        action.push({label: value, data: key});
    }       