// ActionScript file/* The functions you'll find here...	DataChanged	passNewLifnrToJavascript	reOrderCommsDetails	SetTitle	EnableButtonsAndFields	SetDefaultValues	DeleteFlagAlert	HandleDeleteFlagAlert	NoContactFlagAlert	HandleNoContactFlagAlert	HandlePayMethodChange	SetPaymentTo	SetSelfBillingField	CorrespondenceCountryChanged1	CorrespondenceCountryChanged2	updateWhoIsPaidText               - inactive! 	handleControlKeyDown	resetCtrlDelayRelease	handleControlKeyUp	numToChar	getContributorEmailCallBack	handleVATPaymentBlock	checkEnablePaymentBlock*/
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
		bEnableSaveButton    	   = bEnable;		bEnablevendortype =          bEnable; //sreddy		bEnableprivate    =          bEnable; //sreddy		bEnableagent      =          bEnable; //sreddy //		comboVendorType.enabled    = bEnable ;  //sreddy

	} 
private function setVendortypefields():void{	if(xmlConDetails.CH_CONTRIB_DETAIL.BRSCH == "ZG02"){		bEnablevendortype   =   false ;		} 			if(xmlConDetails.CH_CONTRIB_DETAIL.BRSCH == "ZG01" 		||   xmlConDetails.CH_CONTRIB_DETAIL.BRSCH == ""  ) 		{ bEnablevendortype   =   true ; }	// sreddy IC#00223669  	if (xmlConDetails.CH_CONTRIB_DETAIL.ZZPI == "X"){	bEnableprivate = false ;				} 	if (xmlConDetails.CH_CONTRIB_DETAIL.ZZPI == "")	{  bEnableprivate = true ;    		} 	// sreddy IC#223665	  	if (xmlConDetails.CH_CONTRIB_DETAIL.ZZSA == "X"){	bEnableagent = false ;				} 	if (xmlConDetails.CH_CONTRIB_DETAIL.ZZSA == "")	{  bEnableagent = true ;    		} 		
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
        comboPaymentTo.ChosenValue= 'F';  //#114//        govtflag      = ""; //Sreddy 23.09.2013 00145795// govtflag = "ZG01" ;firsttime = false;nogovtflag = "";//        bEnablevendortype = false; //Sreddy 23.09.2013 00145795
		deleteFlag 	  = "";
		postBlock 	  = "";		
		NoEmailFlag   = "";
		NoContactFlag = "";
 
		dfSelfBilling.text 	= "";
		
		tiFirstName.text   	= "";
		tiSurname.text 	   	= "";		tiStaffNumber.text  = "";
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
        nogovtflag          = ""; //sreddy	        govtflag            = ""; //sreddy
		ClearBankAddress()
 		
 		taEditorialText.text = "";
 		
		dgPayments.dataProvider = "";
		dgHistory.dataProvider  = "";
			}// commeted to revert back changes to IC279394// Satrt sreddy 19.11.2014 Govt flag alert IC#279394	   private function GovtFlagAlert():void{	//if ( nogovtflag == true && firsttime == false){	//	if  (firsttime == false){	   if (comboContribTypes.ChosenValue != "S") {   if 	(nogovtflag == "X" ) {   if 	(firsttime == false){	Alert.show("Is the contributor a goverment related person?", "Warning", Alert.YES | Alert.NO,this, HandleGovtFlagAlert, null,Alert.NO);	   	   	firsttime = true ;	DataChanged(true);	setvendortype();    }	}	    } }//  end sreddy 19.11.2014 Govt flag alert IC#279394

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

// Start sreddy 19.11.2014 Govt flag alert IC#353683		private function HandleGovtFlagAlert(oEvent:CloseEvent):void{		 if (oEvent.detail==Alert.NO) {			comboVendorType.selected = false   			setvendortype();			nogovtflag = "X";             }else{         comboVendorType.selected = true       setvendortype();	         nogovtflag = "X";          }	}// End sreddy 19.11.2014 Govt flag alert IC#353683	
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
        if(comboPayMeth.value == "B"){ // BACS
          CurrencyCheck.allowGBP = true;          CurrencyCheck.validate();          if(editRights == cPartial)  // i.e. editorial users dependent on SU01 user group           {                EnableBankFields();	       // "ungrey out" bank details tab fields          }          comboCurrency.enabled      = false;   // #299  BACS = grey out curr + GBP only           comboCurrency.ChosenValue = 'GBP';         }        else if (comboPayMeth.value == "F" || comboPayMeth.value == "U") //Worldlink cheque / transfer        {            CurrencyCheck.allowGBP = false;          CurrencyCheck.validate();	          if(editRights == cPartial)// i.e. editorial users dependent on SU01 user group           {                        DisableBankFields();	            // "grey out" bank details tab fields          }          comboCurrency.enabled      = true;    // #299 non BACS => any curr possible
        }        else                             // non-BACS, e.g. cheque etc. etc.        {           CurrencyCheck.allowGBP = true;          CurrencyCheck.validate();	                                 
          if(editRights == cPartial)  // i.e. editorial users dependent on SU01 user group           {           
             DisableBankFields();	            // "grey out" bank details tab fields
          }          comboCurrency.enabled      = true;    // #299 non BACS => any curr possible
        }                checkValidPaymentMethod(); // Make sure this payment method is allowed        
 	} 	 	public function checkValidPaymentMethod():Boolean 	{ 		// GYORK - temporarily disable this change so we can put another change through		//return true;		// GYORK - end of temporary disablement 		 		// Valid payment method?        var previous_value:String = "";        if (displayMode == cEdit && xmlConDetails && xmlConDetails.CH_CONTRIB_DETAIL && xmlConDetails.CH_CONTRIB_DETAIL.ZWELS)        {        	previous_value = xmlConDetails.CH_CONTRIB_DETAIL.ZWELS.toString();        }                if (comboPayMeth.value != previous_value)        {        	if (this.chequeRights != 'X' && comboPayMeth.value == 'C') // Cheque        	{        		// Confirm with user        		var popup:ChequePaymentConfirm = new ChequePaymentConfirm();        		popup.previousPaymentType = previous_value;        		popup.ref_paymentTypeCombo = comboPayMeth;        		popup.ref_paymentBlockCombo = comboPayBlock;        		PopUpManager.addPopUp(popup, this, true);        		PopUpManager.centerPopUp(popup);        		        		        	}    	        	/*         	var selectedItem:XML = xmlInitData.EX_T_PAY_METHODS.item.(DATA==comboPayMeth.value)[0];        	var isNotAllowed:String = selectedItem.BLOCKED.toString();        	if (isNotAllowed == 'X')        	{        		Alert.show("You can no longer select payment method " + selectedItem.LABEL);        		return false;        	} */        	        }        return true;
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
/*  	If the VAT number is "invalid" disable entry into the self billing date field 		i.e. "grey out" self bill date                                                  */
				if (editRights != cFull) {

			dfSelfBilling.enabled 	   = false;   // field does not allow entry
//			dfSelfBilling.selectedDate = null;	  // date cleared out		

		}else{
			
			dfSelfBilling.enabled = true;        // field allows entry
		}
	}
   /*    ======================================================================================   If a VAT number is entered without a self-bill date, a payment block is set.   If a self-bill date is entered with a VAT number present, the payment block is lifted.   ======================================================================================   */	private function handleVATPaymentBlock():void{			// For GB contributors, we have some control over VAT / self-billing		if ( comboAddressCountries.value == 'GB' ){			// If the VAT number field has been filled in				if (tiVatNo.text != ""){                         				// If the self-bill date has been filled in				if (dfSelfBilling.selectedDate != null){     									// If the payment block is not ALREADY unblocked previously								if (comboPayBlock.ChosenValue == "7"){                                         						// unblock payment, null => nothing selected in combobox			//			comboPayBlock.ChosenValue	= ""; Leena						// send a message to the screen			//		    Alert.show("Self billing date has been entered. Payment block removed.");  Leena					}								// Self bill date is empty				}else{            							 						// If it is not ALREADY blocked					if (comboPayBlock.ChosenValue != "7"){     						// Self-bill block => 7						comboPayBlock.ChosenValue = "7";							// send a message to the screen					     						Alert.show("Payment is blocked until Self billing date is entered.");					}				}       // ...if (dfSelfBilling.selectedDate != null){     			// VAT is empty, make sure there is no self-bill block			}else{				// If pay block is set				if (comboPayBlock.ChosenValue == 7){     					comboPayBlock.ChosenValue = "";				}				//...If pay block is set			}				// ...if (tiVatNo.text != ""){ 		}				// ...if ( comboAddressCountries.value == 'GB' ){	}				// ...endfunction	
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
        comboPayMeth.ChosenValue = "B";         // BACS set as default   
        HandlePayMethodChange();      }else{
               comboPayMeth.ChosenValue = "U";         // Worldlink cheque        HandlePayMethodChange();      } 
    }        /**      * Post code is mandatory for all countries other than Ireland    */    protected function setPostCodeMandatoryDependingOnCountry():void    {    	var value:String = comboAddressCountries.value.toString();    	    	if (comboAddressCountries      	    && value.search('GB') == -1 )    	{    		PostCodeCheck.required = false;    	}    	else    	{    		PostCodeCheck.required = true;    	}    	PostCodeCheck.validate();    	
    }
    
//  Test tracker #114 - highlight effect of payment recipient field    //  Finally, we moved the combo field (left here just in case Sophie changes her mind)
/*    protected function updateWhoIsPaidText():void
    {
      if(comboPaymentTo.value == "F"){   // Freelancer

//      This text is displayed to the right of surname on the contributor admin screen:
        txtWhoIsPaid.text = 'Note: Freelancer receives payment'; 

      }else{    	                    // Agency
   	    
   	    txtWhoIsPaid.text = 'Note: Agency receives payment';
    	
      } 	
    	
    }        */
// Graham - keyboard shortcut CTRL-S = saveprivate function handleControlKeyDown(event:KeyboardEvent):void {	trace("Down: " + event.keyCode);}private var ctrlDelayRelease:Boolean = false;private function resetCtrlDelayRelease(event:Event):void{	ctrlDelayRelease = false;}private function handleControlKeyUp(event:KeyboardEvent):void {	// If we're checking for multiple key combinations, we have to do it on key up.	// This is because of a bug in ie7 (and possible 6 too).	// If you press ctrl then s, flex only triggers a keydown event for the ctrl key,	// but when you release the keys it triggers key-up for both of them.	//	// This means that if a user pressed ctrl-s, and released the "ctrl" key before releasing	// the "s" key, the save wouldn't trigger, since in the keyup event for the "s" key, 	// event.ctrlKey would be false.  To get around this, we set a delay when ctrl is released of a 	// few miliseconds effectively keeping it held down for longer		trace("UP: " + event.keyCode);	  	if (event.keyCode == 27)	{		event.stopImmediatePropagation();		escapeKeyPressed(event);		return;	}	// Function to do things when the user hits ctrl and a key  if (event.ctrlKey || ctrlDelayRelease)  {  var key:String = numToChar(event.charCode)    switch(event.keyCode){    case (83):  // "s"    // Save is ctrl-s or ctrl-k// Only triggeredd if the save button is enabled and visible    if (bEnableSaveButton && bShowButtons)    {    ServerRequest(cSave);    }    break;    }  }    if (event.keyCode == 17) // If ctrl key released by itself (0x11 = 17 = ctrl)  {  	// Set a delay on the ctrl-key release  	  	var ctrlReleaseTimer:Timer = new Timer(500, 1);    ctrlReleaseTimer.addEventListener(TimerEvent.TIMER, resetCtrlDelayRelease);  	ctrlReleaseTimer.start();  	ctrlDelayRelease = true;  	  }  }// Graham - keyboard shortcut CTRL-S = save (cont.)private function numToChar(num:int):String {        if (num > 47 && num < 58) {            var strNums:String = "0123456789";            return strNums.charAt(num - 48);        } else if (num > 64 && num < 91) {            var strCaps:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";            return strCaps.charAt(num - 65);        } else if (num > 96 && num < 123) {            var strLow:String = "abcdefghijklmnopqrstuvwxyz";            return strLow.charAt(num - 97);        } else {            return num.toString();        }}/*	getContributorEmailCallBack (Z_ECS_CPR_GET_EMAIL_TEXT)		Set html property for html control to display the contributor email*/private function getContributorEmailCallBack(result:Object):void{			html1.htmlText = result.EX_HTML;						if (html1.htmlText == "") {				html1.htmlText = "No Email Found"			}	/* populate data on Contributor Email tab */	sentDate1 = result.EX_SENDDATE;	sentTime1 = result.EX_SENDTIME;	sentCPR1  = result.EX_CPR_NUMBER;}/*	getHTMLForEmail (Z_ECS_CPR_GET_EMAIL_TEXT)		get the HTML text for the email*/     private function getHTMLForEmail(CPRStatus:String):void{	/* Status now hard coded is FModule *///	wsGetContributorEmail.Z_ECS_CPR_GET_EMAIL_TEXT_NOSIM.request.IM_STATUS=CPRStatus;	wsGetContributorEmail.Z_ECS_CPR_GET_EMAIL_TEXT.send();	//	html1.htmlText = wsGetContributorEmail.Z_ECS_CPR_GET_EMAIL_TEXT.lastResult.EX_HTML;	}// Escape presssed - prompt the user whether they want to clear all dataprotected function escapeKeyPressed(event:Object = ""):void{	if (displayMode == cNew || displayMode == cEdit)	{			// Show OK and Cancel buttons		var buttonsToShow:uint = Alert.OK | Alert.CANCEL;				// Add the keyboard shortcuts to the button labels		Alert.okLabel = "OK (1)";		Alert.cancelLabel = "CANCEL (2)";		Alert.buttonWidth += 30;					// Open the prompt		var clearPromptText:String;		if (displayMode == cNew)			clearPromptText = "Do you want to clear your entries?";		else			clearPromptText = "Do you want to cancel your changes? \n (All changes since you last saved will be lost)";				var clearPrompt:Alert = Alert.show(clearPromptText, "", buttonsToShow, this, clearAlertCloseHandler, null, Alert.OK);				// Add a keyboard listener		clearPrompt.addEventListener(KeyboardEvent.KEY_UP, clearAlertCloseHandler);				// Reset the Alert labels		Alert.okLabel = "OK";		Alert.cancelLabel = "CANCEL";		Alert.buttonWidth -= 30;							}		} /** Decide what to do after the user has pressed "Escape", and has been *  prompted to confirm clearing the data. *  *  This function handles both keyboard and mouse click events */private function clearAlertCloseHandler(event:Event):void{	var keyboardEvent:KeyboardEvent = event as KeyboardEvent;  	var closeEvent:CloseEvent = event as CloseEvent;  	var detail:uint;			if (keyboardEvent)	{  // If a key was pressed, we ignore any key apart form "1" (ascii 49) or "2" (ascii 50)		var alertPopup:Alert = (event.currentTarget as Alert);			if (keyboardEvent.charCode == 49) // 1 = OK		{			detail = Alert.OK;			PopUpManager.removePopUp(alertPopup);					}					else if (keyboardEvent.charCode == 50) // 2 = Cancel		{			detail = Alert.CANCEL;			PopUpManager.removePopUp(alertPopup);			}					else			return;			}				if (closeEvent)	{ // If the user pressed a button and closed the popup		detail = closeEvent.detail;	}			// Handle the user action	if (detail == Alert.CANCEL)		return; // User cancelled the action, so return		if (detail != Alert.OK)		return; // Should never happen	    // If ni Edit mode, or in Create mode but with some data preloaded from CPR	if (displayMode == cEdit || (CPRforNewContrib != null && CPRforNewContrib.length > 0 ) )	{ /** Revert back to what we last loaded (which may be from one of two web services - 	        *  wsGetNewContribFromCPR or wsGetContributor) and restore everything to as it was before the        *  user made any changes       */              		// Set defaults for dropdowns etc.	    SetDefaultValues();		    	    	    // Clone the old values so that if we clear xmlConDetails we still have xmlLastConDetails		xmlConDetails = new XML(xmlLastConDetails.toString());		CurrentConNr = xmlConDetails.CH_CONTRIB_DETAIL.LIFNR;				// Get bank details of this contributor		GetBankAddress();				// Set the remaining data				SetUnboundData();		SetTitle();		buildCPRsArray();				// set the mode of vendor type field//		setVendoredit();	}	else // Create mode	{ // Clear all data		xmlConDetails = new XML("<outer><CH_CONTRIB_DETAIL/></outer>");		SetDefaultValues();		}			// Reset the validators	ValidateAll();	}protected function checkEnablePaymentBlock( _enableFields:Boolean, _paymentType:Object):Boolean{	if (!_enableFields) return false;		// GYORK - temporarily disable this change so we can put another change through	//return true;	// GYORK - end of temporary disablement		var paymentTypeString:String;	if (_paymentType && _paymentType.data)	{		paymentTypeString = _paymentType.data.toString();	} 		if (paymentTypeString == 'C')	{		// Check access#		if (this.chequeRights == 'X')		{			return true;					}		else		{			return false;					}	}	else	{		return true;	}		
} 