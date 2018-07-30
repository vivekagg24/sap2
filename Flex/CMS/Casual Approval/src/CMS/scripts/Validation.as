// ActionScript file
import mx.core.UIComponent;

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
		}
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
  