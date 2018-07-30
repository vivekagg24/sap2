package visualComponents.GridComponents
{
	import mx.controls.CheckBox;
	import mx.controls.listClasses.BaseListData;
	import flash.events.Event;
	import mx.controls.Alert;
	import mx.controls.dataGridClasses.DataGridListData;

	public class EditableCheckbox extends CheckBox
	{
		// Constructor
		public function EditableCheckbox():void
		{
			super();
			this.addEventListener(Event.CHANGE, _onChange);
		}
		
		override public function set listData(value:BaseListData):void
		{
			super.listData = value;
			
			if (value && value.label == "X"){
				this.selected = true;
			}
			else {
				this.selected = false;
			}
		}
		
 		// When data changes, update data provider
		protected function _onChange(event:Event):void
		{	
			if (listData)
			{				
				if (this.selected)
				{
					listData.label = 'X';					
				}
				else
				{
					listData.label = ' ';
				}
				var ld:DataGridListData = listData as DataGridListData;
				if (ld)
				{
					this.data[ld.dataField] = listData.label;
				}		
			}
		}
	}
}