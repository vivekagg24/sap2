package VDG
{
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.listClasses.BaseListData;
	import flash.events.MouseEvent;
	import mx.managers.ISystemManager;
	import flash.display.DisplayObjectContainer;
	import mx.managers.ToolTipManager;
	import mx.core.IUIComponent;
	import mx.events.ToolTipEvent;

/** DataGridItemRenderer where the tooltip is set to the value of the contents
 *  Mainly used for column headers where you have lots of columns and can't fit
 *  them all on the screen full-size, so some of the header is lost.
 * 
 */
	public class TipRenderer extends DataGridItemRenderer
	{

		override public function set listData(value:BaseListData):void
		{
			super.listData = value;			
			super.toolTip = value.label;						
		}
		
		override public function set toolTip(value:String):void
		{
			// Since the validateProperties() method of the DataGridItemRenderer class removes tooltips, we
			// have prevent this happening by overriding this method and ignoring the external call.
			// This does mean that to set the toolTip from outside this class we have to use the
			// method below (set toolTipVDG)
					
		}	
		
		// Our own method for setting tooltips
		public function set toolTipVDG(value:String):void
		{
			super.toolTip = value;
		}
	
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