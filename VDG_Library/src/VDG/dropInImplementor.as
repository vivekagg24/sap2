// ActionScript file
// Include this file in all your item renderers (including headers) which don't already implement
// the interface mx.controls.listClasses.IDropInListItemRenderer if you want to use
// the gradual resizing effects.

// Note that a lot of UIComponents, such as Label, Text and Button, as well as DataGridItemRenderer, already
// implement this interface, so you don't need to include this file

protected var _listData:mx.controls.listClasses.BaseListData;

public function set listData(value:mx.controls.listClasses.BaseListData):void {
	_listData = value;	
}

public function get listData():mx.controls.listClasses.BaseListData {
	return _listData;	
}