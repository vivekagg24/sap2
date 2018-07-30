// ActionScript file
// Handles processing (approval and rejection) of retainer contracts

import mx.managers.PopUpManager;
import mx.core.IFlexDisplayObject;
import flash.events.Event;
import mx.collections.XMLListCollection;
import mx.core.Repeater;
import mx.controls.DataGrid;
import mx.collections.ICollectionView;
import visualComponents.TableOutput;
import mx.core.IUIComponent;
import mx.core.Container;
import mx.events.DynamicEvent;
import mx.managers.CursorManager;

	public function processingReturned(event:ResultEvent):void {
		// We have the result of a rejection or an approval back from SAP
		var b:XML = new XML(event.result[0]);
		var d:String;
		var XMLMessList:XMLList;
	
		if (event.target.service == "Z_CAS_EXPENSES_APPROVEService") {
			XMLMessList = wsDoApprove.Z_CAS_EXPENSES_APPROVE.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_CAS_EXPENSES_REJECTService") {
			XMLMessList = wsDoReject.Z_CAS_EXPENSES_REJECT.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_CAS_EXPENSES_HOLDService") {
			XMLMessList = wsDoHold.Z_CAS_EXPENSES_HOLD.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_CAS_EXPENSES_UNHOLDService") {
			XMLMessList = wsDoUnHold.Z_CAS_EXPENSES_UNHOLD.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_HR_CAS_TRAVEL_EXPService") {
			XMLMessList = wsShowExpense.Z_HR_CAS_TRAVEL_EXP.lastResult.ES_RETURN.item;		
		}
		
		// output messages		
		if (XMLMessList) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
		if (event.target.service == "Z_CAS_EXPENSES_REJECTService" || event.target.service == "Z_CAS_EXPENSES_APPROVEService"){
			doRefresh();			
		}
	}
            
	public function doApprove():void {
       	wsDoApprove.Z_CAS_EXPENSES_APPROVE.request.ITEMS = getSelected();
       	var Item_Lines:Array = getSelectedItems();
		var notHold:Boolean = true;
		var lineCount:int = 0;

	    // check that no line items have been selected for rejection
	    if (Item_Lines && Item_Lines.length > 0) {	    	
	    	Alert.show("Line items selected for rejection, please remove before approving");
	    }
	    else {
	       	for each (var x:XML in wsDoApprove.Z_CAS_EXPENSES_APPROVE.request.ITEMS)
    	   	{
       			lineCount = lineCount + 1;
       			var onHold:String = x.RESUB;
	       		if (onHold != '')
    	   		{
					notHold = false;
       			} 
	       	}
			if (lineCount == 0) {
				Alert.show("Please select at least 1 item to approve");
			}
			else if (notHold == true) {
				var event:DynamicEvent = new DynamicEvent("collapseAll", true);		
				this.dispatchEvent(event);
        	   	wsDoApprove.Z_CAS_EXPENSES_APPROVE.send();  	
		    }
			else
	    	{
	   			Alert.show("Please remove any items on hold before approving");
		    }		    	
	    }
	}
            
	public function doReject():void {
		CursorManager.setBusyCursor();
    	wsDoReject.Z_CAS_EXPENSES_REJECT.request.ITEMS = getSelected();
       	wsDoReject.Z_CAS_EXPENSES_REJECT.request.ITEM_DETAIL = getSelectedItems();
		var reason:Boolean = true;
		var notHold:Boolean = true;
		var lineCount:int = 0;

	    // check the reason text has been set for the line items
	    for each (var w:XML in wsDoReject.Z_CAS_EXPENSES_REJECT.request.ITEM_DETAIL) {
	    	var lineRejectReason:String = w.APPREJTEXT;
       		if (lineRejectReason == '')
       		{
				reason = false;
       		}     		
	    }
	    
       	for each (var x:XML in wsDoReject.Z_CAS_EXPENSES_REJECT.request.ITEMS)
       	{
       		lineCount = lineCount + 1;
       		var rejectReason:String = x.APPREJTEXT;
			var onHold:String = x.RESUB;
       		if (rejectReason == '')
       		{
				reason = false;
       		} 
       		if (onHold != '')
       		{
				notHold = false;
       		}
       	}
		if (lineCount == 0) {
			Alert.show("Please select at least 1 item to reject");
		}
		else if (reason == true && notHold == true) {
			var event:DynamicEvent = new DynamicEvent("collapseAll", true);		
			this.dispatchEvent(event);			
       		wsDoReject.Z_CAS_EXPENSES_REJECT.send();  	
	    }
	    else if (reason != true)
	    {
	   		Alert.show("You must enter a reason for all items being rejected");
	    }
	    else
	    {
	   		Alert.show("Please remove any items on hold before rejecting");
	    }  
	    CursorManager.removeBusyCursor();       	
	}	     

	private function getSelected():Array {
    // Get selected items
       	var selectedItems:Array = new Array();
       	var allItems:XMLList = new XMLList(wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.HEADERS.item);

       	for each (var x:XML in allItems)
       	{
       		var selected:String = x.APPREJ;
       		if (selected == 'X')
       		{
       			var y:XML = new XML("<item/>");
          			y.WIID = x.WIID;
           			y.APPREJTEXT = x.APPREJTEXT; 
           			y.SUBSTITNAM = x.SUBSTITNAM;         			
           			y.UNAME = x.UNAME; 
					y.PERNR = x.PERNR;
           			y.CLAIM_NO = x.CLAIM_NO; 
           			y.RESUB = x.RESUB; 
           			selectedItems.push(y);
       		} 
       	}
       	return selectedItems;     	
    } 

	private function getSelectedItems():Array {
    // Get selected items
       	var selectedItems:Array = new Array();
       	var allItems:XMLList = new XMLList(wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.ITEMS.item);

       	for each (var x:XML in allItems)
       	{
       		var selected:String = x.APPREJ;
       		if (selected == 'X')
       		{
        			var y:XML = new XML("<item/>");
          			y.WIID = x.WIID;
					y.RECEIPTNO = x.RECEIPTNO;
					y.APPREJ = x.APPREJ;
           			y.APPREJTEXT = x.APPREJTEXT; 
           			y.CLAIM_NO = x.CLAIM_NO; 
           			selectedItems.push(y);
       		} 
       	}
       	return selectedItems;
    } 
                      		
	public function onSelectAll(event:DynamicEvent):void {
		// First of all, which component was clicked?
		var grid:DataGrid = event.grid;
		if (!grid) return;				
				
		var repeaterContainer:Container = grid.parent.parent.parent.parent as Container;
				
		// Now do the expand
		for each (var component:IUIComponent in repeaterContainer.getChildren())
		{
			var t_o:TableOutput = component as TableOutput;
			if (t_o)
			{
				t_o.selectLine_header();
			}
		}
	} 

	public function onDeselectAll(event:DynamicEvent):void {
		// First of all, which component was clicked?
		var grid:DataGrid = event.grid;
		if (!grid) return;				
				
		var repeaterContainer:Container = grid.parent.parent.parent.parent as Container;
				
		// Now do the expand
		for each (var component:IUIComponent in repeaterContainer.getChildren())
		{
			var t_o:TableOutput = component as TableOutput;
			if (t_o)
			{
				t_o.deSelectLine();
			}
		}
	} 

	private function onExpandAll(event:DynamicEvent):void {
		CursorManager.setBusyCursor();
		// First of all, which component was clicked?
		var grid:DataGrid = event.grid;
		if (!grid) return;				
				
		var repeaterContainer:Container = grid.parent.parent.parent.parent as Container;
			
		// Now do the expand
		for each (var component:IUIComponent in repeaterContainer.getChildren())
		{
			var t_o:TableOutput = component as TableOutput;	
			var l_dg_dgmain:DataGrid = t_o.DGmain;
			var data:XML = (l_dg_dgmain.dataProvider as XMLListCollection).getItemAt(0) as XML;
			
			if (t_o && t_o.allItems[0])
			{
				t_o.expand();
				data.expand = "true";
			}
		}
		CursorManager.removeBusyCursor();
	}
			
	private function onCollapseAll(event:DynamicEvent):void	{
		CursorManager.setBusyCursor();			
				
		// var repeaterContainer:Container = grid.parent.parent.parent.parent as Container;
		var repeaterContainer:Container = repeateContainer as Container;
		
		// Now do the expand
		for each (var component:IUIComponent in repeaterContainer.getChildren())
		{
			var t_o:TableOutput = component as TableOutput;
			var l_dg_dgmain:DataGrid = t_o.DGmain;
			var data:XML = (l_dg_dgmain.dataProvider as XMLListCollection).getItemAt(0) as XML;			
			if (t_o)
			{
				t_o.collapse();
				data.expand = "false";
			}
		}
		CursorManager.removeBusyCursor();
	}			
            	
	// call the web service to put the item on hold
	public function setOnHold(WIID:String, holduntil:String, holdtext:String):void
	{
		holdWIID = WIID;
		holdDate = holduntil;
		holdReason = holdtext;
		wsDoHold.Z_CAS_EXPENSES_HOLD.send();
	}
		
	// call the web service to take the item off hold
	public function setOnUnHold(WIID:String, holduntil:String, holdtext:String):void
	{
		holdWIID = WIID;
		holdDate = holduntil;
		holdReason = holdtext;			
		wsDoUnHold.Z_CAS_EXPENSES_UNHOLD.send();
	}	
		
	// return the history for the line selected
	public function getHistory(claim_no:String):XMLList
	{
		var outerLines:* = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_HISTORY.item;
		var lines:XMLList = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_HISTORY.item.(CLAIM_NO == claim_no);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	
	
	// return the notes for the line selected
	public function getNotes(parent_wiid:String):XMLList
	{
		var outerLines:* = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_NOTES.item;
		var lines:XMLList = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_NOTES.item.(PARENT_WIID == parent_wiid);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	

	// return the claimant details for the line selected
	public function getClaimantDetails(parent_wiid:String):XMLList
	{
		var outerLines:* = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_NOTES.item;
		var lines:XMLList = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_NOTES.item.(PARENT_WIID == parent_wiid);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}
	
	// return the notes for the line selected
	public function getLineNotes(parent_wiid:String, receiptNo:String):XMLList
	{
		var outerLines:* = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_LINE_NOTES.item;
		var lines:XMLList = wsGetItemsToApprove.Z_CAS_EXPENSES_GET_ITEMS.lastResult.CLAIM_LINE_NOTES.item.(WIID == parent_wiid && RECEIPTNO == receiptNo);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	
	
	// call the web service to display the expense claim
	public function showExpenses(claim_no:String, personnel_no:String):void
	{
		expenseClaimNo = claim_no;
		expensePernr = personnel_no;
		wsShowExpense.Z_HR_CAS_TRAVEL_EXP.send();
	}		