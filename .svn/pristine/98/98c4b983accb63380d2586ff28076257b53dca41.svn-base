/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	ValidationScripts.as
		Functions for validating the data on the CPR Entry screen

	checkFormIsValid
		Check the data is valid before save
	setInvalidGLCodes
		Add or subtract to number of invalid values - must be 0 to save.
		Item renderer in datagrid calls this function
	setInvalidProjectCodes
	setInvalidCostCentres
	setInvalidAmounts
	setFormIsValid
		Set global Valid flag and style for save buttons based on the form's validity
	validateContributorNumberBeforeSave
*/

/*
	checkFormIsValid
		Check the data is valid before save
*/
import mx.validators.Validator;
import mx.validators.ValidationResult;
import mx.events.ValidationResultEvent;
import flash.events.FocusEvent;
import ecs.generalClasses.CPRItem;


private function checkFormIsValid(level:int):Boolean{
	        
	validateAll();
	
	if (comboSpecialPayment.selectedIndex > 0 && level==3){
	//Cannot save a cash payment as desk head approved
		showMessage("You cannot save a cash pament as 'approved'",true,txtContributorName);    			
  		return false;
	}
	
	if (comboContract.selectedIndex < 0)
	{	// There is more than one default contract, and the user hasn't picked one		 
		showMessage("Please choose one of the contracts below",true,comboContract);    			
  		return false;		
	}
		        			
	
	var item:Object = comboContract.selectedItem;
	var contract_string:String;
	if (item)
	 	contract_string = comboContract.selectedItem.data.toString();
	else
		contract_string = "";
	 	
	if (contract_string.length < 1 && !chkNewContributor.selected)
	{
		showMessage("Please choose one of the contracts below",true,comboContract);    			
  		return false;	
	}
	
	if (contractReasonVisible && taContractReason.text=="") {     
	//User hasn't entered a reason for not selecting a valid contract  		 
		showMessage("Please enter a reason for not selecting a contract",true,taContractReason);    			
  		return false;
  	}
  	
  	if (level>1 && pageNumbersRequired && txtPageNumbers.text=="" && txtPageNumbers.text!="N") {
 	//Is page number required?
 		txtPageNumbers.setFocus();
 		showMessage("Please enter the page number",true,txtPageNumbers);
  		return false;
  	}
   	 
   	
	if (!formIsvalid){
		//Form is not currently valid (set by setFormIsValid)
		
		if (comboSpecialPayment.selectedIndex > 0 && txtOnBehalfOf.text.length==0)
	    {
	 // If a special payment is entered Input on behalf of must be completed
	      showMessage("Input on behalf of is required with special payment types",true,txtOnBehalfOf);	    
	    } 	
		
		if (txtStory.text==""){
			//Story is mandatory
			txtStory.setFocus();
			showMessage("Please enter the story details",true,txtStory);      			
		}
		if (contributorNumberError||(txtContributor.text=="" &&!chkNewContributor.selected)){
			//Valid contributor number?
			showMessage("Please enter a valid contributor",true,txtContributor); 
		}
		if (invalidPubDate){
			//Valid publication date?
			showMessage("Please enter a valid publication date",true,dtPubDate);        			
		}      	
		if (invalidGLCodes>0) {     
			//valid GL account(s) ?
			showMessage("Please enter a valid GL Account",true,null,"GLErrorFocus");
		} 
		if (invalidProjectCodes>0) {
			//Invalid project code entered ?
			showMessage("Please enter a valid project code",true,null,"ProjectErrorFocus");
		}    
		if (invalidAmounts>0) {
			//Invalid amount entered
			showMessage("Please enter a valid amount",true,null,"AmountErrorFocus");
		} 
		if (invalidCostCentres>0) {
			//Invalid project code entered ?
			showMessage("Please enter a valid cost centre",true,null,"CostCentreErrorFocus");
		}       
	
	}
	
	return formIsvalid;
}

/*
	setInvalidGLCodes
		Add or subtract to number of invalid codes - must be 0 to save.
		Item renderer in datagrid calls this function
*/
public function setInvalidGLCodes(add:Boolean):void{
	if (add) invalidGLCodes++;
   	else invalidGLCodes--;
   	setFormIsValid();
}
  
/*
	setInvalidProjectCodes
		Add or subtract to number of invalid values - must be 0 to save.
		Item renderer in datagrid calls this function
*/ 
public function setInvalidProjectCodes(add:Boolean):void{
   	if (add) invalidProjectCodes++;
   	else invalidProjectCodes--;
   	setFormIsValid();
}
 
/*
	setInvalidAmounts
		Add or subtract to number of invalid values - must be 0 to save.
		Item renderer in datagrid calls this function
*/  
public function setInvalidAmounts(add:Boolean):void{
	if (add) invalidAmounts++;
   	else invalidAmounts--;
   	setFormIsValid();
}

/*
	setInvalidCostCentres
		Add or subtract to number of invalid values - must be 0 to save.
		Item renderer in datagrid calls this function
*/
public function setInvalidCostCentres(add:Boolean):void{
	if (add) invalidCostCentres++;
   	else invalidCostCentres--;
   	setFormIsValid();
}

/*
	setFormIsValid
		Set global Valid flag and style for save buttons based on the form's validity
*/
private function setFormIsValid():void{
   if (invalidGLCodes>0 || invalidProjectCodes>0 || invalidAmounts>0 || invalidCostCentres>0
   	|| invalidPubDate
   	|| txtStory.text=="" 
   	|| contributorNumberError 
   	|| (txtContributor.text=="" &&!chkNewContributor.selected )  ) 
   	{
   	formIsvalid=false;
   	saveButtonStyle = "buttonDisabled";   
    }
   else{
   	saveButtonStyle="button";
   	formIsvalid=true;
   }
}



/*
	validateContributorNumberBeforeSave
*/
private function validateContributorNumberBeforeSave(level:int):Boolean{
  if (chkNewContributor.selected && CPRHeader.NEW_NAME1==""){
  	//Must at least enter the name for a new contributor
  	showMessage("Please enter the name of the new contributor",true);
  	return false;
	}
	if (chkNewContributor.selected && level>1){
  	//Cannot have a new contributor for a validated payment
  	showMessage("You can only select a new contributor for an initial/ unvalidated payment",true,chkNewContributor);
  	return false;
  }
  if (txtContributor.text=="" && !chkNewContributor.selected){
  	//Must enter a contributor number
  	showMessage("Please select a contributor",true),txtContributor;
  	return false;
  }
  
  return true;
}

// Trigger all validators    
private function validateAll():void
{
	// Make the Publication Date field think its been focused out of so that it converts
	// whatever the user has typed in into a proper date
	var event:FocusEvent = new FocusEvent(FocusEvent.FOCUS_OUT, false, false, dtPubDate);
	dtPubDate.dispatchEvent(event);
	
	formIsvalid = true;
	var resultEvent:ValidationResultEvent;
	
	// Trigger form field validation	
	
	invalidPubDate = false;
	resultEvent = validDtPubdate.validate();
	if (resultEvent.type == ValidationResultEvent.INVALID)
	   	{
		formIsvalid = false;
		invalidPubDate = true;
	}	
	
	resultEvent = validTxtContributor.validate(); 	
	if (resultEvent.type == ValidationResultEvent.INVALID)  formIsvalid = false;
	
	resultEvent = validComboContract.validate();
	if (resultEvent.type == ValidationResultEvent.INVALID)  formIsvalid = false;
	
	if (taContractReason.visible)
	{
		resultEvent = validTaContractReason.validate();
		if (resultEvent.type == ValidationResultEvent.INVALID)  formIsvalid = false;
	}

		
	resultEvent = validTxtPageNumbers.validate();
	if (resultEvent.type == ValidationResultEvent.INVALID)  formIsvalid = false;
	
	resultEvent = validTxtStory.validate();
	if (resultEvent.type == ValidationResultEvent.INVALID)  formIsvalid = false;
	
	resultEvent = validateonbehalfof.validate();
	if (resultEvent.type == ValidationResultEvent.INVALID)  formIsvalid = false;
	
	
	// Trigger line item validation	
	invalidAmounts = 0;
	invalidCostCentres = 0;
	invalidGLCodes = 0;
	invalidProjectCodes = 0;
	
	for each (var item:CPRItem in CPRItems)
	{
		if (item.amountRenderer 
		    && item.amountRenderer.visible
		    && item.amountRenderer.parent)
		    {
		    	resultEvent = item.amountRenderer.valAmount.validate();
		    	if (resultEvent.type == ValidationResultEvent.INVALID)
		    	{
		    		formIsvalid = false;
		    		invalidAmounts++;
		    	}
		    				    	
		    }
		    
		    
		if (item.costCentreRenderer
		    && item.costCentreRenderer.visible
		    && item.costCentreRenderer.parent)
		    {
		    	resultEvent = item.costCentreRenderer.valCostCentre.validate();
		    	if (resultEvent.type == ValidationResultEvent.INVALID)
		    	{
		    		formIsvalid = false;
		    		invalidCostCentres++;
		    	}
		    			
		    }
		    
		    
		if (item.GLRenderer 
		   && item.GLRenderer.visible
		   && item.GLRenderer.parent)
		   {
		   		resultEvent = item.GLRenderer.valGLAccount.validate();
		    	if (resultEvent.type == ValidationResultEvent.INVALID)
		    	{
		    		formIsvalid = false;
		    		invalidGLCodes++;	
		    	}
		    				   		
		   }
		   
		   
		if (item.projectRenderer
		   && item.projectRenderer.visible
		   && item.projectRenderer.parent)
		   {
		   		resultEvent = item.projectRenderer.valProject.validate();
		    	if (resultEvent.type == ValidationResultEvent.INVALID)
		    	{
		    		formIsvalid = false;
		    		invalidProjectCodes++;	
		    	}
		    					   		
		   }
		   
	}
	
}            
	
 
