package visual
{
	
	// Known bugs
	// 1 - If you tab into the field and edit it, thenwhen you exit the field it doesn't
	//     save the value
	
	import mx.controls.dataGridClasses.DataGridItemRenderer;
	import mx.controls.TextInput;
	import flash.events.Event;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.dataGridClasses.DataGridListData;

	public class TimeRenderer extends TextInput
	{
		
		public function TimeRenderer():void		
		{
			super();
			this.addEventListener(Event.CHANGE, textChecker);
			this.text = "00:00";
		}
		
		override public function set listData(value:BaseListData):void
		{
			super.listData = value;
			this.text = value.label;
			// Now fix the text
			textChecker(new Event("Dummy"));
		}
			
		
		
		/** Always ensure the time is formatted as hh:mm
		 * 
		 */
		public function textChecker(event:Event):void
		{
			var value:String = this.text;
			var cursor_pos:int = this.selectionBeginIndex;
			var old_cursor_pos:int = cursor_pos;
			var characters_removed:int = 0;
			
			// Initialise
			if (value.length == 0)
			value = "00:00";		
			
			// Make sure its no more than 5 characters
			if (value.length > 5)  value = value.substr(0,5); 
			
			// Do some quick validation to remove illegal characters
			for (var i_1:int = 0; i_1 < value.length; i_1++)
			{
				var t:String = value.substr(i_1, 1);
				if (!isNumeric(t))
				{
					if (t == ":" && i_1 == 2) // The only time we allow a non-numeric characeter is when its a colon in the 3rd character
					{
						// Do nothing						
					}
					else // Remove the illegal character
					{

						if (i_1 == value.length - 1) // Is it the last character
						{
							value = value.substr(0, i_1)
						}							
						else	
						{
							var m:String = value.substr(0, i_1);
							var n:String = value.substring(i_1 +1 , value.length)
							var n1:String = value.substring(i_1 + 1, i_1 + 1);
							var n2:String = value.substring(i_1 + 1, i_1 + 2);
							value =  m + n;
							
						}
						if ( t != ":" || i_1 != 3 || old_cursor_pos <3 )								
						{
							characters_removed ++; // Move the cursor left
						}							
						i_1--;						
					}
				}
			}		
						
			// Add a colon at character 3 if there isn't one
			switch (value.length)
			{
				case 0:
					value = "00:00";					
					break;
				case 1:
					value = value + "0:00";					
					break;
				case 2:
					value = value + ":00";
					break;
				case 3:
					if (value.substr(2,1) == ":")
					{
						value = value + "00";
					}
					else
					{
						value = value.substr(0,2) + ":" + value.substr(2,1)
						characters_removed--; // We've added a character before the cursor, so shift sursor right
					}
					break;
				case 4:
					if (value.substr(2,1) == ":")
					{
						value = value + "0";
					}
					else
					{
						value = value.substr(0,2) + ":" + value.substr(2,2)
						characters_removed--; // We've added a character before the cursor, so shift sursor right
					}
					break;				
				case 5:
					if (value.substr(2,1) == ":")
					{
						// Do nothing
					}
					else
					{
						// Add a colon and chop off the last character
						value = value.substr(0,2) + ":" + value.substr(2,2)
					}
					break;							
			}				
			
			super.text = value;
			if (this.listData)
			{ 
				listData.label = value;
/* 				if (listData is DataGridListData;
				{
					var _ld:DataGridListData = listData as DataGridListData;
					this.data[listData.
				} */
				
			}
			
			cursor_pos = old_cursor_pos - characters_removed;
			this.selectionBeginIndex = cursor_pos;
			this.selectionEndIndex = cursor_pos;
			
			
			// Make sure its a valid time
			validateTime();
		}
		
		/** Validates whetehr a one-character string is a number 
		 */
		private function isNumeric(v:String):Boolean
		{
			if (v >= "0" && v <= "9")
				return true;
			else
				return false;
		}
		
		public function validateTime():void
		{
			// We can assume we have a 5-character field padded with 0's
			var invalid:Boolean = false
			
			if (this.text.length < 5) invalid = true;
			
			// Validate the hour	
			if (getHour(text) > 23) invalid = true;
			
			// Validate the minutes
			if (getMinute(text) > 59) invalid = true;
			
			
			if (invalid)
				this.setStyle("color", "red");
			else
				this.setStyle("color", "black");
			
		}
		
		
		
		public static function getHour(val:String):int
		{
			var s:String = val.substr(0,2);
			var n:Number = new Number(s);
			var i:int = int(n);
			return i;			
		}

		public static function getMinute(val:String):int
		{
			var s:String = val.substr(3,2);
			var n:Number = new Number(s);
			var i:int = int(n);
			return i;			
		}		
		
	}
}