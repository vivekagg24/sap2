package ni.components
{
	import mx.controls.TextInput;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;

/* A SelectableTextInput is a Text Input field whose text can always be selected, even if 
   the field cannot be edited. This allows uses to copy values from this field even if it is not
   editable.
   
   When the field is greyed out, you have to use the mouse to select the field, since 
   you can't tab to it. Once you have selected the field, you can copy its contents 
   using the keyboard or mouse as normal.
*/
	public class SelectableTextInput extends TextInput
	{
		public function SelectableTextInput()
		{
			super();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			textField.addEventListener(MouseEvent.MOUSE_DOWN, handler1);
			textField.addEventListener(MouseEvent.CLICK, handler1);	
			textField.addEventListener(KeyboardEvent.KEY_UP, handler1);
		}
		
		
		/* We don't want the event to propagate as that will remove the focus from this field. 
		  The flash player focuses on the text field when we click on it, and then the 
		  Flex componets remove focus from our textbox, which we don't want to happen. 
		*/
		protected function handler1(event:Event):void
		{
			if (!enabled)
				event.stopImmediatePropagation();
		}

			
		
		
		/* Function called during a change - causes the textField to stay selecteable and editable
		
		*/
		private function doit():void 
		{
			if (textField)
			{
				textField.selectable = true;
				textField.enabled = true;

			}				
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();			
			doit();
			
		}
		
		override public function set editable(value:Boolean):void
		{
			super.editable = value;
			doit();
		}
		
		override public function set enabled(value:Boolean):void
		{
			super.enabled = value;
			doit();
		}	
		
	}
}