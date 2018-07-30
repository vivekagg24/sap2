// ActionScript file
import mx.controls.Alert;
import Components.ChequePaymentConfirm;
import mx.managers.PopUpManager;


	// Update custom Javascript function in HTML wrapper.  
	// This is called on any change of data to update the portal 'dirty' flag
	private function DataChanged(bChange:Boolean):void{

		if(bChange){
			
			dataChanged = 'X';
			
		}else{
			
			dataChanged = '';
		}
// these 2 javascript functions can be found in a BSP handle class ZCL_ECS_OUTPUT_FLEX_APP
		ExternalInterface.call("updatePortalDirtyFlag", bChange);
		ExternalInterface.call("updateSAPgui", dataChanged, dbUpdated);				
	}		
	
	// The javascript wrapper can hold the contributor number. Useful if we want to tab between HTML pages
	// and pass the contributor number (linfr) from one to the other
	// When a new contributor is created, we tell the Javascript wrapper what the new number is.
	
	private function passNewLifnrToJavascript(LIFNR:String):void
	{
		try {
			ExternalInterface.call("passContributorToCPR", LIFNR);
			trace("Contributor passed up");
		}
		catch (e:Error) {
			trace("Error passing conributor passed up");
		}		
	}
	

	// Order the comms details so that there any entries are in order (no tel3 w/o tel2 & tel1..
	// if tel3 & tel2 but no tel1, move tel3 & tel2 to tel2 and tel1.  This ensures backend
	// storage works correctly
	private function reOrderCommsDetails():void{

		if ((tiEmail.text == "") 
		&& (tiEmail2.text != "")){
			
			tiEmail.text = tiEmail2.text;
			tiEmail2.text = ""			
		}	

		if ((tiTelNr.text == "") 
		&& (tiTelNr2.text == "")
		&& (tiTelNr3.text != "")){

			tiTelNr.text  = tiTelNr3.text;
			tiTelNr2.text = "";
			tiTelNr3.text = "";
		}	

		if ((tiTelNr.text == "") 
		&& (tiTelNr2.text != "")
		&& (tiTelNr3.text == "")){

			tiTelNr.text  = tiTelNr2.text;
			tiTelNr2.text = "";
		}	

		if ((tiTelNr.text == "") 
		&& (tiTelNr2.text != "")
		&& (tiTelNr3.text != "")){

			tiTelNr.text  = tiTelNr2.text;
			tiTelNr2.text = tiTelNr3.text;
			tiTelNr3.text = "";
		}	

		if ((tiTelNr.text != "") 
		&& (tiTelNr2.text == "")
		&& (tiTelNr3.text != "")){

			tiTelNr2.text = tiTelNr3.text;
			tiTelNr3.text = "";
		}	
	}

	private function SetTitle():void{
		
		if(CurrentConNr == "" || CurrentConNr == null){

			Title = cDefaultTitle;			
		}else{
			Title = cDefaultTitle + ": Contributor number - " + CurrentConNr;
		}
	}
	
	private function EnableButtonsAndFields(bEnable:Boolean):void{

		bEnableFields 			   = bEnable;
		bEnablePartialRightsFields = bEnable;
		bEnableServerTripButtons   = bEnable;
		bEnableSaveButton    	   = bEnable;

	} 
private function setVendortypefields():void{
}
	private function SetDefaultValues():void{

		CurrentConNr = "";

		ResetRequiredFields();		
				
		bEnableDispChanButton = true;

		bBankInvalid   = false;	
		bIBANInvalid   = false;	
		bVatNoInvalid  = true; 
				
		CheckDuplicates = "X";
		
		tnFinDetail.selectedIndex   = 0;
		tnContributor.selectedIndex = 0;		
		
		cbPostBlock.selected = false;
		cbDelFlag.selected   = false;			
		cbNoEmail.selected   = false;
		cbNoContact.selected = false;

		comboContribTypes.selectedIndex = -1;
		comboPayMeth.selectedIndex		= -1;
		comboPayterms.selectedIndex 	= -1;

		comboPayBlock.ChosenValue	= "";
		comboBankCountries.ChosenValue	= 'GB';
		comboAddressCountries.ChosenValue= 'GB';
		comboCurrency.ChosenValue		= 'GBP';

		deleteFlag 	  = "";
		postBlock 	  = "";		
		NoEmailFlag   = "";
		NoContactFlag = "";
 
		dfSelfBilling.text 	= "";
		
		tiFirstName.text   	= "";
		tiSurname.text 	   	= "";
		tiAgent.text 		= "";
		tiAlias.text 		= "";
		tiAgency.text 		= "";
		tiAgencyContact.text = "";
		tiHouse.text 		= "";
		tiStreet.text 		= "";
		tiTown.text 		= "";
		tiCity.text 		= "";
		tiPostCode.text 	= "";
		tiVatNo.text 		= "";
		tiPrevAcc.text		= "";
		tiTelNr.text 		= "";
		tiTelNr2.text 		= "";
		tiTelNr3.text 		= "";
		tiFax.text 			= "";
		tiWebsite.text 		= "";
		tiEmail.text 		= "";
		tiEmail2.text 		= "";
		tiSortCode.text 	= "";
		tiAccountNr.text 	= "";
		tiControlKey.text 	= "";
		tiBKRef.text 	  	= "";
		tiIBAN.text			= "";
		tiMemo.text			= "";
        nogovtflag          = ""; //sreddy	
		ClearBankAddress()
 		
 		taEditorialText.text = "";
 		
		dgPayments.dataProvider = "";
		dgHistory.dataProvider  = "";
		

	private function DeleteFlagAlert():void{

		Alert.show("Are you sure you wish to mark this contributor for deletion?", "Warning",Alert.OK | Alert.NO,this,HandleDeleteFlagAlert,null,Alert.NO);
	}

	private function HandleDeleteFlagAlert(oEvent:CloseEvent):void{

		 if (oEvent.detail==Alert.NO) {

			cbDelFlag.selected = false       
         }
	}

	private function NoContactFlagAlert():void{

		Alert.show("Are you sure you wish to mark this contributor as non-contactable?", "Warning",Alert.OK | Alert.NO,this,HandleNoContactFlagAlert,null,Alert.NO);
	}

	private function HandleNoContactFlagAlert(oEvent:CloseEvent):void{

		 if (oEvent.detail==Alert.NO) {
			cbNoContact.selected = false       
         }
	}

// Start sreddy 19.11.2014 Govt flag alert IC#353683	
	private function HandlePayMethodChange():void{
		
		DataChanged(true);

// If contype = F, paymeth = C, set payment to field and prompt user 
		//SetPaymentTo(); Don't do this any more

// Set Bank details as mandatory if user has chosen paymeth = B		
		ValidateBankDetails();
		
// Set names as mandatory if nec - this may have changed as agent should be mand
// if payment to is visible and eq to Agent
 		ValidateNames();

// Test track #185 Editorial users are not allowed to 
// maintain bank details for non BACS payment methods

          CurrencyCheck.allowGBP = true;
        }
          if(editRights == cPartial)  // i.e. editorial users dependent on SU01 user group 
             DisableBankFields();	            // "grey out" bank details tab fields
          }
        }
 	}
 	}
	
	private function SetPaymentTo():void{

		comboPaymentTo.selectedIndex = -1;
		
		if(ValidatePaymentTo() != null){
	
			//FocusComponent = comboPaymentTo;
			
			//Alert.show('Please choose a payment recipient',"Payment Recipient",0,this,HandleValidationAlertClose); 
			
			//tnFinDetail.selectedIndex = 1;
		}
	}
	
	private function SetSelfBillingField():void{
/*  	If the VAT number is "invalid" disable entry into the self billing date field
		

			dfSelfBilling.enabled 	   = false;   // field does not allow entry
//			dfSelfBilling.selectedDate = null;	  // date cleared out		

		}else{
			
			dfSelfBilling.enabled = true;        // field allows entry
		}
	}

//  Test Track #64 - Correspondance Country influences Quick address	
	protected function CorrespondenceCountryChanged1():void 
	{
 		if(comboAddressCountries.value == "GB"){
          
          DisableAddressFieldsBeforeQASearchIsUsed();   // Don't let user enter a GB address without trying once quick address
          
          EnableQuickAddressFieldForGBCountry();        // Quick addres field must be "open" for entry
          this.focusManager.setFocus(tiQuickAddress);   // move the cursor to quick address field
          
		}else{
                                                       // QAS not used for non-GB addresss		  
          EnableAddressFieldsAfterQASearchIsUsed();    // re-using this one
          
          DisableQuickAddressFieldForNonGBCountry();  // Turn "off" entry for quick addres field
          this.focusManager.setFocus(tiHouse);        // move the cursor to first address field
          
		} 
	}

//  Test tracker #129 - Default payment method for non-GB countries	
	protected function CorrespondenceCountryChanged2():void 
    {
      if(comboAddressCountries.value == "GB"){

        HandlePayMethodChange();
       
    }
    }

//  Test tracker #114 - highlight effect of payment recipient field    
/*    protected function updateWhoIsPaidText():void
    {
      if(comboPaymentTo.value == "F"){   // Freelancer

//      This text is displayed to the right of surname on the contributor admin screen:
        txtWhoIsPaid.text = 'Note: Freelancer receives payment'; 

      }else{    	                    // Agency
   	    
   	    txtWhoIsPaid.text = 'Note: Agency receives payment';
    	
      } 	
    	
    }        */

} 