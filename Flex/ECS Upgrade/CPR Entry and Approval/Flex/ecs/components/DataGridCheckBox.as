package ecs.components
{
	import mx.controls.Button;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.events.Event;
	import mx.controls.CheckBox;
	import mx.controls.dataGridClasses.DataGridListData;

// We need to break the namespace constraints to access the currentIcon property
// This is a bit naughty as it might not work in the next version of Flex
	import mx.core.mx_internal;
	use namespace mx_internal;

	public class DataGridCheckBox extends CheckBox
	{
		public function DataGridCheckBox()
		{						
			super();
			addEventListener(Event.CHANGE, updateData, false, 0, true);	
		}
		
		public var onValue:Object = true;
			public var offValue:Object = false;
			private var _value:* = false;
			
			public function set value(val:*) :void {
				_value = val;
				invalidateProperties();
			}
			
			public function get value():Object  {
				if (_value == undefined)
					return _value;
				else
					return selected ? onValue:offValue;
			}
			
			 
						
			
			override protected function commitProperties():void {
				if (_value != undefined)
					selected = (_value == onValue);
				
				if (this.enabled)
				{
					addEventListener(Event.CHANGE, updateData, false, 0, true);			
					trace("Add listener for checkbox " + this.uid);						
				}
				else
				{
					removeEventListener(Event.CHANGE, updateData, false);			
					trace("Remove listener for checkbox " + this.uid);							
				}
	
				super.commitProperties();
			}
			
			// Updates the data when user clicks
			public function updateData(event:Event):void
			{
				if (listData) {
					data[DataGridListData(listData).dataField] = value;
					trace("change event in datagridcheckbox " +  uid);
				}	
				else
				{
					trace("change event in datagridcheckbox but no listdata " + uid);
				}			
			}
	
			override public function set data(item:Object):void	{
				super.data = item;
				if (item != null) {
					value = item[DataGridListData(listData).dataField];
					
					var col:DataGridColumn = (listData.owner as DataGrid).columns[listData.columnIndex];
					
					if (item.hasOwnProperty("onQuery"))
					{
						if (item.onQuery)
						{
							this.enabled = false;						
						}
						else
						{
							this.enabled = col.editable;
						}						
					}

					
				}
			}
	
			override protected function updateDisplayList(unscaledWidth:Number,unscaledHeight:Number):void {
				super.updateDisplayList(unscaledWidth, unscaledHeight);
				if (currentIcon) {
					var style:String = getStyle("textAlign");
					if ((!label) && (style == "center" || style == "centre")) {
						currentIcon.x = (unscaledWidth - currentIcon.measuredWidth)/2;
					}
					currentIcon.visible = (_value!=undefined);
				}
			}
			
			public function set text(val:String):void {
				value = val;
			}
			
			public function get text():* {
				return value;
			}
			
		
		
	}
}