package VisualComponents
{
	import flash.geom.Rectangle;
	import mx.controls.listClasses.IListItemRenderer;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import mx.controls.*;
	import mx.controls.listClasses.*;
	import mx.managers.ISystemManager;
	import flash.display.Sprite;
	import mx.controls.listClasses.BaseListData;
	import flash.display.DisplayObject;
	import mx.events.ColorPickerEvent;
	import mx.events.*;
	import flash.utils.*;
	import mx.controls.dataGridClasses.*;
	import mx.core.*;


	public class ColourPickerRenderer extends ColorPicker implements IDropInListItemRenderer, IListItemRenderer
	{
		public function ColourPickerRenderer()
		{			
			super();
			this.addEventListener(ColorPickerEvent.CHANGE, colourChangeHandler, false, 6);
			
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0.0, useWeakReference:Boolean=false):void
		{
			super.addEventListener(type, listener);
		}
		
		protected var _listData:DataGridListData;
		public function get listData():BaseListData
		{
			return _listData;
		}
		
		public function set listData(value:BaseListData):void
		{
			_listData = DataGridListData(value);
			invalidateProperties();		
		}
		
		override protected function commitProperties():void
		{
			if (_listData)
			{
				var colour:uint = new Number(_listData.label) as uint;
				super.selectedColor = colour;				
			}			
		}
		
		override public function validateProperties():void
		{
			super.validateProperties();
			if (_listData)
			{
				var colour:uint = new Number(_listData.label) as uint;
				super.selectedColor = colour;				
			}		
		}
		
		private var _data:Object;
		public function get data():Object
		{
			return _data;
		}
		
		public function set data(value:Object):void
		{
			_data = value;
			dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));			
		}
		
		/** This is used by the DataGridColumn to get data from the component.
		 * 
		 *  We have to make sure the property "editorDataField" of the DataGridColumn is set 
		 *  to "color" (the default is "text").
		 * 
		 *  The text property of the ColorPicker is already used
		 */  
		public function get color():String
		{
			if (_listData)
				return _listData.label;
			else
				return null;			
		}
		
		
		protected function colourChangeHandler(event:ColorPickerEvent):void
		{
			if (_listData)
			{
				_listData.label = new String( event.color );				
			}
			if (_data && _listData.dataField)
			{
				_data[_listData.dataField] = new String( event.color );
			}
			var e:FlexEvent = new FlexEvent(FlexEvent.DATA_CHANGE, true, true);
					
			var e2:DataGridEvent = new DataGridEvent(DataGridEvent.ITEM_EDIT_END,
			                                 true,
			                                 true,
			                                 _listData.columnIndex,
			                                 _listData.dataField,
			                                  _listData.rowIndex, 
											 DataGridEventReason.NEW_ROW,
											 this);
			this.dispatchEvent(e);
			this.dispatchEvent(e2);		
			var m:* = describeType(data);							 
			
		}
		
		
	}
}