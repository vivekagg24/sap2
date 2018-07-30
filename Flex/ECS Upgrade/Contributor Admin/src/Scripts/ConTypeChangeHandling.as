// ActionScript file

	private function NewContribType():void{

		if (NamesWillBeOverwritten() == true){

			Alert.show("Name data will be lost by changing contributor type.  Continue?", "Warning",Alert.OK | Alert.NO,this,HandleNamesLossPrompt,null,Alert.NO);
			 
		}else{

			ProcessNewContribType();
			CorrespondenceCountryChanged1();    // handle quck address / address fields for non-GB

		}
	}

	private function HandleNamesLossPrompt(oEvent:CloseEvent):void{

		if (oEvent.detail==Alert.OK){

			ProcessNewContribType();

		}else{

			comboContribTypes.ChosenValue = tiPrevConType.text;
		}
	}

	private function ProcessNewContribType():void{

		if(comboContribTypes.selectedIndex == -1){

			tiPrevConType.text = "";
			
		}else{
	
			tiPrevConType.text = comboContribTypes.ChosenValue.toString();			
		}

		if (CurrentConNr == cNewContributor){

			SetNewContribTypeDefaults();
		}
		
		DataChanged(true);

		SetConTypeFields();

// 114		SetPaymentTo();
		
		ValidateAll();

		ClearDisabledNameFields();
		
		clearVendortype();  // Sreddy 02.10.2013

	}

	private function SetNewContribTypeDefaults():void{
		
		switch(comboContribTypes.ChosenValue.toString()){

			case 'F':                            // Freelance			

				comboPayMeth.ChosenValue = "B";
                comboCurrency.ChosenValue = "GBP";   // #299 GBP greyed out if BACS 
				comboCurrency.enabled      = false;  // #299
				comboPaymentTo.ChosenValue = "F"; // freelancer

                if(editRights == cPartial){    // i.e. non-editorial user (dependent on SU01 user group) 
                  EnableBankFields();	       // #185 "grey out" bank details tab fields because payment method is not BACS
                }
				comboPayterms.ChosenValue = "Z07P";  // 1)was Z30N TT #169 Neil, 2) SC236691 Neil 15.4.2008 was Z28D
                comboPayBlock.ChosenValue = "8" ; //SREDDY
				break;
			
			case "S":	                         // Staff				
                govtflag      = ""; //Sreddy 23.09.2013
				comboPayMeth.ChosenValue = "A";
                if(editRights == cPartial){    // i.e. non-editorial user (dependent on SU01 user group) 
                  DisableBankFields();	       // #185 "grey out" bank details tab fields because payment method is not BACS
                }
       //    		comboVendorType.ChosenValue = ""; // SREDDY 24.09.2013
				comboPayterms.ChosenValue = "ZSTF";
				comboPayBlock.ChosenValue = ""; //SREDDY 
				break;
							
			case "A":				            //  Agency	

				comboPayMeth.ChosenValue = "B";

                comboCurrency.ChosenValue = "GBP";   // #299 GBP greyed out if BACS 
				comboCurrency.enabled      = false;  // #299

                if(editRights == cPartial){    // i.e. non-editorial user (dependent on SU01 user group) 
                  EnableBankFields();	       // #185 "grey out" bank details tab fields because payment method is not BACS
                }
              
				comboPayterms.ChosenValue = "Z07P"; // 1)was Z30N TT #169 Neil, 2) SC236691 Neil 15.4.2008 was Z28D
				comboPayBlock.ChosenValue = "8"; //SREDDY 
				break;
		}
	}

	private function NamesWillBeOverwritten():Boolean{

		switch(comboContribTypes.ChosenValue.toString()){
		
			case 'F':
			
				if((tiAgency.text != "") ||
	   			   (tiAgencyContact.text != "")){
		
					return true;
	   			   }
		
				break;
								
			case "S":

				if((tiAgency.text != "") 		||
	   			   (tiAgencyContact.text != "") ||
	   			   (tiAgent.text != "") 		||
	   			   (tiAlias.text != "")){
		
					return true;
	   			   }

				break;

			case "A":				

				if((tiSurname.text != "") 		||
	   			   (tiFirstName.text != "") 	||
	   			   (tiAgent.text != "") 		||
	   			   (tiAlias.text != "")){
		
					return true;
	   			   }
				break;
		}

		return false;
	}

	private function SetConTypeFields():void{

		DisableAllNameFields();
		
		if(ValidateConType() != null){
					
			comboContribTypes.setFocus();

			application.focusManager.showFocus();			
		   	
		}else{

			EnableNameFields();
			tiQuickAddress.enabled  = true;
		
		}
	}

	private function EnableNameFields():void{

// this is switching opening up / closing off input fields

		switch(comboContribTypes.ChosenValue.toString()){
		
			case 'F': // Freelancer
			
				tiFirstName.enabled 	= true;  
				tiSurname.enabled 		= true;
				tiAgent.enabled 		= true;
				tiAlias.enabled 		= true;
				
				break;
								
			case "S": // Staff

				tiFirstName.enabled 	= true;
				tiSurname.enabled   	= true;
				tiStaffNumber.enabled   = true;
								
				break;

			case "A": // Agency				

				tiAgency.enabled 		= true;
				tiAgencyContact.enabled = true;

				break;
		}

	}

	private function DisableAllNameFields():void{
		
			tiFirstName.enabled 	= false;
			tiSurname.enabled 		= false;
			tiAgent.enabled 		= false;
			tiAlias.enabled 		= false;
			tiAgency.enabled 		= false;
			tiAgencyContact.enabled = false;
			tiQuickAddress.enabled  = false;
			tiStaffNumber.enabled   = false;
		
//			ClearDisabledField(comboVendorType); //sreddy
	}
	
	private function ClearDisabledNameFields():void{

		ClearDisabledField(tiFirstName);
		ClearDisabledField(tiSurname);
		ClearDisabledField(tiAgent);
		ClearDisabledField(tiAlias);
    	ClearDisabledField(tiAgency);
		ClearDisabledField(tiAgencyContact);
		ClearDisabledField(tiQuickAddress); 
		ClearDisabledField(tiStaffNumber);
	}

	private function ClearDisabledField(Field:TextInput):void{
		
		if(Field.enabled == false){
			Field.text = "";
		}
	}

// test tracker #64 - Quick address handling according to country chosen
	private function DisableAddressFieldsBeforeQASearchIsUsed():void{

// The address fields should not be available for input before the quick address
// function has been used once.
		
			tiHouse.enabled 	= false;
			tiStreet.enabled 	= false;
			tiTown.enabled 		= false;
			tiCity.enabled 		= false;
			tiPostCode.enabled 	= false;
	}	

// test tracker #64 - Quick address handling according to country chosen
	private function EnableAddressFieldsAfterQASearchIsUsed():void{

// Once the Quck address button has been pushed the fields should be open
		
			tiHouse.enabled 	= true;
			tiStreet.enabled 	= true;
			tiTown.enabled 		= true;
			tiCity.enabled 		= true;
			tiPostCode.enabled 	= true;

	}		
	
// test tracker #64 - Quick address handling according to country chosen
	private function DisableQuickAddressFieldForNonGBCountry():void{

			tiQuickAddress.enabled 	= false;

	}		
	
// test tracker #64 - Quick address handling according to country chosen
	private function EnableQuickAddressFieldForGBCountry():void{

			tiQuickAddress.enabled 	= true;

	}			
	
// Test tacker #185	When a editorial user selects non-BACS payment method, 
// grey out bank details fields
	private function DisableBankFields():void{
		
	  comboBankCountries.enabled = false;
	  tiControlKey.enabled 	     = false;

      tiAccountNr.enabled 	     = false;
	  tiSortCode.enabled     	 = false;
	  
	  tiBKRef.enabled 	         = false;
	  tiIBAN.enabled 	         = false;
	  tiMemo.enabled 	         = false;
//	  comboPaymentTo.enabled 	 = false;
      btnIBAN.enabled	         = false;
         
	}
	
	private function InitDisableBankFields():void{  
// BACS is set as default so we need to leave the account/sort codes open 
	  comboBankCountries.enabled = false;
	  tiControlKey.enabled 	     = false;
//	  tiAccountNr.enabled 	     = false;
//	  tiSortCode.enabled     	 = false;
	  tiBKRef.enabled 	         = false;
	  tiIBAN.enabled 	         = false;
	  tiMemo.enabled 	         = false;
//	  comboPaymentTo.enabled 	 = false;
      btnIBAN.enabled	         = false;
      
	}
		
	
	private function EnableBankFields():void{
		
	  comboBankCountries.enabled = true;
	  tiControlKey.enabled 	     = true;
	  tiAccountNr.enabled 	     = true;
	  tiSortCode.enabled     	 = true;
	  tiBKRef.enabled 	         = true;
	  tiIBAN.enabled 	         = true;
	  tiMemo.enabled 	         = true;
//	  comboPaymentTo.enabled 	 = true;
      btnIBAN.enabled         	 = true;

	}
	
	private function DisablePaymentDetailsFields():void{  // #125 editorial user input is "limited"
		comboPayterms.enabled = false;
		cbPostBlock.enabled   = false;
//		comboPayBlock.enabled = false;  #223 editorial needs to maintain this if the VAT no is entered => block set
		cbDelFlag.enabled     = false;
	}
private function clearVendortype():void{ 	
//		govtflag = ""; // sreddy
		comboVendorType.selected = false; 
}
	