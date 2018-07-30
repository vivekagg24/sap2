package ecs.components
{
	import mx.controls.CheckBox;
	import ecs.generalClasses.MessageSuppression;
	
	
	public class SuppressableMessage extends Message
	{
		public var checkbox:CheckBox;
		
		private var _suppression:MessageSuppression;		
		
			
		public function SuppressableMessage(suppressed:MessageSuppression = null)
		{
			super();
			this._suppression = suppressed;
			this.setStyle("borderAlpha", 0.9); // Make the border darker so we can read the checkbox text
			
		}
		
		// Set / get suppression
		public function get suppression():MessageSuppression
		{
			return this._suppression;			
		}
		public function set suppression(val:MessageSuppression):void
		{
			// Note this message should never be passwed a null value
			_suppression = val;
			if (checkbox)			
				checkbox.selected = !(_suppression.suppression.valueOf());
		}
		
		
		
		/** Add an extra checkbox
		 */
		override protected function createChildren():void
		{
			super.createChildren();
			
			// Create checbkox if not already created
			checkbox = new CheckBox();
			checkbox.id = 'checkbox';
			checkbox.label = "Show this message next time";
			checkbox.setStyle("horizontalCenter", 0);
			if (_suppression)	
				checkbox.selected = !(_suppression.suppression.valueOf());				
			
			
			// Add it if not already added (getCheildIndex throws an error if it isn't a child
			try {
				var i:int = this.getChildIndex(checkbox);
			}
			catch (e:Error)
			{
				this.barBox.addChild(checkbox);
				this.barBox.setStyle("horizontalGap", 30);
			}				
		}
		
		// Close, and tell application whether mssage should stay suppressed
		override public function handleClose():void
		{
			super.handleClose();
			suppression.suppression = !checkbox.selected.valueOf();			
		}
		
		
	}
}