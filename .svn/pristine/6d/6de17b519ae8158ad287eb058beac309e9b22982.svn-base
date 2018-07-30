// ActionScript file - User Interaction
import mx.collections.XMLListCollection;
import events.DeleteEvent;
import flash.events.StatusEvent;
import components.ActivePassiveRenderer;
import flash.external.ExternalInterface;
import mx.controls.listClasses.BaseListData;
import mx.controls.DataGrid;

// Handle when the user adds an item
public function addSubstitute(xml:XML):void
{
	(dgMySubstitutions.dataProvider as XMLListCollection).addItem(xml);	
	
	setDirty(true);	
}

// Handle when the user clicks on the DELETE item
public function handleSubstituteDelete(event:DeleteEvent):void
{
	var row:int = event.listData.rowIndex - 1; // Since the table has a reader, index 0 is the header
	(dgMySubstitutions.dataProvider as XMLListCollection).removeItemAt(row);

	setDirty(true);		
}

// Handle when you switch from active to passive and back
public function setSubstituteStatus(_listData:BaseListData, _text:String):void
{
	var _owner:DataGrid = _listData.owner as DataGrid; 
	var _index:int = _listData.rowIndex + _owner.verticalScrollPosition - 1; // Take off 1 for the scroll header
	
	var o:Object; // object to change
	o = (_owner.dataProvider as XMLListCollection).getItemAt(_index) ; // take away 1 for header row
	if (_text != ActivePassiveRenderer.c_active && _text != ActivePassiveRenderer.c_passive)
		return; // should never happen
	
	o.ACTIVE_TXT = _text;
	o.ACTIVE_TXT  = _text;
	o.ACTIVE = convertActiveToSAP(_text);
	
	// Force setter to ensure binding is triggered
	(_owner.dataProvider as XMLListCollection).setItemAt(o, _index);

	setDirty(true);	
}

// True = unsaved data
public function setDirty(val:Boolean):void
{
	if (this.dirtyFlag != val)
	{
		this.dirtyFlag = val;
		ExternalInterface.call("setDirty", val);	
	}
}