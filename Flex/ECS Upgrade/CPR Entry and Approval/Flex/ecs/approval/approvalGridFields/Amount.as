package ecs.approval.approvalGridFields
{
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.Text;

	public class Amount extends Text
	{
		
		override public function set data(value:Object):void {
			var colours:Array = new Array("#5d99dd", "#5d99dd");
			if (value != null) {
            	super.data = value;
            	
                // the parent DataGridColumn is passed as value before the real data arrives
                if (!(value is DataGridColumn)) {
                	
                	//If it is held set the style to give a colour change and highlight the fact
                	
                	if (value.highlightRow) {
                		setStyle("fillColors", colours);
                	} 
                }
       		}
		}
		
	}
}