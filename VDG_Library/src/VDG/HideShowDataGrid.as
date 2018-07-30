package VDG
{
	import mx.core.UIComponent;
	import mx.controls.listClasses.*; //.ListBaseContentHolder;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.*;
	import mx.managers.PopUpManager;
	import mx.containers.TitleWindow;
	import mx.controls.Alert;
	import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.events.Event;
    import mx.managers.PopUpManager;
    import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import mx.core.ClassFactory;
	import flash.events.ContextMenuEvent;
	import mx.controls.Button;
	import mx.events.CloseEvent;
	import mx.core.UIComponent;
	import mx.events.DataGridEvent;
	import mx.events.IndexChangedEvent;
	import mx.controls.dataGridClasses.DataGridColumn;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import mx.core.mx_internal;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import mx.effects.Effect;
	import mx.events.EffectEvent;
	import mx.effects.Glow; 
	import mx.core.UITextField;
	import mx.effects.Resize;
	import flash.geom.Point;
	import mx.controls.dataGridClasses.DataGridBase;
	import flash.text.TextField;
	import mx.managers.ToolTipManager;
	
	import VDG.vdg_internal;
	
	//namespace vdg_internal;
	use namespace VDG.vdg_internal;
	
	
	// This style corresponds to hiding or showing a column. If set to zero, we simply hide or show the 
	// column with no effect. If set to more than zero, then we apply the effect and the resize styles, 
	// if they are set.
	
	// N.B. Since DataGridColumn Objects are a logical representation of the datagrid column, and don't
	// exist in the physical display, we can't use an effect to resize them
	
	// Similarly, DataGridItemRenderers do not accept effects, so we have to code our own.
	
	[Style(name="columnHideShowDuration", type="uint",  inherit="no")]	
	
	// We can set the columns to gradually shrink (when made invisible) or expand 
	// (when made visible), rather than just simply appearing.
	// Not recommended if your datagrid has a large number of cells.
	[Style(name="columnHideShowGradual", type="Boolean",  inherit="no")]

		
	// Colour to apply when hiding a cell
	[Style(name="columnHideColor", type="Number", inherit="no")]
	
	// Colour to apply when showing a cell
	[Style(name="columnShowColor", type="Number", inherit="no")]	
	

	// Time to apply colour after cell shown (microseconds)
	[Style(name="columnShowAfterDuration", type="uint")]
	

	
	// A datagrid with the option to hide or show columns
		public class HideShowDataGrid extends DataGrid
	{
		
		    include "ArrayUtils.as";
		    include "DataGridUtils.as";
							
			// Very important Array, holds all the display variant info
			// We use this to know which columns are hidden or not hidden
			// and what order they are in.
			[Bindable]			
			protected var _variant:Array;
			protected var _oldVariant:Array;
			
			// Data to hold columns as they are supplied
			protected var _oldColumns:Array;	
			
			// Which column is sorted?
			// mx.DataGrid class already has a variable for this but it is private
			protected var sortColIndex:int;
			
			
			// Used instead of mx_internal equivalent
			vdg_internal var owner:DataGrid;
	
	
			// Context Menu Options
			protected var cmi_hide:ContextMenuItem;
			protected var cmi_show:ContextMenuItem;
			protected var cmi_reset:ContextMenuItem;
			
			// Context Menu "Show Columns" popup
			protected var cm_popup:TitleWindow;
			protected var cm_popup_dg:DataGrid;
			protected var cm_popup_dg_c1:DataGridColumn;  // Show/hide tickbox
			protected var cm_popup_dg_c2:DataGridColumn;  // Column name
			protected var cm_popup_dg_c3:DataGridColumn;  // Column no (invisible)
			protected var cm_popup_data:Array;
			protected var cm_popup_ok:Button; // OK Button

			// Effects for hiding and un-hiding columns
			protected var ch_columns:Array;      // Array of columns which have been hidden / unhidden
			
			// Global variables for searching arrays
			protected var g_searchId:String; 
			protected var g_searchHeader:String;
			protected var g_searchIndex:uint;
			
				
			// Duration for close / hide effect
			protected var duration:uint = 0;//150; // Miliseconds
			protected var _columnShowAfterDuration:uint = 0;
			protected var steps:uint = 12; // Number of iterations in column shrinkage
			protected var useShrink:Boolean = true;

			// Colours for show / hide
			protected var _columnHideColor:int = -1;
			protected var _columnShowColor:int = -1;
			
		public function HideShowDataGrid()
		{
			//TODO: implement function
			super();
			
			// We want these event listeners to be triggered AFTER the column has been resized,
			// so we give them a low priority
	    	this.addEventListener(DataGridEvent.COLUMN_STRETCH,setVariantFromDisplay,false,-4);		 
	    	this.addEventListener(IndexChangedEvent.HEADER_SHIFT,setVariantFromDisplay,false,-4);	
	    	
	    	// Default in column hiding
	    	hideShowColumns = true;		
		}
		
		
		
		
	////////////////////////
	// Public properties  //
	////////////////////////
	
		// Variant is read only		
		public function get variant():Array {
				return _variant;
			}
	
	
	// hideShowColumns
	// This flag controls whether a user can hide and unhide columns using right-click
	
	protected var _hideShowColumns:Boolean;
	
	[Inspectable]
	public function set hideShowColumns(value:Boolean):void {
		if (value == _hideShowColumns)
			return;
			
		if (value == true)
			setupContextMenu();
		else
			removeContextMenu();		
	}
	
	public function get hideShowColumns():Boolean {	
		return _hideShowColumns;
	}
	
	// Do some internal stuff when setting the columns
	override public function set columns(value:Array):void
	{
		super.columns = value;
		
		for each (var obj:Object in columns)
		{
			if (obj is VariantDataGridColumn)
			{
				obj.owner = this;
			}
			
			
		}
	}
	
	
			/////////////////////////////////////////
			// UI Component Methods                //
			//                                     //
			/////////////////////////////////////////
			

			protected function cloneColumns():void {
				// Creates a copy of the columns for later use
				// We need to retain the original column settings so we know what to apply
				// the variant to.
				
				// The column order is the most important thing - we're not really bothered about the 
				// orignal width, so we can call this after "set column()"
				trace ("Clone columns");
				
				// (creates a new array containing references to the elements in the old array)
	    		_oldColumns = new Array();
	    		for (var i:String in this.columns)
	    		{
	    			_oldColumns[i] = new Object();
	    			_oldColumns[i].ref = this.columns[i];
	    			_oldColumns[i].headerText = this.columns[i].headerText;
	    			_oldColumns[i].dataField = this.columns[i].dataField;
	    			_oldColumns[i].originalWidth = this.columns[i].width;
	    			_oldColumns[i].wasVisible = this.columns[i].visible;
	    			
	    		}  
			}
			


	
			//////////////////////////////////////////////////
			// Updates the variant from the current display //
			//////////////////////////////////////////////////
			public function setVariantFromDisplay(event:Object = ""):void {
				// Sets the variant based on the current display 
				// The event is never used, we just have it as this method is an event handler
				if (!(event is Event))
					event = new Event("");
					
				// First, make sure that if any columns have a fixed width, it is applied here
				// (to-do)	
				
				var i:String;
				var l_colSorted:DataGridColumn;
				// Loop through the old columns and, for each one, find the new column that matches it
				_variant = new Array();
				for (i in _oldColumns) {	
						
					// Use global variables to set the values to be searched for
					g_searchHeader = _oldColumns[i].headerText;
					// Search for the new column that matches _oldColumn[i]
					l_colSorted = this.columns.filter(search)[0];
					
					// Save the results in the variant
					// The variable names must match those in SAP structure ZECS_FLEX_VARIANT
					// and must also be uppercase
					_variant[i] = new Object();
					_variant[i].COL_NO = i;
					_variant[i].COL_ORDER = g_searchIndex;
					_variant[i].SORT_DESCENDING = l_colSorted.sortDescending;
					
					// Save the sorted column
					if (i as int == sortColIndex)
					
						_variant[i].SORTED = true;
					else
						_variant[i].SORTED = false;
						
					
					_variant[i].VISIBLE = l_colSorted.visible;
					if (_variant[i].VISIBLE == true || _variant[i].VISIBLE == "true")
					{
						// If column is hidden, width will be zero, which we don't want,
						// so only save width for visible columns
						_variant[i].WIDTH = int(l_colSorted.width);
					}
					if (!_variant[i].WIDTH || _variant[i].WIDTH == "" || _variant[i].WIDTH == 0  || _variant[i].WIDTH == null)
					{
						// If nothing is in the width attribute, use the original width
						_variant[i].WIDTH = _oldColumns[i].originalWidth;
					}
					
				} // End of "for (i in _oldColumns)" loop
			}
		
			/////////////////////////////////////////
			// Methods to handle right-clicking on //
			// datagrid for hiding and showing     //
			/////////////////////////////////////////
			
			protected function setupContextMenu():void {
				this.contextMenu = new ContextMenu();
				this.contextMenu.hideBuiltInItems();
				
				// Add the Hide button
				cmi_hide = new ContextMenuItem('Hide Column');
				this.contextMenu.customItems.push(cmi_hide);			
				
				// Add the Show button
				cmi_show = new ContextMenuItem('Show Columns');
				this.contextMenu.customItems.push(cmi_show);
				
				// Add the Clear button
				cmi_reset = new ContextMenuItem('Reset Columns');
				this.contextMenu.customItems.push(cmi_reset);
				
				contextMenu.addEventListener(ContextMenuEvent.MENU_SELECT,contextSelect);
				cmi_hide.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,contextHide);
				cmi_show.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,contextShow);
				cmi_reset.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,contextReset);
								
			}
			
			protected function contextSelect(event:ContextMenuEvent):void {
				// function called when the user right-clicks on a column before the menu is displayed.
				// We use this to check if a column is hideable. If it isn't hideable, don't display the 
				// "hide" option
				
				var hideable:Boolean;
					
				// Check that we have a custom items array to work with - if not, exit
				if (!this.contextMenu.customItems)
				{
					trace("No context menu");
					return;
				}

				
				// Get the column that was right-clicked
				var col:int = getContextColumn(event);
				if (col < 0) return;
				hideable = true;
				
				// Check if this column is a VariantDataGridColumn and is hideable (normal DataGridColumns are always hideable)
				var vcol:VariantDataGridColumn = columns[col] as VariantDataGridColumn;
				if (vcol && vcol.hideable == false) hideable = false;
				
				var index:int; // Index of this menu item in the array of custom menu items
					index = this.contextMenu.customItems.indexOf(cmi_hide)
					
				// If columns is hideable but context menu doesn't have hide option, add hide option	
				// If it's there but invisible, make it visible			
				if (hideable)
				{
					if (index == -1)
					{
						this.contextMenu.customItems.push(cmi_hide);
						trace("add hide option");
					}
					cmi_hide.visible = true;
					cmi_hide.enabled = true;
				}
							
				// If columns is not hideable but context menu has hide option, remove hide option	
				if (!hideable && index != -1)
					{
						cmi_hide.visible = false;
						cmi_hide.enabled = false
						//this.contextMenu.customItems = removeItemAt(this.contextMenu.customItems,index);
						trace("remove hide option");						
					}

				
				
			}
			
			protected function removeContextMenu():void {
				this.contextMenu = null;
			}
			
			protected function contextHide(event:ContextMenuEvent):void 
			{
				// Function called if user right-clicks on the datagrid
				// and selects "Hide Column"
				
				// First of all, which column was right-clicked?
				var col_index:int = getContextColumn(event);
				if (!col_index || col_index == -1) return; // Some error so don't hide the column
				
				// OK, is the column hideable?
				// If not hideable, don't hide it				
				if (columns[col_index].hasOwnProperty("hideable")  && columns[col_index].hideable == false)
					return;
						
				// Store the list of columsn which were hidden
				ch_columns = new Array();
				ch_columns[0] = new Object();
				ch_columns[0].index = col_index;
				ch_columns[0].originalWidth = columns[col_index].width;
				ch_columns[0].targetWidth = 0;
				
			
				// Hide / show the columns
				startColHideShow();
				
		
			}
			
			protected function startColHideShow():void {
				// Kicks off the process of hiding or showing a column, taking into account the 
				// chosen effects
				
				// Get the styles to determine how we will process this
				duration = this.getStyle("columnHideShowDuration");
				useShrink = this.getStyle("columnHideShowGradual");						
				_columnShowAfterDuration =  this.getStyle("columnShowAfterDuration");
				_columnHideColor = this.getStyle("columnHideColor");
				_columnShowColor = this.getStyle("columnShowColor");		
				
				// Do we animate the resizing of the columns, or do we just resize?
				if (duration == 0)
			 	{
					doColResizeEnd(new Event(""));
				}
				
				else
				
				{
					// Start to hide/show the columns in duration micorseoncds time.
					var timer:Timer = new Timer(duration / steps, steps);
					
				
					// Are we doing a gradual shirnk?
					if (useShrink == true) 		                       
				 	{
				 		// If so, we want to run this function
						timer.addEventListener(TimerEvent.TIMER,doColResize);
						
						// Remove the event listeners which turn column headers blue
						quickResizeRemoveListeners();
						
						// Stop any tooltips
						ToolTipManager.enabled = false;
						
						// Also, we don't want to re-render every cell every time we resize. If we have more
						// than about 4 rows, the resize is jerky, so for consistency always 
						// remove all data cells from the display (keep the columns headers though).
						hideDataCells();
				 	}
				}  
							
				// 
				// Set the background colour
				for each (var k:Object in ch_columns)
				{			
					doHeaderBackground(k);
				}
				
				
				// Remove resize mouse listeneres
				
				
				//  Kick everything off	
				if (timer)	
				{			
					timer.addEventListener(TimerEvent.TIMER_COMPLETE, doColResizeEnd);
					timer.start();
				}				
			}
			
			protected function undoHeaderBackgroundAll(event:Event):void
			{
				for each (var obj:Object in ch_columns)
				{
					undoHeaderBackground(obj);
				}				
			}
			
			protected function undoHeaderBackground(obj:Object):void {
				// Make the background of the header transparant again.
				var header:Object;
				var hu:TextField;		// DataGridItemRenderer is a subclass of TextField.		
				
				try  {
					header = getColumnHeader(obj.index);
					hu = header as TextField; 
				}
				catch (e:Error)
				{
					return;
				}
								
				// Only proceed for visible cells
				// 
				if (header && header.visible == true && hu)
				{
					hu.background = false;
											
				}							
			}
			
			protected function doHeaderBackgroundAll(event:Event):void
			{
				for each (var obj:Object in ch_columns)
				{
					doHeaderBackground(obj);
				}				
			}
			
			protected function doHeaderBackground(obj:Object):void {
				var header:Object;
				var hu:TextField;		// DataGridItemRenderer is a subclass of TextField.
				
				try  {
					header = getColumnHeader(obj.index);
					hu = header as TextField;
					trace (hu.name);

				}
				catch (e:Error)
				{
					trace ("Column not yet visible");
					return;
				}
				
				
				// Only proceed for visible TextField cells (hu will be null if header is not a TextField (e.g. a DataGridItemRenderer
				if (header.visible == true && hu)
				{
					// Deal with columns that we are removing
					if (obj.targetWidth == 0 && _columnHideColor >= 0 && !isNaN(_columnHideColor) )
					{
						hu.background = true;
						hu.alpha = 0.5;
						hu.backgroundColor = _columnHideColor;
						hu.borderColor = _columnHideColor;
						trace("colour " + _columnHideColor);
					}
					
					// Deal with columns we are unhiding
					if (obj.targetWidth != 0 && _columnShowColor >= 0 && !isNaN(_columnShowColor) )
					{
						hu.background = true;
						hu.alpha = 0.5;
						hu.backgroundColor = _columnShowColor;
						hu.borderColor = _columnShowColor;
						trace("colour " + _columnShowColor);
					}							
				}							
			}
			
			protected function doColResize(event:TimerEvent):void {				
				// Resize the columns
				// This is a pseudo-effect. We can't use normal effects, since
				// we can't perform effects on a single columns, only the whole
				// datagrid.
				var time:int = getTimer();	
				
				var copyCols:Array = this.columns;
				var l:DataGridColumn;
				var startWidth:uint;
				var endWidth:uint;
				var newWidth:uint;
				var completed:Number = event.target.currentCount / event.target.repeatCount;  // How far through are we?
				for (var i:String in ch_columns)
				{	
					
					l = copyCols[ch_columns[i].index];   // Reference to the column we are shrinking (in this.columns)
					startWidth = ch_columns[i].originalWidth;  // What was the original width?
					endWidth = ch_columns[i].targetWidth;  // What width are we aiming for?
					newWidth = startWidth - ( (startWidth - endWidth) *  completed );
					
					// We can't use "width = " as this requires all columns to be visible
					// instead use function mx_internal_setwidth()					 		
					if (newWidth > 0 && l.visible == false)
					{
						l.visible = true;
					}
					l.mx_internal::setWidth( newWidth );
					
				
					
					itemEditorInstance = null;  // Hiding or unhiding the last column falls over if we have an active item editor
					//invalidateDisplayList();
				}
				
				//this.columns = copyCols;
				this.quickResize();
				
				// Apply colours
				for each (var k:Object in ch_columns)
				{
					// We have to do a call later, otehrwise the colour gets overritten
					this.callLater(doHeaderBackground,new Array(k));	
				}
				
				
				trace("add / removed " + ch_columns.length + " columns");
				trace("Took " + (getTimer() - time) + " miliseconds");
				trace("Timestamp " + getTimer());
				
			}
			
				
			protected function doColResizeEnd(event:Event):void {			
				// Our column-resize effect	has finished				
				// Hide the columns where target size = 0
				var copyCols:Array = this.columns;
				for (var i:String in ch_columns)
				
				{	
					if (ch_columns[i].targetWidth == 0)
					{
						copyCols[ch_columns[i].index].mx_internal::setWidth(0);
						copyCols[ch_columns[i].index].visible = false;
					}
					else
					{
						copyCols[ch_columns[i].index].mx_internal::setWidth(ch_columns[i].targetWidth);
						copyCols[ch_columns[i].index].visible = true;
					}
				}
				this.quickResize();
				
				this.invalidateDisplayList();
				this.invalidateProperties();
				this.invalidateSize();
				super.columns = copyCols;
				
				
				// Re-add the event listeners that we removed from the resize
				quickResizeReAddListeners(); // listeners to turn column header blue
				drawSeparators(); // Listeners for columns resize
				
				//Re-activate tool-tips
				ToolTipManager.enabled = true;
				
				// Set the column headers back to the original colour
				// If we have  abuilt in delay, then wait before switching them back
				if (_columnShowAfterDuration == 0)
					{					
						this.callLater(undoHeaderBackgroundAll, new Array(new Event("")));
					}
				else
					{
						this.callLater(doHeaderBackgroundAll, new Array(new Event("")));
						var timer:Timer = new Timer(_columnShowAfterDuration, 1);
						timer.addEventListener(TimerEvent.TIMER_COMPLETE,undoHeaderBackgroundAll);
						timer.start();
					}
				
				
				// Now if datagrid is not horizontally scrollable, when we hide, show or resize columns,
				// the widths of the other columns will change. The DataGrid class does this for us.
				// Therefore we need to get the widths from the display.
				setVariantFromDisplay(new Event(""));
			}
			
			
			protected function contextShow(event:ContextMenuEvent):void 
			{
				// Function called if user right-clicks on the datagrid
				// and selects "Show Columns". Displays a popup
				// where the user can select to hide or show each column
				var cm_popup2:TitleWindow;
				var padding:uint = 3; // Padding of child elements in pixels
				var buttonHeight:uint = 20 // Height of button in pixels
				
				// Create the popup
				cm_popup = PopUpManager.createPopUp(this,TitleWindow,true) as TitleWindow;
				PopUpManager.centerPopUp(cm_popup);
				cm_popup2 = (cm_popup as TitleWindow);
				cm_popup2.showCloseButton = true;
				cm_popup2.width = 200;
				cm_popup2.height = 350;
				cm_popup2.title = "Columns";
				cm_popup2.layout = "absolute";
				
				// Create the datagrid for the popup
				cm_popup_dg = new DataGrid();
				cm_popup_dg.editable = true;
				
				// Set up the data for the popup data grid
				cm_popup_data = new Array();
				_variant.sort(sortByColNo);
				for (var i:String in _variant)
				{
					// If the column is not hideable, don't show it in the list
					// Note, you have to use VariantDataGridColumns if you want to flag a column as unhideable
					var lcol:Object = _oldColumns[i].ref;
					if (!lcol.hasOwnProperty("hideable") || lcol.hideable == true)
					{
						cm_popup_data.push( new Object() );
						var n:uint = cm_popup_data.length - 1;
						cm_popup_data[n].VISIBLE = _variant[i].VISIBLE;
						cm_popup_data[n].COL_NO = _variant[i].COL_NO;
						cm_popup_data[n].COL_ORDER = _variant[i].COL_ORDER;
						cm_popup_data[n].NAME = _oldColumns[i].headerText;		
					}			
				}
				cm_popup_data.sort(sortByColOrder); // We have to sort it as we can't have gaps in a dataprovider
				cm_popup_data = cm_popup_data.slice(0);
				cm_popup_data.filter(removeEmptyNames);
				cm_popup_dg.dataProvider = cm_popup_data;
				
				
				
				// Set up the datagrid itself
				cm_popup_dg.draggableColumns = false;
				cm_popup_dg.sortableColumns = false;
				
				
				// Set up the datagrid columns
				// We have to assign variables to Datagrid.columns[i],
				// it doesn't work the other way round
				
	
		    // Visible checkbox column
			//	use namespace internal;
				cm_popup_dg_c1 = cm_popup_dg.columns[0];
				cm_popup_dg_c1.editable = true;				
				cm_popup_dg_c1.dataField = 'VISIBLE';
				cm_popup_dg_c1.headerText = 'Show';
				cm_popup_dg_c1.rendererIsEditor = true;
				cm_popup_dg_c1.itemRenderer = new ClassFactory(VDG.ListCheckbox);
				//cm_popup_dg_c1.AS3::setStyle("paddingLeft",10);
				cm_popup_dg_c1.width = 38;
				
				
				// Name column			
				cm_popup_dg_c2 = cm_popup_dg.columns[1] ;
				cm_popup_dg_c2.editable = false;
				cm_popup_dg_c2.dataField = 'NAME';
				cm_popup_dg_c2.headerText = 'Column';
				
				// Col number column (Invisible)
				cm_popup_dg_c3 = cm_popup_dg.columns[2];
				cm_popup_dg_c3.visible = false;
				cm_popup_dg_c3.dataField = 'COL_NO';
				cm_popup_dg_c3.sortDescending = false;
				
				// Other columns				
				cm_popup_dg.columns[3].visible = false;
				
				
     			// Add the datagrid to the popup
				cm_popup2.addChild(cm_popup_dg);

				cm_popup_dg.setStyle("bottom",padding + buttonHeight + padding);
				cm_popup_dg.setStyle("top",padding );
				cm_popup_dg.setStyle("right",padding);
				cm_popup_dg.setStyle("left",padding);							
								
				// Create,the OK button
				cm_popup_ok = new Button();
				cm_popup2.addChild(cm_popup_ok);
				cm_popup_ok.height = buttonHeight;
				cm_popup_ok.x  = padding;
				cm_popup_ok.width  = 50;
				cm_popup_ok.label = "Ok";
				cm_popup_ok.setStyle("bottom",padding);
				cm_popup_ok.addEventListener(MouseEvent.CLICK,OK_ShowCols_Popup);
				
				
				// Add an event litener for the close button
				cm_popup2.addEventListener(CloseEvent.CLOSE,close_ShowCols_Popup);		
			
			}
			
			protected function contextReset(event:Object = ""):void 
			{
				// Disable tooltips
				ToolTipManager.enabled = false;
				
				
				var tempColumns:Array = new Array;
				
				var widthScale:Number;
				var totalOldColWidth:Number = 0; // Total of all widths stored in oldColumns
				var totalNowColWidth:Number = 0; // Total of all widths stored in columns (actual display)
				
				// Make all columns visible
				setColumnsToVisible();  // Otherwise we get errors trying to resize columns
				
				// Revert to the original sort order 
				for (var j:String in this.columns)
	    		{
	    			 tempColumns[j] = _oldColumns[j].ref;
	    			 var col:DataGridColumn = tempColumns[j];	    			
	    			 totalOldColWidth += _oldColumns[j].originalWidth;
	    			 totalNowColWidth += _oldColumns[j].ref.width;  			     			 
	    		}  	    		
	    		super.columns = tempColumns;
	    		
	    		// Scale the column widths so that they are in proportion to their original sizes.
	    		widthScale = totalNowColWidth / totalOldColWidth;
	    		
	    		// Now that the columns are in order and we've run "set columns", reset the width
	    		for (j in this.columns)
	    		{
	    			 tempColumns[j].width = (_oldColumns[j].originalWidth * widthScale);	    			     			 
	    		}
	    		
	    		// Just to neaten things up, reset the width again.
	    		for (j in this.columns)
	    		{
	    			 tempColumns[j].width = (_oldColumns[j].originalWidth * widthScale);	    			     			 
	    		}	    		  	
	    		
	    		// Finally, hide any columns that weren't originally visible
	    		for (j in this.columns)
	    		{
	    			if (!_oldColumns[j].wasVisible)
	    			{
	    				columns[j].visible = false;	
	    			}
	    		}
	    		
	    		
	    		// This needs to be called again after Flex has recalculated all
	    		// the column sizes. If this is the first call, call it again after 
	    		// everything has been redrawn
	    		
	    		if (event is Event)
	    		{
	    			this.callLater(contextReset);
	    		}
	    		else
	    		{
	    			// Restart any tooltips
					ToolTipManager.enabled = true;
	    		}
				
			}
			
			protected function close_ShowCols_Popup(event:Event):void {
				// Close the "Show columns" popup
				
				cm_popup.removeEventListener(CloseEvent.CLOSE,close_ShowCols_Popup);
				PopUpManager.removePopUp(cm_popup);
				cm_popup = null;
			}
			
			
			protected function OK_ShowCols_Popup(event:Event):void {
				// OK buton clicked, so take the values from the
				// "Show columns" popup and apply to the display
				// In other words, unhide and hide columns as per user decision
				cm_popup_data.sort(sortByColNo);
				
				ch_columns = new Array(); // Columns being hidden or unhidden
				var l_col:Object = new Object(); // Entry in ch_columns
				var l_index:uint; // Column number
				
				// Loop through each returned value and see if it has changed
				for (var i:String in cm_popup_data) {
					l_index = cm_popup_data[i].COL_NO;
					l_col.index =  _variant[l_index].COL_ORDER;
					if (cm_popup_data[i].VISIBLE == 'true' || cm_popup_data[i].VISIBLE == 'X' || cm_popup_data[i].VISIBLE == true)
						{
						if (_variant[l_index].VISIBLE != true)	
							{
								// Add an item to be un-hidden
								l_col.originalWidth = 0;
								l_col.targetWidth = 100// _variant[i].width;
								
								ch_columns.push(clone(l_col));
							}
						_variant[l_index].VISIBLE = true;
						
						}
					else
						{
						if (_variant[l_index].VISIBLE != false)
							{
								// Add an item to be hidden
								l_col.originalWidth = _variant[l_index].WIDTH;
								l_col.targetWidth = 0;
								ch_columns.push(clone(l_col));
							}	
						_variant[l_index].VISIBLE = false;	
						}				
				}
				
				
				// Update the display

				startColHideShow();

				close_ShowCols_Popup(event);

			}
			
			protected function getContextColumn(event:ContextMenuEvent):int
			{
				// Return the index of the column that was right-clicked on
				// This is the order of the column in the this.columns array,
				// so if there are hidden columns to the right of this one then they
				// will affect the return value
				
				var ret_val:int = -1;
				// Which column was the mouse on when it was right-clicked?
				// obj will normally be an item renderer
				var obj:Object = event.mouseTarget;	
				
				try
				{	
					// If the object clicked on was an item renderer / item editor (such as a column
					// item or column header) then we can determine the column from the listData object		
					ret_val =  obj.listData.columnIndex;
				}
				catch (e:Error)
				{
					// If the user has clicked on an empty item, there will be no item renderer
					// So we have to rely on mouseX
					var x:uint = event.mouseTarget.mouseX;
					var leftX:uint = 0;
					var rightX:uint;
					ret_val = -1;					
					for (var colid:String in this.columns)
					{
						var col:DataGridColumn = this.columns[colid];
						if (col.visible == true) // We only count visible columns
						{
							rightX = leftX + col.width;
							// LeftX and RightX represent the left and right boundaries of the column
							// Check to see if where the mouse was clicked falls between these two points
							if (leftX <= x && x < rightX)
								ret_val = uint(colid);
							
							leftX = rightX;	
						}
					} // End of "for" loop
					
				}
				
				return ret_val;
			}
			
			protected function setColumnsToVisible():void {
				// Makes all datagrid columns visible
				trace("Make all columns visible");
				
				// We need to set all columns as visible before setting width
				// This is so that the two arrays visibleColumns and Columns are the same
				// otherwise calls to "set width" will error.
				// The Flex Datagrid class expects all columns to be visible when the "set width"
				// method is called.
				
			    // We have already stored which columns should be visible in the variant, 
			    // so we can make them invisible again later
				var tempColumns:Array;
				tempColumns = this.columns;
				for (var k:String in tempColumns)
				{
					tempColumns[k].visible = true;
				}
				super.columns = tempColumns;
				mx_internal::visibleColumns = tempColumns;
				
			}		
		
			private function search(element:*, index:int, arr:Array):Boolean {
				// Check if the element supplied matches the values set in the global variables
				if (!element) return false;
				
				var ret:Boolean;
				if (element.headerText == g_searchHeader) // &&  element.id == g_searchId 
				{
					ret = true;
					g_searchIndex = index; // Save the index of the value returned
				}					
				else 
				{
					ret = false;
				}
				
				return ret;
				
			}
			
			override protected function makeRowsAndColumns(left:Number, top:Number,
                                        right:Number, bottom:Number,
                                        firstCol:int, firstRow:int,
                                        byCount:Boolean = false, rowsNeeded:uint = 0):Point
            {
            	// Override this method to catch errors
            	var point:Point;
            	trace ("Running makeRowsAndColumns");
            	trace ("Left: " + left);
            	trace ("Right: " + right);
            	trace ("Top: " + top);
            	trace ("Bottom: " + bottom);
            	trace ("firstCol: " + firstCol);
            	trace ("firstRow: " + firstRow);
            	trace ("byCount: " + byCount);
            	trace ("rowsNeeded: " + rowsNeeded);
            	trace("");

            		// Prolem is here somewhere
            		//this.listItems = [];
            		//this.rowInfo = []; // Force recalculation
            		point = super.makeRowsAndColumns(left, top,
                                                right, bottom,
                                                firstCol, firstRow,
                                                byCount, rowsNeeded)	
                                                
                   return point;                             
            }
		
		
	}
}