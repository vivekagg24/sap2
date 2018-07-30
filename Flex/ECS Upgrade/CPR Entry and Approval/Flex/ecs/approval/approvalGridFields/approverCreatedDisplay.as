package ecs.approval.approvalGridFields
/**************************************************************************************
 * approverCreatedDisplay
 * Itemrenderer shows a coloured checkbox indicating whether or not the person 
 * approved the payment at desk head level also created the payment.
 * ************************************************************************************/
{
	import ecs.components.DataGridCheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.display.Graphics;
	import ecs.generalClasses.StringHelper;
	public class approverCreatedDisplay extends ecs.components.DataGridCheckBox
	{

		public function approverCreatedDisplay() {
			enabled = false; // Not editable
		}
		override public function set visible(value:Boolean):void{
			//Hide if it is a batch line or cost centre line
			if (data.batchLine||data.costCentreLine) super.visible=false;
			else super.visible = value;
			
		}
		
		override public function set data(value:Object):void {
			var colours:Array = new Array("#fee960","#fee960");
			var strHelper:StringHelper = new StringHelper();
			
			if (value != null) {
            	super.data = value;
            	
                // the parent DataGridColumn is passed as value before the real data arrives
                if (!(value is DataGridColumn)) {
                	selected = value.approver;
                	//If the value is true - i.e. approver created the payment then apply the style to change the colour
                	if (value.approver) {
                		setStyle("fillColors",colours);
                	} 
                }
       		}
		}
	}
}