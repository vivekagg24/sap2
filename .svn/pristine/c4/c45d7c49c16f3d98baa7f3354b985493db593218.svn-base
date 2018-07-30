// ActionScript file
import mx.core.UIComponent;


// There is a known bug with Flex validation where the validated field takes a black border
// following the clearance of validation errors / clearance of text.  Details on:
// http://www.adobe.com/cfusion/webforums/forum/messageview.cfm?forumid=60&catid=585&threadid=1236847&enterthread=y

// This is dealt with by ensuring that all mandatory fields are set as required and validated 
// on the initial load.  This is in InitialiseAllValidatorFields(), called from 
// function ServerRequest, parameter 'cInitLoad'
// The initial set of the field to 'required' before storing any data in the field or deleting 
// from the field presumably stores the initial border colour correctly.

// NB that validation here is dependant on the type of validator used and custom logic 
// as to what should be validated when.  The main focus of these functions are to ensure 
// that the correct fields are labelled as mandatory at the correct times
// eg1 only the agency field should be mandatory of the name fields if the user
// has selected 'agency' as the contributor type
// eg2 Email is mandatory unless the user has selected the 'No email available' flag

// Tip: Don't forget ctrl + left click on a function
/*=========================================So... you want to make a field mandatory?=========================================Step 1 - Create a validator----------------------------------------------------------------------------    <mx:Validator id	=	"HouseCheck"    		required		=	"true"  		source			=	"{tiHouse}"         	property		=	"text" />Step 2 - Add a function to private function ValidateAll()----------------------------------------------------------------------------	validateAddress();Step 3 - In private function ValidateDataOnSave, set up a new case statement:----------------------------------------------------------------------------	case 6:		ErrdComponent = validateAddress();		break;Step 4 - Set up "sub-function"----------------------------------------------------------------------------	private function validateAddress():UIComponent{		var HouseCheckResult:ValidationResultEvent = HouseCheck.validate();				if (HouseCheckResult.type == ValidationResultEvent.INVALID){		return tiHouse;	}	return null;	}Step 4 - Add to function  InitialiseAllValidatorFields----------------------------------------------------------------------------	HouseCheck.required     = true;	HouseCheck.validate();*/ 
//*********************** TOP LEVEL VALIDATION FUNCTIONS ***********************
//******************************************************************************
	
	// Validate all fields that are referenced to validators (has to happen on initialisation)
	private function ValidateAll():void{

		ValidateConType();

		ValidateNames();
			setGBPAllowed();
		ValidateCurrency();
		
		ValidateTelCos();

		ValidateBankDetails();
		
		ValidatePaymentTo();				validateAddress();
		
		if(editRights == cPartial){            // i.e. editorial users dependent on SU01 user group 
          InitDisableBankFields();	           // "grey out" some bank details tab fields by default TT #125
          DisablePaymentDetailsFields();
        }

	}

	// Validate Bank details (as previous server trip and flag set necessary),
	// then validate all fields referenced to validators, stopping validation and
	// prompting user on hitting each error
	private function ValidateDataOnSave():Boolean{

		var ErrdComponent:UIComponent;
		var i:int
		if(dataChanged == ""){
			
			Alert.show('Data already saved',"Save"); 			
	
			return false;
		}				if (!checkValidPaymentMethod())		{			return false;
		}
		
		reOrderCommsDetails();          // tel no & email reordering
				
		while(ErrdComponent == null){   // while there is no error keep looking...
			
			switch (i){
				
				case 0:                // the switch allows the use to fix one issue before getting the next error message

					ErrdComponent = ValidateConType();
					break;

				case 1:

					ErrdComponent = ValidateNames();
					break;
				
				case 2:
		
					ErrdComponent = ValidateTelCos();		//tel no and email			
					break;
					
				case 3:					
					ErrdComponent = ValidateBankDetails();			
					
					if(ErrdComponent != null){
						tnFinDetail.selectedIndex = 1;		//tn table navigator					
					}
						
					break;

				case 4:
					ErrdComponent = ValidateCurrency();

					if(ErrdComponent != null){
						tnFinDetail.selectedIndex = 0;		//tn table navigator		 			
					}
					
					break;
						
				case 5:
			
					ErrdComponent = ValidatePaymentTo();				
					
					if(ErrdComponent != null){
						tnFinDetail.selectedIndex = 1;							
					}
										
					break;
				case 6:									ErrdComponent = validateAddress();					break;									
				case 7:
					
					return true;
					
			}
			
			i++;
		}                 // end of while

		ShowValidationAlert(ErrdComponent);
   
		return false;
	}
		 
	private function ShowValidationAlert(Component:UIComponent):void{

		FocusComponent = Component;  // need to "clock" this here and deal with it after the alert popup is closed...
		Alert.show('Please edit data in highlighted fields',"Errors exist",0,this,HandleValidationAlertClose); 
	       
	}
	 
	private function HandleValidationAlertClose(event:CloseEvent):void{
//     ... and here we are with our focus
        FocusComponent.setFocus();   

		application.focusManager.showFocus();
       
	}

//*********************** FIELD GROUPING VALIDATION FUNCTIONS ******************
//******************************************************************************

	// With all these ValidateX functions, the required fields are first 
	// set and then the validate method of the associated validator(s) then called
	// If there is > 1 field, results are checked seqentially, and where an error is found
	// the function finishes and returns the the field in error back to the calling function
	// This allows the calling program to process the errored field
	
// CONTRIBUTOR TYPE
	private function ValidateConType():UIComponent{
		
		SetReqdConType();                           // i.e true
		
		var ConTypeResult:ValidationResultEvent = ConTypeCheck.validate();
		
		if(ConTypeResult.type == ValidationResultEvent.INVALID){

			return comboContribTypes;
		}
		
		return null;
	}

// NAMES
	private function ValidateNames():UIComponent{

		SetReqdNameFields();
		
		var SurnameResult:ValidationResultEvent 	= SurnameCheck.validate();
		var FirstNameResult:ValidationResultEvent 	= FirstNameCheck.validate();
		var AgencyResult:ValidationResultEvent 		= AgencyCheck.validate();
		var AgentResult:ValidationResultEvent 		= AgentCheck.validate();
		var StaffNumber:ValidationResultEvent 		= StaffNumber.validate();
		
		if (FirstNameResult.type == ValidationResultEvent.INVALID){
			return tiFirstName;
		}
		
		if (SurnameResult.type == ValidationResultEvent.INVALID){
			return tiSurname;
		}
		
		if (AgencyResult.type == ValidationResultEvent.INVALID){
			return tiAgency;
		}

		if(AgentResult.type == ValidationResultEvent.INVALID){
			return tiAgent;
		}
        if(StaffNumber.type == ValidationResultEvent.INVALID){
			return tiStaffNumber;
		}		
		return null;
	}
	 
// PHONE NUMBERS AND EMAILS.  
	private function ValidateTelCos():UIComponent{

		SetReqEmail();
		
		var EmailCheckResult:ValidationResultEvent  = EmailCheck.validate();
		var EmailCheckResult2:ValidationResultEvent = EmailCheck2.validate();		  
		var PhoneCheck1Result:ValidationResultEvent = PhoneCheck1.validate();
		var PhoneCheck2Result:ValidationResultEvent = PhoneCheck2.validate();
		var PhoneCheck3Result:ValidationResultEvent = PhoneCheck3.validate();		

		if (EmailCheckResult.type == ValidationResultEvent.INVALID){

			return tiEmail;
		}

		if (EmailCheckResult2.type == ValidationResultEvent.INVALID){
   
			return tiEmail2;
		}
		 
		if (PhoneCheck1Result.type == ValidationResultEvent.INVALID){
					   
			return tiTelNr;
		}
		
		if (PhoneCheck2Result.type == ValidationResultEvent.INVALID){
		   
			return tiTelNr2;
		}
		  
		if (PhoneCheck3Result.type == ValidationResultEvent.INVALID){
		
			return tiTelNr3;
		}  
		
		return null;
	}

// CURRENCY
	private function ValidateCurrency():UIComponent{
		
		SetReqdCurrField();				setGBPAllowed();		
		var CurrCheckResult:ValidationResultEvent = CurrencyCheck.validate();
		
		if(CurrCheckResult.type == ValidationResultEvent.INVALID){

			return comboCurrency;

		}
		
		return null;
	}

// BANK DETAILS
	private function ValidateBankDetails():UIComponent{
	
		SetReqdBankFields();

		var SortCodeCheckResult:ValidationResultEvent = SortCodeCheck.validate();
		var AcNrCheckResult:ValidationResultEvent 	  = AccountNrCheck.validate();
			
		if (SortCodeCheckResult.type == ValidationResultEvent.INVALID){
			return tiSortCode;
		}
	
		if (AcNrCheckResult.type == ValidationResultEvent.INVALID){
			return tiAccountNr;				
		}

//      If sort code is required and server check is still negative, error
		if((SortCodeCheck.required == true) && (bBankInvalid == true)){
			return tiSortCode;
		}

//      Handle IBAN checking		
		if((tiIBAN.text != "") && (bIBANInvalid == true)){
			return tiIBAN;
		}

		return null;
	}
	
// Payment TO 	
	private function ValidatePaymentTo():UIComponent{

		SetReqPaymentTo();
		
	 	var CheckToResult:ValidationResultEvent = PaymentToCheck.validate();

		if(CheckToResult.type == ValidationResultEvent.INVALID){

			return comboPaymentTo;
		}
		
		return null;
	}

		private function validateAddress():UIComponent{//	var HouseCheckResult:ValidationResultEvent    = HouseCheck.validate();  // #401	var StreetCheckResult:ValidationResultEvent   = StreetCheck.validate();	var PostCodeCheckResult:ValidationResultEvent = PostCodeCheck.validate();		//	if (HouseCheckResult.type    == ValidationResultEvent.INVALID){   // #401//		return tiHouse;//	}	if (StreetCheckResult.type   == ValidationResultEvent.INVALID){		return tiStreet;	}	if (PostCodeCheckResult.type == ValidationResultEvent.INVALID){		return tiPostCode;	}	return null;	}	


//*********************** SET MANDATORY FIELDS FUNCTIONS ***********************
//******************************************************************************

// Contributor type
 	private function SetReqdConType():void{

		ConTypeCheck.required = true; 		
 	}

// NAMES
 	private function SetReqdNameFields():void{

		if(comboContribTypes.selectedIndex == -1){

			ResetRequiredNames();
			
			return;
		}
		
		switch(comboContribTypes.ChosenValue.toString()){
			
			case 'F':			// For freelancers, this further depends on whether payment 			// is being made to the individual or the company
				if (comboPaymentTo.selectedIndex == 1)				{  // If the payment is to the company					FirstNameCheck.required = false;					SurnameCheck.required = false;					AgencyCheck.required = false;					StaffNumber.required = false;										AgentCheck.required = true;  // <===									}				else			    {  // If the payment is to the individual, or is not specified					FirstNameCheck.required = true;  // <===					SurnameCheck.required = true;    // <===					AgencyCheck.required = false;					StaffNumber.required = false;					AgentCheck.required = false;									}				

				break;
				
			case "S":				

				FirstNameCheck.required = true;    // <===
				SurnameCheck.required = true;      // <===

				AgencyCheck.required = false;
				StaffNumber.required = true;       // <===				AgentCheck.required = false;
				break;
								
			case "A":				

				AgencyCheck.required = true;        // <===				AgentCheck.required = false;

				FirstNameCheck.required = false;
				SurnameCheck.required = false;
				
				StaffNumber.required = false;
								
				break;
		}

		SetReqdAgentField();
	}

	private function SetReqdAgentField():void{

		AgentCheck.required = false;	
			
		if((comboPaymentTo.visible == false) ||
   		   (comboPaymentTo.selectedIndex == -1)) {
			
			return;
		}

		if(comboPaymentTo.selectedItem.data == 'A' ){
			AgentCheck.required = true;
		}
	}

// CURRENCY
  	private function SetReqdCurrField():void{

		CurrencyCheck.required = true;
		
 	}


// BANK
	private function SetReqdBankFields():void{
		
		SortCodeCheck.required  = false;
		AccountNrCheck.required = false;

		if ((tiControlKey.text != "" )  || 
			(tiIBAN.text != "" )		||
			(tiSortCode.text != "" )    ||
			(tiAccountNr.text != "" )   ||
			(tiBKRef.text != "" )){

				SortCodeCheck.required  = true;
				AccountNrCheck.required = true;
				
			}else{
		
				if(comboPayMeth.selectedIndex == -1){
					return;
				}

				if(comboPayMeth.selectedItem.data == cBACS){
					
						SortCodeCheck.required  = true;
						AccountNrCheck.required = true;
				}
			}				
	}


// EMAIL
  	private function SetReqEmail():void{

		if(NoEmailFlag == ''){
			
			EmailCheck.required = true; 					
		
		}else{
			EmailCheck.required = false; 								
		}
 	}
 	

// CHEQUE / BACS payment TO
	private function SetReqPaymentTo():void{

		if((comboPayMeth.selectedIndex == -1) ||
 		   	(comboContribTypes.selectedIndex == -1)){

				ResetPaymentTo();
				
				return;
		   	}
		   	
		if(comboContribTypes.selectedItem.data == 'F') { // GYORK Can now select contributor payee for more than just cheques,
													     // for BACS and other payment types as well
			bPaymToVisible = true;
	
			PaymentToCheck.required = true;
			
		}else{

			ResetPaymentTo();

		}		if((comboContribTypes.selectedItem.data == 'F') ||  // sreddy 23.09.2013		   (comboContribTypes.selectedItem.data == 'A')){		    	bVendorTypeVisible = true;		    	bnoemailvisible = false;}		    	else{		    	bVendorTypeVisible = false		    	bnoemailvisible = true;
		    }
	}

		
//*********************** Reset mandatory fields *******************************
//******************************************************************************
	private function ResetRequiredFields():void{

		ConTypeCheck.required = false;
				
		ResetRequiredNames();

		EmailCheck.required = false;
		CurrencyCheck.required = false;
		SortCodeCheck.required = false;
		AccountNrCheck.required = false;
		
		ResetPaymentTo();
	} 	
	
 	private function ResetRequiredNames():void{
		
		FirstNameCheck.required = false;
		SurnameCheck.required 	= false;
		AgencyCheck.required 	= false;		
		AgentCheck.required		= false;
		StaffNumber.required    = false;
	}
	
	private function ResetPaymentTo():void{

		bPaymToVisible = false;

		PaymentToCheck.required = false;
	
	}	
		
	private function InitialiseAllValidatorFields():void{

		ValidateConType();

		ValidateCurrency();

		ValidateTelCos();
		
		FirstNameCheck.required = true;
		SurnameCheck.required 	= true;
		AgencyCheck.required 	= true;
		AgentCheck.required 	= true;
		StaffNumber.required    = true;
	    firsttime               = false; //sreddy//    	HouseCheck.required     = true;	
		FirstNameCheck.validate();
		SurnameCheck.validate();	
		AgencyCheck.validate();
		AgentCheck.validate();		
		StaffNumber.validate();
//		HouseCheck.validate();  // #401		
		SortCodeCheck.required  = true;
		AccountNrCheck.required = true;
		
		SortCodeCheck.validate();	
		AccountNrCheck.validate();	

		bPaymToVisible = true;			

		PaymentToCheck.required = true;		
		
		PaymentToCheck.validate();
	}/** Sets the GBP Allowed flag  */		private function setGBPAllowed():void	{		CurrencyCheck.allowGBP = true;		if (comboPayMeth && (comboPayMeth.value == "F" || comboPayMeth.value == "U")) //Worldlink cheque / transfer			CurrencyCheck.allowGBP = false;
	}	private function setvendortype():void{		if (comboVendorType.selected == true){			govtflag = "ZG02";			}					else{				govtflag = "ZG01"; }			//	govtflag == "X";				DataChanged(true); //sreddy		}    private function setpiflag():void // Private Investigator flag -  sreddy 	IC~180440    {		if (privateInves.selected == true) {			pisetflag= "X";			}					else{				pisetflag = " ";		}}
    private function sasetflag():void // Search Agent flag -  sreddy 	IC~223665    {		if (searchAgent.selected == true) {			setsaflag = "X";			}					else{				setsaflag = " ";		}}