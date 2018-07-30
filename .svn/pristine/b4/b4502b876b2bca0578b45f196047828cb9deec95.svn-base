// ActionScript file
// Handles processing (approval and rejection) of retainer contracts

i/* mport mx.managers.PopUpManager;
import mx.core.IFlexDisplayObject;
import flash.events.Event;
import mx.collections.XMLListCollection;

			// Count number preapproved / approved / MD approvad
			private var count_preapproved:uint;
			private var count_mdapproved:uint;
			private var count_approved:uint;
			private var count_error:uint;
			private var count_rejected:uint;
           
        public function doApprove():void {
            	wsDoApprove.Z_CAS_MISC_APPROVE.request.ITEMS = getSelected();
				wsDoApprove.Z_CAS_MISC_APPROVE.send();	
            }
            
            public function doReject():void {
            	wsDoReject.Z_CAS_MISC_REJECT.request.ITEMS = getSelected();
            	wsDoReject.Z_CAS_MISC_REJECT.send();           	
            }	     

            public function doHold():void {
          	    resultMessages = new Array();
                errorMessages = new Array();
            	getSelected();
            	if (count_selected == 0) {
            		Alert.show('Please select at least one contract.');
            		return;
            	}
            	// If at least one contract was selected, continue
            	       	            	
				// Initialise the count of records processed and set up the mode
            	processsing_index = 0;
            	count_error = 0;
            	count_rejected = 0;
            	mode = c_rejecting;
            	
            	// Now call the first record, and which will call the second record when it is finished, and so on
            	processNext();   
          	
            }
            
            private function getSelected():Array {
            	// Get selected items
            	var selectedItems:Array = new Array();
            	var allItems:XMLList = new XMLList(wsGetItemsToApprove.Z_CAS_MISC_GET_ITEMS.lastResult..item);
            	for each (var x:XML in allItems)
            	{
            		var selected:String = x.APPREJ;
            		if (selected == 'X')
            		{
            			var y:XML = new XML("<item/>");
            			y.WIID = x.WIID;
            			y.APPREJTEXT = x.APPREJTEXT;            			
            			selectedItems.push(y);
            		} 
            	}
            	return selectedItems;
            } 
            
           
            private function RejectionTextPopup(name1:String):void{
		  	
				rejText = RejectionText(PopUpManager.createPopUp(this, RejectionText ,true));
			
				rejText.ClaimIdx = processsing_index;
							
				rejText.title = "Rejection text: " + name1;
			
				rejText.showCloseButton = true;	

				PopUpManager.centerPopUp(rejText);
		
				// Tell the popup to call "processNext()" if the user clicks cancel.
				// This will skip to the next contract, and if there are no more contracts,
				// it will terminate processing.
		    	rejText.addEventListener("close", processNextHandler);
			    rejText["btnCancel"].addEventListener("click", processNextHandler); 
			    
				// Tell the popup to call the web service to reject the contract if the user
				// clicks ok. This will tell SAP to reject the contract, and then carry on processnig			      
           		rejText["btnSave"].addEventListener("click", triggerRejectionWebService); 
				
				// Our work is done. The popup will handle the next action.
				return;
		}
		
		
		private function triggerRejectionWebService(event:Event):void {
			// Sets the text from the popup
			if (event.target
			    && event.target.parent
			    && event.target.parent.taRejText)
			   		rejectionReason = event.target.parent.taRejText.text;
			
			// If a popup triggered this event, close it
			// Note that event target will be the button, we need to check its parent object
			if (event.target
			    && event.target.parent
			    && event.target.parent.isPopUp
			    && event.target.parent.isPopUp == true)
					PopUpManager.removePopUp(event.target.parent as IFlexDisplayObject);
			
			
			// And call the web service to cancel the Contract
			wsDoReject.Z_ECS_REJECT_RET_PAYMENTS.send();
		} */
		
