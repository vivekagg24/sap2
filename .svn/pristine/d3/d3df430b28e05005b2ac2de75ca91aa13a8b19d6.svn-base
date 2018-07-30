package
{
	import flash.display.InteractiveObject;
	
	import mx.collections.XMLListCollection;
	import mx.containers.BoxDirection;
	import mx.controls.*;
	import mx.controls.listClasses.ListData;
	import mx.core.ClassFactory;
	import mx.core.UIComponent;
	import mx.events.CollectionEvent;
	import mx.events.ScrollEvent;
	import mx.core.IUIComponent;
	import flash.display.DisplayObject;
	import flash.events.Event;
	

/**  Grid for displaying shifts
 *   Each shift is an editable cell
 * 
 *   All cells are the same size
 * 
 */ 
	public class FastShiftGrid extends UIComponent
	{
		private static const DEFAULT_SCROLLBAR_THICKNESS:uint = 20;
		
		
		protected var _visiibleCells:Array; // An array of all the visual cells of the grid
		
		protected var _cellData:Array; // An array of all the data for the cells in the grid
		
		
		protected var _cellRows:int = 8; 				// The number of ACTUAL rows of data in the grid 
		protected var _visibleCellRows:int = 8;			// The number of VISIBLE rows of data in the grid
		
		protected var _cellColumns:int = 2000;			// The number of ACTUAL columns of data in the grid (including the header)
		protected var _visibleCellColumns:int = 30;		// The number of VISIBLE columns of data in the grid (including the header)
		
		protected var _dataProvider:XMLListCollection; 
		
		public var labelField:String; 					// The label field for drop-in item renderes
		
		// What colours to use for what values
		protected var _colorKey:XMLListCollection;
		public var colorKeyArray:Array; // An associative array whic permits faster access to the colrKey
		public function set colorKey(value:XMLListCollection):void
		{
			if (_colorKey === value) return;
			
			// Watch for changes
			value.addEventListener(CollectionEvent.COLLECTION_CHANGE, resetColorKeyArray);
			if (_colorKey) _colorKey.removeEventListener(CollectionEvent.COLLECTION_CHANGE, resetColorKeyArray);
			
			// Store
			_colorKey = value;
			
			// Proces
			resetColorKeyArray(new Event("dummy"));			
		}
		
		// Are the cells editable?
		public var editable:Boolean = true;
		
		/** When the colorKey changes, rebuild the array which we use for fast searching 
		 * 
		 */
		private function resetColorKeyArray(event:Event):void
		{
			colorKeyArray = [];
			var s:Object;
			for each (var x:XML in _colorKey)
			{
				// Do we already have it, if so then continue
				s = null;
				try {
					s = colorKeyArray[x.abbreviation];
					if (s) continue;
				}
				catch (e:Error) {}
				
				// Insert the new entry
				if (x.color)
					colorKeyArray[x.abbreviation] = new String(x.color);				
				
			}
			
			// Now re-color the cells
			for each (var o:Object in _visiibleCells)
			{
				try {
					o.lookUpColour(o.text);
				}
				catch (e:Error)
				{
					// Do nothing
				}
					
				
			}
		}
			
		
		
		// All cells are the same size apart from the left-most labal
		public var showRowLabel:Boolean = false;
		protected var rowLabelCellSize:int = 80;
		protected var cellHGap:int = 2;
		protected var cellHSize:int = 30;
		protected var cellVGap:int = 2;
		protected var cellVSize:int = 22;
		
		/** Scrollbars
		 * 
		 */							
		protected var hScrollbarNeeded:Boolean;
		protected var vScrollbarNeeded:Boolean;
		
		protected var hScrollBar:HScrollBar; 
		protected var vScrollBar:VScrollBar; 
		
		protected var _horizontalScrollPosition:int = 0;
		protected var _verticalScrollPosition:int = 0;
		
		public function set horizontalScrollPosition(value:int):void
		{
			_horizontalScrollPosition = value;
			// Need to redraw stuff
			this.invalidateDisplayList();
		}
		public function set verticalScrollPosition(value:int):void
		{
			_verticalScrollPosition = value;
			// Need to redraw stuff
			this.invalidateDisplayList();
		}
		public function get horizontalScrollPosition():int
		{
			return _horizontalScrollPosition;
		}
		public function get verticalScrollPosition():int
		{
			return _verticalScrollPosition;
		}
	
		
		

				
		/** The DataProvider tells us what data to pass to our cells, and where to store any data 
		 *  put into our cells.
		 * 
		 *  It will also capture any changes within the data
		 * 
		 *  For the moment, we take data as XMLList or XMLListCollection only
		 * 
		 *  When you change the dataProvider, we invalidate the properties of this object, and
		 *  in commitProperties(), we assign the cells of the dataProvider to our grid and determine if
		 *  this size of the dataProvider affects the size of our grid, or whether we need scrollbars
		 * 
		 */ 
		[Bindable]  
		public function set dataProvider(value:Object):void
		{
			if (value is XMLList)
			{
				if (!_dataProvider || value != _dataProvider.source) // Are we cahnging data provider
				{
					// Remove the old listener if there is one
					if (_dataProvider) _dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, dataProvderChangeHandler);
					
					// Store the dataprovider and prcoess (later) 
					_dataProvider = new XMLListCollection(value as XMLList);
					invalidateProperties();
					
					// Catch any changes within the dataProvider (use a weak ref in case we are garbage collected)
					_dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, dataProvderChangeHandler, false, 0, true)
				}
				
			}
			else if (value is XMLListCollection)
			{
				if (!_dataProvider || value != _dataProvider)
				{
					// Remove the old listener if there is one
					if (_dataProvider) _dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, dataProvderChangeHandler);
					
					// Store the dataprovider and prcoess (later) 
					_dataProvider = value as XMLListCollection;
					invalidateProperties();;
					
					// Catch any changes within the dataProvider (use a weak ref in case we are garbage collected)
					_dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, dataProvderChangeHandler, false, 0, true);				
				}				
			}				
		}		
		public function get dataProvider():Object
		{
			return _dataProvider;
		}
		

		
		
		/** ClassFactory to create each cell
		 */
		protected var cellCreator:ClassFactory;
		
		/** Constructor 
		 */
		public function FastShiftGrid()
		{
			super();
			this.tabChildren = true;
			

		}
		
		// If we don't explicitly say how big it should be, make it big enough to fit everything	
		override protected function measure():void
		{
			super.measure();
			
			if (isNaN(this.explicitHeight))
			{
				var heightOfContents:int = ((cellVGap + cellVSize) * _cellRows);			
				measuredHeight = heightOfContents;				
			}
			
			if (isNaN(this.explicitWidth))
			{
				var widthOfContents:int  = ((cellHGap + cellHSize) * _cellColumns);
				if (showRowLabel) widthOfContents += rowLabelCellSize - cellHSize;
				
				measuredWidth = widthOfContents;				
			}
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			// We don't actually create our children in here
			// We create them in updateDisplayList()			
		}
		
		/** If the data has changed we update the data in the item renderers
		 * 
		 *  We never need to regenerate the item renderers, we just recylce them
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			// Determine the number of rows and columns based on the size of the component
			determineGridSize(false);
			
			// Do we need scrollbars?
			// If we do, work out the number of visible rows and columns
			checkForScrollBars();		
			
			// If we've introduced scrollbars, we need to recalculate the grid size
			if (hScrollbarNeeded || vScrollbarNeeded)
				determineGridSize(true);
				
			
			// Create the data for the cells.
			// If the visual item renderers already exist, update them with data
			// but don't create them if they don't exist. When they are created they
			// will receive the data.
			createDataForCells();
		}

		/** Draw everything
		 */
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth , unscaledHeight);

			// Do we need scrollbars?
			// If we do, work out the number of visible rows and columns
			checkForScrollBars();
			
			graphics.clear(); // Get rid of all existing graphics of this component (doesn't clear graphics of children)
			
			// Draw the border
			graphics.drawRect(0,0,this.width, this.height);
			
			
			// Create the object that will create each visual cell
			cellCreator = new ClassFactory(FastGridCell);
			
			// Create the array containing the text cells
			// Even though its a 2-d grid, this is a 1-d array
			//var numCells:int = _cellRows * _cellColumns;
			var numVisibleCells:int = _visibleCellRows * _visibleCellColumns;
			if (!_visiibleCells) _visiibleCells = new Array(numVisibleCells);
						

			var thisCell:InteractiveObject; // Current cell
			
			var currIndex:Array = [0, 0]; // An array containing the horizontal and vertical cell indexes
			for (var count:int = 0; count < numVisibleCells; count++)
			{
				
				// Check if the renderer exists. If it does, recycle it
				thisCell = null;
				try {
					thisCell = _visiibleCells[count];
				}
				catch (e:Error) {trace("Cell array error");}
				
				if (!thisCell)
				{
					_visiibleCells[count] = thisCell = cellCreator.newInstance(); // If it doesn't exists, create a new one
					(thisCell as FastGridCell).enabled = this.editable;
					this.addChild(thisCell);
					
					thisCell.height = cellVSize;
					
					if (showRowLabel && currIndex[0] == 0)
					{
						thisCell.width = rowLabelCellSize;
					}
					else
					{
						thisCell.width =  cellHSize;
					}
					
				}
				
				// Move it to where it should be
				if (showRowLabel)
				{
					thisCell.x = (currIndex[0] * (cellHGap + cellHSize));
					if (currIndex[0] > 0)
					thisCell.x += rowLabelCellSize - cellHSize;
				}
				else
				{
					thisCell.x = (currIndex[0] * (cellHGap + cellHSize));
				}
				
				thisCell.y = (currIndex[1] * (cellVGap + cellVSize));
				
				// Pass data to cell
				if (_cellData)
					updateRendererDataAt(currIndex[0] + horizontalScrollPosition, currIndex[1] + verticalScrollPosition);	
				
				// Now increment our 2-d index
				currIndex[0]++;
				if (currIndex[0] >= _visibleCellColumns) // Go to the next line
				{
					currIndex[0] = 0;
					currIndex[1]++;
				}
			}
			
			// Finally cleanup by removing any old cells which are no longer visible
			if (numVisibleCells < _visiibleCells.length)
			{
				var cell_to_delete:DisplayObject;
				for (var deletion_count:int = numVisibleCells; deletion_count < _visiibleCells.length; deletion_count++)
				{
					cell_to_delete =  _visiibleCells[deletion_count];
					if (cell_to_delete)
					{
						cell_to_delete.visible = false;   // Make invisible (not really necessary as will be hidden when removed from dispaly list)
						removeChild(cell_to_delete);      // Remove from the display list
						_visiibleCells.splice(deletion_count, 1); // Remove from the array
						
						// Remove any listeners we add too
					}					
				}
			}			
		}
		
		/** Determine grid size from dataProvider
		 * 
		 *  Sets _cellRows, _cellCols and _numCells based on how many entries are
		 * in the dataProvider. Also, add more cells to to make sure the grid is 
		 * full of cells.
		 *  
		 * Assumes we have the dataprovider
		 */
		private function determineGridSize(takeAccountOfScrollBars:Boolean):void
		{		
			var oldRows:int =  _cellRows;
			var oldCols:int =  _cellColumns;	
			
			var newRowCount:int = 0;
			var newColCount:int = 0;
							
			if (this._dataProvider)
			{
				newRowCount = _dataProvider.length;					
				// Since each row may have a different number of columns, determine biggest row
				for each (var x:XML in _dataProvider)
				{
					var l_cols:int = x.children().length();
					if (l_cols > newColCount)
					newColCount = l_cols
				}
			}	 
				
			// If the size of the grid is set explicitly, we must fill it
			// We do need to worry about scrollbars in this case, since a horizontal scrollbar affects the
			// vertical size
			var innerHeight:int = this.height;
			
			var l_visibleCellColumns:int = calculateVisibleColumns(!takeAccountOfScrollBars);			 		
			var l_visibleCellRows:int    = calculateVisibleRows(!takeAccountOfScrollBars);		
			if (l_visibleCellColumns > 	newColCount) newColCount = 	l_visibleCellColumns;
			if (l_visibleCellRows > 	newRowCount) newRowCount = 	l_visibleCellRows;
			
				
			
			if (!_visiibleCells) // No data yet, so just create an empty grid
			{
				_cellData = new Array(newColCount * newRowCount);					
			}
			else // Adjust the _visiibleCells array to account for the size of the new dataProvider
			{
				// We could do something clever here to save speed, but for the moment, 
				// create a new grid and fill it again from the dataProvider
				
				// TO-DO - make it cleverer and faster by expanding the array and keeping old data
				
				_cellData = new Array(newColCount * newRowCount)	;
				
			}
			
			_cellRows = newRowCount;
			_cellColumns = newColCount;
			
		
			
		}
		
		
		private function calculateVisibleColumns(ignoringScrollbars:Boolean):int
		{
			var innerWidth:int  = this.width;
			var l_visibleCellColumns:int;
			
			if (vScrollbarNeeded && !ignoringScrollbars)
				innerWidth -= DEFAULT_SCROLLBAR_THICKNESS;
			
			if (showRowLabel)
			{
				l_visibleCellColumns = 1 + Math.floor( (innerWidth - rowLabelCellSize) / (cellHSize + cellHGap) );	
			}
			else
			{
				l_visibleCellColumns = Math.floor( innerWidth  / (cellHSize + cellHGap) );	
			}			
			return l_visibleCellColumns;
		}
		
		
		private function calculateVisibleRows(ignoringScrollbars:Boolean):int
		{
			var innerHeight:int  = this.height;
			var l_visibleCellRows:int;
			
			if (hScrollbarNeeded && !ignoringScrollbars)
				innerHeight -= DEFAULT_SCROLLBAR_THICKNESS;

			l_visibleCellRows = Math.floor( innerHeight  / (cellVSize + cellVGap) );	
						
			return l_visibleCellRows;
		}		
		

		/** Work out how big the component is and whether to display scrollbars
		 * 
		 *  Calculates _visibleCellColumns and _visibleCellRows and creates 
		 *  the scrollbars as required
		 * 
		 *  Assumes we've already worked out how many cells to display
		 */
		protected function checkForScrollBars():void
		{				
			// How many cells can we display
			var innerWidth:int  = this.width;
			var innerHeight:int = this.height;
			
			_visibleCellColumns = calculateVisibleColumns(true);			
			_visibleCellRows    = calculateVisibleRows(true);
			
			
			// First, if we need scrollbars, calculate effect on internal size
			// Having a vertical scrollbar can take up sufficient space that we have to reduce the number of visible columns
			// Ditto ver horizontal scrollbars and the number of rows.
			if (_visibleCellColumns < _cellColumns)
			{
				hScrollbarNeeded = true;
				innerHeight -= DEFAULT_SCROLLBAR_THICKNESS;
				_visibleCellRows    = calculateVisibleRows(true);			
			}
			if (_visibleCellRows < _cellRows)
			{
				vScrollbarNeeded = true;
				innerWidth -= DEFAULT_SCROLLBAR_THICKNESS;
				_visibleCellColumns = calculateVisibleColumns(false);
			}			
			
			// Now, make sure the number of visible rows (or columns) is not
			// bigger than the actual number of rows (or columns)
			if (_cellColumns < _visibleCellColumns) _visibleCellColumns = _cellColumns;
			if (_cellRows < _visibleCellRows) _visibleCellRows = _cellRows;
			
			// Now create the scrollbars
			// HORIZONTAL
			if (hScrollbarNeeded)
			{
				// We want a horizontal scrollbar
				if (!hScrollBar)
				{
					hScrollBar = new HScrollBar();
					hScrollBar.height = DEFAULT_SCROLLBAR_THICKNESS;
					hScrollBar.width = innerWidth;
					hScrollBar.x = 0
					hScrollBar.y = this.height - DEFAULT_SCROLLBAR_THICKNESS;
					hScrollBar.visible = true;
					hScrollBar.lineScrollSize = 1;
					hScrollBar.minScrollPosition = 0;

					this.addChild(hScrollBar);
					hScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
				}
				hScrollBar.maxScrollPosition = _cellColumns - _visibleCellColumns;
				hScrollBar.pageSize = _visibleCellColumns;
				hScrollBar.invalidateProperties();
				hScrollBar.invalidateDisplayList();	
								
			}			
			else
			{
				// We don't want a horizontal scrollbar
				if (hScrollBar) // Delete it if it exists
				{
					hScrollBar.removeEventListener(ScrollEvent.SCROLL, scrollHandler);
					removeChild(hScrollBar);
					hScrollBar = null; 
				}
			}
			
			// VERTICAL 
			if (vScrollbarNeeded)
			{
				// We want a vertical scrollbar
				if (!vScrollBar)
				{
					vScrollBar = new VScrollBar();
					vScrollBar.height = innerHeight;
					vScrollBar.width = DEFAULT_SCROLLBAR_THICKNESS;
					vScrollBar.x = this.width - DEFAULT_SCROLLBAR_THICKNESS;
					vScrollBar.y = 0; 
					vScrollBar.visible = true;
					vScrollBar.lineScrollSize = 1;
					vScrollBar.minScrollPosition = 0;

					this.addChild(vScrollBar);
					vScrollBar.addEventListener(ScrollEvent.SCROLL, scrollHandler);
				}	
				vScrollBar.maxScrollPosition = _cellRows - _visibleCellRows;
				vScrollBar.pageSize = _visibleCellRows;
				vScrollBar.invalidateProperties();
				vScrollBar.invalidateDisplayList();			
			}			
			else
			{
				// We don't want a vertical scrollbar
				if (vScrollBar) // Delete it if it exists
				{
					vScrollBar.removeEventListener(ScrollEvent.SCROLL, scrollHandler);
					removeChild(vScrollBar);
					vScrollBar = null; 
				}
			}			
		}		
		
		
		/** Pass data to the item renderer
		 * 
		 *  Note that the row and column are the actual row and column, not the 
		 *  visible row and column. We calculate the row and column of the renderer by subtracting
		 *  the scroll position
		 * 
		 */
		private function updateRendererDataAt(column:int, row:int):void
		{
				var visible_row:int = row - verticalScrollPosition;
				var visible_col:int = column - horizontalScrollPosition;
				
				if (showRowLabel) // If we have a row label, this is always displayed, so we don't scroll it
				{
					if (column == 0)					
						visible_col = 0;										
					else
					{
						if (visible_col == 0)
							visible_col = -1; // Don't display the left-most non-label column
					}
						
				}
				
				if (    visible_row < 0 
				     || visible_col < 0
				     || visible_row > _visibleCellRows
				     || visible_col > _visibleCellColumns)
					return; // We're outside the visible box, so don't carry on
				
				var visible_index:int = (visible_row * _visibleCellColumns) + visible_col;
				var logical_index:int = (row * _cellColumns) + column;

				var l_thisCell:InteractiveObject = _visiibleCells[visible_index]; // Current cell
				var l_thisCellUntyped:* = l_thisCell;
				var xmlData:XML = _cellData[logical_index];
				
				if (l_thisCell) // If item renderer exists
				{
					if (l_thisCell.hasOwnProperty("data"))
						l_thisCellUntyped.data = xmlData;
						
					if (l_thisCell.hasOwnProperty("listData"))
					{
						var label:String;
						try {
							label =  xmlData[labelField];
						} catch (e:Error) {}
						l_thisCellUntyped.listData = new ListData(label, null, labelField , "", this, row, column);	
					}
				}			
		}

		
	
		// Getthe index of the given item
		public function indicesToIndex(row:int, col:int):int
		{
			if (row < 0 || row > _cellRows || col < 0 || col > _cellColumns)
				return -1;
				
			var i:uint = (row * _cellColumns) + col;
			return i;	
		}
		
		
		
		/** Takes data from the dataProvder and builds the cells
		 * 
		 */
		protected function 	createDataForCells():void
		{
			
			if (!_dataProvider)
				{
					//clearCells();
					return; // If we don't havea dataPrvider, don't do anything
				}
				 
				
			/** Create the data for the cells
			 */			 
			if (!_cellData) _cellData = new Array(_cellColumns * _cellRows); 
			
			// The dataProvider is first in rows, then in columns
			var l_rows:Array = _dataProvider.toArray();
			var l_rowCount:int = 0;
			var l_colCount:int = 0;
			var dataIndex:int = 0; // The index of the item in the dataProvider array
			
			for each (var xml_row:XML in l_rows)
			{
				// We ignore any data elements that lie outside of the boundaries of the grid
				// as set by _cellColumns and _cellRows					
				if (l_rowCount >= _cellRows)
				break; // Exit this loop
				
				
				var emptyXML:XML = new XML(<empty></empty>);
				
				
				l_colCount = 0;
				var l_cols:XMLList = xml_row.children();
				while (l_colCount < _cellColumns)
				{
					var xml_cell:XML;
					try {
						xml_cell = l_cols[l_colCount];
					}
					catch (e:Error) // If the number of columns is wider than this particular row of the dataprovider, 				 
					{				// make sure every column afterwards is filled with blanks
						xml_cell = emptyXML;
						
					}
					// We ignore any data elements that lie ouside of the boundaries of the grid
					// as set by _cellColumns and _cellRows					
					if (l_colCount >= _cellColumns)
						break; // Exit this loop
					
					// Process the cell
					dataIndex = (l_rowCount * _cellColumns) + l_colCount;
					var oldData:XML = _cellData[dataIndex];
					if (oldData && oldData != xml_cell)
					{
						// No change - do nothing						
					}
					else
					{
						_cellData[dataIndex] = xml_cell; // Update the data
						
						// If there is an item renderer, update it, otherwise it will
						// be updated when it is created in updateDisplayList;	
						if (_visiibleCells)				
							updateRendererDataAt(l_colCount , l_rowCount);						
					}					
					l_colCount++;
				}
				// Now make any remaining cells in this row blank
				while (l_colCount < _cellRows)
				{
					dataIndex = (l_rowCount * _cellColumns) + l_colCount;
					
					
					l_colCount++;
				}
				
								
				l_rowCount++;				
			}
			
		}

		/** Handle scrolling
		 * 
		 */
		protected function scrollHandler(event:ScrollEvent):void
		{
			if (event.direction == BoxDirection.HORIZONTAL)
			{
				horizontalScrollPosition = event.position;
			}
			else if (event.direction == BoxDirection.VERTICAL)
			{
				verticalScrollPosition = event.position;
			}
		} 		
		
	
	
		/** Handles changes ot the data provider
		 * 
		 *  Sometimes, instead of a whole collection changing, only some entries have changed.
		 *  To be more efficient, we can update only those entries that have changed
		 * 
		*/ 
		protected function dataProvderChangeHandler(event:CollectionEvent):void
		{
			// For the moment, just call invalidateProperties() to regenerate all data;
			invalidateProperties();
			invalidateDisplayList()
		}	
	}	
}