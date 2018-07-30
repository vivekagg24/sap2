
private function QuickAddress():void{

    EnableAddressFieldsAfterQASearchIsUsed();

	if (tiQuickAddress.text && tiQuickAddress.text != "")
    {
		CursorManager.setBusyCursor();
	
		popup = new QAS_Component();
		PopUpManager.addPopUp(popup,this,true);
  		PopUpManager.bringToFront(popup);
  		
		popup.height = 320;
		popup.x=100;
		popup.y=100;
		popup.setStyle("backgroundColor","#808000");
		popup.width = 440;
	/*	popup.service_url = "http://saponi.ni.ad.newsint:8080/sap/bc/bsp/sap/zecs_qas/qas.do?sap-client=007"  */
		popup.service_url = getUrlQAS();
		popup.startSearch( tiQuickAddress.text );
		popup.addEventListener("AddressFound",handle_address_found);

		CursorManager.removeBusyCursor();
    }
    else
    {
    	// Do nothing
    }
}

private function getUrlQAS():String {
	var retUrl:String;
	
	if (Security.sandboxType == Security.REMOTE)
		retUrl = "/sap/bc/bsp/sap/zecs_qas/qas.do";
	else
		retUrl = "http://vecdci.ds.newsint:8000/sap/bc/bsp/sap/zecs_qas/qas.do?sap-client=007";
	
	return retUrl;
}



public function handle_address_found(event:AddressEvent):void {
	
	var HouseNumber:String;
	var Street:String;
	var MidInitial:String;
	var Forename:String;
	var Organisation:String;

//*      Organisation = event.address.child("ORG");
      
//*      if(Organisation != ""){
//*	#64	tiAgency.text = Organisation;	
//*	#64	comboContribTypes.ChosenValue = 'A';
		
	//	ProcessNewContribType();  // Removed GYORk 10 11 2007 - this was resetting the "payment to" field
	                               // when quick address came back
		
//* 	}else{

/* 

// ----------------------------------------------------------------
// 8.6.2007 ECS Enhancements - Test Tracker issue #64 - Neil Wilson
// ----------------------------------------------------------------

// Names are no longer updated by quick address. 
// I'm not entrely happy about the way SUPPREM was handled but I guess there is
// no "perfect" way so to keep it simple, lt's try not handlng it at all.

     Alert.show("Is this individual a Staff member?","Contributor type", Alert.YES | Alert.NO,this,HandleContribTypeChoice,null,Alert.NO);

		MidInitial = event.address.child("MIDINITIAL");
		Forename = event.address.child("FORENAME") 
	
		tiFirstName.text = Forename + " " + MidInitial; 
		tiSurname.text = event.address.child("SURNAME");
		
		if(tiSurname.text == ""){
			
			tiSurname.text = event.address.child("SUBPREM");			
	    }

*/
	
//	}

// expression to use when debugging: event.address


	tiHouse.text  = "";
    tiStreet.text = "";



	
//    tiHouse.text     = event.address.child("SUBPREM");
	var formattedName:String = event.address.child("SUBPREM");	
	var splitName:Array = formattedName.split(/ /);
	if (   splitName[0] == 'Mrs'
	    || splitName[0] == 'Mr'
	    || splitName[0] == 'Ms'
	    || splitName[0] == 'Dr'
	    || splitName[0] == 'Sir'
	    )
	    {
	    	splitName.splice(0,1);
	    }
	    
    switch (comboContribTypes.selectedIndex)
    {
    	case 0: // Agency
    		tiAgency.text = formattedName;
    	
    	case 1: // Freelancer
    	
    		tiFirstName.text = splitName[0];
    		tiSurname.text = splitName[splitName.length - 1];
    	
    	case 2: // Staff
    	
    		tiFirstName.text = splitName[0];
    		tiSurname.text = splitName[splitName.length - 1];
    }
    
	 tiHouse.text     = event.address.child("BDNAME");
    tiStreet.text    = event.address.child("THFARE");
	tiTown.text      = event.address.child("LOCAL");
 	tiCity.text      = event.address.child("POSTTOWN");
	tiPostCode.text  = event.address.child("POSTCODE");
	
	
    PopUpManager.removePopUp(popup);
    
	tiQuickAddress.text = "";
    			
}

private function HandleContribTypeChoice(oEvent:CloseEvent):void{

		if (oEvent.detail==Alert.YES){

			comboContribTypes.ChosenValue = 'S';

		}else{

			comboContribTypes.ChosenValue = 'F';			
		}

		ProcessNewContribType();
	
}