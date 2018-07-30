/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

Changes:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
CR255113 - Make it possible for duplicate box to how page no
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

WebServiceCalls.as: functions calling web services on SAP
		loadData (Z_ECS_GET_CPR)
			get the data for a CPR or initialise the structures for initial create
		getContracts (Z_ECS_CPR_GET_CONTRACTS)
			get the list of contracts based on contributor/ cost centre/ publication date
		saveCPR (Z_ECS_SAVE_CPR)
			Save the CPR !
			Validate the data first
		doublePaymentCheck (Z_ECS_CHECK_DOUBLE_PAYMENT)
			check for double payment before save
		getContributorDetails (Z_ECS_CPR_GET_CONTRIBUTOR_DET)
			get all the details for the contributor
		searchContributorsPostCode (Z_ECS_SEARCH_CONTRIBUTORS)
			Search for contributors by post code
		searchContributorName (Z_ECS_CONTRIB_SEARCH) 
			Search for contributors by name
		deleteCPR (Z_ECS_DELETE_CPR)
		
		getHTMLForEmail (Z_ECS_CPR_GET_EMAIL_TEXT)
			get the HTML text for the email
		copyCPR (Z_ECS_GET_CPR)
			get details for a copy
		saveAsUrgent (Z_ECS_SAVE_AS_URGENT)
			Save an ME Approved CPR as Urgent
		repeatContributorSearch()
			Repeat the last contributor search
*/

/*
	loadData (Z_ECS_GET_CPR)
		get the data for a CPR or initialise the structures for initial create
*/
public function loadData():void{
	if (MODE == CREATE && createScreenInit)
	{
		getCPRCallBack(createScreenInit) // Don't bother going back to the server, just use what we got last time
		
		// Clear the history datagrids, if they have been created
		try {
			dgCPRChanges.dataProvider = new XMLList();
			dgCPRChanges.invalidateProperties();
			dgWorkflowChanges.dataProvider = new XMLList();
			dgWorkflowChanges.invalidateProperties();
		}
		catch (err:Error) {}

	}
	else
	{
		// Clear the history datagrids, if they have been created
		try {
			if (dgCPRChanges)
			{
				dgCPRChanges.dataProvider = new XMLList();
				dgCPRChanges.invalidateProperties();				
			}
			if (dgWorkflowChanges)
			{
				dgWorkflowChanges.dataProvider = new XMLList();
				dgWorkflowChanges.invalidateProperties();				
			}

		}
		catch (err:Error) {}
		
		// Get the CPR and CPR Change history
		wsAllBusyCursor.Z_ECS_GET_CPR.send();
		if (cpr != null && cpr.length != 0) // Only get history if there is a cpr to get history for
			wsAllNoBusyCursor.Z_ECS_GET_CPR_CHANGES.send();
	}
	     
	     
}
  
/*
	getContracts (Z_ECS_CPR_GET_CONTRACTS)
		get the list of contracts based on contributor/ cost centre/ publication date
*/
import mx.controls.Alert;
import mx.core.Application;
import mx.events.CloseEvent;
import mx.modules.ModuleManager;
import mx.core.UIComponent;
import ecs.gridFields.AmountInput;
import mx.rpc.soap.Operation;
import flash.events.IEventDispatcher;
import mx.rpc.events.ResultEvent;
import ecs.generalClasses.CPRItem;
import ecs.gridFields.GLAccountInput;

private function getContracts():void{

	var currRFCItem:XML;
	var node:XML;
	var items:Array = new Array();
	var i:int;
	
	trace("getContracts()");
	
	
//Display mode - already got the contracts?	
	if (MODE==DISPLAY&&gotContracts)
	{
	    trace("returning getContracts()"); 
		return;
	} 
	if (MODE==DISPLAY) gotContracts=true;
 	if (txtContributor.text!=""){
 // Only if the user had entered a contributor
 		//Get all the cost centres		
 		for each(var item:CPRItem in CPRItems){
 			if (item.costCentre!=""){	
 				currRFCItem = new XML("<item></item>");
 				node =  new XML("<COST_CENTRE>" + item.costCentre +  "</COST_CENTRE>");
				currRFCItem.appendChild(node);				
				items[i] = currRFCItem;		
				i++	
 			}
 		}
 		wsAllNoBusyCursor.Z_ECS_CPR_GET_CONTRACTS.request.IM_T_COST_CENTRES = items;
 		wsAllNoBusyCursor.Z_ECS_CPR_GET_CONTRACTS.send();
 		trace("getting Contracts()"); 		
 	} 
}

/*
	saveCPR (Z_ECS_SAVE_CPR)
		Save the CPR !
		Validate the data first

*/
private var cprSaveLevel:int;
private function currencySaveCheck(event:CloseEvent):void
{
	if (event.detail == Alert.OK)
		saveCPR(cprSaveLevel, "X");
}

public function saveCPR(level:int, skipCurrencyMessage:Object = ""):void{
	
	var arrItems:Array = new Array();						//Items for CH_T_ITEMS
	var i:int = 0;						
	var node:XML;											
	var currRFCItem:XML;									//Currrent item node for CH_T_ITEMS
	var amount:Number;										//Amount for line item
	var format:NumberFormatter = new NumberFormatter();		//Number formatter
	var commas:RegExp = /,/g;							//Reg expression to remove commas
  	format.useThousandsSeparator=false;
  	
  	//re-enable the application
  	this.enabled=true;		
  	
  	//Check the data is valid		
  	if (!checkFormIsValid(level)) return;
  	
  	// Check line items currency match document currency
  	if (skipCurrencyMessage == "")
  	{
  		var currItem:CPRItem;		//Current item in items loop
  		var showCurrMessage:Boolean = false;
  		var otherCurrency:String;
  		for each (currItem in CPRItems)
  		{
  			if (currItem.currency != cprCurrency && currItem.currency.length > 0 && cprCurrency.length > 0)
  			{
  				showCurrMessage = true;
  				otherCurrency = currItem.currency;
  			}
  				
  		}
  		if (showCurrMessage)
  		{
  			var message:String; 
  				if (contributorCurrency.length > 0)
  			{
  				message = "This contributor's currency is " + contributorCurrency;
  				message += ". However, there is a line item with a currency of " + otherCurrency;
  				message += ". This payment will be converted to " + contributorCurrency;
  			}
  			else
  			{
  				message = "All payments will be converted to the currency of the first line item";
  				message += "in this document(" + cprCurrency + ").";
  			}
  			
  			cprSaveLevel = level;  			
  			Alert.show(message, "Currency mismatch", Alert.OK | Alert.CANCEL, this, currencySaveCheck); 
  			return; 			
  		}
  	}

	// Select the correct Item Category
	raiseGLAccountChanged();
	//var currItem:CPRItem;		//Current item in items loop
	var cat:String;
  	for each (currItem in CPRItems)
  	{
  		cat = currItem.GLRenderer.setItemCategory();
  		if (cat.length > 0 && cat != currItem.itemCategory) // This should always be false, as the call to setItemCategory() should 
  		{                                                   // update the item category, but just to be on the safe side we check it again.
  			currItem.itemCategory = currItem.GLRenderer.setItemCategory();
  		}  			
  	}
  
	CPRHeader.STORY = txtStory.text;
	//Publication ID
	CPRHeader.PUBID = comboPubID.selectedItem.data;
	//Contributor number
	CPRHeader.LIFNR = txtContributor.text;
	//Contributor reference
	CPRHeader.XBLNR = txtContributorReference.text;
	//Currency
	/// * if (CPRHeader.WAERS=="") CPRHeader.WAERS = contributorCurrency;
	CPRHeader.WAERS = cprCurrency;
	
	//Cash payment indicator
	if (comboSpecialPayment.selectedIndex>-1){
		CPRHeader.CASH = comboSpecialPayment.selectedItem.data;
	}
	else CPRHeader.CASH = "";
	
	//Urgent flag
	if (chkUrgent.selected) CPRHeader.URGENT = "X";
	else CPRHeader.URGENT = "";
	if (chkHeld.selected) CPRHeader.HELD = "X";
	else CPRHeader.HELD = "";
	//New contributor flag
	if (chkNewContributor.selected) CPRHeader.NEW_CONTRIB = "X";
	else CPRHeader.NEW_CONTRIB = ""
	
	//Publication date
	CPRHeader.PUBDATE = getPublicationDate();
	//Page numbers
	CPRHeader.PAGENOS = txtPageNumbers.text;
	//Contract
	if (comboContract.selectedItem!=null) CPRHeader.CONTRACT = comboContract.selectedItem.data;
	else CPRHeader.CONTRACT = "";
	
	//reason for not selecting a contract
	CPRHeader.CONTRACT_REASON = taContractReason.text;
	//payment made on behalf of
	CPRHeader.ONBEHALFOF = txtOnBehalfOf.text;
	//reason the payment is urgent
	CPRHeader.URGENTREASON = txtUrgentReason.text;
	
	//Get the items
	for each(var item:CPRItem in CPRItems){
		amount = 0;
		currentItemIndex=i;
		
		//Check the amount is > 0
		if (!isNaN(Number(item.amount.replace(commas,"")))){
			amount = Number(item.amount.replace(commas,""));
		}
		if (amount<=0) continue;
		
		//Check the user has entered a cost centre
		if (item.costCentre==null || item.costCentre==""){
			showMessage("Please enter a Cost Centre for item " + (i + 1),true,null,"CostCentreFocus");
			return;
		}
		//If saving a validated payment
		if (level>1 || Number(CPRHeader.STATUS)>=2){
			//Some cost centres require a projectc ode
			if (initXml.CH_T_COST_CENTRES.item.(DATA==item.costCentre).PROJECT_REQUIRED=="X" && item.project==""){				
				showMessage("Cost centre " + item.costCentre + "requires a project code" + " (item " + (i + 1) + ")",true, item.projectRenderer);

				return;
			}
			//GL account is required
			if (item.GLAccount==""){
				showMessage("Please enter a GL account for item " + (i + 1),true,null,"GLFocus");
				return;
			}
			
		}
		//Build XML node for RFC table row structure
		currRFCItem = new XML("<item></item>");
		
		node =  new XML("<AMOUNT>" + format.format(amount) +  "</AMOUNT>");
		currRFCItem.appendChild(node);
		
		node =  new XML("<CURRENCY>" + item.currency +  "</CURRENCY>");
		currRFCItem.appendChild(node);
		
		node =  new XML("<COST_CENTRE>" + item.costCentre +  "</COST_CENTRE>");
		currRFCItem.appendChild(node);

		node =  new XML("<ITEM_CATEGORY>" + item.itemCategory +  "</ITEM_CATEGORY>");
		currRFCItem.appendChild(node);

		node =  new XML("<GL_ACCOUNT>" + item.GLAccount +  "</GL_ACCOUNT>");
		currRFCItem.appendChild(node);
		
		node =  new XML("<PROJECT>" + item.project +  "</PROJECT>");
		currRFCItem.appendChild(node);
		
		node =  new XML("<DOCUMENT>" + item.document +  "</DOCUMENT>");
		currRFCItem.appendChild(node);
		
		node =  new XML("<YEAR>" + item.year +  "</YEAR>");
		currRFCItem.appendChild(node);
		
		arrItems[i] = currRFCItem;		
		i++	
	}
	
	if (i<=0) {
		//no items with £ >0 entered, focus on first amount field
		showMessage("You have not entered any items for this payment, therefore it cannot be saved",true,null,"FirstAmountFocus");				
		return;
	}
	if (!chkHeld.selected && dtPubDate.text == ""){
		//Publication date is required if held checkbox is not selected
		showMessage("Please enter a publication date",true,dtPubDate);
		return;
	}
	
	wsAllBusyCursor.Z_ECS_SAVE_CPR.request.IM_NEW_LEVEL = String(level);
	wsAllBusyCursor.Z_ECS_SAVE_CPR.request.IM_HEADER = CPRHeader;
	wsAllBusyCursor.Z_ECS_SAVE_CPR.request.CH_T_ITEMS = arrItems;
	this.enabled=false;	
	
	/** Here is where we send the request to SAP
	 */
	wsAllBusyCursor.Z_ECS_SAVE_CPR.send();
	
	// Clear out any info messages
	clearInfoMessage();	
	
}
private function convertCurrency(amount:Number,fromCurrency:String,toCurrency:String):void{
	if (fromCurrency==""||toCurrency=="") return;
	wsAllNoBusyCursor.Z_ECS_CONVERT_CURRENCY.request.IM_FROM = fromCurrency;
	wsAllNoBusyCursor.Z_ECS_CONVERT_CURRENCY.request.IM_TO = toCurrency;
	wsAllNoBusyCursor.Z_ECS_CONVERT_CURRENCY.request.IM_AMOUNT = amount;
	wsAllNoBusyCursor.Z_ECS_CONVERT_CURRENCY.send();
	currencyConversionInProgress = true;
}
   
/*
	doublePaymentCheck (Z_ECS_CHECK_DOUBLE_PAYMENT)
		check for double payment before save
*/ 
private function doublePaymentCheck(level:int):void{
  	
  	var netAmount:Number = Number(totalNet);
  	var format:NumberFormatter = new NumberFormatter();     	
  	
  	if (!validateContributorNumberBeforeSave(level)) return;
  	if (!checkFormIsValid(level)) return;
  	
  	format.useThousandsSeparator=false;
  	publicationDate=getPublicationDate();
  	
  	saveLevel=level;
    this.enabled=false;
    
    // Make the button glow so users know which one was used
    switch (level)
    {
    	case 0:
    		efGlowForButton.target = btnSaveChanges;
    		break;
    	case 1:
    		efGlowForButton.target = btnSave;
    		break;
    	case 2:
    		if (btnSave2.visible)
    			efGlowForButton.target = btnSave2
    		else
    			efGlowForButton.target = btnValidate;
    			
    		break;
    	case 3:
    		efGlowForButton.target = btnSave3;
    		break;
    	default:
    	   efGlowForButton.target = null; 	
    }
    if (efGlowForButton.target)
    	efGlowForButton.play();

	// Make sure the item category matches the gl code for each line
	for each (var item:CPRItem in CPRItems)
	{
		var cat:String = item.GLRenderer.setItemCategory();
		if (cat.length > 0)
		{
			item.itemCategory = cat;
			item.itemCategoryRenderer.data = item; // Trigger 'set data()' for this line			
		}
	} 
    
    // Check whether the user has changed amount but hasn't tabbed or clicked out
    // of this field before clicking "save"
    var focused:Object = this.getFocus();
    var amtInputField:AmountInput = null;    
    if (focused && focused is AmountInput)
    	amtInputField = focused as AmountInput;    
    else if (focused && focused.parent && focused.parent is AmountInput)
    	amtInputField = (focused.parent) as AmountInput;
    else if (focused && focused.parent && focused.parent.parent && focused.parent.parent is AmountInput)
    	amtInputField = (focused.parent.parent) as AmountInput;

	if (amtInputField && amtInputField.raiseChange() && currencyConversionInProgress)
	{
		// We need to wait for the call to wsAllNoBusyCursor.Z_ECS_CONVERT_CURRENCY to return
		// before we send the request
		// Set the priority to -2 so the normal event handler currencyConvertCallBack() is called first
		(wsAllNoBusyCursor.Z_ECS_CONVERT_CURRENCY as IEventDispatcher).addEventListener(ResultEvent.RESULT, dpc ,false, -2, true);		
	}
	else
	{	
		 // Send the request
 		wsAllNoBusyCursor.Z_ECS_CHECK_DOUBLE_PAYMENT.request.IM_NET_AMOUNT = format.format(totalAmount);
  		wsAllNoBusyCursor.Z_ECS_CHECK_DOUBLE_PAYMENT.send();
	}
		

} 

// Call double payment check after currency conversion
private function dpc(event:ResultEvent):void
{
	// Remove the listener so it doesn't happen next time
	(event.currentTarget as IEventDispatcher).removeEventListener(ResultEvent.RESULT, dpc, false);
	// Call
	doublePaymentCheck(saveLevel);
}
	
  
public function doublePaymentContinue():void{
  	saveCPR(saveLevel);	
}

/*
	getContributorDetails (Z_ECS_CPR_GET_CONTRIBUTOR_DET)
		get all the details for the contributor
		
*/   
private function getContributorDetails(onEnter:Boolean):void{
	//make sure contributor has been entered
	if (txtContributor.text==""||chkNewContributor.selected) return;
	
	// If "Hold Data" is on for both contributor name and 
	// contributor number fields, return. Only applies to "hold data", not "set data".
	if (isContributorHeld()) return;
	
	//Searching for contributor if the user pressed enter
	if (isNaN(Number(txtContributor.text)) && onEnter){
		searchContributorName(txtContributor.text);
	}	
	//Update the Contributor tab in ZECS_CPR_PLUS BSP application
	if (inGUI&&MODE!=CREATE){
		ExternalInterface.call("updateContributorTab",txtContributor.text);
	}
	// Don't bother if it is the same contributor as before, unless its been blanked out,
	// but still move cursor
	if (txtContributor.text==prevContributor && txtContributorName.text.length > 0)
	{
		focusOnStoryWhenContributorRetreived(); 
		return;
	} 
	
	prevContributor=txtContributor.text;
	
	// First check if we have already loaded this contribuor. If we have, we still retreive the
	// information from the SAP database, in case it has changed, but first we retreive it from our store, to
	// allow the usr to continue entering the payment. 
	// (The recent payments list will almost certainly have changed)
	if (!onEnter)
	{
		var contribObj:Object = retreiveFromRecentContribs(txtContributor.text);
		if (contribObj)
		{
			getContributorDetailsCallBack(contribObj, false, true); // Get details but don't display messages,
			                                                        // Messages will be displayed a fraction of a second later
			                                                        // when the contributor is returned from the database
			trace("Used recent contrib list");
		}
		
		// Focus on story field?
	    focusOnStoryWhenContributorRetreived();  			
		
		// Clear recent CPRs
   		contributorCPRs = new XML("<CH_T_CPRS><item><STORY>Loading..</STORY><STATUS>none</STATUS></item></CH_T_CPRS>"); 		
		
		// Get contributor details from database.
		// We always go to the database, in case the details have changed.
		wsAllNoBusyCursor.Z_ECS_CPR_GET_CONTRIBUTOR_DET.send();
		
		// Get recent payments seprately, since this takes longer. 		
		wsAllNoBusyCursor.Z_ECS_GET_CONTRIB_RCNT_CPRS.send();
	}
	
	 
}

/*
	searchContributorsPostCode (Z_ECS_SEARCH_CONTRIBUTORS)
		Search for contributors by post code
*/
private function searchContributorsPostCode():void{
	wsAllBusyCursor.Z_ECS_SEARCH_CONTRIBUTORS.request.NAME = "";
	wsAllBusyCursor.Z_ECS_SEARCH_CONTRIBUTORS.request.PSTLZ =txtPostCode.text;
	wsAllBusyCursor.Z_ECS_SEARCH_CONTRIBUTORS.send();
}

/*
	searchContributorName (Z_ECS_CONTRIB_SEARCH) 
		Search for contributors by name
*/
private function searchContributorName(name:String):void{
	if (name.length == 0)
		return;

	var searchString:String = name.toUpperCase();
	var contribNumber:String;
	var contrib:Object;
	
	// First check last 20 contributors to see if he/she is in there
	for each (contrib in last20NamesDropDown)
	{
		if (contrib.data.toString() == searchString)
		{
			contribNumber = contrib.extra.toString();
			txtContributor.text = contribNumber; // This also triggers an event which calls getContributorDetails(false)
			
			return;					
		}
	}

	// Can't find him/her, so search in SAP
	wsAllBusyCursor.Z_ECS_CONTRIB_SEARCH.request.IM_SEARCH_STRING = searchString;	
	wsAllBusyCursor.Z_ECS_CONTRIB_SEARCH.send();

	
	
}

/*
	deleteCPR (Z_ECS_DELETE_CPR)
*/
private function deleteCPR(event:Object):void{
 	this.enabled=false;
 	wsAllBusyCursor.Z_ECS_DELETE_CPR.send();
}
 
/*
	getHTMLForEmail (Z_ECS_CPR_GET_EMAIL_TEXT)
		get the HTML text for the email
*/     
/*
private function getHTMLForEmail(CPRStatus:String):void{
	wsGetContributorEmail.Z_ECS_CPR_GET_EMAIL_TEXT.request.IM_STATUS = CPRStatus;
	wsGetContributorEmail.Z_ECS_CPR_GET_EMAIL_TEXT.send();
}
*/
/*
	copyCPR (Z_ECS_GET_CPR)
		get details for a copy
*/
private function copyCPR():void{
	if (dgRecentPayments.selectedItem == null)
		return;
	var _cpr:String = dgRecentPayments.selectedItem.CPR.toString();
	if (_cpr.length == 0)
		return;	

	wsGetCPRDataForCopy.Z_ECS_GET_CPR.request.IM_DOCUMENT_NUMBER = dgRecentPayments.selectedItem.CPR.toString();
	wsGetCPRDataForCopy.Z_ECS_GET_CPR.request.IM_COMPANY_CODE = dgRecentPayments.selectedItem.COMPANY.toString();
	wsGetCPRDataForCopy.Z_ECS_GET_CPR.request.IM_YEAR = dgRecentPayments.selectedItem.YEAR.toString();
	wsGetCPRDataForCopy.Z_ECS_GET_CPR.send();
	tnPaymentDetails.selectedIndex=0;
	
}

/*
	saveAsUrgent (Z_ECS_SAVE_AS_URGENT)
		Save an ME Approved CPR as Urgent
*/
public function saveAsUrgent():void {
	if (chkUrgent.selected) {
		wsAllBusyCursor.Z_ECS_SAVE_AS_URGENT.request.IM_REASON = txtUrgentReason.text;
		wsAllBusyCursor.Z_ECS_SAVE_AS_URGENT.send();
	}
	else 
	{
		Alert.show("You must tick the 'Urgent' box first", "", 0x4,null, function():void {this.focusManager.setFocus(chkUrgent);} );		
		
	}
/* 	else 
	{
		Alert.show("You must enter a reason first", "", 0x4, null, function():void {this.focusManager.setFocus(txtUrgentReason);});
		
	} */
	
}

public function repeatContributorSearch():void
{
	searchContributorsNewCallBack(lastSearchResults);
}

public function preloadContributorSearch(event:Object = null):void
{
	ModuleManager.getModule(swfmodule_contrib_search).load();
}