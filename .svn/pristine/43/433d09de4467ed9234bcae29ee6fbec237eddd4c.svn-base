package ecs.approval.approvalGridFields
{
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import ecs.generalClasses.ApprovalTree;

/** Item renderer for the Story line column, which also displays Cost Centres and 
 *  Batch numbers, depending on what kind of line it is.
 */
	public class StoryLine extends DataGridItemRenderer
	{
		public function StoryLine()
		{
			super();
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			this.setStyle("fontWeight","normal");
			
			// Set Cost Centre lines to "bold"
			if (value && value is ApprovalTree)
			{
				if (value.costCentreLine)
				{
					this.setStyle("fontWeight","bold");		
				}
					
				
			}
				
			
		}
		
		
	}
}