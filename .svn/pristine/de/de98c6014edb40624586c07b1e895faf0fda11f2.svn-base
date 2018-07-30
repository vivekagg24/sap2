// ActionScript file for goods receipt
	import mx.controls.DateField;
	import visualComponents.DateField1;
	import mx.controls.CheckBox;
	import mx.controls.listClasses.BaseListData;
	import mx.controls.DataGrid;

	public const noPO:String = 'No PO';
	public const unknownMaterial:String = 'Material not on PO';
	public var maxWeight:Number = 30.000;
	public var maxReels:int = 60;
	
	// PO search results
	[Bindable]
	public var poSearchList:XMLList;	
	
	// item search results
	[Bindable]
	public var itemSearchList:XMLList;		

	// material combo box
	[Bindable]
	private var materialList:Array;
	[Bindable]
	private var unknownList:Array;	
	// mill combo box
	[Bindable]
	private var millList:Array;
	// vendor combo box
	[Bindable]
	private var vendorList:Array;
	// PO combo box
	[Bindable]
	private var POList:Array;			

	// werks combo box
	[Bindable]
	private var werksList:Array;
					
	[Bindable]
	public var SelectedWerks:String;
	public var passedWerks:String;

	// get deliveries for site selected
	public function getDeliveries():void {
    	// This function is run when the application is first opened	
		wsGetDeliveries.ZNP_INBOUND_READ.send();
	}

	// when refresh button clicked, refresh the screen
	public function doRefresh():void
	{
		CursorManager.setBusyCursor();
		// Refresh display
		currentState = '';
		// Clear data
		EBELN.text = '';
		EBELP.text = '';
		LIFNR.text = '';
		MILL.text = '';
		MATNR.text = '';
		DEL_NOTE.text = '';
		WEIGHT.text = '';
		REEL.text = '';
		// Get deliveries for site
		getDeliveries();
    	CursorManager.removeBusyCursor();
	}  

	// display the results
	public function showResults(event:ResultEvent):void {
		// This is the result of the webservice called by getDeliveries();
		// output messages		
		var XMLMessList:XMLList;
		XMLMessList = wsGetDeliveries.ZNP_INBOUND_READ.lastResult.RE_T_MESSAGES.item;
		poSearchList = wsGetDeliveries.ZNP_INBOUND_READ.lastResult.PURCHASE_ORDERS.item;

		if (XMLMessList && XMLMessList[0] != null) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		} else {
	        PopulatePO(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.PURCHASE_ORDERS.item);
			SelectPO();
			if (EBELN.text == noPO) {
				PopulateVendor(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.VENDOR_MILL.item);
				populateMaterial(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.MATERIALS.item);
			} else {
				PopulateVendor(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.PURCHASE_ORDERS.item);
				populateMaterial(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.PURCHASE_ORDERS.item);
			}
			populateUnknown(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.MATERIALS.item);
			SelectVendor();	
			SelectMaterial();	
			SelectUnknown();	
	        PopulateWerks(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.ET_WERKS.item);
			SelectWerks();	
			lastPost.text = 'wk ' + wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_WEEK
				+ ' - ' + wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_DATE.substr(8,2)
				+ '.' + wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_DATE.substr(5,2)
				+ '.' + wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_DATE.substr(0,4);	
				
			// set last posted date
			lastPostingDate.setDate(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_DATE.substr(8,2));
			lastPostingDate.setMonth(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_DATE.substr(5,2));
			// need to shift the date as jannuary is 0 in flex
			lastPostingDate.setMonth(lastPostingDate.getMonth()-1);
			lastPostingDate.setFullYear(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.E_LAST_POSTED_DATE.substr(0,4));
			// set values for max weight and max reels
			setMaxValues(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.ET_PARAMETERS.item);				
		}
	}			          

	//Process messages and error from SAP function calls
	public function processingReturned(event:ResultEvent):void {
		// We have the result of a rejection or an approval back from SAP
		var b:XML = new XML(event.result[0]);
		var d:String;
		var XMLMessList:XMLList;
	
 		if (event.target.service == "ZNP_PLANT_AUTH_CHECKService") {
			XMLMessList = wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.RE_T_MESSAGES.item;
	        PopulatePlant(wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.ET_WERKS.item);
			SelectPlant();
		}
		else if (event.target.service == "ZNP_INBOUND_ITEM_LOOKUPService") {
			XMLMessList = wsItemLookup.ZNP_INBOUND_ITEM_LOOKUP.lastResult.RE_T_MESSAGES.item;
			itemSearchList = wsItemLookup.ZNP_INBOUND_ITEM_LOOKUP.lastResult.ITEM_VENDOR.item;			
		}
  		else if (event.target.service == "ZNP_INBOUND_PO_LOOKUPService") {
			XMLMessList = wsPOLookup.ZNP_INBOUND_PO_LOOKUP.lastResult.RE_T_MESSAGES.item;
			poSearchList = wsPOLookup.ZNP_INBOUND_PO_LOOKUP.lastResult.PURCHASE_ORDERS.item;			
		}
		else if (event.target.service == "ZNP_INBOUND_MANUAL_ADDService") {
			XMLMessList = wsManualAdd.ZNP_INBOUND_MANUAL_ADD.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "ZNP_INBOUND_REVERSEService") {
			XMLMessList = wsReverseLine.ZNP_INBOUND_REVERSE.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "ZNP_INBOUND_RECEIPTService") {
			XMLMessList = wsReceiptLine.ZNP_INBOUND_RECEIPT.lastResult.RE_T_MESSAGES.item;
		}
		
		// output messages		
		if (XMLMessList && XMLMessList[0] != null) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
		if (event.target.service != "ZNP_INBOUND_PO_LOOKUPService") {
			doRefresh();			
		}
	}  		        

	// displays popup window for PO search on button click
	private function onPOSearchClick():void
	{
		var message:onPOSearch =  PopUpManager.createPopUp(this, onPOSearch) as onPOSearch;
		message.data = this.data;
	} 
	
	// call into SAP to get list of POs for site
  	public function doPOSearch():void{
    	// This function is run when the popup is first opened	
		wsPOLookup.ZNP_INBOUND_PO_LOOKUP.send();
  	}	

	// displays popup window for item search on button click
	private function onItemSearchClick():void
	{
		//wsItemLookup.ZNP_INBOUND_ITEM_LOOKUP.send();
		var message:onItemSearch =  PopUpManager.createPopUp(this, onItemSearch) as onItemSearch;
		message.data = this.data;
	} 
	// call into SAP to get list of item vendors for site
  	public function doItemSearch():void{
    	// This function is run when the popup is first opened	
		wsItemLookup.ZNP_INBOUND_ITEM_LOOKUP.send();	
  	}  	
  	
	// manually add delivery line item and receipt it
  	public function onManualAdd(EBELN:String, EBELP:String, LIFNR:String,
  								MILL:String, MATNR:String, DEL_NOTE:String,
  								WEIGHT:String, REEL:String, DEL_DATE:String,
  								EBELN2:String, TRANS:Boolean, DESTINATION:String):void{
		var alert_text:String;
		
		// check the date is not a future date
		var todaysDate:Date = new Date();
		var enteredDate:Date = new Date(2010, 0, 1);
		
		//enteredDate.setDate(DEL_DATE.substr(0,2));
		enteredDate.setMonth(DEL_DATE.substr(3,2));
		// need to shift the date as jannuary is 0 in flex
		enteredDate.setMonth(enteredDate.getMonth()-1);
		enteredDate.setDate(DEL_DATE.substr(0,2));
		enteredDate.setFullYear(DEL_DATE.substr(6,4));
		
		if (enteredDate > todaysDate) {
			alert_text = 'You cannot enter a future date';
			Alert.show(alert_text);				
		} else if (enteredDate <= lastPostingDate) {
			alert_text = 'Period has already been closed, date must be after ' + lastPostingDate.toDateString();
			Alert.show(alert_text);				
		} else {
			
		// check the user has entered some data - minimun is vendor, material, weight and reels	
			if (LIFNR == '') {
				alert_text = 'Please enter the vendor';
				Alert.show(alert_text);						
			} else if (MATNR == '') {
				alert_text = 'Please enter a material';
				Alert.show(alert_text);							
			} else if (WEIGHT == '') {
				alert_text = 'Please enter the weight';
				Alert.show(alert_text);	
			} else if (parseFloat(WEIGHT) > maxWeight){
				alert_text = 'Weight exceeds the maximum weight of ' + maxWeight + ' tonnes';
				Alert.show(alert_text);											
			} else if (REEL == ''){
				alert_text = 'Please enter the number of reels';
				Alert.show(alert_text);	
			} else if (parseInt(REEL) > maxReels){
				alert_text = 'Number of reels exceeds the maximum of ' + maxReels;
				Alert.show(alert_text);				
			} else if (DEL_NOTE == ''){
				alert_text = 'Please enter the delivery note reference';
				Alert.show(alert_text);							
			} else if (DEL_DATE == ''){
				alert_text = 'Please enter the date of the delivery';
				Alert.show(alert_text);	
			} else {
				// set the data to be passed back to SAP when adding a receipt line manually
				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.WERKS = SelectedPlant;
				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.DEL_DATE = DateToSAPFormat(DEL_DATE);
				if (EBELN == noPO) {
					wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.EBELN = EBELN2;
				} else {
					wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.EBELN = EBELN;
				}
				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.EBELP = EBELP;
				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.LIFNR = LIFNR;
		   		wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.MILL = MILL; 
	   			wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.MATNR = MATNR;
   				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.DEL_NOTE = DEL_NOTE;
	   			wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.WEIGHT = WEIGHT;
   				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.request.I_DELIVERY_LINE.REEL = REEL; 

				wsManualAdd.ZNP_INBOUND_MANUAL_ADD.send(); 		
		 	}
		}
  	}  
  	
  	// goods receipt a line
  	public function onReceiptLine(receiptLine:XML):void{
		var alert_text:String;
		var enteredDateString:String;
		var firstdecimal:int;
		var weightdecimal:int = -1;
		var reeldecimal:int = -1;
		var weightsubstring:String;
		var weightlength:int;
		var reelsubstring:String;
		var reellength:int;		
		
		// check the weight is in a valid format (nnnnnnnnn.nn)
		weightlength = receiptLine.WEIGHT.toString().length;
		firstdecimal = receiptLine.WEIGHT.indexOf(".");
		if (firstdecimal > -1) {
			weightsubstring = receiptLine.WEIGHT.substr(firstdecimal + 1, 9999);
			weightlength = weightsubstring.length;
			weightdecimal = weightsubstring.indexOf("."); }
		else {
			weightlength = 0;
		}
		
		// check the reels is in a valid format (nnn.nn)
		reellength = receiptLine.REEL.toString().length;
		firstdecimal = receiptLine.REEL.indexOf(".");
		if (firstdecimal > -1) {
			reelsubstring = receiptLine.REEL.substr(firstdecimal + 1, 9999);
			reellength = reelsubstring.length;
			reeldecimal = reelsubstring.indexOf("."); }
		else {
			reellength = 0;
		}
		
		// if date is in format yyyy-mm-dd change to dd.mm.yyyy
		if (receiptLine.DEL_DATE.substr(4,1) == '-' && receiptLine.DEL_DATE.substr(7,1) == '-') {
			receiptLine.DEL_DATE = receiptLine.DEL_DATE.substr(8,2) + '.'
			+ receiptLine.DEL_DATE.substr(5,2) + '.' + receiptLine.DEL_DATE.substr(0,4);
		}

		if (receiptLine.DEL_DATE.substr(6,4).length == 2) {
			receiptLine.DEL_DATE = receiptLine.DEL_DATE.substr(0,6) + '20' + receiptLine.PRINT_DATE.substr(6,2);
		}

		// check the date is not a future date
		var todaysDate:Date = new Date();
		var enteredDate:Date = new Date(2010, 0, 1);

		var month:Number = new Number(receiptLine.DEL_DATE.substr(3,2));
		month = month - 1; // January is 0 in flex
		
		//enteredDate.setDate(receiptLine.DEL_DATE.substr(0,2));
		enteredDate.setMonth(receiptLine.DEL_DATE.substr(3,2));
		// need to shift the date as jannuary is 0 in flex
		enteredDate.setMonth(enteredDate.getMonth()-1);
		enteredDate.setDate(receiptLine.DEL_DATE.substr(0,2));
		enteredDate.setFullYear(receiptLine.DEL_DATE.substr(6,4));
		
		// check the validity of the entered date by comparing it to entered date
		// as flex adjusts the date to be valid - e.g invalid date of 31/02/2010 becomes 03/02/2010
		if ( enteredDate.getDate() != parseInt(receiptLine.DEL_DATE.substr(0,2)) ||
			 enteredDate.getMonth() != month  || enteredDate.getFullYear().toString() != receiptLine.DEL_DATE.substr(6,4) ) {
			alert_text = 'Invalid Date';
			Alert.show(alert_text);				 	
		} else if (enteredDate > todaysDate) {
			alert_text = 'You cannot enter a future date';
			Alert.show(alert_text);				
		} else if (enteredDate <= lastPostingDate) {
			alert_text = 'Period has already been closed, date must be after ' + lastPostingDate.toDateString();
			Alert.show(alert_text);				
		} else {
			// validate the user has entered data
			if (receiptLine.LIFNR == '') {
				alert_text = 'Please enter the vendor';
				Alert.show(alert_text);						
			} else if (receiptLine.MATNR == '') {
				alert_text = 'Please enter a material';
				Alert.show(alert_text);							
			} else if (receiptLine.WEIGHT == '') {
				alert_text = 'Please enter the weight';
				Alert.show(alert_text);		
			} else if (weightdecimal > -1) {
				alert_text = 'invalid weight';
				Alert.show(alert_text);				
			} else if ( weightlength > 3 ) {
				alert_text = 'too many decimal places for the weight';
				Alert.show(alert_text);	
			} else if (parseFloat(receiptLine.WEIGHT) > maxWeight) {
				alert_text = 'Weight exceeds the maximum weight of ' + maxWeight + ' tonnes';
				Alert.show(alert_text);								
			} else if (receiptLine.REEL == ''){
				alert_text = 'Please enter the number of reels';
				Alert.show(alert_text);	
			} else if (reeldecimal > -1) {
				alert_text = 'invalid number of reels';
				Alert.show(alert_text);				
			} else if ( reellength > 2 ) {
				alert_text = 'too many decimal places for reels';
				Alert.show(alert_text);					
			} else if (parseInt(receiptLine.REEL) > maxReels){
				alert_text = 'Number of reels exceeds the maximum of ' + maxReels;
				Alert.show(alert_text);
			} else if (receiptLine.DEL_NOTE == ''){
				alert_text = 'Please enter the delivery note reference';
				Alert.show(alert_text);							
			} else if (receiptLine.DEL_DATE == ''){
				alert_text = 'Please enter the date of the delivery';
				Alert.show(alert_text);	
			} else if (receiptLine.MILL == ''){
				alert_text = 'Please enter the mill';
				Alert.show(alert_text);	
			} else {
				// set the data to be passed into SAP when receipting a line
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.WERKS = receiptLine.WERKS;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.EBELN = receiptLine.EBELN;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.EBELP = receiptLine.EBELP;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.MESS_DATE = receiptLine.MESS_DATE;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.MESS_TIME = receiptLine.MESS_TIME;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.ZINPUT = receiptLine.ZINPUT;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.LIFNR = receiptLine.LIFNR;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.MILL = receiptLine.MILL;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.MATNR = receiptLine.MATNR;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.DEL_DATE = DateToSAPFormat(receiptLine.DEL_DATE);
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.DEL_TIME = receiptLine.DEL_TIME;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.DEL_NOTE = receiptLine.DEL_NOTE;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.WEIGHT = receiptLine.WEIGHT;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.TONNES = receiptLine.TONNES;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.REEL = receiptLine.REEL;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.REELS = receiptLine.REELS;
				wsReceiptLine.ZNP_INBOUND_RECEIPT.request.I_RECEIPT.DEL_TYPE = receiptLine.DEL_TYPE;
		
				wsReceiptLine.ZNP_INBOUND_RECEIPT.send();
	 		}  
		}
  	}  			  	
  	
  	// reverse a goods receipt
  	public function onReverseLine(reverseLine:XML):void{
		// set data to be passed into SAP when reversing a line
		wsReverseLine.ZNP_INBOUND_REVERSE.request.I_REVERSE.WERKS = reverseLine.WERKS;
		wsReverseLine.ZNP_INBOUND_REVERSE.request.I_REVERSE.EBELN = reverseLine.EBELN;
		wsReverseLine.ZNP_INBOUND_REVERSE.request.I_REVERSE.EBELP = reverseLine.EBELP;
		wsReverseLine.ZNP_INBOUND_REVERSE.request.I_REVERSE.MESS_DATE = reverseLine.MESS_DATE;
		wsReverseLine.ZNP_INBOUND_REVERSE.request.I_REVERSE.MESS_TIME = reverseLine.MESS_TIME;
		
		wsReverseLine.ZNP_INBOUND_REVERSE.send();
  	}  	
  	
	// set the PO drop list to selected value
	public function setPOCombo():void {
		comboPO.setFocus();
	
 		if(comboPO.selectedItem != null){
			EBELN.text = comboPO.selectedItem.data1;
		}

		if (EBELN.text == noPO) {
			PopulateVendor(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.VENDOR_MILL.item);
			populateMaterial(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.MATERIALS.item);
			SelectUnknown();
			EBELN2.editable = true;
			EBELN2.setStyle('backgroundColor', 'white');	
		} else {
			PopulateVendor(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.PURCHASE_ORDERS.item);
			populateMaterial(wsGetDeliveries.ZNP_INBOUND_READ.lastResult.PURCHASE_ORDERS.item);
			EBELN2.text = '';
			EBELN2.editable = false;
			EBELN2.setStyle('backgroundColor', '0xDCDCDC');					
		}
		SelectVendor();	
		SelectMaterial();			
	}

	// set the PO to be returned
	private function SelectPO():void{      
        for (var i:int = 0; i< POList.length; i++){	      	
         	if(POList[i].data1 == EBELN.text ){
        		comboPO.selectedIndex = i;
        		return;
        	}
        }

		if (POList.length > 0) {
			comboPO.selectedIndex = 0;	
			EBELN.text = POList[0].data1;
			if (EBELN.text == noPO) {
				EBELN2.editable = true;
				EBELN2.setStyle('backgroundColor', 'white');		
			} else {
				EBELN2.text = '';
				EBELN2.editable = false;
				EBELN2.setStyle('backgroundColor', '0xDCDCDC');						
			}
		}
	}
	
	// set the PO drop list of sites 
	private function PopulatePO(POXML:Object):void{
		var POsXML:XMLList = POXML as XMLList;
        var xmlPOsLength:int  = POsXML.length();
		var value:String;
		var key1:String;
		var oldPO:String = '';

        POList = new Array();

        var i:Number=0;
        for (i=0; i< xmlPOsLength; i++){
			value = POsXML[i].EBELN.toString();	
        	if (value != oldPO) {
       		    key1 = POsXML[i].EBELN.toString();
    	   	    oldPO = value;
	            POList.push({label: value, data1: key1});        		
        	}
		}
    }  	
    
	// set the Vendor drop list to selected value
	public function setVendorCombo():void {
		comboVendor.setFocus();
		
 		if(comboVendor.selectedItem != null){
			LIFNR.text = comboVendor.selectedItem.data1;
			MILL.text = comboVendor.selectedItem.data2;						
		} 	
	}

	// set the Vendor to be returned
	private function SelectVendor():void{
        for (var i:int = 0; i< vendorList.length; i++){	      	
         	if(vendorList[i].data1 == LIFNR.text &&
         		vendorList[i].data2 == MILL.text){
        		comboVendor.selectedIndex = i;
        		return;
        	} 
        }

		if (vendorList.length > 0) {
			comboVendor.selectedIndex = 0;	
			LIFNR.text = vendorList[0].data1;
			MILL.text = vendorList[0].data2;
		}
	}
	
	// set the Vendor drop list of sites 
	private function PopulateVendor(VendorXML:Object):void{
		var VendorsXML:XMLList = VendorXML as XMLList;
        var xmlVendorsLength:int  = VendorsXML.length();
   		var value:String;
		var key1:String;
		var key2:String;
		var vendorOld:String = '';
        vendorList = new Array();

        var i:Number=0;
        for (i=0; i< xmlVendorsLength; i++){
            if ( VendorsXML[i].EBELN.toString() ==  EBELN.text) {
    	        value = VendorsXML[i].NAME1.toString()
	           		+ ' - ' + VendorsXML[i].MILL_NAME.toString();
				if (value != vendorOld) {
    	   	    	key1 =  VendorsXML[i].LIFNR.toString();
	    		    key2 =  VendorsXML[i].MILL.toString();
    		    	vendorOld = value;
    	    	    vendorList.push({label: value, data1: key1, data2: key2});            	
			    }
            } else if (EBELN.text == noPO) {
				if (VendorsXML[i].MILL == null || VendorsXML[i].MILL_NAME.toString() == '') {
					value = VendorsXML[i].NAME1.toString();					
				} else {
		            value = VendorsXML[i].NAME1.toString()
    		       		+ ' - ' + VendorsXML[i].MILL_NAME.toString();
				}
       		    key1 =  VendorsXML[i].LIFNR.toString();
    	    	key2 =  VendorsXML[i].MILL.toString();
	            vendorList.push({label: value, data1: key1, data2: key2});
            }
		}	
    }   
    
	// set the Material drop list to selected value
	public function setMaterialCombo():void {
		comboMaterial.setFocus();
		
 		if (comboMaterial.selectedItem != null){
 			MATNR.text = comboMaterial.selectedItem.data1;
 			EBELP.text = comboMaterial.selectedItem.data2;
 			if ( comboMaterial.selectedItem.label == unknownMaterial) {
 				comboUnknown.enabled = true;
 				SelectUnknown();
 			} else {		
 				comboUnknown.enabled = false;	
 			}
		} else {
			MATNR.text = '';
			EBELP.text = '';
		}
	}

	// set the Material to be returned
	private function SelectMaterial():void{
		if (materialList != null ) {
	        for (var i:int = 0; i< materialList.length; i++){	      	
    	     	if(MATNR != null && MATNR.text != '' && materialList[i].data1 == MATNR.text && EBELP != null && materialList[i].data2 == EBELP.text){
	 				if ( materialList[i].data1 == unknownMaterial) {
 						comboUnknown.enabled = true;
 					} else {
	 					comboUnknown.enabled = false;					
		 			} 
    	    		comboMaterial.selectedIndex = i;
        			return;
	        	} 
    	    }
        }

		if (materialList.length > 0) {
			comboMaterial.selectedIndex = 0;	
			MATNR.text = materialList[0].data1;
			EBELP.text = materialList[0].data2;	
			
 			if ( materialList[0].data1 == unknownMaterial) {
 				comboUnknown.enabled = true;
 			} else {
 				comboUnknown.enabled = false;
 			} 			
		}
	}
	
	// set the Material drop list of sites 
	private function populateMaterial(MaterialXML:Object):void{
		var MaterialsXML:XMLList = MaterialXML as XMLList;
        var xmlMaterialsLength:int  = MaterialsXML.length();
   		var value:String;
		var key1:String;
		var key2:String;        
        materialList = new Array();

		if (EBELN.text == noPO) {
			value = 'Select a material';
    	   	key1 =  '';
    	   	key2 =  '';
   	    	materialList.push({label: value, data1: key1, data2: key2});
		}

        var i:Number=0;
        for (i=0; i< xmlMaterialsLength; i++){
            if ( MaterialXML[i].EBELN.toString() == EBELN.text) {
            	value = MaterialXML[i].MAKTX.toString();
	       	    key1 =  MaterialXML[i].MATNR.toString();
	       	    key2 =  MaterialXML[i].EBELP.toString();
	            materialList.push({label: value, data1: key1, data2: key2});            	
            } else if (EBELN.text == noPO) {
	            value = MaterialsXML[i].MAKTX.toString();
	       	    key1 =  MaterialXML[i].MATNR.toString();
	       	    key2 =  MaterialXML[i].EBELP.toString();
    	        materialList.push({label: value, data1: key1, data2: key2});
            }
		}
		if (EBELN.text != noPO) {
			value = unknownMaterial;
	       	key1 =  '';
	       	key2 =  '';
    	    materialList.push({label: value, data1: key1, data2: key2});
		}		
    }  

	// set the unknown drop list to selected value
	public function setUnknownCombo():void {
 		comboUnknown.setFocus();
		
 		if (comboUnknown.selectedItem != null){
			MATNR.text = comboUnknown.selectedItem.data1;
			
		} else {
			MATNR.text = '';
		} 
	}

	// set the unknown material to be returned
	private function SelectUnknown():void{
 		if (unknownList != null ) {
	        for (var i:int = 0; i< unknownList.length; i++){	      	
    	     	if(MATNR != null && unknownList[i].data == MATNR.text){
    	    		comboUnknown.selectedIndex = i;
        			return;
	        	} 
    	    }
        }

		if (unknownList.length > 0) {
			comboUnknown.selectedIndex = 0;	
			MATNR.text = unknownList[0].data1;		
		} 
	}
    
	// set the unknown material drop list of sites 
	private function populateUnknown(MaterialXML:Object):void{
 		var MaterialsXML:XMLList = MaterialXML as XMLList;
        var xmlMaterialsLength:int  = MaterialsXML.length();
   		var value:String;
		var key1:String;        
        unknownList = new Array();

		value = 'Select a material';
       	key1 =  '';
   	    unknownList.push({label: value, data1: key1});

        var i:Number=0;
        for (i=0; i< xmlMaterialsLength; i++){
            value = MaterialsXML[i].MAKTX.toString();
       	    key1 =  MaterialXML[i].MATNR.toString();
   	        unknownList.push({label: value, data1: key1});
		} 
    } 
    
	// set the unknown drop list to selected value
	public function trans(select:Boolean):void {
		comboDestination.enabled = select;
	}   
	
	// set the werks drop list to selected value
	public function setWerksCombo():void {
		comboDestination.setFocus();
		
		if(comboDestination.selectedItem != null){
			SelectedWerks = comboDestination.selectedItem.data;						
		}else{
			SelectedWerks = passedWerks;			
		}
	}

	// set the werks to be returned
	private function SelectWerks():void{
        for (var i:int = 0; i< werksList.length; i++){	      	
        	if(werksList[i].data == SelectedWerks){
        		comboDestination.selectedIndex = i;
        		return;
        	}
        }
    	comboDestination.selectedIndex = 0;
    	SelectedWerks = werksList[0].data;
	}
	
	// set the werks drop list of sites to transfer stock to
	private function PopulateWerks(werkXML:Object):void{
		var werksXML:XMLList = werkXML as XMLList;
        var xmlWerksLength:int  = werksXML.length();
        werksList = new Array();

        var i:Number=0;
        for (i=0; i< xmlWerksLength; i++){
            var value:String = werksXML[i].WERKS.toString()
            	+ '-' + werksXML[i].NAME1.toString();
            var key:String = werksXML[i].WERKS.toString();                         
            werksList.push({label: value, data: key});
		}
    }	     
       
	// set the maximum values for validation 
	private function setMaxValues(parameterXML:Object):void{
		var parametersXML:XMLList = parameterXML as XMLList;
        var xmlParametersLength:int = parametersXML.length();

        var i:Number=0;
        for (i=0; i< xmlParametersLength; i++){
            if (parametersXML[i].CONFIG.toString() == 'MAX_WEIGHT') {
            	maxWeight = parametersXML[i].VALUE.toString();
            } else if (parametersXML[i].CONFIG.toString() == 'MAX_REELS') {
	            maxReels = parametersXML[i].VALUE.toString();
            }
		}	
    }            	  		