/*	
Application: ECS Payment approval (desk head and managing editor)
Author: 	 DJ McNamara 
Date:		 March 2007

WebServiceCallBack.as: functions called by the web services when they have completed (asycnhronous SOAP)

	getSelScreenCallBack
		callback from web service wrapper for Z_ECS_GET_APPROVAL_SEL_SCREEN
		builds the dataproviders for the selection screen
		runs the report if drilling in from CAS
		
	getDataCallBack
		Called by the web service wrapper for Z_ECS_GET_APPROVAL_DATA
		Populates the data grid with the list of payments
		Updates the tab description if running in CAS	
	
	approveCallBack
		Callback from the web service wrapper for Z_ECS_APPROVE_CPRS
		Display messages in popup window
		Reselect data for grid	
	
	setDefaultsOnScreen
		Sets default fields on the screen, depending on the userid and publication
		
	queryCallBack
		Callback from placing (or cancelling) an item from qery	

/*
getSelScreenCallBack
	callback from web service wrapper for Z_ECS_GET_APPROVAL_SEL_SCREEN
	builds the dataproviders for the selection screen
	runs the report if drilling in from CAS
*/


import mx.managers.*;
import flash.events.Event;
import mx.core.UIComponent;
import mx.core.IUIComponent;
import flash.display.DisplayObject;
import mx.events.*;
import mx.core.IToolTip;
import mx.controls.ToolTip;
import flash.events.MouseEvent;
import mx.controls.ComboBase;
import mx.collections.ICollectionView;
import mx.collections.ListCollectionView;
import mx.controls.ComboBox;
import mx.controls.TextInput;
import mx.rpc.events.FaultEvent;
import mx.collections.XMLListCollection;
import ecs.generalClasses.LoaderPopup;

private function getSelScreenCallBack(result:Object):void {
	if (getPublications) {
		//Build dropdown list of publications (realistically only one)
		publications = buildDropdownList(new XML(ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult).CH_T_PUBLICATIONS, false);
		getPublications = false;
	}
	 
	//Default the publication if necessary 
	if (comboPubID.selectedIndex < 0)  comboPubID.selectedIndex = 0;
	
	//Build cost centre list (bound to list)
	costCentresXML = new XML(ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult).CH_T_COST_CENTRES;
	costCentres = buildDropdownList(costCentresXML, false);
	//Build batch list (bound to combobox)
	batches =  buildDropdownList(new XML(ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult).CH_T_BATCHES, true);
	//Build created by list (bound to combobox)
	createdByList =  buildDropdownList(new XML(ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult).CH_T_ENTERED_BY, true);
	
	//Set managing editor flag
	if (ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult.EX_MAN_EDITOR=="X"){
		managingEditor=true;
	}
	else{
		managingEditor=false;
	}
	
	// Set "interim approver only" flag
	if (ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult.EX_INTERIM_ONLY=="X")
	{
		interimDeskHeadOnly = true;
	}
	else
	{
		interimDeskHeadOnly = false;
	}
	
	//Cost centres passed in from CAS
	if (passedCCs == "") {
		selAllCostCentres(true);
	} else {
		// Selected cost centres have been passed to us. Only select those ones.
		selSpecificCostCentres();		
	}
	//Setup grid columns
	setUpGridColumns();
	dg.columns=columns;
	
	// Enable tooltips once data is refreshed
	dg.addEventListener(FlexEvent.UPDATE_COMPLETE,  function():void {	ToolTipManager.enabled = true; } , false, 0, true); 

	// Set up default valus
	var defaults:XML = new XML(ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult.EX_SCREEN_DEFAULTS);
	if (defaults && defaults.toString().length > 0)
	{
		setDefaultsOnScreen(defaults);
	}
	
	// If cost centres have been passed from Portal (from the Dashboard) 
	// then run the report
	if (passedCCs != "")
	{
		getData();
	}
	
	// Handle SAP System parameters
	
	for each (var param:XML in ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.lastResult.EX_T_SYS_PARAMS.item)
	{
		switch (param.CONFIG.toString())
		{
			// Parallel processing allowed?
			case "PARA":
				maxParallelProcesses = int(param.VALUE);
				if (maxParallelProcesses < 1)
					maxParallelProcesses = 1;  // Must have at least one process
				break;
			
			// Minimum job size when sending CPRs for approval in blocks, rather than all together
			// A value of 0 indicates that they should be sent all together
			case "JOBS":
				approvalJobSize = int(param.VALUE);
				
				break;
			
		}
	}
		

}

/*
	getDataCallBack
		Called by the web service wrapper for Z_ECS_GET_APPROVAL_DATA
		Populates the data grid with the list of payments
		Updates the tab description if running in CAS
*/
private function getDataCallBack(result:Object):void {	
	
	turnOffToolTips();	
	
	reportData = new XML(ws1.Z_ECS_GET_APPROVAL_DATA.lastResult).CH_T_REPORT;
	if (reportData.item.length()==0){
		Alert.show("No Payments were found matching the selection criteria.");	
	}
	//Updates the description for CAS
	ExternalInterface.call("TabDescription",String(reportData.item.length()));
	
	populateGridStructure();
	

	
	
} 

/**
 *  approveCallBack
	Callback from the web service wrapper for Z_ECS_APPROVE_CPRS
	Display messages in popup window
	Reselect data for grid
*/
private function approveCallBack(result:Object):void {
	
	var win:MessageDisplay;
	messages=result.EX_T_MESSAGES;
	this.enabled=true;
	win = MessageDisplay(PopUpManager.createPopUp(this,MessageDisplay,true));

	getData();
	
}

/**
 *  approveIterativeCallBack
	Callback from the web service iterative wrapper for Z_ECS_APPROVE_CPRS
	Display messages in popup window
	Reselect data for grid
*/
private function approveIterativeCallBack(combinedResult:Object):void
{	
	messages = new XMLList();
	var messagesWrapper:XMLListCollection = new XMLListCollection(messages);
	
	// Get all the messages from all the results
	var resultType:String;
	for each (var singleResult:Object in combinedResult)
	{
		resultType = singleResult.type.toString();
		if 	(resultType == "Result")
		{
			for each (var message:XML in singleResult.result..EX_T_MESSAGES)
			{
				messagesWrapper.addItem(message);
			}
		}
		
	}
	
	// Refresh the application
	this.enabled=true;
	var win:MessageDisplay;
	win = MessageDisplay(PopUpManager.createPopUp(this,MessageDisplay,true));

	getData();
	
}

/**
 *  approveIterativeCallBackPartial
	Callback from the web service iterative wrapper for Z_ECS_APPROVE_CPRS
	Called when one or more calls failed and one or more calls passed.
*/
private function approveIterativeCallBackPartial(combinedResult:Object):void
{
	approveIterativeCallBack(combinedResult);
	
	// We call the alert AFTER creating the message box so that the alert is shown on top
	Alert.show("The system failed part-way through processing the CPRs. Any payments which have disappeared from your screen have been successfully approved / rejected." + 
			  " The results that were returned before the error occured are shown. ");
	
}


private function turnOffToolTips():void {
	// Remove any active tooltips before refreshing the screen!
	// Also disable any more tooltips until the screen is refreshed!
	//
	// This is because, next time we move the mouse over an item with a tooltip, 
	// the ToolTipManagerImpl will try to move the tooltip from the old UIComponent
	// to the new one. If the old UIComponent isn't visible any more it throws a hissy fit.
	
	var toolTipImpl:IToolTipManager = ToolTipManagerImpl.getInstance();
	var toolTipImpl2:ToolTipManagerImpl = toolTipImpl as ToolTipManagerImpl;

	// Get the object who's tooltip this is (the object that we are hovering over)
	var tooTipTarget:DisplayObject = toolTipImpl.currentTarget;
	
	// Remove the tooltip
	if (tooTipTarget) 
	{
		// This is the safest way to make the tooltip disappear, as it makes the ToolTipManagerImpl
		// think that the mouse has moved, and resets all the internal variables of ToolTipManagerImpl properly
		var mouseOutEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT, true, false, 0, 0, null);
		tooTipTarget.dispatchEvent(mouseOutEvent);
		
		// And make sure no other events are triggered, just to be on the safe side (the null means unregister)
		toolTipImpl2.registerToolTip(tooTipTarget, null);  // Unregister any tooltip mouse-move handlers
	}	
	
	// Turn off tooltips
	ToolTipManager.enabled = false;
	
	// Don't forget to re-enable tooltips once the screen is updated
	
}	

private function setDefaultsOnScreen(defaults:XML):void
{
	var items:XMLList = defaults.item;
	for each (var x:XML in items)
	{
		var fname:String = x.FNAME.toString();
		var fval:String  = x.FVAL.toString();
		
		if (application.hasOwnProperty(fname))  // If this field exists
		{
			var field:Object = application[fname];
			
			// Check that the field is visible
			if (field is IUIComponent && !field.visible)
				continue;  
				
			// Application settings
			if (fname == "height" || fname == "width")
			{
				application[fname] = fval;
				
			}
			
			// Any text field
			if (field is TextInput && field.text != fval)  
			{
				// Change the value
				field.text = fval;
				// Tell any listeners that the value has changed
				(field as UIComponent).dispatchEvent(new Event(Event.CHANGE));				
			}	
			
			// RadioButton or Checkbox
			else if (field is Button) 
			{
				
				if (fval == 'X' || fval == 'TRUE' || fval == 'x' || fval == 'true')
				{
					
					if (field.selected != true)
					{
						// Change the value
						field.selected = true;
						// Tell any listeners that the value has changed
						(field as UIComponent).dispatchEvent(new Event(Event.CHANGE));	
					}					
					
				}
				else
				{
					if (field.selected != false)
					{
						// Change the value
						field.selected = false;
						// Tell any listeners that the value has changed
						(field as UIComponent).dispatchEvent(new Event(Event.CHANGE));	
					}
				}
				
						
			}
			
			// Combo box
			else if (field is ComboBox)
			{
				var dp:ListCollectionView = (field as ComboBase).dataProvider as ListCollectionView;
				if (dp)
				{
					var ind:int = -1;
					for (var j:int = 0; j < dp.length; j++)
					{
						var obj:Object = dp.getItemAt(j)
						if (obj.data == fval || obj.label == fval)
						{
							ind = j;
							j = dp.length; // Stop after we find the first one		
						}

					}
					
					if (ind > -1 && (field as ComboBox).selectedIndex != ind)
					{
						// Change the value
						(field as ComboBox).selectedIndex = ind;
						// Tell any listeners that the value has changed
						(field as ComboBox).dispatchEvent(new ListEvent(ListEvent.CHANGE));
					}

				}
				
			}
				
		}
		
	}
	
}




public function handleApproveCprsFault(event:FaultEvent):void
{	
	var alertMessage:String = "This operation has failed to complete successfully.";
	alertMessage += "Any payments which have disappeared from your screen have been successfully approved/rejected.";
	Alert.show(alertMessage); 
	this.enabled = true;	
	getData();	
}


