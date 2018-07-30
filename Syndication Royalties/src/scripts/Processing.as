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

    
  
                             
	public function processingReturned(event:ResultEvent):void {
		// We have the result of a rejection or an approval back from SAP
		var b:XML = new XML(event.result[0]);
		var d:String;
		var XMLMessList:XMLList;
	
		if (event.target.service == "Z_CAS_ROY_APPROVEService") {
			XMLMessList = wsDoApprove.Z_CAS_ROY_APPROVE.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_CAS_ROY_REJECTService") {
			XMLMessList = wsDoReject.Z_CAS_ROY_REJECT.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_CAS_ROY_HOLDService") {
			XMLMessList = wsDoHold.Z_CAS_ROY_HOLD.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "Z_CAS_ROY_UNHOLDService") {
			XMLMessList = wsDoUnHold.Z_CAS_ROY_UNHOLD.lastResult.RE_T_MESSAGES.item;
		}
		
		// output messages		
		if (XMLMessList) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
		if (event.target.service != "Z_CAS_ROY_HOLDService" && event.target.service != "Z_CAS_ROY_UNHOLDService"){
			doRefresh('X');			
		}
	}
            
	public function doApprove():void {
       	wsDoApprove.Z_CAS_ROY_APPROVE.request.ITEMS = getSelected();   
       	var reason:Boolean = true;    
		var notHold:Boolean = true;
		var lineCount:int = 0;
      	for each (var x:XML in wsDoApprove.Z_CAS_ROY_APPROVE.request.ITEMS)
       	{
			lineCount = lineCount + 1;
     		var ApproveReason:String = x.APPREJTEXT;
       		var onHold:String = x.RESUB;
       		reason = true;
       		notHold = true;
       		//if (ApproveReason == '')
       		//{
			//	reason = false;
       		//} 
       		//if (onHold != '')
       		//{
			//	notHold = false;
       		//} 
       	}
		if (lineCount == 0) {
			Alert.show("Please select at least 1 item to approve");
		}
		else if (reason == true && notHold == true) {
           	wsDoApprove.Z_CAS_ROY_APPROVE.send();               	   
           }
		//else if (reason != true)
	    //{
	   	//	Alert.show("You must enter a reason for all items being approved");
	    //}
		else
		{
	   		Alert.show("Please remove any items on hold before approving");
		}
	}
            
	public function doReject():void {
		wsDoReject.Z_CAS_ROY_REJECT.request.ITEMS = getSelected();
		var reason:Boolean = true;
		var notHold:Boolean = true;
		var lineCount:int = 0;
       	for each (var x:XML in wsDoReject.Z_CAS_ROY_REJECT.request.ITEMS)
       	{
       		lineCount = lineCount + 1;
       		var rejectReason:String = x.APPREJTEXT;
			var onHold:String = x.RESUB;
			notHold == true;
       		if (rejectReason == '')
       		{
				reason = false;
       		} 
       		//if (onHold != '')
       		//{
			//	notHold = false;
       		//}
       	}
		if (lineCount == 0) {
			Alert.show("Please select at least 1 item to reject");
		}
		else if (reason == true && notHold == true) {
           	wsDoReject.Z_CAS_ROY_REJECT.send();           	
 	    }
	    else if (reason != true)
	    {
	   		Alert.show("You must enter a reason for all items being rejected");
	    }
	    //else
	    //{
	   	//	Alert.show("Please remove any items on hold before rejecting");
	    //}
	}	     
    
      
	private function getSelected():Array {
		// Get selected items
      	var selectedItems:Array = new Array();
       	var allItems:XMLList = new XMLList(wsGetItemsToApprove.Z_CAS_ROY_GET_ITEMS.lastResult..item);  
       	for each (var x:XML in allItems)
       	{
       		var selected:String = x.APPREJ;
       		if (selected == 'X')
       		{
       			var y:XML = new XML("<item/>");
       			y.PARENT_WIID   = x.PARENT_WIID;
       			y.WIID          = x.WIID;
       			y.APPREJTEXT    = x.APPREJTEXT; 
       			y.INIT_APPROVER = x.INIT_APPROVER;
       			y.BELNR         = x.BELNR;
       			y.BUKRS         = x.BUKRS;
       			y.GJAHR         = x.GJAHR;        			
       			       		
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
				t_o.selectLine();
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
		// First of all, which component was clicked?
		var grid:DataGrid = event.grid;
		if (!grid) return;				
				
		var repeaterContainer:Container = grid.parent.parent.parent.parent as Container;
//		var l_children:* = repeaterContainer.getChildren();				
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
	}
			
	private function onCollapseAll(event:DynamicEvent):void	{
		// First of all, which component was clicked?
		/* var grid:DataGrid = event.grid;
		if (!grid) return;	 */			
				
		//var repeaterContainer:Container = grid.parent.parent.parent.parent as Container;
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
	}			
            	
	// call the web service to put the item on hold
	public function setOnHold(WIID:String, holduntil:String, holdtext:String):void
	{
		holdWIID = WIID;
		holdDate = holduntil;
		holdReason = holdtext;
		wsDoHold.Z_CAS_ROY_HOLD.send();
	}
		
	// call the web service to take the item off hold
	public function setOnUnHold(WIID:String, holduntil:String, holdtext:String):void
	{
		holdWIID = WIID;
		holdDate = holduntil;
		holdReason = holdtext;			
		wsDoUnHold.Z_CAS_ROY_UNHOLD.send();
	}	
		
	// return the history for the line selected
	public function getHistory(BELNR:String):XMLList
	{
		var outerLines:* = wsGetItemsToApprove.Z_CAS_ROY_GET_ITEMS.lastResult.ROY_HISTORY.item;
		var lines:XMLList = wsGetItemsToApprove.Z_CAS_ROY_GET_ITEMS.lastResult.ROYALTY_HISTORY.item.(INVOICE == BELNR);	
	
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	