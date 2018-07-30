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
	
		// output messages		
		if (XMLMessList) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
	}
            
	// return the history for the line selected
	public function getHistory(parent_wiid:String):XMLList
	{
		var outerLines:* = wsGetItemsToReport.Z_CAS_SRM_REPORTING.lastResult.HISTORY.item;
		var lines:XMLList = wsGetItemsToReport.Z_CAS_SRM_REPORTING.lastResult.HISTORY.item.(PARENT_WIID == parent_wiid);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	
	
	// return the notes for the line selected
	public function getNotes(parent_wiid:String):XMLList
	{
		var outerLines:* = wsGetItemsToReport.Z_CAS_SRM_REPORTING.lastResult.NOTES.item;
		var lines:XMLList = wsGetItemsToReport.Z_CAS_SRM_REPORTING.lastResult.NOTES.item.(PARENT_WIID == parent_wiid);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
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
	
		