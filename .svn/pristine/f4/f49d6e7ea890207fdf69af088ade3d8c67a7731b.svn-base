/*	
Application: ECS Payment approval (desk head and managing editor)
Author: 	 DJ McNamara 
Date:		 March 2007
	UserInteraction.as: functions to handle user interaction
	
	selAllCostCentres
		(de)select all cost centres in the list component
	showCPR
		Launch the iView to display a CPR
	confirmApprove
		User confirms approval  - if yes then run Approve function
	Approve
		approve the selected items
	addSelectedItems
		Add the items in a cost centre or batch to the XML structure to be passed to Z_ECS_APPROVE_CPRS
	addItem
		Add an item to the XML structure to be passed to Z_ECS_APPROVE_CPRS
		XML consists of key for document on SAP 
	newContributorConfirm
		Extra confirmation required if there is a new contributor in the selected payments
	showCPRPopup
		Show a CPR in a popup
	functionOnCPRLoad
		When the CPR popup has loaded, pass it the neccesary parameters
*/

/*

	selAllCostCentres
		(de)select all cost centres in the list component
*/
private function selAllCostCentres(all:Boolean):void {
	if (all) {
		var indices:Array = new Array();
		for (var i:int = 0; i < costCentres.length; i++) {
			indices[i] = i;
		}
		lstCostCentres.selectedIndices = indices;
	} else {
		lstCostCentres.selectedIndices = new Array();
	}
}

/*

	selSpecificCostCentres
		Select specific cost centres passed in from CAS
*/
private function selSpecificCostCentres():void {
	var indices:Array = new Array();
	var j:int = 0;
	for (var i:int = 0; i < costCentres.length; i++) {
		if (passedCCs.lastIndexOf('~' + costCentres[i].data) != -1) {
			indices[j++] = i;
		}
	}
	lstCostCentres.selectedIndices = indices;
}


/*
	showCPR
		Launch the iView to display a CPR
*/
public function showCPR(cpr:String,company:String,year:String):void{
	if (cpr==null ||cpr=="")return
	
	if (this.height >= 600)  // Enough room on screen, so open popup
	{
		var cprkey:CPRKey = new CPRKey();
		cprkey.docNo = cpr;
		cprkey.year = year;
		cprkey.company_code = company;
		cprkey.access_mode = "3";//Display
		showCPRPopup(cprkey);		
	}
	else  // Too small for popup, so open in new iview
	{
		var iviewURL:String="pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/com.ni.cis.ecs.ecsbspiviews/com.ni.cas.cis.ecs.iv_bsp_paymententry?mode=3";
		iviewURL+= "&cpr=" + cpr;
		iviewURL+= "&company=" + company;
		iviewURL+= "&year=" + year;
		ExternalInterface.call("portalNavigate",iviewURL,"1","toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50","cpr");
 		
	}

	

 }
		
/*
	confirmApprove
		User confirms approval  - if yes then run Approve function
*/			
private function confirmApprove():void{
	var confirmWindow:Confirm = Confirm(PopUpManager.createPopUp(this, Confirm, true));
	confirmWindow.question="Please confirm that you wish to approve the selected payments."
	confirmWindow.addEventListener("selectedYes", Approve, false, 0, true);
}	

/*
	Approve
		approve the selected items
*/
private function Approve(event:Event):void {
	// Check if anything selected.
	var newContributorFlag:Boolean = false;
	if (dp==null) return;
	arrSelected = new Array();
	
	// Loop through array
	for each (var levelOne:ApprovalTree in dp){
		if (!levelOne.isOpen){
			
			if (!managingEditor){
				//Desk head therefore add all payments for this cost centre
				addSelectedItems(arrSelected,levelOne.childList,newContributorFlag);
			}
			else{
				//ME has batches as well  - extra level in the hierarchy
				//Go through the children for this node
				for each (var levelTwo:ApprovalTree in levelOne.childList){
					//Batch line
					if (!levelTwo.isOpen) addSelectedItems(arrSelected,levelTwo.childList,newContributorFlag);
					//Payment line
					if (!levelTwo.batchLine && !levelTwo.costCentreLine) addItem(levelTwo,newContributorFlag);	
				}
			}	
		}
		//Payment line
		if (!levelOne.batchLine && !levelOne.costCentreLine) addItem(levelOne,newContributorFlag);	
	} 
	
	// Populate Web Service parameters and call it.
	if (arrSelected.length > 0) {
		if (newContributorFlag) newContributorConfirm();
		else submitApproval(null);
		
	} else {
		Alert.show("No CPRs currently selected for approval.");
	}
}

/*
	addSelectedItems
		Add the items in a cost centre or batch to the XML structure to be passed to Z_ECS_APPROVE_CPRS
*/
private function addSelectedItems(arrSelected:Array,items:ArrayCollection,newContributorFlag:Boolean):void{
	for each (var item:ApprovalTree in items) {
		 addItem(item,newContributorFlag);
	}
}

/*
	addItem
		Add an item to the XML structure to be passed to Z_ECS_APPROVE_CPRS
		XML consists of key for document on SAP 
*/
private function addItem(item:ApprovalTree,newContributorFlag:Boolean):void{
	if (item.selected == true) {
			// This row is selected for approval.
		var xmlCPR:XML = new XML("<item>" 
					+ "<BELNR></BELNR>"
					+ "<BUKRS></BUKRS>"
					+ "<GJAHR></GJAHR>"
					+ "</item>");
					
		xmlCPR.BELNR = item.cpr;
		xmlCPR.GJAHR = item.year;
		xmlCPR.BUKRS = item.company;
		arrSelected.push(xmlCPR);
		if (item.newContributor) newContributorFlag=true;
	}
}
					
/*
	newContributorConfirm
		Extra confirmation required if there is a new contributor in the selected payments
*/
private function newContributorConfirm():void{
	var confirmWindow:Confirm = Confirm(PopUpManager.createPopUp(this, Confirm, true));
	confirmWindow.question="The selcted payments contain a new contributor. Please confirm that you wish to approve the selected payments."
	confirmWindow.addEventListener("selectedYes", submitApproval);
}			


import mx.events.PropertyChangeEvent;
import mx.controls.SWFLoader;
import mx.managers.*;
import ecs.generalClasses.CPRKey;
import flash.events.IOErrorEvent;
import flash.events.Event;
import mx.events.FlexEvent;
import ecs.generalClasses.LoaderPopup;

private var popupCPR:LoaderPopup;      // Remember the popup so we can show it again
private var cprToShowInPopup:CPRKey; // Details of what to load

protected function preloadCPRPopup():void
{
	cprToShowInPopup = new CPRKey()
	cprToShowInPopup.access_mode = "3";// Display
	cprToShowInPopup.docNo = "";
	
	
	// Create invisible popup
	popupCPR = PopUpManager.createPopUp(this, LoaderPopup, true) as LoaderPopup;
	popupCPR.doClose();
	popupCPR.visible = false;
	
	// Start the loader
	var sl:SWFLoader = popupCPR.swfloader;
	sl.addEventListener(IOErrorEvent.IO_ERROR, function():void {Alert.show('Error displaying payment')} );
	sl.addEventListener(Event.COMPLETE, myFunc, false, 0, true);
	sl.load(swfmodule_cpr_entry);	
	
	PopUpManager.removePopUp(popupCPR);
	popupCPR = null;	
}
	


/** Load the CPREntry screen as a popup to display a CPR
 */
protected function showCPRPopup(cprToShow:CPRKey):void
{
	cprToShowInPopup = cprToShow; // Remember the details of the cpr we want to open so we can
	                              // pass it to CPREntry.swf when it has loaded
	
	trace("Opening CPREntry popup from approval screen  " + getTimer());
	if (popupCPR)
	{		
		popupCPR.visible = true;
		var ev:Event = new Event(Event.COMPLETE);
		PopUpManager.bringToFront(popupCPR);
		popupCPR.swfloader.dispatchEvent(ev); // Make it act like it just loaded itself
		resizeCPRPopup()
		popupCPR.title = "Edit payment " + cprToShow.docNo;
		
	}
	else
	{
		// show the popup
		var popup:LoaderPopup = PopUpManager.createPopUp(this, LoaderPopup, true) as LoaderPopup;
		PopUpManager.bringToFront(popup);		
		popup.visible = true;
					
		PopUpManager.centerPopUp(popup);
		PopUpManager.bringToFront(popupCPR);
		popup.y = 100;
		
		// Start the loader
		var sl:SWFLoader = popup.swfloader;
		sl.addEventListener(IOErrorEvent.IO_ERROR, function():void {Alert.show('Error displaying payment')} );
		sl.addEventListener(Event.COMPLETE, functionOnCPRLoad, false, 0, true);
		sl.load(swfmodule_cpr_entry);	
		
		popupCPR = popup;
		popupCPR.title = "Edit payment " + cprToShow.docNo;		
		resizeCPRPopup()
	}		
}

/** When we load the CPR, tell it what to do
 * 
 *  This method gets called twice, first when the popup is created and secondly
 *  when the swf is loaded and ready
 */
private function functionOnCPRLoad(event:Event):void
{
	if (popupCPR == null)
		return;
	
	var loaderSM:SystemManager = SystemManager(popupCPR.swfloader.content);
	if (loaderSM == null) return; 
	
	var cprApp:Object = loaderSM.application;
	if (cprApp == null) // If not ready yet, wait until its ready
	{
		loaderSM.addEventListener(FlexEvent.APPLICATION_COMPLETE, functionOnCPRLoad, false, 0, true);
		return;
	}
	
	trace("Passing parameters to CPREntry popup from approval screen  " + getTimer());
	cprApp.loadNewCPR(cprToShowInPopup.docNo, cprToShowInPopup.year, cprToShowInPopup.company_code, cprToShowInPopup.access_mode);
	cprApp.containing_popup_window = popupCPR; // Gives the CPR screen a reference to its containing popup
}

// Resize the CPR popup depending on the current application size
private function resizeCPRPopup():void
{
		if (!popupCPR) return;
	
		if (this.width > 1200)
			popupCPR.width = 1100;
		else
			popupCPR.width = this.width - 50;
			
		if (this.height > 900)			
			popupCPR.height = 800;
		else
			popupCPR.height = this.height - 100;	
		
		// Scroll back to top-left	
		popupCPR.verticalScrollPosition = 0;
		popupCPR.horizontalScrollPosition = 0;
}
	
private function myFunc(event:Event):void
{
	
}
{
	
}
