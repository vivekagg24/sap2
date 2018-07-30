package ecs.approval.approvalGridFields
{
/**************************************************************************************
 * urgentDisplay
 * Itemrenderer shows a coloured checkbox indicating whether or not the payment is urgent
 * ************************************************************************************/
	import ecs.components.DataGridCheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.display.Graphics;
	
	public class urgentDisplay extends ecs.components.DataGridCheckBox
	{
		public function urgentDisplay() {
			enabled = false; //Not editable
		}
		override public function set visible(value:Boolean):void{
			//Hidecheckbox if this is a batch or cost centre line
			if (data.batchLine||data.costCentreLine) super.visible=false;
			else super.visible = value;
			
		}
		override public function set data(value:Object):void {
			var colours:Array = new Array("#fe6b60", "#fe6b60");
			if (value != null) {
            	super.data = value;
                // the parent DataGridColumn is passed as value before the real data arrives
                if (!(value is DataGridColumn)) {
                	selected = value.urgent;
                	if (value.urgent) {
                		//If urgent then set colour to highlight the fact
                		setStyle("fillColors", colours);
                	} 
                }
       		}
		}
	}
}