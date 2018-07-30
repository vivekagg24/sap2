// ActionScript file
import mx.core.UIComponent;import mx.events.ValidationResultEvent;

	private function ValidateAll():UIComponent{

		var AmountResult:ValidationResultEvent 	  = AmountCheck.validate();
		var PerNrFromResult:ValidationResultEvent = PerNrFromCheck.validate();	
		var PerNrToResult:ValidationResultEvent   = PerNrToCheck.validate();		

		if (AmountResult.type == ValidationResultEvent.INVALID){

			return tiGTAmount;
		}
		
		if (PerNrFromResult.type == ValidationResultEvent.INVALID){

			return tiPernrFrom;
		}
		
		if (PerNrToResult.type == ValidationResultEvent.INVALID){
	
			return tiPernrTo;
		}		return null;
	}

	private function ValidateDataOnSubmit():Boolean{

		var ErrdComponent:UIComponent;
		var i:int
				
		while(ErrdComponent == null){
			
			switch (i){
				
				case 0:

					ErrdComponent = ValidateAll();
					break;

				case 1:
				
					return true;
					break;
			}
			
			i++;
		}

		ShowValidationAlert(ErrdComponent);
   
		return false;
	}

	private function ShowValidationAlert(Component:UIComponent):void{

		FocusComponent = Component;
		Alert.show('Please edit data in highlighted fields',"Errors exist",0,this,HandleValidationAlertClose); 
	       
	}
  	private function FormatError(Component:UIComponent, ErrorString:String):void{	  			FocusComponent = Component;	  			Alert.show(ErrorString,cErrorTitle,0,this,HandleValidationAlertClose);   		}	private function HandleValidationAlertClose(event:CloseEvent):void{			if (FocusComponent) FocusComponent.setFocus();				application.focusManager.showFocus();						FocusComponent = null;			}	private function FormatMessages(messageXML:XML):String{    	var currItem:XML;    	var itemsList:XMLList = messageXML.EX_RETURN_MESSAGES;		var Message:String;    	for each(currItem in itemsList.item){    		    		if(Message == null){	  			Message = currItem.MESSAGE.toString() + '\n'    			    		}else{	  			Message = Message +  currItem.MESSAGE.toString() + '\n'    			    			    		}  		}			return Message;	}			