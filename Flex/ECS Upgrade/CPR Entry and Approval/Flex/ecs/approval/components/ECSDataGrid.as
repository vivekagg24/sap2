package ecs.approval.components{
   import mx.core.*;
   import mx.controls.dataGridClasses.*;
   import mx.controls.DataGrid;
   import flash.display.*;
   import mx.collections.ArrayCollection;
   import VDG.VariantDataGrid;
   import VDG.HideShowDataGrid;
   import mx.events.CollectionEvent;
   import mx.collections.ICollectionView;
   import flash.events.ContextMenuEvent;
   import mx.controls.listClasses.ListRowInfo;
   import mx.controls.Alert;
   import mx.controls.Tree;
   import ecs.generalClasses.ApprovalTree;
   import flash.ui.ContextMenuItem;
   import ni.components.cas.QueryPopup;
   
   /***********************************************************************
   * ECSDataGrid.as
   * Class overrides datagrid so that it can change the row colour according 
   * to the data for that row
   * *********************************************************************/
   public class ECSDataGrid extends VariantDataGrid
   {   	 
   	
	// Context menu
	public const CONTEXT_QUERY_DO:String = "Mark as query";
	public const CONTEXT_QUERY_CANC:String = "Cancel query";
   	
   	public var skipNextDraw:Boolean = false;
   	
   	// When right-clicking, we get a context menu
   	// This object is the data behind the line that was clicked
   	protected var contextLine:ApprovalTree;
   	  
   
   override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number,
                                                   color:uint, dataIndex:int):void
   {
        // make any tests here, then change color accordingly. For example: color = 0xFF0000; 
        // call the super function to make it happen.
        var allData:ArrayCollection= (dataProvider as ArrayCollection);
        if (dataProvider!=null && allData.length>dataIndex){ 
	        var item:Object ;
	       
	        item = allData.getItemAt(dataIndex);
	        if (item.costCentreLine){
	        	color = 0xC0D9F2;
	        	  
	        }
	        else if (item.batchLine)
	        {
	            color = 0xffff80;   
	          
	        } 
      	       
        }
        super.drawRowBackground(s,rowIndex,y,height,color,dataIndex);
        
    } 

	
/* 	override public function set dataProvider(value:Object):void
	{
		super.dataProvider = value;
		updateRowCount();
		if (value is ICollectionView)
		{
			(value as ICollectionView).addEventListener(CollectionEvent.COLLECTION_CHANGE, updateRowCount);
		}
		
	}
	
	/**
	 * Set the size of the datagrid so that all rows are shown, by setting the rowCout property
	 */
/* 	private function updateRowCount(event:Object = ""):void
	{
		var numRows:int = this.dataProvider.length + 2; // +1 for the header line, +1 for an empty row at the end
		if (numRows < 5) numRows = 6;
		this.rowCount = numRows;		
	} */ 
	
	/**
	 * Sometimes we don't want to redraw the entire datagrid when the dataprovider changes. 
	 * In these instances, we set the skipNextDraw flag, then change the individual Item Renderers 
	 * manually.
	 */
	override protected function updateDisplayList(unscaledWidth:Number,
    unscaledHeight:Number):void
    {
    	if (skipNextDraw)
    	{
    		skipNextDraw = false;
    		itemsSizeChanged = false;
    		return;
    	}

    	super.updateDisplayList(unscaledWidth,  unscaledHeight); 
  
    }

	// Handle right click
	override protected function contextSelect(event:ContextMenuEvent):void
	{
		super.contextSelect(event);
		
		// First set up the items for query
		var query_do:ContextMenuItem;
		var query_canc:ContextMenuItem;
		for each (var item:ContextMenuItem in contextMenu.customItems)
		{
			if (item.caption == CONTEXT_QUERY_DO || item.caption == CONTEXT_QUERY_CANC)
				item.visible = false;
			
			if (item.caption == CONTEXT_QUERY_DO)
				query_do = item;
				
			if 	(item.caption == CONTEXT_QUERY_CANC)
				query_canc = item;				
		}
		if (!query_do)
		{
			query_do = new ContextMenuItem(CONTEXT_QUERY_DO, true, false, false);
			query_do.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, queryContextSelect);
			contextMenu.customItems.push(query_do)
		}
		if (!query_canc)
		{
			query_canc = new ContextMenuItem(CONTEXT_QUERY_CANC, true, false, false);
			query_canc.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, queryContextSelect);
			contextMenu.customItems.push(query_canc)
		}		
		contextMenu.customItems = contextMenu.customItems;
		// Refresh
		
		/** Get row that was clicked **/
		// This doesn't work if the user clicked on something that wasn't an item renderer, such as an empty row or
		// a row with no renderer
		var obj:Object = event.mouseTarget;
		var data:ApprovalTree; // The row that was clicked
		
		for (var i:int = 0; i < 4; i++)
		{
			if (!data && obj.hasOwnProperty("data") && obj.data is ApprovalTree)			
			{
				data = obj.data as ApprovalTree;
			}
			else
			{
				obj = obj.parent;
			}			
		}
		contextLine = data;
		if (!data) return;
		
		
		// Check its not an expand/collapse lign
		if (data.childList.length > 0)
			return;
			
		// If we are already on query, show the "Cancel query" option, else show the "Query" option	
		if (data.onQuery)
		{
			query_canc.visible = true;	
			query_canc.enabled = true;	
			contextMenu.customItems = contextMenu.customItems; // Refresh
		}
		else
		{
			query_do.visible = true;
			query_do.enabled = true;
			contextMenu.customItems = contextMenu.customItems; // Refresh
		}
	}	
				 
	
	private function queryContextSelect(event:ContextMenuEvent):void
	{
		var l_caption:String = (event.currentTarget as ContextMenuItem).caption;
		if (l_caption == CONTEXT_QUERY_CANC)
		{			
			QueryPopup.show(this, contextLine, parentApplication.ws1.Z_ECS_PUT_ON_QUERY, parentApplication.refreshGrid);
		}
		else if (l_caption == CONTEXT_QUERY_DO)
		{
			QueryPopup.show(this, contextLine, parentApplication.ws1.Z_ECS_PUT_ON_QUERY, parentApplication.refreshGrid);
		}
		
	}

       
}

}