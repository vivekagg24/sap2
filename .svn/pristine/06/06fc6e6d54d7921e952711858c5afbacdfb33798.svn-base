// ActionScript file
	// werks combo box

	import mx.binding.utils.BindingUtils;
	
	[Bindable]
	private var werksList:Array;
					
	[Bindable]
	public var SelectedWerks:String;
	public var passedWerks:String;

	[Bindable]
	public var werks:XMLList;
	
	// movement reason combo box
	[Bindable]
	private var reasonList:Array;
					
	[Bindable]
	public var SelectedReason:String;
	[Bindable]
	public var SelectedReasonType:String;

	// material combo box
	[Bindable]
	private var materialList:Array;
	[Bindable]
	private var materialList2:Array;	
	
	// Destination site combo box
	[Bindable]
	private var destWerksList: Array;
	
	[Bindable]
	public var SelectedDestWerks: String;
					
	// display the results
	public function showResults(event:ResultEvent):void {
		// This is the result of the webservice called by getDeliveries();
		var XMLMessList:XMLList;
		XMLMessList = wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.RE_T_MESSAGES.item;
			
		if (XMLMessList && XMLMessList[0] != null) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
		else {		
			// set up the drop down boxes
	        PopulateWerks(wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.ET_WERKS.item);
			SelectWerks();
        	PopulateReason(wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.ET_MOVEMENT_REASON.item);
			SelectReason();
    	    PopulateMaterial(wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.ET_ITEMS.item);
			SelectMaterial();	
			SelectMaterial2();	
			lastPost.text = 'wk ' + wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_WEEK
				+ ' - ' + wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_DATE.substr(8,2)
				+ '.' + wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_DATE.substr(5,2)
				+ '.' + wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_DATE.substr(0,4);			

			// set last posted date
			lastPostingDate.setDate(wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_DATE.substr(8,2));
			lastPostingDate.setMonth(wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_DATE.substr(5,2));
			// need to shift the date as jannuary is 0 in flex
			lastPostingDate.setMonth(lastPostingDate.getMonth()-1);
			lastPostingDate.setFullYear(wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.lastResult.E_LAST_POSTED_DATE.substr(0,4));
		}
	}
	
	//Process messages and error from SAP function calls
	public function processingReturned(event:ResultEvent):void {
		// We have the result of a rejection or an approval back from SAP
 		var b:XML = new XML(event.result[0]);
		var d:String;
		var XMLMessList:XMLList;
	
		CursorManager.setBusyCursor();
 		if (event.target.service == "ZNP_PLANT_AUTH_CHECKService") {
			XMLMessList = wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.RE_T_MESSAGES.item;
			//plants = wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.ET_WERKS.item;
	        PopulatePlant(wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.ET_WERKS.item);
			SelectPlant();
		}
 		else if (event.target.service == "ZNP_STOCK_ADJUST_ADDService") {
			XMLMessList = wsStockAdjust.ZNP_STOCK_ADJUST_ADD.lastResult.RE_T_MESSAGES.item;
		}
 		else if (event.target.service == "ZNP_STOCK_TRANSFER_ADDService") {
			XMLMessList = wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.lastResult.RE_T_MESSAGES.item;
		}
 		else if (event.target.service == "ZNP_STOCK_ADJUST_REVERSEService") {
			XMLMessList = wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.lastResult.RE_T_MESSAGES.item;
		}
 		else if (event.target.service == "ZNP_STOCK_TRANSFER_REVERSEService") {
			XMLMessList = wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.lastResult.RE_T_MESSAGES.item;
		}						
		
		// output messages		
		if (XMLMessList && XMLMessList[0] != null) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
		doRefresh(); 
		CursorManager.removeBusyCursor();
	}  
	
	// when refresh button clicked, refresh the screen
	public function doRefresh():void
	{
		// Refresh display
		currentState = '';
		// Clear data
		LIFNR.text = '';
		MILL.text = '';
		MATNR.text = '';
		WEIGHT.text = '';
		REEL.text = '';
		LIFNR1.text = '';
		MILL1.text = '';
		MATNR1.text = '';
		WEIGHT1.text = '';
		REEL1.text = '';
		SelectedDestWerks = '';
		COMMENT.text = '';
		SelectedReason = '';
		SelectedReasonType = '';		
		// Get stock adjustments for site
		getStockAdjust();		
		// Rerfresh messages
		//resultMessages = new Array();
    	//errorMessages = new Array();

	} 
	
	// get stock adjustments and transfers for site selected
	public function getStockAdjust():void {
    	// This function is run when the application is first opened	
		wsGetStockAdjustment.ZNP_STOCK_ADJUST_READ.send();
  
  		// clear the output messages
	   	//resultMessages = new Array();
 		//errorMessages = new Array();
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

	// set the destination plant
 	public function setDestWerksCombo():void {
		comboDestWerks.setFocus();
		
		if(comboDestWerks.selectedItem != null){
			SelectedDestWerks = comboDestWerks.selectedItem.data;
		}
	}

	private function SelectDestWerks():void{
        for (var i:int = 0; i< destWerksList.length; i++){	      	
        	if(destWerksList[i].data == SelectedDestWerks){
        		comboDestWerks.selectedIndex = i;
        		return;
        	}
        }
    	comboDestWerks.selectedIndex = 0;
    	SelectedDestWerks = destWerksList[0].data;
	}
	
	// set the werks drop list of sites to transfer stock to
	private function PopulateWerks(werkXML:Object):void{
		var werksXML:XMLList = werkXML as XMLList;
        var xmlWerksLength:int  = werksXML.length();
        werksList = new Array();
        destWerksList = new Array();

        var i:Number=0;
        for (i=0; i< xmlWerksLength; i++){
            var value:String = werksXML[i].WERKS.toString()
            	+ '-' + werksXML[i].NAME1.toString();
            var key:String = werksXML[i].WERKS.toString();                         
            werksList.push({label: value, data: key});
            destWerksList.push({label: value, data: key});
		}
    }
    
	// set the movement reason drop list to selected value
	public function setReasonCombo():void {
		comboReason.setFocus();
		
		if(comboReason.selectedItem != null){
			SelectedReason = comboReason.selectedItem.data1;
			SelectedReasonType = comboReason.selectedItem.data2;						
		}
	}

	// set the movement reason to be returned
	private function SelectReason():void{
        for (var i:int = 0; i< reasonList.length; i++){	      	
        	if(reasonList[i].data1 == SelectedReason && reasonList[i].data2 == SelectedReasonType){
        		comboDestination.selectedIndex = i;
        		return;
        	}
        }
    	comboReason.selectedIndex = 0;
    	SelectedReason = reasonList[0].data1;
    	SelectedReasonType = reasonList[0].data2;
	}
	
	// set the movement reason drop list for goods movement
	private function PopulateReason(reasonXML:Object):void{
		var reasonsXML:XMLList = reasonXML as XMLList;
        var xmlReasonLength:int  = reasonsXML.length();
        var in_dec:String;
        reasonList = new Array();

        var i:Number=0;
        for (i=0; i< xmlReasonLength; i++){
        	if ( reasonXML[i].BWART == '551' || reasonXML[i].BWART == '161' ){
        		in_dec = '(-)';
        	}
        	else {
        		in_dec = '(+)';
        	}
/*             var value:String = reasonsXML[i].GRUND.toString()
            	+ '-' + reasonsXML[i].GRTXT.toString() + ' ' + in_dec; */
            var value:String = reasonsXML[i].GRTXT.toString() + ' ' + in_dec;            	
            var key2:String = reasonsXML[i].GRUND.toString();
            var key1:String = reasonsXML[i].GRTXT.toString();                         
            reasonList.push({label: value, data1: key1, data2: key2});
		}
    }    

	// set the material drop list to selected value - stock transfer
	public function setMaterialCombo():void {
		comboMaterial.setFocus();

		if(comboMaterial.selectedItem != null){
			LIFNR.text = comboMaterial.selectedItem.data1;
			MILL.text = comboMaterial.selectedItem.data2;
			MATNR.text = comboMaterial.selectedItem.data3;		
		}
	}
	
	// set the material drop list to selected value - stock transfer
 	public function setMaterialCombo2():void {
		comboMaterial2.setFocus();
		
		if(comboMaterial2.selectedItem != null){
			LIFNR1.text = comboMaterial2.selectedItem.data1;
			MILL1.text = comboMaterial2.selectedItem.data2;
			MATNR1.text = comboMaterial2.selectedItem.data3;			
		}
	}

	// set the material to be returned - stock transfers
	private function SelectMaterial():void{
        for (var i:int = 0; i< materialList.length; i++){	      	
			if(materialList[i].data1 == LIFNR.text &&
				materialList[i].data2 == MILL.text &&
				materialList[i].data3 == MATNR.text){
        		comboMaterial.selectedIndex = i;      		
        		return;
        	}
        }
		if(materialList.length > 0){
	    	comboMaterial.selectedIndex = 0;
			LIFNR.text = materialList[0].data1;
			MILL.text = materialList[0].data2;
			MATNR.text = materialList[0].data3;
		}
	}
	
	// set the material to be returned - stock adjustments
	private function SelectMaterial2():void{
        for (var i:int = 0; i< materialList2.length; i++){	      	
			if(materialList2[i].data1 == LIFNR1.text &&
				materialList2[i].data2 == MILL1.text &&
				materialList2[i].data3 == MATNR1.text){
        		comboMaterial2.selectedIndex = i;      		
        		return;
        	}
        }
    	if(materialList.length > 0){
	    	comboMaterial2.selectedIndex = 0;
			LIFNR1.text = materialList2[0].data1;
			MILL1.text = materialList2[0].data2;
			MATNR1.text = materialList2[0].data3;
    	}
	}	
	
	// set the material drop list of sites to transfer stock to
	private function PopulateMaterial(matXML:Object):void{
		var materialXML:XMLList = matXML as XMLList;
        var xmlMaterialLength:int  = materialXML.length();
		var value:String;
		var key1:String
		var key2:String
		var key3:String		
        materialList = new Array();
        materialList2 = new Array();

        var i:Number=0;
        for (i=0; i< xmlMaterialLength; i++){
        	if ( materialXML[i].MILL_NAME && materialXML[i].MILL_NAME == ''){
	            value = materialXML[i].NAME1.toString()
            		+ ' - ' + materialXML[i].MAKTX.toString();
        	}
        	else { 		
	            value = materialXML[i].NAME1.toString()
            		+ ' - ' + materialXML[i].MILL_NAME.toString()
            		+ ' - ' + materialXML[i].MAKTX.toString();
           	}
       	    key1 = materialXML[i].LIFNR.toString();
    	    key2 = materialXML[i].MILL.toString();
	        key3 = materialXML[i].MATNR.toString();                         
            materialList.push({label: value, data1: key1, data2: key2, data3: key3});
            materialList2.push({label: value, data1: key1, data2: key2, data3: key3});
		}
    }
  
    
    // manually add stock adjustment item and receipt it
  	public function onAdd(LIFNR:String, MILL:String, MATNR:String, REASON:String,
  							REASONTYPE:String, WEIGHT:String, REEL:String, TYPE:String, DATE:String,
  							REC_WERKS:String, COMMENT:String):void{
		// check the user has entered some data - minimun is vendor, material, weight and reels
		var alert_text:String;
		
		// check the date is not a future date
		var todaysDate:Date = new Date();
		var enteredDate:Date = new Date(2010, 0, 1);
		
		//enteredDate.setDate(DATE.substr(0,2));
		enteredDate.setMonth(DATE.substr(3,2));
		// need to shift the date as jannuary is 0 in flex
		enteredDate.setMonth(enteredDate.getMonth()-1);
		enteredDate.setDate(DATE.substr(0,2));
		enteredDate.setFullYear(DATE.substr(6,4));
		
		if (enteredDate > todaysDate) {
			alert_text = 'You cannot enter a future date';
			Alert.show(alert_text);				
		} else if (enteredDate <= lastPostingDate) {
			alert_text = 'Period has already been closed, date must be after ' + lastPostingDate.toDateString();
			Alert.show(alert_text);				
		} else {
			// check the user has entered some data - minimun is vendor, material, weight and reels
			// for an intersite transfer, also need to provide the destination site
			if (WEIGHT == '') {
				alert_text = 'Please enter the weight';
				Alert.show(alert_text);							
			} else if (REEL == ''){
				alert_text = 'Please enter the number of reels';
				Alert.show(alert_text);								
			} else if (DATE == ''){           
				alert_text = 'Please enter the date';
				Alert.show(alert_text);	
			} else if ((REASONTYPE == '551' || REASONTYPE == '552') && (REC_WERKS == '')) {
				alert_text = 'Please enter the destination site';
				Alert.show(alert_text);
			} else if (SelectedPlant == SelectedDestWerks) {
				alert_text = 'Source and destination site cannot be the same';
				Alert.show(alert_text);							
			} else {
				if (TYPE == 'stock adjustment') {
					// set data to be passed into SAP to add stock adjustment line
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.WERKS = SelectedPlant;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.LIFNR = LIFNR;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.MILL = MILL;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.MATNR = MATNR;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.REASON = REASON;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.GRUND = REASONTYPE;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.WEIGHT = WEIGHT;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.REEL = REEL;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.WERKS_REC = SelectedDestWerks;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.COMMENT_TEXT = COMMENT;
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.request.I_STOCK_ADJUST.ADJUST_DATE = DateToSAPFormat(DATE);
					
					wsStockAdjust.ZNP_STOCK_ADJUST_ADD.send();
				} else if (TYPE == 'stock transfer') {
					// set data to be passed into SAP to add stock transfer line
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.WERKS = SelectedPlant;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.LIFNR = LIFNR;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.MILL = MILL;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.MATNR = MATNR;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.DESTINATION = REASON;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.WEIGHT = WEIGHT;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.REEL = REEL;
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.request.I_STOCK_TRANSF.TRANS_DATE = DateToSAPFormat(DATE);
					
					wsStockTransfer.ZNP_STOCK_TRANSFER_ADD.send();				
				}
	
	  			// clear the output messages
			   	//resultMessages = new Array();
	 			//errorMessages = new Array();  		
		 	}
		}
  	} 
  	
  	// reverse a line
  	public function onReverseLine(reverseLine:XML):void{
		var reason:String = reverseLine.REASON;
		var destination:String = reverseLine.DESTINATION;
  		if (reason && reason != ' ') {
			// set data to be passed into SAP to reverse stock adjustment line
			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.request.I_STOCK_ADJUST.WERKS = reverseLine.WERKS;
			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.request.I_STOCK_ADJUST.LIFNR = reverseLine.LIFNR;
			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.request.I_STOCK_ADJUST.MILL = reverseLine.MILL;
			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.request.I_STOCK_ADJUST.MATNR = reverseLine.MATNR;
			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.request.I_STOCK_ADJUST.ADJUST_DATE = reverseLine.ADJUST_DATE;
			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.request.I_STOCK_ADJUST.ADJUST_TIME = reverseLine.ADJUST_TIME;

			wsStockAdjustReverse.ZNP_STOCK_ADJUST_REVERSE.send();
  		} else if (destination && destination != ' ') {
			// set data to be passed into SAP to reverse stock transfer line
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.WERKS = reverseLine.WERKS;
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.LIFNR = reverseLine.LIFNR;
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.MILL = reverseLine.MILL;
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.MATNR = reverseLine.MATNR;
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.TRANS_DATE = reverseLine.TRANS_DATE;
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.TRANS_TIME = reverseLine.TRANS_TIME;
			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.request.I_STOCK_TRANSF.DESTINATION = reverseLine.DESTINATION;

			wsStockTransferReverse.ZNP_STOCK_TRANSFER_REVERSE.send();  			
  		}
  
  		// clear the output messages
	   	//resultMessages = new Array();
 		//errorMessages = new Array();	
  	}  	