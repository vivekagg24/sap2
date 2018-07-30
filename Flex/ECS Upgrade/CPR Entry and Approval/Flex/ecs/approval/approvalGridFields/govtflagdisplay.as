package ecs.approval.approvalGridFields
{
/**************************************************************************************
 * newContributorDisplay
 * Itemrenderer shows a coloured checkbox indicating whether or not this is the first 
 * payment to this contributor
 * ************************************************************************************/
	import ecs.components.DataGridCheckBox;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.display.Graphics;
	
	public class govtflagdisplay extends ecs.components.DataGridCheckBox
	{
		public function govtflagdisplay() {
			enabled = false; //Not editable
		}
		override public function set visible(value:Boolean):void{
			//Hide checkbox if this is a cost centre or batch line
			if (data.batchLine||data.costCentreLine) super.visible=false;
			else super.visible = value;
			
		}
		override public function set data(value:Object):void {
			var colours:Array = new Array("#d1f1da","#d1f1da");
			if (value != null) {
            	super.data = value;
                // the parent DataGridColumn is passed as value before the real data arrives
                if (!(value is DataGridColumn)) {
                	
                	selected = value.Relation;
                	//Set the colour property if it is a new contributor, highlighting the fact
                	if (value.Relation) {
                		setStyle("fillColors",colours);
                	} 
                }
       		}
		}
	}
}