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
	   
	private function SelectFormType():void{
        for (var i:int = 0; i< formType.length; i++){	      	
        	if(formType[i].data == SelectedFormType){
        		comboFormType.selectedIndex = i;
        		return;
        	}
        }
    	comboFormType.selectedIndex = 0;
    	SelectedFormType = formType[0].data;
	}
	
	private function PopulateFormType():void{
		
        var xmlFormTypeLength:int  = xmlalldata.FORMTYPE.item.length();

        formType = new Array();

        var i:Number=0;

        for (i=0; i< xmlFormTypeLength; i++){
            var value:String = xmlalldata.FORMTYPE.item[i].FORM_TYPE.toString();
            var key:String = xmlalldata.FORMTYPE.item[i].FORM_TYPE.toString();                         
            formType.push({label: value, data: key});
		}
    }
    
	private function SelectPerson():void{
        for (var i:int = 0; i< person.length; i++){	      	
        	if(person[i].data == SelectedPerson){
        		comboPerson.selectedIndex = i;
        		return;
        	}
        }
    	comboPerson.selectedIndex = 0;
    	SelectedPerson = person[0].data;
	}
	
	private function PopulatePerson():void{	
        var xmlPersonLength:int  = xmlalldata.REQUESTOR.item.length();

        person = new Array();

        var i:Number=0;

        for (i=0; i< xmlPersonLength; i++){
            var value:String = xmlalldata.REQUESTOR.item[i].REQUESTOR.toString();
            var key:String = xmlalldata.REQUESTOR.item[i].REQUESTOR.toString();                         
            person.push({label: value, data: key});
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