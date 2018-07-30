// ActionScript file
// Handles processing (approval and rejection) of retainer contracts

import mx.managers.PopUpManager;
import mx.core.IFlexDisplayObject;
import flash.events.Event;
import mx.collections.XMLListCollection;

			// Count number preapproved / approved / MD approvad
			private var count_preapproved:uint;
			private var count_mdapproved:uint;
			private var count_approved:uint;
			private var count_error:uint;
			private var count_rejected:uint;


                      
            public function processingComplete():void {
            	// Approval or rejection of all contracts is complete.
            	
            	// Enable the back button and
            	// show the status as "complete"
            	//progBar.label = "Complete";
            	//goBackButon.visible = true;
            	//goBackButon.enabled = true;	
            	processing = false;
            	var resultText:String = "";
            	
            	switch (mode) {
            		case c_rejecting:
            			if (count_selected == 1) 
            				resultText = count_rejected +
            			             " contract successfully rejected. \r";
            			else
            				resultText = count_rejected +
            			             " contracts successfully rejected. \r";                			             
            			break;
            		case c_approving:
            			switch (count_preapproved) {
            				case 0:
            					break;
            					// Do nothing            					
            				case 1:            				
            					resultText += count_preapproved +
            			             " contract successfully preapproved. \r";
            			        break; 
            			    default:
            			        resultText += count_preapproved +
            			             " contracts successfully preapproved. \r";
            			        break;   
            			}
            			switch (count_approved + count_mdapproved) {
            				case 0:
            					break;
            					// Do nothing            					
            				case 1:
            					resultText += (count_approved + count_mdapproved) +
            			             " contract successfully approved. \r";
            			        break; 
            			    default:
            			        resultText += (count_approved + count_mdapproved) +
            			             " contracts successfully approved. \r";
            			        break;   
            			}
            				if (resultText == "") resultText = "0 contracts successfully approved. \r";
	
            			break;
            	}
            	if (count_error == 1 )
            		resultText +=  "1 contract errored. \r";
            	if (count_error > 1 )
            		resultText += count_error +  " contracts errored. \r";
            		
            	// Output the results
            	if (count_error > 0)
            	{
            		for (var j:int = 0; j < errorMessages.length; j++)
            		{
            			resultText += "\r";
            			resultText += errorMessages[j];
            		}          		
            	}
            	
            	Alert.show(resultText);
            	doRefresh();
            }
            
            public function processingReturned(event:ResultEvent):void {
				// We have the result of a rejection or an approval back from SAP
				var b:XML = new XML(event.result);
				var d:String;
				
				// Store result message
				resultMessages.push(b.EX_RETURN_MESSAGE);
							
				
				// Update counters
				if (b.EX_RETURN_CODE) 
				{
					d = b.EX_RETURN_CODE;
					if (d != "0") // If error
					{
					    count_error ++;
					    var message:String = "Error with retainer for " + b.EX_CONTRIB_NAME1;
					    message += "\r" + b.EX_RETURN_MESSAGE + "\r";
					    errorMessages.push(message);
					}
					else if (mode == c_rejecting) 
					{
					    count_rejected ++;
					} 
					else
					{
						d = b.EX_APPROVAL_TYPE;
						switch (d) {
							case 'A':
								count_approved ++;
								break;
							case 'P':
								count_preapproved ++;
								break;
							case 'M':
								count_mdapproved ++;
								break;
					}
						
						
					}					  
				}

				// Get the next record, or finish if we are done
				processNext();
            }
            
            public function doApprove():void {
            	wsDoApprove.Z_CAS_HR_APPROVE.request.ITEMS = getSelected();
				wsDoApprove.Z_CAS_HR_APPROVE.send();	
            }
            
            public function doReject():void {
            	wsDoReject.Z_CAS_HR_REJECT.request.ITEMS = getSelected();
            	wsDoReject.Z_CAS_HR_REJECT.send();           	
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
            	var allItems:XMLList = new XMLList(wsGetItemsToApprove.Z_CAS_HR_GET_ITEMS.lastResult..item);
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
            
            private function processNextHandler(event:Event):void {
            	// Use this function when we want "processNext" to be triggered by an event
            	
            	// If a popup triggered this event, close it
				// Note that event target will be the button, we need to check its parent object
				if (event.target
			  	   && event.target.parent
			  	   && event.target.parent.isPopUp
			 	   && event.target.parent.isPopUp == true)
				PopUpManager.removePopUp(event.target.parent  as IFlexDisplayObject);
				
				// Now call processNext
				processNext();
				
            }
            
            private function processNext():void {
            	// Process each item in sequence. Once each item is processed, this function is
            	// called again.
            	            	
            	// Make sure we are in the Approving viewstate
            	// The Approving viewstarte is used for both approving and rejecting
            	//if (currentState == null || currentState == ''	) currentState = 'Approving';
            	
            	// Set up visual stuff
            	//goBackButon.visible = false;
            	//progBar.label = mode;
            	//progBar.setProgress(processsing_index,count_selected);
            	
            	// Check to see if we've processed all contracts. If we have, then finish,
            	// else carry on with the next contract
            	if (processsing_index == count_selected) {
            		processingComplete(); // We've finished
            		return;
            	}
            	processsing_index++;
            	
            	// Get the record to procees and tell the webservice which retainer contract
            	// to approve or reject when it runs.            
            	var i:int = processsing_index - 1; // Since Actionscript arrays start at index 0
            	var x:XML = new XML( table_selected[i] )
            	PUB_ID = x.PUBID;
            	CONTRACT_ID = x.CONTRACT;
            	table_selected_XMLList[i].PROGRESS = mode;
            	            	
            	switch (mode) 
            	{
            		case c_rejecting:
            			RejectionTextPopup(x.NAME1);
            			//wsDoReject.Z_ECS_REJECT_RET_PAYMENTS.send();
            			break;
            		case c_approving:
            			wsDoApprove.Z_ECS_APPROVE_RET_PAYMENTS.send();
            			break;
            	}
            	          	
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
		}
		
