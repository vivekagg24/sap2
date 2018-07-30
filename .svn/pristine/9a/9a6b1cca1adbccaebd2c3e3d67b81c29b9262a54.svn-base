// ActionScript file
            /////////////////////////////
			//  DataGrid UI Utils     //
			///////////////////////////
			import mx.controls.dataGridClasses.DataGridColumn;
			import flash.display.DisplayObject;
			import mx.rpc.events.AbstractEvent;
			import mx.controls.listClasses.IDropInListItemRenderer;
			import mx.core.IDataRenderer;
			import mx.core.ScrollPolicy;
			import flash.events.MouseEvent;
			import flash.events.EventDispatcher;
			import flash.display.Sprite;
			import mx.core.UIComponent;
			import mx.managers.IToolTipManagerClient;
			
			
// Utility functions to include in custom subclasses of DataGrid.
// Used for finding and working with the individual graphical elements of 
// datagrids. 

			protected function removeDataCells():void
			{
				var cells:Array = getAllItemRenderers(false, true);
				for each (var cell:DisplayObject in cells)
				{
					cell.parent.removeChild(cell);					
				}
				
			}
			
			protected function hideDataCells():void
			{  // Set the cell to invisible
				var cells:Array = getAllItemRenderers(false, true);
				for each (var cell:DisplayObject in cells)
				{
					
					cell.visible = false;
					if (cell is Sprite)
					{
						Sprite(cell).graphics.clear();
					} 
								
				}
			}
			
			public function getAllItemRenderers(getColHeaders:Boolean = true, getColData:Boolean = true):Array
			{
				// Gets all item renderers (or all headers, or all data cells)
				// Does include the headers
				// Does include custom item renderers (unlike getItemRenderedByColumn() )
				// Does not return the display items for empty cells
				var renderers:Array;
				renderers = new Array();
				
				// Gets the child UI components of DataGrid. We're looking for the ListBaseContentHolder, which
				// holds all the cells
				var uic:ListBaseContentHolder;
				for (var i:uint = 0; i <  this.numChildren; i++)
				{
					try 
					{
						var uic1:ListBaseContentHolder = (this.getChildAt(i) as ListBaseContentHolder);
						if (uic1) uic = uic1
						
					}
					catch (e:Error)
					{
						// Just carry on
					}
					
				}
				if (!uic || uic == null)
					return null;
				
				// OK, now get all item renderers
				for (var j:uint = 0; j <  uic.numChildren; j++)
				{
					var cell:DisplayObject = uic.getChildAt(j);
					var icell:IDropInListItemRenderer = cell as IDropInListItemRenderer;
					var isHeader:uint; // (1 = header, 2 = not header, 0 = we aren't checking)
					
					if (cell.visible == true && cell is IDataRenderer)
						{
							// If we are only getting headers or only getting data, check to see if this cell
							// is a data cell or header cell.
							// Assume all headers implement IDropInListItemRenderer
							// Be careful if using a custom column header
							
							isHeader = 0;
							if (getColHeaders == false || getColData == false)
							{
								if (icell && icell.listData.rowIndex == 0)
									isHeader = 1;
								else
									isHeader = 2;
							}													
							if (isHeader == 0 || (isHeader == 1 && getColHeaders == true) || (isHeader == 2 && getColData == true) )
								renderers.push(cell);							
								// Add this cell to the ones we are returning
														
						}
				}
					
								
				return renderers;
				
				
			}
			
			
			
			public function getItemRenderedByColumn(col:uint):Array 
			{
				// Returns all item renders in the specified datagrid columns
				// Does include the headers
				// Does not return the display items for empty cells
				// Does not include custom renderes that don't implement IDropInListItemRenderer
				
				var renderers:Array;
				renderers = new Array();
				
				var others:Array;
				others = new Array();
				
				// Make sure its a valid visible column
				if (columns.length <= col || columns[col].visible == false)
					return null;
				
				// Gets the child UI components of DataGrid. We're looking for the ListBaseContentHolder, which
				// holds all the cells
				var uic:ListBaseContentHolder = null;
				for (var i:uint = 0; i <  this.numChildren; i++)
				{
					try 
					{
						var obj:Object = this.getChildAt(i);
						if (obj is ListBaseContentHolder)
							uic = obj as ListBaseContentHolder;
						
					}
					catch (e:Error)
					{
						// Just carry on
					}
					
				}
				if (!uic || uic == null)
					return null;
				
				for (var j:uint = 0; j <  uic.numChildren; j++)
				{
					var cell:DisplayObject = uic.getChildAt(j);
					if (cell is IDropInListItemRenderer
					     && ((cell as IDropInListItemRenderer).listData)
					     && (cell as IDropInListItemRenderer).listData.columnIndex == col    )
					 
						{
							// Add this cell to the ones we are returning
							renderers.push(cell);							
						}
					if ( !(cell is IDropInListItemRenderer) )
						others.push(cell);
				}
					
								
				return renderers;
			}		
			
			private function getColumnHeader(col:uint):DisplayObject {
				// Returns the UI component corresponding to the header of the given column
				var renderers:Array = getItemRenderedByColumn(col);
				for each (var Obj:Object in renderers)
				{
					// Look for header line = row 0
					if (Obj.hasOwnProperty("listData") && Obj.listData.rowIndex == 0) 
						var com:Object = Obj;
				}
								
				return (com as DisplayObject);
			}
		
		
		
		
		   
			

			
				protected function quickResize():void {
				// Quickly resize the columns without calling InvalidateDisplay
				// All we have to do is adjust the itemrenderers and the UIComponent "lines" 
				
				// Assumes we don't have horizontal scrollbars
				
				var totalColWidth:uint = 0;
				var newTotalColWidth:uint = 0;
				var ratio:Number;
				var col:DataGridColumn;
				
				// Calcuate the total horizontal size
				// If there is a vertical scrollbar, don't include this in the total
				for each (col in columns)
				{
					if (col.visible) totalColWidth += col.width;					
				}
				
				// Resize the individual columns if we are not in a scrollable column				
				if (totalColWidth != this.width && this.horizontalScrollPolicy == ScrollPolicy.OFF)
					{					
						ratio = this.width / totalColWidth ;
						for each (col in columns)
						{
							if (col.visible)
							{
								if (col.mx_internal::colNum != columns.length)
								{
									col.mx_internal::setWidth(uint(col.width * ratio));									
								}
								else
								{
									col.mx_internal::setWidth( this.width - 	newTotalColWidth);								
								}	
								newTotalColWidth += col.width;	
							}			
						}
						
					}
					

				
				// Move the item renderers
				var left:uint = 0;
				var renderers:Array;
				for (var i:uint = 0; i < columns.length; i++)
				{
			//		if (columns[i].visible == true)
			//		{						
						renderers = getItemRenderedByColumn(i);
						
						for each (var item:Object in renderers)
						{
							item.x = left;
							if (item.visible)
							{
								item.width = columns[i].width;								
							}
						}								
						
						left += columns[i].width;
			//		}
					
				}
				
				// Redraw lines
				clearSeparators();				
				var lines:Sprite = Sprite(listContent.getChildByName("lines"));
				for (var k:uint = 0; k < lines.numChildren; k++)
				{
					try {lines.removeChildAt(k)} catch (e:Error) {};
					
				}
				drawLinesAndColumnBackgrounds();
				
				// We don't want to run drawSeparators as this adds mouse listeners allowing the user to resize
				// columns, which we don't want them to be able to do while the animatio is in progress.
				// We do however need to run it after the animation is finished to allow user to resize columns
				// again.
				//drawSeparators();
				
			}
			
			protected function quickResizeRemoveListeners():void
			{			
				var x:Object = this.hasEventListener(MouseEvent.MOUSE_OVER);
				
				this.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				this.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
				
				x = this.hasEventListener(MouseEvent.MOUSE_OVER);
			}
			
			protected function quickResizeReAddListeners():void
			{
				this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
				
			}
			public function stringToBoolean(string:String):Boolean {				
				// This is a proper type conversion from string to boolean
				// The standard flex type conversion returns true for any empty string
				
				var bool:Boolean;
				if (string == 'X' || string == 'true' || string == 'TRUE' || string == 'True')
						bool = new Boolean(true);
					else         
						bool = new Boolean(false);
				
				return bool;
			}
			

			
			