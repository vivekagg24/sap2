// ActionScript file

	private function getComboValue(value:Object):String{
		var xmlValue:XMLList = value.descendants("DATA");
		return xmlValue.toString();        	
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

 	public function EnableButtons(Enable:Boolean):void{
 		
 		bEnableButtons = Enable;
 		
 	}

	private function clone(source:Object):*{

	    var myBA:ByteArray = new ByteArray();
	    myBA.writeObject(source);
	    myBA.position = 0;
	    return(myBA.readObject());
	}

	private function SetTitle():void{
	
		CurrentPerNr = ClaimLine.PERNR;
		CasualName   = ClaimLine.CASUAL_NAME;
	
		if(CurrentPerNr == "" || CurrentPerNr == null){

			Title = cDefaultTitle;			
		}else{
			Title = cDefaultTitle + ": Personnel number " + CurrentPerNr + " - " + CasualName;
		}
	
	}
	
	private function CheckItemsForSave():Boolean{
		
		for(var i:int; ClaimItems.length > i; i++){
			
			if(ClaimItems[i].UPDATED == 'X'){
				
				return true;
			}
		}
		
		return false;
	}


	private function SaveItem():void{
		
		if (CheckItemsForSave() == true){

			ServerRequest(cSave,'',0,null);

		}else{
			
			FormatError(btnSave,"No data has changed");
		}
	}

						
	private function CreatePSkey():void{
		
		PSkey = new Object();
		
		PSkey.PERNR = ClaimLine.PERNR
		PSkey.INFTY = '2010';
		PSkey.SUBTY = ClaimLine.SUBTY
		PSkey.OBJPS = ClaimLine.OBJPS
		PSkey.SPRPS = ClaimLine.SPRPS
		PSkey.ENDDA = DateToSAPFormat(ClaimLine.ENDDA.toString())
		PSkey.BEGDA = DateToSAPFormat(ClaimLine.BEGDA.toString())
		PSkey.SEQNR = ClaimLine.SEQNR

	}		
	
	private function FormatMessages(messageXML:XML):String{

    	var currItem:XML;
    	var itemsList:XMLList = messageXML.EX_RETURN_MESSAGES;

		var Message:String;

    	for each(currItem in itemsList.item){
    		
    		if(Message == null){

	  			Message = currItem.MESSAGE.toString() + '\n'
    			
    		}else{

	  			Message = Message +  currItem.MESSAGE.toString() + '\n'    			
    			
    		}
  		}
	
		return Message;
	}
	
	
	private function DateToSAPFormat(sDate:String):String{
		
		var SAPDate:String = sDate.substr(6,4) + sDate.substr(3,2) + sDate.substr(0,2) 
	
		return SAPDate;	
				
	}
	
	private function TimeToSAPFormat(sTime:String):String{

		var SAPTime:String = sTime.substr(0,2) + sTime.substr(3,2) + '00';
	
		return SAPTime;	
		
	}
	
