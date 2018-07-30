package ecs.approval.approvalGridFields
{
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import flash.events.Event;
	


	public class ContribType extends DataGridItemRenderer
	{
		public static const c_staff:String = "Staff";
		
		public function ContribType()
		{
			super();
			
			// Make sure that this component is always rendered with red text
			// Otherwise the color will revert to black when the line selector
			// moves over it.
			this.addEventListener(Event.RENDER, doColours);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
			doColours();
		}
		
		private function doColours(event:Object = "" ):void
		{
			if (!data || !data.contributorType)
				return;
							
			if (data.contributorType == c_staff)
			{
				super.textColor = 0xFF0000;  // Red
				this.setStyle("color", 0xFF0000);
			}
			else
			{
				super.textColor = 0x000000; // Black
				this.setStyle("color", 0x000000);
			}
		}
		
		override public function set textColor(value:uint):void
		{
			super.textColor = value;
		}

		
		
	}
}