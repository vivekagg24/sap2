// ActionScript file
import flash.events.Event;

		dg.removeEventListener("updateComplete",DataGridUpdated);

		DataProviderManager.ResetGrid();
		
		if(comboPubID.selectedItem != null){

			SelectedDept = comboPubID.selectedItem.data;						
		}else{
			SelectedDept = passedDept;			
		}
	}
	
	private function SelectPublication():void{

        for (var i:int = 0; i< publications.length; i++){	
        	
        	if(publications[i].data == SelectedDept){
        		
        		comboPubID.selectedIndex = i;
        		
        		return;
        	}
        }

    	comboPubID.selectedIndex = 0;
    	SelectedDept = publications[0].data;
		
	}
	
		
        var xmlCostLength:int  = xmlalldata.EX_T_VALID_DEPTS.item.length();

        publications = new Array();

        var i:Number=0;

        for (i=0; i< xmlCostLength; i++){

            var value:String = xmlalldata.EX_T_VALID_DEPTS.item[i].DEPT.toString();

            var key:String = xmlalldata.EX_T_VALID_DEPTS.item[i].DEPT_ID.toString();                         

            publications.push({label: value, data: key});
		}

    }
	
	private function buildDropdownList(list:XMLList,blanks:Boolean):Array{
		var arrayValues:Array = new Array();
		var currentValue:valueForDropdown;
		var i:int;
		var item:XML;
		for each(item in list.item){
			currentValue = new valueForDropdown();
			
			currentValue.data  = item.DATA.toString();
			currentValue.label = item.LABEL.toString();
		
			if (blanks || currentValue.label!="") arrayValues[i] = currentValue;
			
			i++;
		}
		return arrayValues;
	}

 	public function EnableButtons(Enable:Boolean):void{
 		
 		bEnableButtons = Enable;
 		
 	}
	
	
	private function RejectionTextPopup(CurrItemIdx:int):void{

		for(CurrItemIdx; ClaimItems.length > CurrItemIdx; CurrItemIdx++){
			
			RejText = RejectionText(PopUpManager.createPopUp(this, RejectionText ,true));
			
			RejText.ClaimIdx = CurrItemIdx + 1;
							
			RejText.title = "Rejection text: " + ClaimItems[CurrItemIdx].CASUAL_NAME;
			
			RejText.showCloseButton = true;	

			PopUpManager.centerPopUp(RejText);
		
		    RejText.addEventListener("close", RejectionTextWinClose);
			    
			RejText["btnCancel"].addEventListener("click", RejectionTextWinClose);   
            RejText["btnSave"].addEventListener("click", RejectionTextWinClose); 

			return;

		}
		
		RejectItems()
	}	

	private function RejectionTextWinClose(event:Event):void{

		var CurrIdx:int = RejText.ClaimIdx - 1;
			
		switch(event.target.id){
					
			case "btnSave":
				
				ClaimItems[CurrIdx].REJECT_TEXT = RejText.taRejText.text;
				
  				PopUpManager.removePopUp(RejText);
				
				break;
			
			case "btnCancel":

				ClaimItems[CurrIdx].SEL = "";
						
				PopUpManager.removePopUp(RejText);
				
				break;			

			case null:

				ClaimItems[CurrIdx].SEL = "";
				
				PopUpManager.removePopUp(RejText);
				
				break;			
		}

		CurrIdx = CurrIdx + 1;
				
		RejectionTextPopup(CurrIdx);
	}
	
	private function RejectItems():void{

		if(ClaimItems.length > 0){

			ServerRequest(cReject,'',0,null);
			
		}
	}
	
	public function PopulateCostCenters():void{

		var currentValue:valueForDropdown;
 
 	    var xmlCostLength:int  = xmlalldata.EX_T_COST_CENTERS.item.length();

        costCentres = new Array();

        var i:Number=0;

        for (i=0; i< xmlCostLength; i++){

			currentValue = new valueForDropdown();	
			
			currentValue.data  = xmlalldata.EX_T_COST_CENTERS.item[i].KEY.toString();
			currentValue.label = xmlalldata.EX_T_COST_CENTERS.item[i].VALUE.toString();
			currentValue.tip   = currentValue.label.substring(0);
	
			costCentres.push(currentValue);
        }
    	
    	setCostCentreDisplay();
    	
	    lstCostCentres.dataProvider= costCentresDisplay;
    
    }
    
    /** Handle resizing of the application
    * 
    */
    private function onResize(event:Event):void
    {
    	setCostCentreDisplay();
    }
    
    
    /** Decide whether to display part or all of the cost centre name
    */    
    private function setCostCentreDisplay(control:uint = 0):void
    {   
    	if (control == 0) // If not specified, show everything if there's room,
    	{                 // otherwise show just the name    	
    		control = 1;
    		if (Application.application.width < 1000)
    			control = 3;
    	}
    	
    	costCentresDisplayMode = control;
    	
    	costCentresDisplay = [];
    	
    	for each (var o:valueForDropdown in costCentres)
    	{
    		var o2:valueForDropdown = new valueForDropdown();
    		o2.data = o.data.substring(0);
    		o2.tip  = o.tip.substring(0);    		
    		
    		 switch (control)
    		{
    		case 1: // Show all
    			o2.label = o.label.substring(0);
    			break;
    		case 2: // Show cost centre number
    			o2.label = (o.label as String).substring(0, 4);	
    			break;
    		case 3: // Show cost centre name
    			o2.label = (o.label as String).substring(7);
    			break;   		
    		}
    		costCentresDisplay.push(o2);
    	}
    	// We need to trigger this manually since you can't
    	// data bind to an array.
    	if (lstCostCentres)
			lstCostCentres.dataProvider= costCentresDisplay;
    	
    }
    
	private function CreateClaimItemsForServerTrip():void{

		ClaimItems = new Array();
		
		// Loop through array, each element is another array containing ApprovalItems.
		for each (var CostCentreLine:ApprovalTree in dp){
			
			if (!CostCentreLine.isOpen && CostCentreLine.SEL == true){

				addCostCentreItems(CostCentreLine.childList);

			}else{

				for each (var WeekStarting:ApprovalTree in CostCentreLine.childList){
					
					if (!WeekStarting.isOpen && WeekStarting.SEL == true){
						 
						addWeekStartingItems(WeekStarting.childList);

					}else{
		
						for each (var Pernr:ApprovalTree in WeekStarting.childList){
		
							if (!Pernr.isOpen && Pernr.SEL == true){
								 
								addPernrItems(Pernr.childList);
		
							}else{
					
								for each (var Claim:ApprovalTree in Pernr.childList){
									
									if(Claim.SEL == true){
										addItem(Claim);
									}
								}
							}
						}	
					}
				}	
			}
		} 
	}
	
	private function addCostCentreItems(items:ArrayCollection):void{

		for each (var WkStartItems:ApprovalTree in items) {
			
			 addWeekStartingItems(WkStartItems.childList);
		}
	}

 	private function addWeekStartingItems(WkStartItems:ArrayCollection):void{
 	
		for each (var PernrItems:ApprovalTree in WkStartItems) {
			
			 addPernrItems(PernrItems.childList);
		} 	
 	}

 	private function addPernrItems(PernrItems:ArrayCollection):void{
 	
		for each (var item:ApprovalTree in PernrItems) {
			
			 addItem(item);
		} 	
 	}

	private function addItem(item:ApprovalTree):void{

	  		row.BEGUZ			 = TimeToSAPFormat(item.BEGUZ.toString());
	  		row.ENDUZ			 = TimeToSAPFormat(item.ENDUZ.toString());
			row.SEL				 = 'X';
			
			ClaimItems.push(row);
	}
	
	private function DateToSAPFormat(sDate:String):String{
		
		var SAPDate:String = sDate.substr(6,4) + sDate.substr(3,2) + sDate.substr(0,2) 
	
		return SAPDate;	
				
	}
	
	private function TimeToSAPFormat(sTime:String):String{

		var SAPTime:String = sTime.substr(0,2) + sTime.substr(3,2) + '00';
	
		return SAPTime;	
		
	}
	
	private function SetBusyCursor():void{
		CursorManager.removeAllCursors()

	}
		// Note - the Date class copes with negative values. So if the date is 02.02.2008, 
		// and we tell it to subtract three from the month (i.e. data.month = -1) then it 
		// knows to change to 02.11.2007 (i.e. the previous year).
		
		const saturday:uint = 6;
		
		
		var daysAferSaturday:int = Today.day - saturday;
		if (daysAferSaturday < 1) daysAferSaturday += 7;
		previousSaturday.date = previousSaturday.date - daysAferSaturday;

		
		
	}
	
	public function tipFunction(obj:Object):String{
		return obj.tip;
		