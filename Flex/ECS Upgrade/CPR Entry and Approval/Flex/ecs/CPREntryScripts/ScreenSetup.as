/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	ScreenSetup.as
		Initial and ongoing setup of the CPR Entry screen: toolbar, visible elements, editable fields etc
	
	setUpScreen
		Hide unnecessary tabs
		Set global editable flags and stylenames
	setToolBar
		Setup the toolbar based on what the user is allowed to do with the payment
	placeButton
		Place the button adjacent to the previous
	setHeldCheckBoxDisplay
		Show /hide the Held checkbox (based on whether the Cost centre allows held items
	setPageNumberDisplay
		Show/ hide page number field based on config for publication and GL account
	openUpApplicationOpen 
		Switch from display to Edit mode
	updateGrid
	setAllowNewContributor
		Set flag for allowing the user to enter a new contributor (cut down info)
		Only commisioning editors can do this.
 	clearContributorDetails
 		Clear out all the contributor info fields
  	setNewContributorFlag
		New contributor selected - disable the contributor field
	addTableRow
		Add an item to the items datagrid
	populateScreenFromUploadProgram
		Batch data load - populate screen from XML passed in on the query string
*/
import ecs.generalClasses.CPRItem;
import flash.events.Event;
import flash.net.URLVariables;
import mx.utils.URLUtil;
import mx.controls.Alert;
import ecs.generalClasses.valueForDropdown;
import mx.collections.ArrayCollection;
import mx.core.IUIComponent;



/*
	setUpScreen
		Hide unnecessary tabs
		Set global editable flags and stylenames
*/
private function setUpScreen():void{
	tnTabs.selectedIndex = 0;  // Select the first tab - "Contibutor Payment Request"
	if (MODE==DISPLAY){
		//Display mode = uneditable, greyed out fields
		tabHistory.enabled=true;
		applicationEditable=false;
		heldFieldEditable=false;
		textInputStyle="disabled";
		comboStyleName="comboDisabled";
		//Don't show the last 20 tab
		tnTabs.getTabAt(1).parent.visible = false;  // last 20
		tnTabs.getTabAt(2).parent.visible = true; // history
		tnTabs.getTabAt(3).parent.visible = true; // communication history
		//try {tnTabs.removeChild(tabLast20);}
		//catch (e:Error) {}		
	}
	else if (MODE == CHANGE)
	{ 
		//Change mode
		tabHistory.enabled=true;
		if (inGUI=="X") ExternalInterface.call("updateSAPgui", "X", "");
	//	try {tnTabs.removeChild(tabLast20);}
	//	catch (e:Error) {}
		tnTabs.getTabAt(1).parent.visible = false;  // last 20
		tnTabs.getTabAt(2).parent.visible = true; // history
		tnTabs.getTabAt(3).parent.visible = true; // communication history
	} 
	else // if(MODE==CREATE) 
	{
		//Create Mode
		tabHistory.enabled=false;
		//Don't show history tabs
		tnTabs.getTabAt(1).parent.visible = true;  // last 20
		tnTabs.getTabAt(2).parent.visible = false; // history
		tnTabs.getTabAt(3).parent.visible = false; // communication history
		//tnTabs.removeChild(tabHistory);
		//tnTabs.removeChild(tabCommunicationHistory);
		if (inGUI=="X") ExternalInterface.call("updateSAPgui", "", "X");		
	}

}
	
/* 
	setToolBar
		Setup the toolbar based on what the user is allowed to do with the payment

*/
public function setToolBar():void{
		
	var left:int=17;
	var countSaveButtons:uint = 0; // Number of different save buttons (not counting Save Urgent)
		
	cnvToolbar.visible=true;
	btnSave.visible=false;
	btnSave2.visible=false;
	btnSave3.visible=false;
	btnEdit.visible=false;
	btnValidate.visible=false;
	btnSaveChanges.visible=false;
	btnDelete.visible=false;
	btnCreateContributor.visible=false;
	btnPrint.visible=false;	
	btnSaveUrgent.visible = false;
	pbHoldOptions.visible=false;
	labHoldOptions.visible=false;
	hbDefaultSave.visible=false;
	if (MODE==CREATE){
		if (allowPost1)
		{
			left=placeButton(btnSave,left);
			countSaveButtons ++;
		} 
		if (allowPost2)
		{
			left=placeButton(btnSave2,left);
			countSaveButtons ++;
		} 
		if (allowPost3)
		{
			left=placeButton(btnSave3,left);
			countSaveButtons ++;
		} 
		left=placeButton(pbHoldOptions,left)		
		pbHoldOptions.visible = true;
		labHoldOptions.visible = true;
		if (countSaveButtons > 1 ) 
		{
			setupSavesCombo();	
			left=placeButton(hbDefaultSave,left);					
		}			
		
	} 
	else if (MODE==DISPLAY){
		if (allowEdit) left=placeButton(btnEdit,left);
		if (allowPrint) left=placeButton(btnPrint,left);
		if (allowUrgent) {
			left = placeButton(btnSaveUrgent, left);
		} 
	}
	else if (MODE==CHANGE){
		if (allowValidate) left=placeButton(btnValidate,left);
		if (allowDelete) left=placeButton(btnDelete,left);
		if (allowPrint) left=placeButton(btnPrint,left);
		left=placeButton(btnSaveChanges,left);
		
	} 
		
}
	
/*
	placeButton
		Place the button adjacent to the previous
*/
private function placeButton(button:IUIComponent,left:int):int{
	button.x = left;
	button.visible = true;
	return left + button.width + 9;
}
	
/*
	setHeldCheckBoxDisplay
		Show /hide the Held checkbox (based on whether the (first) Cost centre allows held items
*/
private function setHeldCheckBoxDisplay():void{
														
	var allowed:String;
	
	try {
		if (!CPRItems || CPRItems.length == 0 || CPRItems[0].costCentre=="") allowed="X";
		else allowed = initXml.CH_T_COST_CENTRES.item.(DATA==CPRItems[0].costCentre).HELD_ALLOWED.toString();
				
	} catch (e:Error)
	{
		allowed = 'X';
	}	
		if (allowed=="X") heldAllowed=true;
		else {
			heldAllowed=false;
			chkHeld.selected=false;
		}
	

}

/*
	setPageNumberDisplay
		Show/ hide page number field based on config for publication and GL account
		Page number is never required for held items
*/
private function setPageNumberDisplay():void{
	//Config at publication ID level
	var pageNoConfig:String = initXml.CH_T_PAGENO_CONFIG.item.(PUBID==getPublicationId()).SCREEN_CONFIG.toString();
	pageNumbersRequired=false;
	if (chkHeld.selected)
		txtPageNumbers.text = "";
		
	//Can be hidden or mandatory
	if(pageNoConfig==HIDDEN){
		txtPageNumbers.visible=false;
		lblPageNumbers.visible=false;	
		return;
	}
	else{
		txtPageNumbers.visible=true;
		lblPageNumbers.visible=true;
		txtPageNumbers.editable = !chkHeld.selected;		
	}
	
	
	if(pageNoConfig==MANDATORY && !chkHeld.selected ){		
		pageNumbersRequired=true;		 
	}
	
	else if (!chkHeld.selected){
		//Is it mandatory for one of the GL accounts
		for each(var item:CPRItem in CPRItems){
			if (item.GLAccount!=""){
				pageNoConfig = initXml.CH_T_GL_ACCOUNT.item.(PUBID==getPublicationId()&& GL_ACCT==item.GLAccount).PAGENOS.toString();
				if (pageNoConfig==MANDATORY) break;
			}
		}
		if(pageNoConfig==MANDATORY){
			pageNumbersRequired=true;	
		}
	}
	// If its both visible and enabled, its tabable, otherwise its not
	txtPageNumbers.tabEnabled = (txtPageNumbers.editable && txtPageNumbers.visible);
	txtPageNumbers.focusEnabled = txtPageNumbers.tabEnabled;
	
	// Validate
	validTxtPageNumbers.validate();
	
}

/*
	openUpApplicationOpen 
		Switch from display to Edit mode

*/
private function openUpApplication():void{
 	applicationEditable=true;
 	heldFieldEditable=true;
 	comboStyleName="";
 	textInputStyle="";

 	for each(var itemObj:CPRItem in CPRItems){
 		//Go through the items and set the properties for "holdable" items to open them up
 		itemObj.amountEditable = true;
 		itemObj.amountStyleName = ""; 		
 		itemObj.costCentreEditable =  true;
		itemObj.costCentreStyleName="";
		itemObj.itemCategoryEditable = true;
		itemObj.itemCategoryStyleName="";
		itemObj.GLAccountEditable = true;
		itemObj.GLAccountStyleName="";
		itemObj.projectEditable = true;
		itemObj.projectStyleName="";
 	}
 	dgItems.executeBindings();
 }
 
 
public function updateGrid():void{
	dgItems.invalidateProperties();
}

/*
	setAllowNewContributor
		Set flag for allowing the user to enter a new contributor (cut down info)
		Only commisioning editors can do this.

*/
public function setAllowNewContributor():Boolean{
     	
 	if (MODE==CREATE &&allowPost1 ){
 		allowNewContributor=true;
 		//Contributor number is no longer required
 		validTxtContributor.required=false;
 		//Remove warnings on field
 		validTxtContributor.validate();
 		return true;
 	}
 	else validTxtContributor.required=true;
 	return false;
 }
 
 /*
 	clearContributorDetails
 		Clear out all the contributor info fields
 */
 private function clearContributorDetails():void{
 	txtinfoAddressLine.text="";
 	txtContributorName.text="";
 	txtEmail.text="";
 	txtInfoCity.text="";
 	txtInfoTelNumber.text="";
 	txtInfoContributorType.text="";
 	txtPostCode.text="";
 	txtAlias.text="";
 	contractList=null;
 	contributorCPRs=null;
 	contributorCurrency="";
 	cprCurrency="";
 	name2="";
 }
 
 /*
 	setNewContributorFlag
		New contributor selected - disable the contributor field
 */
 private function setNewContributorFlag():void{
 	if (chkNewContributor.selected){
 		validTxtContributor.error = false;
 		validTxtContributor.required =false;
 		txtContributor.text="";    		
 		clearContributorDetails();
 		
 		contributorNumberError=false;
 		txtContributor.enabled =false;
  		setFormIsValid();
 	}
 	else{
 		txtContributor.enabled =true;
 		validTxtContributor.required = true;
 	}
 	validTxtContributor.validate();
}	

/*
	addTableRow
		Add an item to the items datagrid
*/ 
private function addTableRow():void{
 	var newItem:CPRItem = new CPRItem();
 	
 	if (contributorCurrency != "")
 	{    // Normal payments - payment converted to contributor's default currency
 		newItem.currency=contributorCurrency;
 		newItem.currencyEditable = true;
 	}
 	else  // Confidential payments - contributor doesn't have a currency
 	// Therefore the payment is made in the selected currency. This means that all
 	// line items must be in the same currency, so we grey out the currency dropdowns on
 	// all but the first line item.
 	{
 		newItem.currency = cprCurrency; 
 		newItem.currencyEditable = false;
 		
 	}
 	
 	
 	newItem.index=CPRItems.length;
 	CPRItems.push(newItem);
 	dgItems.executeBindings();
 	dgItems.invalidateProperties();
}


/*
	populateScreenFromUploadProgram
	 Batch data load - populate screen from XML passed in on the query string
*/
public function populateScreenFromUploadProgram(newXML:String):void{
	
	var xmlCPR:XML = new XML(unescape(newXML));   //Load the XML
	var pubDateString:String="";				  //Formatted publication date
	var newItem:CPRItem;						  //New item for grid

	removeAllPopups();

	if (MODE!=CREATE||xmlCPR.length()==0) return; //Create only
	txtContributor.text=xmlCPR.LIFNR;			  //Contributor
	fromUpload=true;
	//Populate name if no contributor passed
	if (txtContributor.text=="")
	{
		txtContributorName.text=xmlCPR.NAME1;		
	} 
		
	 //Set dropdown index for publications
    if (publications!=null){       
		for (var k:int=0;k<publications.length;k++){
	    	if (publications[k].data==xmlCPR.PUBID){ 
	        	comboPubID.selectedIndex=k;
	        	break;
	        }
	    }
	}
	//Raise publication changed event
	comboPubID.dispatchEvent(new ListEvent(Event.CHANGE));
	
	// Set data fields
	cpr = "";
	year = "";
	company = "";
	txtContributorReference.text =xmlCPR.XBLNR;		//Contributor's reference
	pubDateString = unescape(xmlCPR.PUBDATE.toString());	//unescape  dateto remove slashes (%2f)
	dtPubDate.text= formatDate(pubDateString);		//Publication date
	txtStory.text=xmlCPR.STORY;						//Story text
	txtOnBehalfOf.text = xmlCPR.ONBEHALFOF;         // Input on behalf of
	
	
	txtPageNumbers.text = xmlCPR.PAGENOS;           // Page numbers
	if (rteNotes)
	{
		rteNotes.text = xmlCPR.NOTES;					// Notes
		rteNotes.callLater(setPaymentNotesLabel);
	}
	else
	{
		// Notes field not created yet
		paymentNotesLongTxt = xmlCPR.NOTES.toString();
		setPaymentNotesLabel();
	}
	//Held checkbox
	if (xmlCPR.HELD.toString()=="X")
	{
		chkHeld.selected=true;
	}
	else
	{
		chkHeld.selected=false;
	}
	heldChanged();
	 
	CPRItems = new Array();
	//Add the line items
	for each (var item:XML in xmlCPR.LINE_ITEM){
		newItem = new CPRItem();
		newItem.itemCategory = item.ITEMCAT;        //Item category
		newItem.amount=item.WRBTR;					//Amount
		newItem.costCentre=item.KOSTL;				//Cost centre
		newItem.project=item.AUFNR;					//Project
		newItem.currency=xmlCPR.CURRENCY;			//Currency
		newItem.GLAccount=removeleadingZeros(item.HKONT.toString());	//GL Account
		CPRItems.push(newItem);
	}
	
	 // Added line below to resolve problem ticket 542 - Problem in Excel upload. If two 
	 // consecutive payments have the same contributor, the total amount isn't being refreshed.
	this.amountChanged();      


	dgItems.executeBindings(true);
	application.enabled = true;
	
	
}

// Sets up the saves combo
private function setupSavesCombo():void
{
	
	// Only call this function once, else we lose whatever is selected when the user saves. 
	// This is because the setUpToolbar method is called after every save.
	if (allowedSaves && allowedSaves.length > 0)
		return;
	
	
	hbDefaultSave.visible = true;
	
	
	allowedSaves = new ArrayCollection();
	var save:valueForDropdown = new valueForDropdown(); 
	save.data = "";
	save.label = "No Default";
	allowedSaves.addItem(save);
	
	
	if (allowPost1)
		{
			save = new valueForDropdown();
			save.data = "1";
			save.label = "Save stage 1";
			allowedSaves.addItem(save);
		}
	if (allowPost2)
		{
			save = new valueForDropdown();
			save.data = "2";
			save.label = "Save Validated";
			allowedSaves.addItem(save);
		}
	if (allowPost3)
		{
			save = new valueForDropdown();
			save.data = "3";
			save.label = "Save Approved";
			allowedSaves.addItem(save);
		}
	
	var sel:String = initXml.EX_DEFAULT_POST.toString();
	for each (var obj:valueForDropdown in allowedSaves)
	{
		if (obj.data === sel)
			comboDefaultSave.selectedItem = obj;
	}
			
}

// Remember the field with focus when we hide this screen
private function rememberFocusField():void
{
	if (this.focusManager)
		focusFieldMemory = this.focusManager.getFocus();
	else
		focusFieldMemory = null;
}
private function getRemberedFocusField():void
{
	if (focusFieldMemory)
		focusFieldMemory.setFocus();
}


