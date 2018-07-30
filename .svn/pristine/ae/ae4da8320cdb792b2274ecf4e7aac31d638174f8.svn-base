package
{
	import flash.events.Event;
	import flash.text.TextFieldType;
	
	import mx.controls.listClasses.BaseListData;
	import mx.events.CollectionEvent;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.managers.IFocusManagerComponent;
	import mx.core.UITextField;
	import mx.collections.XMLListCollection;
	import flash.events.FocusEvent;
	import flash.utils.getTimer;
	import mx.core.UIComponent;
	import mx.collections.ICollectionView;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	

	public class FastGridCell extends UITextField implements IDropInListItemRenderer, IFocusManagerComponent
	{
		include "focusableInclude.as";
				

		
		public function FastGridCell():void
		{
			super();
			this.addEventListener(Event.CHANGE, changeHandler, false, 0, true);		
			this.addEventListener(FocusEvent.FOCUS_OUT, updateDP, false, 0, true);
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHander, false, 5);
				
			this.isHeader = this._isHeader; // Call setter method to define styles			
			super.useRichTextClipboard = true; 
			super.multiline = true;		
			this.backgroundColor = 0xFFFFFF;	
			this.background = true;	
			this.border = true;
			this.borderColor = 0x999999;
			
			selectable = true;
			focusRect = true;
			tabEnabled = true;
	
		}
		
		// Link to main grid (don't need to make this bindable as its only set once, so
		// ignore the compile-time warnings)		
		public var topGrid:ShiftGrid;
		

		

		
		public static const DEFAULT_MEASURED_WIDTH:Number = 50;
		public static const DEFAULT_MAX_WIDTH:Number = 50;
			
		// Is this cell a column/row header	
		protected var _isHeader:Boolean = false;
		public function get isHeader():Boolean
		{
			return _isHeader;
		}
		public function set isHeader(val:Boolean):void
		{
			_isHeader = val;
			if (isHeader)
			{
				//this.editable = false;
				this.selectable = false;
				super.type = TextFieldType.DYNAMIC;
				this.enabled = false;
				//this.focusEnabled = false;					
				this.setStyle("borderStyle", "inset");	
			}
			else
			{
				this.selectable = true;
				super.type = TextFieldType.INPUT;
				this.enabled = true;
				//this.focusEnabled = true;	
				this.setStyle("borderStyle", "inset");	
			}


		}
		
		
		/** Use some of the attributes of the DATA object to set 
		 *  colour and formatting
		 */
		public function set data(value:Object):void
		{
					
			if (!value) return;
			
			var s:String;
			var n:Number;
			
			// Set colour
	 		if (value.color)
			{
				var checker:String = value.color;
				if (checker.length > 0)
				{
					var ui:uint = uint(value.color);
					this.setColor(ui);					
				}
		
			} 
			
			if (value.hover)
			{
				this.toolTip = value.hover;
			}
			else
			{
				this.toolTip = null;
			}		
			
			// Set background colour
			if (value.backgroundColor)
			{
				s = new String(value.backgroundColor );
				this.setStyle("backgroundColor", s);			
			}	
					
			// Set background disabled colour
			if (value.backgroundColor)
			{
				s = new String(value.backgroundDisabledColor  );
				this.setStyle("backgroundDisabledColor", s);			
			}			
			
			// Set width
			if (value.width)
			{
				n = new Number(value.width);
				s = new String(value.width) + "px";
				if (n > 0)
				{					
					this.setStyle("width", n);
					this.explicitWidth = n;
					this.width = n;					
				}
			}
			
			if (value.enabled)
			{
				if (value.enabled == "true")
				{
					this.enabled = true;
				}
				else if (value.enabled == "false")
				{
					this.enabled = false;
				}				
			}

		}
		
		
		protected var _listData:BaseListData;		
		public function get listData():BaseListData
		{
			return _listData;
		}
		
		public function set listData(value:BaseListData):void
		{	
			var change:Boolean = false;
			
			if (!_listData)
			{				 
				change = true;
				_listData = value;				 
			}
			else if (value.label != this.text)
			{
				change = true;
			}			
			_listData = value;			
							
			if (change || this.text != _listData.label) // If change
			{
				this.text = _listData.label; // Set text
				
				lookUpColour(text); // This might slow things down a little
			}
			
		}
		
		
		
		/** If the text contains any tabs, pass any text after the tab to the next cell.
		 *  Go via the dataprovider
		 */  		
		public function set_text(value:String, event:Event):void
		{
			if (!_listData)
			{ 
				if (event.target != event.currentTarget) // If the event has come from elsewhere, don't update
					super.text = value;				
			} 
			else
			{
				var strings:Array = breakAtLineOrTab(value, true);
				if (strings.length == 1)
				{
					if (event.target != event.currentTarget) // If the event has come from elsewhere, don't update
						super.text = value;
				//	setSelection(value.length, value.length);
					updateDP();
				}
				else // Pasted text contains one or more tabs
				{
					// Start from current row
					var rowCount:int = _listData.rowIndex;
					var colCount:int = _listData.columnIndex;
					var thisString:String;
					var lastChar:String;
					for (var i:int = 0; i < strings.length; i++)
					{
						thisString = strings[i];
						var t_len:int = thisString.length;
						lastChar = thisString.substr(t_len - 1, 1);
						if (i == 0) // First pass
						{
							super.text = thisString.substr(0, t_len - 1);
							setSelection(t_len, t_len);
							updateDP();	
							if (lastChar == '\t') colCount++
							if (lastChar == '\r')
							{
								rowCount++;
								colCount = _listData.columnIndex;
							}													
						}
						else if (i == (strings.length - 1)) // last pass
						{
							updateDP_other_cell(colCount, rowCount, thisString);
						}
						else
						{
							updateDP_other_cell(colCount, rowCount, thisString.substr(0, thisString.length - 1) );
							if (lastChar == '\t') colCount++
							if (lastChar == '\r')
							{
								rowCount++;
								colCount = _listData.columnIndex;
							}								
						}	
					}
					// Since we now may have more columns or rows, recalculate the grid size
					(_listData.owner as UIComponent).invalidateProperties();
				}
			}
			
			lookUpColour(super.text);
			
			

		}
		
		// Breaks the string into an  array at a line or a tab		
		private function breakAtLineOrTab(s:String, includeBreakInArray:Boolean):Array
		{
				var working:String = new String(s); // Clone the string
				
				// We only want one type of carriage return
				working.replace("\r\n", "\r");				
				working.replace("\n", "\r");
				
				var tab_i:int;// Tab 				
				var line_i:int; // Carriage Return
				var min_i:int = 0;  // The first break, be it a carriage return or a line return				
				var return_strings:Array = [];
								
				while (min_i > -1)
				{
					tab_i = working.indexOf("\t"); 
					line_i = working.indexOf("\r"); 
					min_i = tab_i;
					if (tab_i > line_i && line_i > -1)
					{
						min_i = line_i;
					}  		
					
					if (min_i == -1) // Last string
					{
						return_strings.push(working);
						return return_strings;
					}
					else if (includeBreakInArray)
					{
						return_strings.push(working.substr(0, min_i + 1));
						working = working.substring(min_i + 1, working.length);
					}
					else
					{
						return_strings.push(working.substr(0, min_i));
						working = working.substring(min_i + 1, working.length);						
					}
				}
				return return_strings;
		}
		
		
		protected function changeHandler(event:Event):void		
		{
			trace("Start text changehandler " + getTimer());
			if (text.indexOf("\t") > -1 || text.indexOf("\r") > -1)
				set_text(this.text, event);
			else
			{
				lookUpColour(text);					
			}
							
			trace("End text changehandler " + getTimer());	
		}
			
		
		/***
		 *  Since some container like HorizontalLists and tileGrids don't support Item Editors,
		 *  we have to go back to the data provider directly
		 * 
		 *  This function updates the dataprovider for the cell that we are in
		 */
		private function updateDP(event:Object = ""):void
		{
			var list:Object = _listData.owner as Object;
			
			var dp:*;
			try {
				dp = (this._listData.owner as Object).dataProvider;
			}	
			catch (e:Error) {}
					
			if (!dp) return;
			
			var i_index:int = (listData.owner as Object).indicesToIndex(listData.rowIndex, listData.columnIndex);			
			
			// Check we have enough rows
			var diff:int = listData.rowIndex - dp.length + 1;
			for (var i:int = 0; i < diff; i++)
			{
				dp.addItem(new XML(<row/>));
			}
			
			// Select the row
			var row:XMLList = (dp.getItemAt(listData.rowIndex) as XML).children();
			
			// Check we have enough columns in this row
			diff = listData.columnIndex - row.length() + 1;	
			if (diff > 0)
			{
				var rowp:XML = dp.getItemAt(listData.rowIndex) as XML;
				for (i = 0; i < diff; i++)
				{
					rowp.appendChild(new XML(<col/>));
				}
				row = rowp.children();
				
			}	
			
			// Finally, update the data
			var o:* = row[listData.columnIndex];
			
			o[list.labelField] = this.text;
			
						
		}

		/*** This function updates the dataprovider for a cell otehr than the one we are in
		 * 
		 *  Assumes the dataProvider is an XMLListCollection, containg rows which contain columns
		 */		
		private function updateDP_other_cell(col:int, row:int, s:String):void
		{
			var list:Object = listData.owner as Object;
			var dp:* = list.dataProvider;
			var diff:int; // Difference between number we have and number we need
			if (!dp) return;
			
			var row_xml:XML;
			var o:*;			
			try {
				row_xml = dp.getItemAt(row) as XML;
			}
			catch (e:Error)// Row doesn't exist - add it to DP	???
			{ }
			if (!row_xml)
			{
				// Check we have enough rows
				diff = row - dp.length + 1;
				for (var i:int = 0; i < diff; i++)
				{
					dp.addItem(new XML(<row/>));
				}
				row_xml = dp.getItemAt(row) as XML;
			}			
			if (row_xml)
			{
				try {
					o = row_xml.children()[col];
				}				
				catch (e:Error)// Cell doesn't exist - add it to DP	???
				{}
				if (!o)
				{
					diff = col - row_xml.children().length() + 1;					
					for (i = 0; i < diff; i++)
					{
						row_xml.appendChild(new XML(<col/>));
					}
					o = row_xml.children()[col];
				}				
			}
			
			if (o)
			{
				o[list.labelField] = s;
			}
			
		}
		
		private function invertDirection(value:String):String
		{
			if (value == "horizontal") return "vertical";
			
			if (value == "vertical") return "horizontal";
			
			return "";
		}
		
		public function lookUpColour(text:String):void
		{
			if (_listData && _listData.owner)
			{
				var a:Array = (_listData.owner as FastShiftGrid).colorKeyArray;
				try {
					var l_color:String = a[text];
					var i:uint = uint(l_color);
					super.setColor(i);						
				}
				catch (e:Error)
				{
					super.setColor(0);		
				}			
			}
			else // We shouldn't get here, but its good practice to cater for all eventualities
			{
				super.setColor(0);	
			}
		}
		
		// used for tabbing
		protected function keyDownHander(event:KeyboardEvent):void
		{
			if (event.keyCode == flash.ui.Keyboard.TAB)
			{
				event.preventDefault();
				event.stopImmediatePropagation();
				
			}
		}
		

		
	}
}