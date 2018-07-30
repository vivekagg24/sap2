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
	
		// output messages		
		if (XMLMessList) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
	}
            
	// return the history for the line selected
	public function getHistory(parent_wiid:String):XMLList
	{
		var outerLines:* = wsGetItemsToReport.Z_CAS_EXPENSES_REPORTING.lastResult.EXP_HISTORY.item;
		var lines:XMLList = wsGetItemsToReport.Z_CAS_EXPENSES_REPORTING.lastResult.EXP_HISTORY.item.(PARENT_WIID == parent_wiid);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	
	
	// return the notes for the line selected
	public function getNotes(parent_wiid:String):XMLList
	{
		var outerLines:* = wsGetItemsToReport.Z_CAS_EXPENSES_REPORTING.lastResult.EXPENSE_NOTES.item;
		var lines:XMLList = wsGetItemsToReport.Z_CAS_EXPENSES_REPORTING.lastResult.EXPENSE_NOTES.item.(PARENT_WIID == parent_wiid);			
		if (lines.length() > 0)
			return lines;
		else
			return null;
	}	