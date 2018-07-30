package ecs.approval.approvalGridFields
{
/**************************************************************************************
 * CPRChangedFlagDisplay
 * Itemrenderer shows a coloured checkbox indicating whether or not the payment 
 * has been it edited since it was created
 * ************************************************************************************/
	import ecs.components.DataGridCheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.display.Graphics;
	import mx.controls.listClasses.IDropInListItemRenderer;
	
	public class CPRChangedFlagDisplay extends ecs.components.DataGridCheckBox implements mx.controls.listClasses.IDropInListItemRenderer
	{
		
		public function CPRChangedFlagDisplay() {
			enabled = false; //Not editable
		}
		override public function set visible(value:Boolean):void{
			//Hide if it is a batch or cost centre line
			if (data.batchLine||data.costCentreLine) super.visible=false;
			else super.visible = value;
			
		}
		override public function set data(value:Object):void {
			var colours:Array = new Array("#fe6b60", "#fe6b60");
			if (value != null) {
            	super.data = value;
                // the parent DataGridColumn is passed as value before the real data arrives
                if (!(value is DataGridColumn)) {
                	selected = value.changed;
                	//If the payment has been changed then set the style to change the colour and highlight the fact
                	if (value.urgent) {
                		setStyle("fillColors", colours);
                	} 
                }
       		}
		}
	}
}