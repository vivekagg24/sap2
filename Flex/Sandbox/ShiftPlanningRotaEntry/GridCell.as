package
{
	import mx.controls.TextInput;
	import mx.controls.listClasses.IDropInListItemRenderer;
	import mx.controls.listClasses.BaseListData;
	import mx.collections.IList;
	import mx.controls.listClasses.ListBase;
	import flash.events.Event;
	import mx.collections.XMLListCollection;
	import mx.collections.ArrayCollection;
	import mx.controls.TextArea;
	import mx.core.UITextField;
	import flash.text.TextField;
	import mx.core.FlexTextField;
	import mx.controls.listClasses.TileBase;
	

	public class GridCell extends TextInput implements IDropInListItemRenderer
	{
		
		public function GridCell():void
		{
			super();
			this.addEventListener(Event.CHANGE, changeHandler, false, 0, true);			
			this.isHeader = this._isHeader; // Call setter method to define styles
			this.maxWidth = 50;						
		}
		
		// Link to main grid (don't need to make this bindable as its only set once, so
		// ignore the compile-time warnings)		
		public var topGrid:ShiftGrid;
		
		
		// Allows us to paste multiple lines
		override protected function createChildren():void
		{
			super.createChildren();
			textField.useRichTextClipboard = true; 
			textField.multiline = true;
		}
		
 		override protected function measure():void
		{
			super.measure();
			this.measuredHeight = 22;
			//this.measuredWidth = 50;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number,   unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			//super.setActualSize(50,22);
		} 
		
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
				this.editable = false;
				this.enabled = false;
				this.focusEnabled = false;	
				this.setStyle("borderStyle", "inset");	
			}
			else
			{
				this.editable = true;
				this.enabled = true;
				this.focusEnabled = true;	
				this.setStyle("borderStyle", "inset");	
			}


		}
		
		
		/** Use some of the attributes of the DATA object to set 
		 *  colour and formatting
		 */
		override public function set data(value:Object):void
		{
			super.data = value;
			
			if (!value) return;
			
			var s:String;
			var n:Number;
			
			// Set colour
			if (value.color)
			{
				s = new String(value.color);
				this.setStyle("color", s);			
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
					this.maxWidth = n;
					this.setStyle("width", n);
					this.explicitWidth = n;
					this.width = n;					
				}

			}

		}
		
		
		protected var _listData:BaseListData;		
		override public function get listData():BaseListData
		{
			return _listData;
		}
		
		override public function set listData(value:BaseListData):void
		{
			_listData = value;
			this.text = _listData.label;
			super.listData = value;
		}
		
		
		/** If the text contains any tabs, pass any text after the tab to the next cell.
		 *  We can do this via the item renderer if it exists, but since the grids/lists
		 *  don't create all renderers, sometimes we need to update the dataprovider directly.
		 */  		
		public function set_text(value:String, event:Event):void
		{
			if (!_listData)
			{
				super.text = value;				
			} 
			else
			{
				var tab_i:int = value.indexOf("\t"); // Tab 
				var line_i:int = value.indexOf("\r");; // Carriage Return
				var min_i:int;  // The first break, be it a carriage return or a line return
				var next_break:String = "tab";
				min_i = tab_i;
				
				if (tab_i > line_i && line_i > -1)
				{
					min_i = line_i;
					next_break = "line";
				}  
				     
				
				if (min_i > -1) // If there are any tabs or carriage returns in our text, we need to update more than one cell
				{
					super.text = value.substr(0,  min_i);
					this.selectionBeginIndex = super.text.length ;
					this.selectionEndIndex = super.text.length
					updateDP(); // First update our cell

					// Take account of scrolling
					var index_modifier:int;
					var direction:String = this.topGrid.direction;
					if (direction == "horizontal")
					{
						index_modifier = (_listData.owner as ListBase).verticalScrollPosition;
					}
					else
					{
						index_modifier = (_listData.owner as ListBase).horizontalScrollPosition;
					}
					
					
					// Now update the next cell(s)
					var i_index:int;
					i_index = (listData.owner as ListBase).indicesToIndex(listData.rowIndex, listData.columnIndex + 1 + index_modifier);					
									
					var next:GridCell = (listData.owner as ListBase).indexToItemRenderer(i_index) as GridCell;
					
					if (next ) // If the next item renderer exists, pass control to that
					{
						next.set_text(value.substr( min_i + 1, value.length -  min_i), event);
					}
					else  // Next item renderer doesn't exist, so update the DataProvider directly
					{
						var re:RegExp = /\t|\r/;
 						var cellsToAdd:Array = value.split(re,100);
						cellsToAdd.splice(0,1); // Remove the first item, as we've already added that to the cell we're in						
						
						
						for each (var s:String in cellsToAdd)
						{
							updateDP_other_cell(i_index + index_modifier, s);
							i_index ++;
						} 
						
						
						
					}

				}
				else
				{
					super.text = value;
					selectionBeginIndex = value.length ;
					selectionEndIndex = value.length;
					updateDP();
					
					// Since tileLists don't support Item Editors, we need to edit the data in the DP directly
					
				}	
			}
		}
		
		protected function changeHandler(event:Event):void		
		{
			set_text(this.text, event);
		}
			
		
		/***
		 *  Since some container like HorizontalLists and tileGrids don't support Item Editors,
		 *  we have to go back to the data provider directly
		 * 
		 *  This function updates the dataprovider for the cell that we are in
		 */
		private function updateDP():void
		{
			var list:ListBase = this._listData.owner as ListBase;
			var dp:* = list.dataProvider;
			if (!dp) return;
			
			var i_index:int = (listData.owner as ListBase).indicesToIndex(listData.rowIndex, listData.columnIndex);
			
			var direction:String;
			if (this.topGrid)		
			{
				direction = invertDirection(this.topGrid.direction);
			}					 
			else if (list is TileBase)
			{
				direction =  (list as TileBase).direction;
				
			}
			
			if (direction == "horizontal")
			{
				i_index += list.horizontalScrollPosition;
			}
			else
			{
				i_index += list.verticalScrollPosition;
			}
			
			
			var o:* = dp.getItemAt(i_index);
			
			o[list.labelField] = this.text;
		}

		/***
		 *  Since some container like HorizontalLists and tileGrids don't support Item Editors,
		 *  we have to go back to the data provider directly
		 * 
		 *  This function updates the dataprovider for a cell otehr than the one we are in
		 */		
		private function updateDP_other_cell(i_index:int, s:String):void
		{
			var list:ListBase = this._listData.owner as ListBase;
			var dp:* = list.dataProvider;
			if (!dp) return;
			
			var o:*;
			try {
				o = dp.getItemAt(i_index);
			}
			catch (e:Error)// Item doesn't exist - need to add it to DP	
			{
				if (dp is XMLListCollection)
				{
					(dp as XMLListCollection).addItemAt(new XML("<item/>"), i_index);					
				}
				if (dp is ArrayCollection)
				{
					(dp as ArrayCollection).addItemAt(new Object(), i_index);					
				}	
				o = dp.getItemAt(i_index);				
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
		
	}
}