package visualComponents.GridComponents
{
	import mx.controls.CheckBox;
	import mx.controls.listClasses.BaseListData;

	public class OutputCheckbox extends CheckBox
	{
//		override public function get listData():BaseListData
		override public function set listData(value:BaseListData):void
		{
			super.listData = value;
			
			this.enabled = false;
			
			if (value && value.label != ""){
				this.selected = true;
			}
			else {
				this.selected = false;
			}
		}		
	}
}