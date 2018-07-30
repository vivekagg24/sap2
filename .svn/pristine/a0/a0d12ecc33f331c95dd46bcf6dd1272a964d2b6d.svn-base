package
{
	import mx.collections.XMLListCollection;
	import mx.formatters.Formatter;
	import mx.formatters.DateFormatter;
	import mx.controls.listClasses.TileBase;
	import mx.controls.TileList;
	import mx.collections.XMLListCollection;
	import mx.core.ClassFactory;
	import mx.containers.Panel;
	import mx.controls.Button;
	import mx.core.UITextField;
	import mx.core.Container;
	
	
	/** Subclass of ShiftGrid specifically for planning rotas
	 * 
	 */
	public class ShiftGrid2 extends ShiftGrid
	{
		
		public function ShiftGrid2():void
		{
			// Create data
			super();
			createDataProvider();	
			super.direction = "vertical";
			
		}
		

		
		/** Create a column of shift names to the left of the TileLists
		 *  Since all itemRenderers in a TileBase must have the same height and width, we need to put these renderes
		 *  to the left (if we are in vertical mode, otherwise on top of) the repeater.
		 * 
		 *  Since we are a descendant of Box, we want these components not to be children of box. 
		 * 
		 */
		override protected function createChildren():void
		{
			super.setStyle("paddingLeft", headers_list_width);
			
			super.createChildren();
			
			if (!headers_list)
			{
				headers_list = new TileList();
				headers_list.explicitWidth = headers_list_width;
				headers_list.explicitHeight = this.height;
				headers_list.direction = direction;	
				headers_list.visible = true;
				headers_list.maxRows = 0;
				headers_list.maxColumns = 1;			
				headers_list.itemRenderer =  new ClassFactory(GridCell);	
				headers_list.dataProvider = dp_headers;	
				
				//rawChildren.addChild(headers_list);	
				addChild(headers_list);	
				
				var t:UITextField = new UITextField();
				t.text = "bob";
				this.rawChildren.addChild(t);
				
				
				var w:Button = new Button();
				w.label = "My button";
				w.explicitWidth = 100;
				w.explicitHeight = 20;
				this.rawChildren.addChild(w);
			}
			
			
			
			
			
			
			
		}

			
	
			
		
	}
}