/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	EventHandlers.as - reacting to UI and programmed events. 
					   (also event triggers)
	
	amountChanged
		triggered to recalculate the total amount 
		may need currency conversion
	raiseGLAccountChanged
		raise an event when a GL account is changed ( resetsthe item category)		
		set the page number display which is dependent on GL Code
	contractChanged
		Contract has changed. Handle contract reason textbox visibility
	selectContributorFromLast20
 		Last 20 contributors - one has been selected from data grid	
 	storyChanged
 	heldChanged
 	pubDateChanged
		The publication date has changed
	handleTabForTxtContributorName
		tab pressed in contributor name field - stop the event as sometimes
		the tab goes haywire and tabs into the browser controls
	keyUpContributorName
		handle "Enter" in the contributor name field - search for contributors
	costCentreChanged
		When cost centre is changed - change the display properties of the held checkbox
		and re-select the allowed contracts
	launchContributorSearch
		Launch the advanced contributor search
	setDataChanged
		pass data changed flad and saved flag to SAP GUI or Portal
	changedPublicationId
		Publication ID has changed - refresh GL accounts, contracts, item categories etc.
	itemDeleted
		item deleted from grid - remove it from array and add a new row at the end
	editClicked
		Switching from display to edit mode
	resetCurrency
		Set currencies in datagrid if contributor currency has changed
  	populateCommunicationHistory
  		Populate data on the communincation history tab
  	currencyChange
  		Handle changes to the input currency. Used for contributors who have no default currency	
  	dateKeyPress(event)
  		When the user presses a key in the date field
  	handleKeyDown
  		When a key is pressed in the application
  	escapeKeyPressed
  		When the Escape key is preseed in the application
  	clearAlertCloseHandler
  		When a user presses the escape key, they are prompted to see if they want to clear all data. This function
  		handles any action they perform here.	
  	saveSaveMessageSuppression
  		User changes the message-suppresion option for the CPR Save message
  	cbRecentCPRxMaxChange
  		User changes the number of payments to show in "Recent Payments"
 	cbRecentCPRxCostCentreChange
  		User changes the cost centre to show in "Recent Payments"  		
  	
*/
import flash.events.KeyboardEvent;
import flash.events.FocusEvent;
import flash.events.Event;
import ecs.generalClasses.CPRItem;
import mx.core.UITextField;
import mx.controls.DateChooser;
import flash.events.TimerEvent;
import flash.utils.Timer;
import mx.controls.Alert;
import mx.events.CloseEvent;
import flash.events.MouseEvent;
import mx.core.UIComponent;
import mx.managers.PopUpManager;
import mx.core.IFlexDisplayObject;
import mx.events.IndexChangedEvent;



/*
	amountChanged
		triggered to recalculate the total amount 
		may need currency conversion

*/
public function amountChanged(event:Object = ""):void{
	var value:String;			//Current value
	var currItem:CPRItem;		//Current item in items loop
	var total:Number = 0;		//Total as numeric
	var amount:Number;			//Item amount
	var index:int = 0;			//Index for loop
	var commas:RegExp = /,/g; 	//Regular expression for removing commas
	var format:NumberFormatter = new NumberFormatter();
	
	format.useThousandsSeparator=true;
	var precision:String = initXml.CH_T_CURRENCIES.item.(DATA==cprCurrency).DECIMALS;
	format.precision=int(precision);
	//Go through items
	for each(currItem  in CPRItems){
		//remove commas which ruins isNaN
		value = currItem.amount.replace(commas,"");
		
		if (!isNaN(Number(value))){
			amount = Number(value);
			//Convert currency (which will then add to total)
			if (currItem.currency!=cprCurrency && amount>0) 
				convertCurrency(amount, currItem.currency, cprCurrency);
			else total = total + amount;
		}
		index++;
	}
	if (total==0){
		totalAmount="";
		totalNet="";
		VATAmount="";
	}
	else{
		totalAmount=format.format(total);
		totalNet=totalAmount;
		//Calculate the VAT
		addVAT();
	}
	
}

/*
	raiseGLAccountChanged
		raise an event when a GL account is changed ( resetsthe item category)		
		set the page number display which is dependent on GL Code
*/		
public function raiseGLAccountChanged():void{  	
	this.dispatchEvent(new Event("changeGLCode"));
	setPageNumberDisplay();
}        

/*
	contractChanged
		Contract has changed. Handle contract reason textbox visibility
*/
private function contractChanged():void{
 	if (comboContract.selectedIndex<0 || comboContract.selectedItem==null)return;
 	if (comboContract.selectedItem.data == DONTKNOW){
 		contractReasonVisible=true;
 		
 		validTaContractReason.validate();
 		taContractReason.setFocus();
 		efGlow.target=taContractReason;
 		efGlow.play();
 	}
 	else contractReasonVisible=false;
 	setDataChanged(true,false);
 }
 
/*
 	selectContributorFromLast20
 		Last 20 contributors - one has been selected from data grid	

*/
private function selectContributorFromLast20():void{
 	if (dgLast20.selectedIndex>-1 && MODE!=DISPLAY){
 		txtContributor.text =
 		 wsAllNoBusyCursor.Z_ECS_GETLAST20.lastResult.EX_T_CON_DETAIL.item[dgLast20.selectedIndex].LIFNR;
 		 tnTabs.selectedIndex=0;
 		 getContributorDetails(false);
 	}
}
 
/*
 	storyChanged
*/ 
private function storyChanged():void{
	setDataChanged(true,false);
	setFormIsValid();
}

// When the 'held' flag changes, change the mandatory indicator on the publication date.
private function heldChanged():void{
	setDataChanged(true,false);
	if (chkHeld.selected){
		dtPubDate.text="";
		dtPubDate.enabled=false;
		dtPubDate.focusEnabled=false;
		validDtPubdate.required = false;
	}
	else{
		dtPubDate.enabled=true;
		dtPubDate.focusEnabled = true;
		validDtPubdate.required = true;
		validDtPubdate.validate();
	}
	
	setPageNumberDisplay();
}

/*
	pubDateChanged
		The publication date has changed
*/
private function pubDateChanged():void{
	setDataChanged(true,false);	
	publicationDate=getPublicationDate();
	pubDateJustChanged=true;
	getContracts();   	
}

/*
	handleTabForTxtContributorName
		tab pressed in contributor name field - stop the event as sometimes
		the tab goes haywire and tabs into the browser controls
*/
private function handleTabForTxtContributorName(event:FocusEvent):void{
	event.stopImmediatePropagation();
}

/*
	keyUpContributorName
		handle "Enter" in the contributor name field - search for contributors
*/
private function keyUpContributorName(event:KeyboardEvent):void{
	if (event.keyCode==Keyboard.ENTER && txtContributorName.text.length > 0 && txtContributorName.editable)
	{
		searchContributorName(txtContributorName.text);	
	}
		
}

/*
	costCentreChanged
		When cost centre is changed - change the display properties of the held checkbox
		and re-select the allowed contracts
*/
public function costCentreChanged():void{
	setHeldCheckBoxDisplay();
	getContracts();
}
		      
/*
	launchContributorSearch
		Launch the advanced contributor search
*/
public function launchContributorSearch():Object{
return launchContributorSearchSWF();
/*
	var win:ContributorSearch;
	application.focusManager.deactivate();
	win = ContributorSearch( PopUpManager.createPopUp(this,ContributorSearch,true));
	return win;
	*/
}

/*
	launchContributorSearchSWF
		Launch the advanced contributor search using an external Contributor Search swf file
*/
import mx.modules.*;
import mx.events.ModuleEvent;
import mx.events.PropertyChangeEvent;
import mx.controls.ComboBase;
import mx.controls.ComboBox;
import mx.rpc.soap.mxml.Operation;
import ecs.generalClasses.valueForDropdown;
public function launchContributorSearchSWF(justShowResults:Boolean = false):Object{
	if (contribSearchPopup)
	{
		(contribSearchPopup as Object).child.reshow();
		return contribSearchPopup;
	}
	else
	{
		var ml:ModuleLoader = PopUpManager.createPopUp(this, ModuleLoader, true) as ModuleLoader;
		ml.addEventListener(ModuleEvent.ERROR, function():void {Alert.show('Error displaying contributor search')} );
		ml.width = 985;
		ml.height = 683;
		ml.url = swfmodule_contrib_search; // "ContributorSearch.swf";
		ml.loadModule();	
		return ml;
	}
	
	

}


/*
	setDataChanged
		pass data changed flad and saved flag to SAP GUI or Portal
*/
public function setDataChanged(changed:Boolean,immediately:Boolean=false):void{
	if (MODE!=DISPLAY){
		var changeFlag:String="";
		
		
		if (inGUI){
			if (changed) changeFlag="X";
			
			if (!immediately) ExternalInterface.call("updateSAPgui",changeFlag,"");
			else ExternalInterface.call("updateSAPguiImmediately","","X");
		}
		else ExternalInterface.call("updatePortalDirtyFlag",changed);
	}
}     
  
/*
	changedPublicationId
		Publication ID has changed - refresh GL accounts, contracts, item categories etc.
*/
public function changedPublicationId():void{
	populateCostCentres(); 
	glAccounts=initXml.CH_T_GL_ACCOUNT.item.(PUBID==getPublicationId());
	defaultPublicationDate();	
	getContracts();   
	getPaymentDueDate();
	setPageNumberDisplay();
	setItemCategories();
}

/*
	itemDeleted
		item deleted from grid - remove it from array. 
*/
public function itemDeleted():void{
	var i:int=0;
	var newItem:CPRItem;
	for each (var item:CPRItem in CPRItems){
		if (item.deleteFlag){
			CPRItems.splice(i,1);			
			
			// newItem = new CPRItem();
			// newItem.currency=cprCurrency;
			// CPRItems.push(newItem);
		}
		i++;
	}
	// Make sure we have at least one row
	if (CPRItems.length == 0)
	{
		newItem = new CPRItem();
		newItem.currency=cprCurrency;
		CPRItems.push(newItem);	
	}
	
	// Currency on top row is always editable (unless the first item is held)
	if (!this.holdData ||
	    !this.holdData.items ||
	     this.holdData.items.length == 0 ||
	     this.holdData.items[0].currency == "")
		(CPRItems[0] as CPRItem).currencyEditable = true;
	
	
	//Recalculate the totals and update the grid
   	amountChanged(null);
   	dgItems.invalidateProperties();
	dgItems.executeBindings();
	updateGrid();
	
}       

/*
	editClicked
		Switching from display to edit mode
*/ 
 private function editClicked():void{
 	MODE=CHANGE;
 	setToolBar();
 	btnPrint.enabled=false;
 	openUpApplication();
 }
  
/*
	resetCurrency
		Set currencies in datagrid if contributor currency has changed
*/
private function resetCurrency():void{	
   var amount:Number;
   var item:CPRItem;
   
   if (contributorCurrency == "")
    // Contributor has no default currency
    // so must be a confidential payment
   {
   		// If CPRItems (the datagrid of line items) is GBP, the CPR currency
   		// is set to empty. Otherwise, the CPR Currency is set to that of the first line item
   		if (!CPRItems || CPRItems.length == 0)
   		{
   			cprCurrency = "GBP";   			
   		}
   		else if (CPRItems.length == 1)
   		{
   			cprCurrency = CPRItems[0].currency;
   		}
   		else // More than one CPR line item
   		{
   			cprCurrency = CPRItems[0].currency;
   			var multipleCurrenciesInLineItems:Boolean = false;
   			for (var i:String in CPRItems)
   			{
   				item = CPRItems[i];   				
   				if (i == "0") // First line item
   				{
   					item.currencyEditable = true;
   				}
   				else // Every other line item
   				{
   					item.currencyEditable = false;
   					if (item.currency != cprCurrency)
   					{
   						item.currency = cprCurrency;
   						multipleCurrenciesInLineItems = true;
   					}
   				}
   			}
   			if (multipleCurrenciesInLineItems)
   			{
   				var message:String = "CPR Items must all be in the same currency for confidential payments. Line items will be adjusted automatically.";
   				showMessage(message, false, null, "");
   				dgItems.executeBindings();
   				//dgItems.invalidateList();
   			} 
   		} 
   }
   else // contributorCurrency != ""
   {
   		cprCurrency = contributorCurrency;
   		
   		// Set the currency of each line item and open them up to editing
   		for each (item in CPRItems){
   			item.currencyEditable = true;
	   		amount = 0;
			if (!isNaN(Number(item.amount))){
				amount = Number(item.amount);
			}
			//Only lines without an amount
   			if (amount<=0) item.currency=contributorCurrency;
   		}
   }
      	dgItems.executeBindings();
   		dgItems.invalidateProperties();   	

}
  
 /*
  	populateCommunicationHistory
  		Populate data on the communincation history tab
 */ 
private function populateCommunicationHistory(commHistory:XMLList):void{
	var item:XMLList; 
	
	//Get email sent for new contract - i.e. when validated or desk head approved
	item = commHistory.item.(STATUS==STATUS_VALIDATED||STATUS==STATUS_APPROVED);
	if (item!=null && item.length()>0){
		sentDate1=formatDate(item[0].SENDDATE.toString());
		sentTime1=item[0].SENDTIME.toString();
		viewEmail1=true;
	}
	else viewEmail1=false;
	item=null;
	//Get email sent when ME approved (or status is blank for legacy payments)
	item = commHistory.item.(STATUS==STATUS_POSTED||STATUS=="");
	if (item!=null && item.length()>0){
		sentDate2=formatDate(item[0].SENDDATE.toString());
		sentTime2=item[0].SENDTIME.toString();
		viewEmail2=true;
	}
	else viewEmail2=false; 	
	
	// If the communication history component is laoded, update it
	if (mlCommHist && mlCommHist.child)
	{
		commHistSetup(mlCommHist.child);
	}
}

public function currencyChange(target:CurrencyCombo):void
{
	// For confidential contributors i.e. those with no currency, handle changes to the
	// currency dropdown. If contributor has currency, do nothing.
	if (contributorCurrency != "") 
		return;
	
	// Set the document currency to be that of the entered item	
	// Also set the currency of all line items to the document currency
	var changeCurrencyCombos:Boolean = false;
	cprCurrency = target.currency;
	for (var s:String in CPRItems)
	{
		var j:int = int(s); // Convert string to integer
		var c:CPRItem = dgItems.dataProvider.getItemAt(j);
		if (c.currency != cprCurrency)
		{
			c.currency = cprCurrency;
			dgItems.dataProvider.setItemAt(c, j);
			CPRItems[s] = c;
			changeCurrencyCombos  = true;
		}
	}
	
	// Update the grid if required
	if (changeCurrencyCombos)
	{

		dgItems.executeBindings();
		dgItems.invalidateList(); 

		
	}


}

protected function dateKeyPress(event:KeyboardEvent):void
{
		if (event.keyCode == Keyboard.F4)		// Return key
		{
			dtPubDate.open();
		}			
}

// In order to capture two key presses together in the ie plugin, we have to handle the key-up event.
// This is because flash doesn't capture the key-down event for 's' if 'the 'ctrl' key is held down
//
// The user will press 'ctrl' and 's' and will either release 'ctrl' or 's' first.
//
// If the user releases 's' first then when we query the keyup event, event.ctrlKey = true, so we know 
// that ctrl-s was released.
//
// However, if after pressing ctrl and s, the user releases 'ctrl' first, then releases 's', when we 
// query the keyup event for the 's' key being released, event.ctrlKey = false. Therefore, we have  
// to remember that the 'ctrl' key was presses for a few miliseconds after it is released.
 
public var rememberCtrlKeyDuration:uint = 500; // Time to remember ctrl key for (miliseconds)
protected var rememberCtrlKey:Boolean = false;
protected function unrememberCtrlKey(event:TimerEvent):void
{
	rememberCtrlKey = false;
}

protected function handleKeyUp(event:KeyboardEvent):void
{
	if (event.keyCode == 0x11)  //ctrl key pressed 
	{
		rememberCtrlKey = true;
		var ctrlTimer:Timer = new Timer(rememberCtrlKeyDuration, 1);
		ctrlTimer.addEventListener(TimerEvent.TIMER_COMPLETE, unrememberCtrlKey);
		ctrlTimer.start();		
		return;
	}
	
	var ctrl:Boolean;
	if (event.ctrlKey || rememberCtrlKey)
		ctrl = true;
	else
		ctrl = false;
	
	// Check for function key
	if (event.keyCode > 111 && event.keyCode < 123)
	{
		event.stopImmediatePropagation();
		functionKeyPressed(event.keyCode - 111, event);
		return;
	}
	
	if (event.keyCode == 27)
	{
		event.stopImmediatePropagation();
		escapeKeyPressed(event);
		return;
	}
		
	

	if (ctrl && (event.charCode == 0x53 || event.charCode == 0x73) )
	{
	 // If ctrl-s or ctrl-S pressed
	 if (MODE == CHANGE && btnSaveChanges.visible && btnSaveChanges.enabled)
	 	doublePaymentCheck(0);
	 else if (MODE == CREATE)
	 {
		f7_save_on_create();
	 }	 
	}
	// Save stage 1
	else if (ctrl && event.charCode == 0x31  ) // ctrl + '1'
	{
		if (btnSave.visible && btnSave.enabled)
		{
				doublePaymentCheck(1);
		}
	}
	// Validate or Save stage 2 (Validated) - either "Validate" button or "Save stage 2" button
	else if (ctrl && event.charCode == 0x32  ) // ctrl + '2'
	{
		if ( (btnSave2.visible && btnSave2.enabled)
		   || (btnValidate.visible && btnValidate.enabled) )
		{
				doublePaymentCheck(2);
		}
	}
	// Save stage 3 (Deskhead Approved)
	else if (ctrl && event.charCode == 0x33  ) // ctrl + '3'
	{
		if (btnSave3.visible && btnSave3.enabled)
		{
				doublePaymentCheck(3);
		}
	}	
	
	// From Display mode to Edit mode 
	else if (ctrl && (event.charCode == 0x45 || event.charCode == 0x65)  ) // ctrl + 'e' or ctrl + 'E'
	{
		if (btnEdit.visible && btnEdit.enabled)
		{
				editClicked();
		}
	}
	
	// Delete CPR
	else if (ctrl && event.charCode == 0x7F ) // ctrl + 4, since ctrl + v means "paste"
	{
		if (btnDelete.visible && btnDelete.enabled)
		{
				confirmDelete();
		}
	}			
				
}

protected function functionKeyPressed(code:int, event:Object = ""):void
{
	switch (code)
	{
		case 7: // F7
			if (MODE == CREATE)
			{
				f7_save_on_create();
			}
					
			
	}
		
}

// User clicks F7 or ctrl-s while screen is in create mode
private function f7_save_on_create():void
{
	var savedButtons:int = 0;
	var save_mode:int;
	var messageText:String = "More than one type of save is available. \n";
		 
	 	// Could be save stage 1, save validated or save approved
	 	// Check which ones the user has available
	 	if (btnSave.visible && btnSave.enabled)
	 		{
	 			savedButtons++;
	 			save_mode = 1;
	 			messageText += "To save as stage one (unvalidated), press 'ctrl' and '1'. \n";
	 		}
	 	if (btnSave2.visible && btnSave.enabled)
	 		{
	 			savedButtons++;
	 			save_mode = 2;
	 			messageText += "To save as Validated, press 'ctrl' and '2'. \n";
	 		}	 	
	 	if (btnSave3.visible && btnSave.enabled)
	 		{
	 			savedButtons++;
	 			save_mode = 3;
	 			messageText += "To save as Approved, press 'ctrl' and '3'. \n";
	 		}
	 	
	 	if (savedButtons == 1)
	 	{
	 		// Only one saved button available, so trigger it
	 		doublePaymentCheck(save_mode);
	 	}
	 	else if (savedButtons > 1) // More that one button
	 	{
	 		// Is there a default option?
	 		var saveType:uint = 0;	 		
	 		if (comboDefaultSave && comboDefaultSave.selectedItem)
	 		{	 			
	 			saveType = uint(comboDefaultSave.selectedItem.data);	 			
	 		}
	 		
	 		if (saveType > 0 )
	 		{
	 			doublePaymentCheck(saveType);
	 		}	 		
	 		else
	 		{
	 			// Prompt the user to choose an option
	 			if (hbDefaultSave && hbDefaultSave.visible)
	 			{
	 				messageText += "\n Alternatively, to use F7 to save, select an option from the dropdown list at the top of the screen. \n";
	 			}
	 			messageText += "\n Please hit 'OK' or 'Return' and then save in the appropriate manner";
	 			showMessage(messageText, false);
	 		}

	 	}	
	 	
	 
}



// Escape presssed - prompt the user whether they want to clear all data
public function escapeKeyPressed(event:Object = ""):void
{
	if (MODE == CREATE)  // For the time being, we're not doing change, since changes are usally done in SAP gui, and Escape closes the window anyway
	{
		var buttonsToShow:uint = Alert.OK | Alert.CANCEL;
		
		// Add the keyboard shortcuts to the button labels
		Alert.okLabel = "OK (1)";
		Alert.cancelLabel = "CANCEL (2)";
		Alert.buttonWidth += 30;	
		
		// Prepare for the prompt
		var clearPromptText:String;
		if (MODE == CREATE)
			clearPromptText = "Do you want to clear your entries";
		else
			clearPromptText = "Do you want to cancel your changes? \n (All changes since you last saved will be lost)";
			
		// Open the prompt
		var clearPrompt:Alert = Alert.show(clearPromptText, "", buttonsToShow, this, clearAlertCloseHandler, null, Alert.OK);
		
		// Add a keyboard listener
		clearPrompt.addEventListener(KeyboardEvent.KEY_UP, clearAlertCloseHandler);
		
		// Reset the Alert labels
		Alert.okLabel = "OK";
		Alert.cancelLabel = "CANCEL";
		Alert.buttonWidth -= 30;		
	}		
}

/** Decide what to do after the user has pressed "Escape", and has been
 *  prompted to confirm clearing the data.
 * 
 *  This function handles both keyboard and mouse click events
 */
private function clearAlertCloseHandler(event:Event):void
{
	var keyboardEvent:KeyboardEvent = event as KeyboardEvent;
	var closeEvent:CloseEvent = event as CloseEvent;
	var detail:uint;
		
	if (keyboardEvent)
	{  // If a key was pressed, we ignore any key apart form "1" (ascii 49) or "2" (ascii 50)
		var alertPopup:Alert = (event.currentTarget as Alert);
	
		if (keyboardEvent.charCode == 49) // 1 = OK
		{
			detail = Alert.OK;
			PopUpManager.removePopUp(alertPopup);			
		}			
		else if (keyboardEvent.charCode == 50) // 2 = Cancel
		{
			detail = Alert.CANCEL;
			PopUpManager.removePopUp(alertPopup);	
		}			
		else
			return;		
	}		
	
	if (closeEvent)
	{ // If the user pressed a button and closed the popup
		detail = closeEvent.detail;
	}
	

	
	
	// Handle the user action
	if (detail == Alert.CANCEL)
		return; // User cancelled the action, so return
	
	if (detail == Alert.OK && MODE == CREATE)
	// Clear all data (unless its set by Set Data or Hold Data)
	{

    	// Clear screen fields - "Key Information" block
    	contributorName = "";
    	taContractReason.text = "";
    	txtStory.text="";
    	txtContributor.text="";
    	txtContributorReference.text="";
    	txtOnBehalfOf.text="";
    	txtUrgentReason.text="";	
		
		// Clear screen fields - "Payment Details" block
		comboSpecialPayment.selectedIndex = -1;
		chkUrgent.selected = false; // will also hide "urgent reson" by data binding
		
		// Clear the CPRItems data structure bound to the data grid
		// Set it to a single item with no values 	
  		itemsXML = new XML("<outer><CH_T_ITEMS><item></item></CH_T_ITEMS></outer>");	
    	populateItems();
    	
  		
		// Clear / default publication date, page number, held flag and payment notes
		chkHeld.selected = false;
		txtPageNumbers.text = "";
		taContractReason.text = "";
		
		if (rteNotes)
		{
			rteNotes.text = "";
			rteNotes.htmlText = "";
		}
		else
		{
			paymentNotesLongTxt = ""
		}		
		
		defaultPublicationDate();
	
	
	
		//If the user is "holding" data populate the fields and set the display accordingly
    	if (MODE==CREATE){
    		if (holdData!=null){
    			populateScreenFromHeldData();
    			updateGrid();
    		}
    	}    
    
    	// Refresh the "Total Net" amount
   		amountChanged();    
   	 
   	 
    	//Get the contributor details if one has come back from holdData
 	   if (CPRHeader.NEW_CONTRIB!="X") getContributorDetails(false);
	}
	else if (detail == Alert.OK && MODE == CHANGE)
	{
		// Remove any active popups
		removeAllPopups();
		
		// Set the screen to display mode
		applicationEditable=false;
 		heldFieldEditable=false;
 		setUpScreen();
 		setToolBar();
 		btnPrint.enabled=true;	
 		contractReasonVisible=false;			//Hide non-standard contract reason
		contractList=null;						//refresh contract list
		chkNewContributor.selected=false;       //Disable allow new contibutor
		allowNewContributor=false;
		clearContributorDetails();				//Clear out the contributor details
		txtContributorName.setFocus();			//Focus on contributor name field
		prevContributor="";						//Reset previous contributor number (used for on change check)
 		
 		// refresh the screen with the result of the last call to getCPR
 		getCPRCallBack("");
 		
 		// Final tidying up
 		defaultPublicationDate();
		setPaymentNotesLabel();
	}
	
}

private function tnTabsChanged(event:IndexChangedEvent):void
{
	if (event.relatedObject === tabCommunicationHistory)
	{
		if (mlCommHist)
		{
			mlCommHist.loadModule();
		}
	}	
}

// Set the data in the Communication History module
// Called when a CPR is loaded, or when the module is first loaded 
private function commHistSetup(obj:Object):void
{
	// Allow the module to load web services
	obj.wsdl_prefix = this.wsdlRoot;
	
	// Tell the module which CPR we are using
	obj.visible = true;
	obj.cpr = this.cpr;
	obj.company = this.company;
	
	// Tell the module whether it can view certain emails
	obj.year = this.year;
	obj.viewEmail1 = this.viewEmail1;
	obj.viewEmail2 = this.viewEmail2;
	obj.sentDate1 = this.sentDate1;
	obj.sentDate2 = this.sentDate2;
	obj.sentTime1 = this.sentTime1;
	obj.sentTime2 = this.sentTime2;
	
}

private function saveSaveMessageSuppression(event:PropertyChangeEvent):void
{
	wsAllNoBusyCursor.Z_ECS_SAVE_USR_PARAM.request.IM_PARAM = SUPPRESS_SAVE_MESSAGE;
	if (saveMesageSuppressed.suppression)
	{
		wsAllNoBusyCursor.Z_ECS_SAVE_USR_PARAM.request.IM_VALUE = "X";
	}
	else
	{
		wsAllNoBusyCursor.Z_ECS_SAVE_USR_PARAM.request.IM_VALUE = "";
	}
	
	
	wsAllNoBusyCursor.Z_ECS_SAVE_USR_PARAM.send();
}

/** If the value has changed, call the web service again
 */
private function cbRecentCPRsMaxChange(event:Event):void
{
	var cb:ComboBox = event.currentTarget as ComboBox;
	var selectedItem = cb.selectedItem;
	if (!selectedItem)
		return; // Make sure something is selected
	
	// Check that web service exists
	if (this.wsAllNoBusyCursor == null)
		return;
	if (this.wsAllNoBusyCursor.Z_ECS_GET_CONTRIB_RCNT_CPRS == null)
		return;
		
	var op:mx.rpc.soap.mxml.Operation = wsAllNoBusyCursor.Z_ECS_GET_CONTRIB_RCNT_CPRS;
	if (op.request == null)
		return;
		
		
	// OK, we're good to go
	// Get the current value
	var oldVal:String = "";
	if (op.request.hasOwnProperty("IM_MAX_RECORDS"))
		oldVal = op.request.IM_MAX_RECORDS;	

	var newVal:String = selectedItem.value;
	
	if (newVal != oldVal) // If change, send
	{
		op.request.IM_MAX_RECORDS = newVal;
		contributorCPRs = new XML("<CH_T_CPRS><item><STORY>Loading..</STORY><STATUS>none</STATUS></item></CH_T_CPRS>");

		// Don't bother sending if we haven't selected a contributor yet
		if (op.request.IM_CONTRIBUTOR && op.request.IM_CONTRIBUTOR != "")
				op.send();
	}
	
	
}

/** If the value has changed, call the web service again
 */
private function cbRecentCPRsCostCentreChange(event:Event):void
{
	var cb:ComboBox = event.currentTarget as ComboBox;
	var selectedItem:valueForDropdown = cb.selectedItem as valueForDropdown;
	var newVal:String; 
	if (selectedItem)
	{
		newVal = selectedItem.data;
	}
	else
	{
		newVal = "";
	}

	
	// Check that web service exists
	if (this.wsAllNoBusyCursor == null)
		return;
	if (this.wsAllNoBusyCursor.Z_ECS_GET_CONTRIB_RCNT_CPRS == null)
		return;
		
	var op:mx.rpc.soap.mxml.Operation = wsAllNoBusyCursor.Z_ECS_GET_CONTRIB_RCNT_CPRS;
	if (op.request == null)
		return;
		
		
	// OK, we're good to go
	// Get the current value
	var oldVal:String = "";
	if (op.request.hasOwnProperty("IM_KOSTL"))
		oldVal = op.request.IM_MAX_RECORDS;	


	if (newVal != oldVal) // If change, send
	{
		op.request.IM_KOSTL = newVal;
		contributorCPRs = new XML("<CH_T_CPRS><item><STORY>Loading..</STORY><STATUS>none</STATUS></item></CH_T_CPRS>");
		
		// Don't bother sending if we haven't selected a contributor yet
		if (op.request.IM_CONTRIBUTOR && op.request.IM_CONTRIBUTOR != "")
				op.send();
	}
	
	
}
