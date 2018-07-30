		package ecs.approval.approvalGridFields
{
/**************************************************************************************
 * heldDisplay
 * Itemrenderer shows a coloured checkbox indicating whether or not the payment 
 * is held
 * ************************************************************************************/
	import ecs.components.DataGridCheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.display.Graphics;
									  
	public class heldDisplay extends ecs.components.DataGridCheckBox
	{
		public function heldDisplay() {
			enabled = false;	//Not editable
		}
		
		override public function set visible(value:Boolean):void{
			//Hide if it is a batch or cost centre line
			if (data.batchLine||data.costCentreLine) super.visible=false;
			else super.visible = value;
		}
		
		override public function set data(value:Object):void {
			var colours:Array = new Array("#5d99dd", "#5d99dd");
			if (value != null) {
            	super.data = value;
            	
                // the parent DataGridColumn is passed as value before the real data arrives
                if (!(value is DataGridColumn)) {
                	selected = value.held;
                	//If it is held set the style to give a colour change and highlight the fact
                	if (value.held) {
                		setStyle("fillColors", colours);
                	} 
                }
       		}
		}
	}
}