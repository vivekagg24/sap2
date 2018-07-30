package VDG
{
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.DataGrid;
	
	//namespace vdg_internal;
	import VDG.vdg_internal;
	use namespace VDG.vdg_internal;
	
	
	public class VariantDataGridColumn extends DataGridColumn
	{
		public function VariantDataGridColumn(columnName:String=null)
		{
			//TODO: implement function
			super(columnName);
		}
		
		// We shouldn't use mx_internal::owner, since this isn't part of the api, so instead we use
		// our own "owner", which is set by the VariantDataGrid.
		// Even if the API changes, we can still use this variable to access the datagrid
		vdg_internal var owner:VariantDataGrid;

		override public function set width(value:Number):void {
			super.width = value;
			
		}
		
		// Override this method to fix a bug in the standard Flex code
		// which makes the tooltip appear as XML.
		// This bug occurs when the dataprovider is XML rather than an Array or ArrayCollection
		override public function itemToDataTip(data:Object):String
		{
			var return_string:String = super.itemToDataTip(data);
			var type:String = typeof(data);
			
			use namespace VDG.vdg_internal;
			if (data is XML && dataTipFunction == null && owner.dataTipFunction == null)
			{
           		var field:String = dataTipField;
            	if (!field)
                	field = owner.dataTipField;
            	if (data[field] != null)
                	data = data[field];
            	else if (data[dataField] != null)
                	data = data[dataField];
                	
                
				if (data is String)
           	 		return String(data);
           	 		
       			try
        		{
            		return data.toString();
        		}
        		catch(e:Error)
        		{
        		}	                	
        	}


			
			
			return return_string;
		}
		
		
		[Inspectable]
		// Can this column be hidden?
		// If we use normal DataGridColumns, every column is hideable
		
		// Note - You can also use "hideable = false" to indicate that an invisible column cannot be unhidden
		
		public var hideable:Boolean = true;
		

		
	}
}