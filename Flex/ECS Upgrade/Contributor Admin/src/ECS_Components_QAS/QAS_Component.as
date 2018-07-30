package ECS_Components_QAS
{
	import mx.controls.Button;
	import mx.controls.DataGrid;
	import mx.controls.Text;
	import mx.core.UIComponent;
	import mx.rpc.http.mxml.HTTPService;
	import mx.events.ListEvent;
	import mx.rpc.events.ResultEvent;
	import flash.events.Event;
	import mx.controls.TextInput;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.Container;
	import mx.containers.Panel;
	import mx.managers.CursorManager;

	
	// Notes on using this component
	// This component can either be used as an inline component or as a popup. 
	
	// The component should first be created, then the search should be started 
	// with a call to method "startSearch", passing the search string. Only the
	// "close" button will be available to the user until valid search results
	// have been returned. This prevents events being triggered which would confuse
	// both the user and QAS.
	
	// The component can be created with any size. The 4 buttons always appear along the buttom.
	// and the DataGrid will size itself to take up all the remaining space automatically.
	// It is advisable to make sure the component is at least big enough to display all four buttons
	// i.e. a minimum width of 400 pixels.
	
	// Once the user has found an address, the QAS and SAP sessions are closed, the
	// component is made invisible, and the "address" and "closed" events are both triggered.
	// If the component is being displayed as a popup, don't forget to remove the popup.

	public final class QAS_Component extends  Panel // Container // UIComponent
	{

		
		//  declare all the visual sub components
		private var grid:DataGrid;
		private var grid_col:DataGridColumn;
		private var button_selection:Button;
		private var button_names:Button;
		private var button_undo:Button;
		private var button_close:Button;
		//private var button_search:Button;
		//private var searchText:TextInput;
		
	    // declare the non-visual sub-components (the http service)
	    private var QAS:HTTPService;
	    
	    // declare global variables for binding
	   	[Bindable]
		public var result:XML;
		[Bindable]
		public var xml_address:XML;
	    
	    
		            public  function QAS_Component()
		{
			super();
				
			setup_elements();
			allign_elements();	
			
		}
  		  
  		        // Function to start the search with the parameters passed
      public  function startSearch( search_text:String ):void{
   	
            // 1 - Close the search in the QAS server
            var closeQASRequest:Object = {'close_qas':'X'};
            QAS.send(closeQASRequest);
            
            // 2 - Close the SAP session
            var closeRequest:Object = {'sap-sessioncmd':'close'};
            QAS.send(closeRequest);
            
            // 3 - Clear out the data
            result = null;
            
            grid.dataProvider = "loading...";
            
            // 4 - Send request
			var request:Object= {search:search_text };

		    QAS.send(closeRequest);
		    
			var oRequestCall:Object = QAS.send(request);
			
			oRequestCall.marker = "QAS_marker";
			
  		}
   
    // Function "close" can be called internally or externally, so is public
        public  function close(event:Event):void {

        	// 1 - Close the search in the QAS server
	       	var closeQASRequest:Object = {'close_qas':'X'};

        	QAS.send(closeQASRequest);
        	
        	// 2 - Close the SAP session
        	var closeRequest:Object = {'sap-sessioncmd':'close'};
        	QAS.send(closeRequest);

        	// 3 - Clear out the data
        	result = null;
        	grid.dataProvider = result;

   			// 4 - Hide this box
   			this.visible = false;

   			// 5 - Finally, throw closed event
   			var closeEvent:Event = new Event("closed");
   			dispatchEvent(closeEvent); 
        }
 
                // Private internal processing 
				    private function click_undo(event:Event):void
		{
			var request:Object= {undo:'X'};

			var oRequestCall:Object = QAS.send(request);         
		
			oRequestCall.marker = "QAS_marker";
			
			
		}
				    private function click_names(event:Event):void
		{
			var request:Object= {names:'X'};

			var oRequestCall:Object = QAS.send(request);         
		
			oRequestCall.marker = "QAS_marker";
			
			
		}
					private function click_selection(event:Event):void
		{
			if (grid.selectedIndex != -1) 
			{
				var selected_line:int = grid.selectedIndex + 1; 
				var request:Object= {sel_line:selected_line };
				var oRequestCall:Object = QAS.send(request);         
		
				oRequestCall.marker = "QAS_marker";
			}
			
		}
				   	private function handleDoubleClick(event:mx.events.ListEvent  ):void
		{
               var index:int = event.rowIndex;
               var request:Object= {sel_line:index };
  			   var oRequestCall:Object = QAS.send(request);
            
			   oRequestCall.marker = "QAS_marker";
			
			
		}
		  	        private function XMLReturned(event:ResultEvent):void
		{
						var oCallResponse:Object = event.token;

  						var Return_message:String;
  							 			
	  					result = new XML(QAS.lastResult);
	  				
	  					if (result != "" && result.hasOwnProperty("address") && result.address != "") 
	  					// If address found, finish search, raise event, and close
							{
								xml_address = new XML (result.address);
							//	var closeRequest:Object = {'sap-sessioncmd':'close'};
							//	QAS.send(closeRequest);
								var addressEvent:AddressEvent = new AddressEvent( result.address );
								dispatchEvent(addressEvent);
								close(addressEvent);
                                return;
							} 
						if (result !="" && result.hasOwnProperty("lines")  && result.lines != "") 
						// If lines are returned, update the display
							{	
										enableButtons();
										grid.dataProvider = result.lines.line;
										grid.executeBindings(false);
										grid.validateDisplayList();
										
							}
						if (result !="" && result.hasOwnProperty("error")  && result.error != "") 
						// If lines are returned, update the display
							{	
										doFailed(result);

										
										
							}
		}
				    private function setup_elements():void {
				    	
				    this.visible = true;	
				    // initial setup of child container elements	
				    
				    // Set up the data grid
				    grid = new DataGrid();
				    grid.id = "grid";
				    grid.doubleClickEnabled = false; // Grid is disabled until results come back, then it is enabled
					grid.addEventListener("itemDoubleClick", handleDoubleClick);
					grid.dragEnabled = false;
					addChild(grid);
					
					// Set up data grid column
					grid_col = new DataGridColumn();
					grid.columns = [grid_col];
					grid_col.headerText="QAS Address Search Hit list";
					grid_col.dataField = "data";
					
					// Set up buttons
					button_selection = new Button();
					button_names = new Button();
					button_undo = new Button();
					button_close = new Button();
					
					button_selection.label="Selection";
					button_names.label = "Names";
					button_undo.label="Undo";
					button_close.label="Close";
					
					button_selection.enabled = false; // Button is disabled until results come back, then it is enabled
					button_names.enabled = false; // Button is disabled until results come back, then it is enabled
					button_undo.enabled = false; // Button is disabled until results come back, then it is enabled
					button_close.enabled = true; // This button is always active
					
					button_selection.addEventListener("click", click_selection);
					button_names.addEventListener("click", click_names);
					button_undo.addEventListener("click", click_undo);
					button_close.addEventListener("click", close);
					
					addChild(button_selection);
		//			addChild(button_names); // Functionality removed in QAS upgrade
					addChild(button_undo);
					addChild(button_close);
					
						// Now set up the HTTP service
					QAS = new HTTPService();
					QAS.useProxy = false;
					QAS.method = "GET";
					QAS.showBusyCursor = true;
					QAS.resultFormat = "e4x";
					QAS.addEventListener("result",XMLReturned);
					// QAS.url = this.url;
            
					
				    }
				    private function allign_elements():void {
    	
				    	
			// Allign visible elements and set all properties
			
			this.layout = "absolute"; 
		    var horizontalMargins:int = this.viewMetricsAndPadding.right + this.viewMetricsAndPadding.left;
			var verticalMargins:int = this.viewMetricsAndPadding.top + this.viewMetricsAndPadding.bottom;
					
			grid.x = 10;
			grid.y = 10;
			grid.width = this.width - horizontalMargins - 20  // 390;
			grid.height = this.height - verticalMargins - 47 //173;


			button_selection.x = 10;
			button_selection.y = this.height - verticalMargins - 27  //190;
			button_selection.width = 73;
			button_selection.height = 20;

			
			button_names.x = 90;
			button_names.y = this.height - verticalMargins - 27  //190;
			button_names.width = 73;
			button_names.height= 20;
			button_names.id = "names";
			
			
			button_undo.x=170;
			button_undo.y = this.height - verticalMargins - 27  //190;
			button_undo.height=20;
			button_undo.width=73;
					
			
			button_close.x = 250;
			button_close.y = this.height - verticalMargins - 27  //190;
			button_close.height=20;
			button_close.width=73;
			
					
			
		}
                    private function doFailed(result:XML):void {
                    // Display error message and eactivate all butons apart fromm "close"
                    					grid.dataProvider = result.error	;
										grid_col.dataField = "message";
										grid.executeBindings(false);
										grid.validateDisplayList();
										button_undo.enabled = false;
										button_names.enabled = false;
										button_selection.enabled = false;
										grid.enabled = false;
                    	
                    }
					private function enableButtons():void {
					// Until the first search results are returned, only the "close" button is active
					// Once a result has come back, as long as that result isn't an error, the buttons are activiated
						if ( button_names.enabled == false ) {
							button_names.enabled = true;
							button_undo.enabled = true;
							button_selection.enabled = true;
							grid.enabled = true;
							grid.doubleClickEnabled= true;
							
						}

     							  

       								
    						}
    		override public function set width(value:Number):void
    							{
    						    if (super.width == value)
      						      return;

   							     super.width = value;
								 allign_elements();
				
								}
			override public function set height(value:Number):void
    							{
    						    if (super.height == value)
      						      return;

   							     super.height = value;
								 allign_elements();
				
								}
			public function set service_url(value:String):void {
				// When the url is set, set the url of the web service too
				QAS.url = value;
			}
			public function get service_url():String {
				// When the url is set, set the url of the web service too
				return QAS.url;
			}
	}
	
	
	


}