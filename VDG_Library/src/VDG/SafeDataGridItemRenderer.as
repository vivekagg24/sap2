package VDG
{
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import flash.display.DisplayObjectContainer;
	import mx.managers.ToolTipManager;
	import flash.events.MouseEvent;

/** This class extends the normal DataGridItemRenderer, and also gets rid of the problem whereby
 *  if you change the data in the datagrid whilst hovering over another field. <br />
 *  
 *  This class can be used in isolation - you don't need to use it with other
 *  classes from this package.
 */  
	public class SafeDataGridItemRenderer extends DataGridItemRenderer
	{
		
		
		// This is a piece of code that Adobe should include in the standard DataGridItemRenderer.
		// If an item renderer is removed from the display while a tooltip is active, the 
		// ToolTipManager should be informed, otherwise it will cause errors later.	
		override public function parentChanged(p:DisplayObjectContainer):void		
		{ 		
			if (!p)
			{
				if (ToolTipManager.currentTarget == this)
				{
					var event:MouseEvent = new MouseEvent(MouseEvent.MOUSE_OUT);
					this.dispatchEvent(event);
				}
			}

			super.parentChanged(p);
		}
		
		
	}
}