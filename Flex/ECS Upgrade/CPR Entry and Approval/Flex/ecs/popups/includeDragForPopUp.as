// ActionScript file
// Include file - add this to a popup to allow user to drag it

 		import mx.events.DragEvent;
 		import mx.core.DragSource;
  		import mx.managers.DragManager;
  		import mx.core.IUIComponent;
  		
  		public var dragStartStageX:int;
  		public var dragStartStageY:int;
  		
  		/** Call this function on MouseDown to initiate the drag
  		 *  If your object is a TitleWindow, then thats all you need to do, 
  		 *  the TitleWindow will handle the rest
  		 */
  		protected function mouseDownHandlerForDrag(event:MouseEvent):void
  		{
  			if (!(event.target is IUIComponent))
  				return; // Stops errors
  			
  			
  			// Don't drag from the grid
  			if (event.target is DataGrid
  			     || (event.target as IUIComponent).parent is DataGrid
  			     || (event.target as IUIComponent).owner is DataGrid)
  			     return;
  			
  			// Don't drag from the buttons
  			if (event.target is Button || event.target is Panel)
  				return;
  				
  			// Don't drag from the panel
  			if ((event.target as Object).hasOwnProperty("id") && (event.target as Object).id == "pnl")
  				return;
  			
  			dragStartStageX = this.x - event.stageX;
  			dragStartStageY = this.y - event.stageY;
  			var ds:DragSource = new DragSource();	
  			DragManager.doDrag(event.currentTarget as IUIComponent, ds, event, null, 0, 0, 0);
  			
  			// Caching to make smoother
  			this.cacheAsBitmap;
  			if (this != event.currentTarget)
  				event.currentTarget.cacheAsBitmap();
  			

  			
  		}
  		
  		/** If the popup is of type Application, call this function on DragOver
  		 *  You don't need this function for TitleWindows.
  		 *  Its not as neat as the default handler, but its better than nothing.
  		 *  You also need to handle the DragEnter event.
  		 *  For example, see
  		 * 		dragEnter="DragManager.acceptDragDrop(event.target as IUIComponent)"
		 * 		mouseDown="mouseDownHandlerForDrag(event)"
	     * 		dragOver="handleDragOver(event);"
  		 */
  		private function handleDragOver(event:DragEvent):void
		{
			this.x = event.stageX + dragStartStageX;
			this.y = event.stageY + dragStartStageY;
			
			// Stop the event propagating - makes it smoother
  			event.stopImmediatePropagation();
			
		}
  		