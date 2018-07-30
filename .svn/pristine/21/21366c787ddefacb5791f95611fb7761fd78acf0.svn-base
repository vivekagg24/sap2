// ActionScript file
	import mx.controls.listClasses.BaseListData;

	public var maxPrintOrder:int = 5000000;
	public var maxPagination:int = 300;	
	public const millisecondsPerDay:int = 1000 * 60 * 60 * 24;
	
	[Bindable]
	private var publicationList:Array;
					
	[Bindable]
	public var SelectedPublication:String;
	[Bindable]
	public var weekday:String;
	[Bindable]
	public var saturday:String;
	[Bindable]
	public var sunday:String;		

	[Bindable]
	public var showTextChanges:Boolean = false;
	[Bindable]
	public var showTextColour:uint = 0xDCDCDC;

	// Grammage combo box
 	[Bindable]
	public var grammageList:Array;

	[Bindable]
	public var SelectedGrammage:String; 
	[Bindable]
	public var SelectedMatkl:String;


	// display the results
	public function showResults(event:ResultEvent):void {
		// This is the result of the webservice called by getDeliveries();
 		var XMLMessList:XMLList;
		XMLMessList = wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.RE_T_MESSAGES.item;
			
		if (XMLMessList && XMLMessList[0] != null) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		} 
		else {
        	PopulatePublication(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.PUBLICATION.item);
			SelectPublication();	
        	PopulateGrammage(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.GRAMMAGE.item);
			SelectGrammage();					
		}
			lastPost.text = 'wk ' + wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_WEEK
			+ ' - ' + wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_DATE.substr(8,2)
			+ '.' + wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_DATE.substr(5,2)
			+ '.' + wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_DATE.substr(0,4);
			
			// set last posted date
			lastPostingDate.setDate(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_DATE.substr(8,2));
			lastPostingDate.setMonth(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_DATE.substr(5,2));
			// need to shift the date as jannuary is 0 in flex
			lastPostingDate.setMonth(lastPostingDate.getMonth()-1);
			lastPostingDate.setFullYear(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_LAST_POSTED_DATE.substr(0,4));							
			// only for usage screen, subtract 1 from the last post date
			lastPostingDate.setTime((lastPostingDate.getTime()-millisecondsPerDay));	
			
			if ( wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.E_SHOW_TEXT_CHANGE == 'X') {
				showTextChanges = true;
				showTextColour = 0xFFFFFF;
			} else {
				showTextChanges = false;
				showTextColour = 0xDCDCDC;				
			}
			// set values for max pagination and max print order
			setMaxValues(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.ET_PARAMETERS.item);	
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
		else if (event.target.service == "ZNP_PRINT_RUN_ADDService") {
			XMLMessList = wsAddPrintRun.ZNP_PRINT_RUN_ADD.lastResult.RE_T_MESSAGES.item;
		}
		else if (event.target.service == "ZNP_PRINT_REVERSEService") {
			XMLMessList =  wsReversePrintRun.ZNP_PRINT_RUN_REVERSE.lastResult.RE_T_MESSAGES.item;
		}
		
		// output messages		
 		if (XMLMessList && XMLMessList[0] != null) {
			var messagePopup:Message =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
		}
		doRefresh(); 
	}  
	
	// when refresh button clicked, refresh the screen
	public function doRefresh():void
	{
 		CursorManager.setBusyCursor();
		// Refresh display
		currentState = '';
		// Clear data
		PRINT_DATE.text = '';
		ISSUE_DATE.text = '';
		PRINT_ORDER.text = '';
		PAGINATION.text = '';
		USAGE.text = '';
		TEXT.text = '';
		COLOUR.text = '';
		// Get stock usage for site
		getStockUsage();		
    	CursorManager.removeBusyCursor();  
	} 
	
	// get stock usage for site selected
	public function getStockUsage():void {
       	var Items:Array = new Array();

    	// This function is run when the application is first opened
		if (wsGetUsage.ZNP_PRINT_RUN_READ.lastResult != null && wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.PLANNED_PRINT_ORDERS.item != null) {
 	       	var allItems:XMLList = new XMLList(wsGetUsage.ZNP_PRINT_RUN_READ.lastResult.PLANNED_PRINT_ORDERS.item);

	       	for each (var x:XML in allItems)
    	   	{
       			var y:XML = new XML("<item/>");
       			y.WERKS = x.WERKS;
				y.PUBLICATION = x.PUBLICATION;
				y.PRINT_DATE = DateToSAPFormat(x.PRINT_DATE);
       			y.ISSUE_DATE = x.ISSUE_DATE; 
      			y.PRINT_ORDER = x.PRINT_ORDER; 
				y.PAGINATION = x.PAGINATION;
				y.GSM = x.GSM;
				y.MATKL = x.MATKL;
       			y.TEXT_CHANGES = x.TEXT_CHANGES; 
      			y.COLOUR_CHANGES = x.COLOUR_CHANGES;
      			y.PAPER_USAGE = x.PAPER_USAGE;      			
       			Items.push(y);
	       	}
	    	wsGetUsage.ZNP_PRINT_RUN_READ.request.PLANNED_PRINT_ORDERS = Items; 
		}
		
 		wsGetUsage.ZNP_PRINT_RUN_READ.send();
	}			

	// set the publication list to selected value
	public function setPublicationCombo():void {
		comboPublication.setFocus();
		
		if(comboPublication.selectedItem != null){
			SelectedPublication = comboPublication.selectedItem.data;
    		weekday = comboPublication.selectedItem.data1;
    		saturday = comboPublication.selectedItem.data2;
    		sunday = comboPublication.selectedItem.data3;
		}
	}

	// set the publication to be returned
	private function SelectPublication():void{
        for (var i:int = 0; i< publicationList.length; i++){	      	
        	if(publicationList[i].data == SelectedPublication){
        		comboPublication.selectedIndex = i;
        		return;
        	}
        }
		if(publicationList.length > 0){
	    	comboPublication.selectedIndex = 0;
    		SelectedPublication = publicationList[0].data;
    		weekday = publicationList[0].data1;
    		saturday = publicationList[0].data2;
    		sunday = publicationList[0].data3;
		}
	}
	
	// set the publication drop list for stock usage
	private function PopulatePublication(publicationXML:Object):void{
		var pubXML:XMLList = publicationXML as XMLList;
        var xmlPublicationLength:int  = pubXML.length();
        publicationList = new Array();

        var i:Number=0;
        for (i=0; i< xmlPublicationLength; i++){
            var value:String = pubXML[i].DESCRIPTION.toString();
            var key:String = pubXML[i].ZNP_TITLE.toString();
            var key1:String = pubXML[i].WEEK_DAYS.toString();
            var key2:String = pubXML[i].SATURDAY.toString();
            var key3:String = pubXML[i].SUNDAY.toString();
            publicationList.push({label: value, data: key, data1: key1, data2: key2, data3: key3});
		}
    }		        

	// set the Grammage list to selected value
 	public function setGrammageCombo():void {
		comboGrammage.setFocus();
		
		if(comboGrammage.selectedItem != null){
			SelectedGrammage = comboGrammage.selectedItem.data;
			SelectedMatkl = comboGrammage.selectedItem.data2;
		}
	} 

	// set the Grammage to be returned
 	private function SelectGrammage():void{
        for (var i:int = 0; i< grammageList.length; i++){	      	
        	if(grammageList[i].data == SelectedGrammage && grammageList[i].data2 == SelectedMatkl){
        		comboGrammage.selectedIndex = i;
        		return;
        	}
        }
		if(grammageList.length > 0){
	    	comboGrammage.selectedIndex = 0;
    		SelectedGrammage = grammageList[0].data;
    		SelectedMatkl = grammageList[0].data2;
		}
	} 
	
	// set the Grammage drop list for stock usage
 	private function PopulateGrammage(grammageXML:Object):void{
		var pagiXML:XMLList = grammageXML as XMLList;
        var xmlgrammageLength:int  = pagiXML.length();
        grammageList = new Array();

        var i:Number=0;
        for (i=0; i< xmlgrammageLength; i++){
            var value:String = pagiXML[i].ZNP_GSM.toString() + ' ' + pagiXML[i].MATKL.toString();
   	        var key:String = pagiXML[i].ZNP_GSM.toString();
   	        var key2:String = pagiXML[i].MATKL.toString();
       	    grammageList.push({label: value, data: key, data2: key2});
		}
    } 	
    
    // manually add stock usage
  	public function onAdd(PRINT_DATE1:String, Publication:String, ISSUE_DATE:String,
  						  PRINT_ORDER:String, Pagination:String, GSM:String, USAGE:String,
  						  TEXT:String, COLOUR:String, MATKL:String):void{
		var alert_text:String;
		var printOrder:int;
		// check the date is not a future date
		var todaysDate:Date = new Date();
		var enteredDate:Date = new Date(2010, 0, 1);
		var issueDate:Date = new Date();
		var pagiCheck:int = new int;
		var maxFutureDate:Date = new Date();
		
		maxFutureDate.setTime(maxFutureDate.getTime() + (30 * millisecondsPerDay));
		pagiCheck = parseInt(Pagination) % 2;
		
		//enteredDate.setDate(PRINT_DATE1.substr(0,2));
		enteredDate.setMonth(PRINT_DATE1.substr(3,2));
		// need to shift the date as jannuary is 0 in flex
		enteredDate.setMonth(enteredDate.getMonth()-1);
		enteredDate.setDate(PRINT_DATE1.substr(0,2));
		enteredDate.setFullYear(PRINT_DATE1.substr(6,4));
		
		//issueDate.setDate(ISSUE_DATE.substr(0,2));
		issueDate.setMonth(ISSUE_DATE.substr(3,2));
		// need to shift the date as jannuary is 0 in flex
		issueDate.setMonth(issueDate.getMonth()-1);
		issueDate.setDate(ISSUE_DATE.substr(0,2));
		issueDate.setFullYear(ISSUE_DATE.substr(6,4));		
		
		printOrder = parseInt(PRINT_ORDER);
		
		PRINT_DATE.setFocus();
		// validate the data entered
		if (enteredDate > todaysDate) {
			alert_text = 'You cannot enter a future date';
			Alert.show(alert_text);		
		} else if (enteredDate <= lastPostingDate) {
			alert_text = 'Period has already been closed, date must be after ' + lastPostingDate.toDateString();
			Alert.show(alert_text);				
		} else if (issueDate <= lastPostingDate) {
			alert_text = 'Period has already been closed, date must be after ' + lastPostingDate.toDateString();
			Alert.show(alert_text);				
		} else if (issueDate < enteredDate) {
			alert_text = 'The print date cannot be after the issue date';
			Alert.show(alert_text);				
		} else if (issueDate > maxFutureDate) {
			alert_text = 'You can not print an issue more than 28 days in advance';
			Alert.show(alert_text);	
		} else if (printOrder > maxPrintOrder)  {
			alert_text = 'Maximun quantity of a print order is ' + maxPrintOrder;
			Alert.show(alert_text);			
		// check the pagination is divisable by 2
		} else if (pagiCheck == 1) {
			alert_text = 'Pagination must be an even number';
			Alert.show(alert_text);	
		} else if (parseInt(Pagination) > maxPagination) {
			alert_text = 'Maximum pagination is ' + maxPagination;
			Alert.show(alert_text);						
		} else {	
			// make sure the publication issue date matches the publication, e.g. NoW on Sundays only
			if ( issueDate.getDay() == 0 && sunday != 'X') {
				alert_text = 'Publication not valid on a Sunday';
				Alert.show(alert_text);					
			} else if ( issueDate.getDay() == 6 && saturday != 'X') {
				alert_text = 'Publication not valid on a Saturday';
				Alert.show(alert_text);					
			} else if ( issueDate.getDay() != 0 && issueDate.getDay()!= 6 && weekday !='X') {
				alert_text = 'Publication not valid on a Weekday';
				Alert.show(alert_text);				
			// check the user has entered some data - minimun is vendor, material, weight and reels
			} else if (PRINT_ORDER == ''){
				alert_text = 'Please enter the print order';
				Alert.show(alert_text);	
	 		} else if (Pagination == '' || Pagination == '0') {
				alert_text = 'Please enter the pagination';
				Alert.show(alert_text); 
			} else if (GSM == ''){
				alert_text = 'Please enter the GSM';
				Alert.show(alert_text);	
			} else if (USAGE == ''){
				alert_text = 'Please enter the usage';
				Alert.show(alert_text);	
			} else {
				// set data to be passed into SAP to add stock usage
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.WERKS = SelectedPlant;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PUBLICATION = Publication;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PRINT_ORDER = PRINT_ORDER;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PRINT_DATE = DateToSAPFormat(PRINT_DATE1);
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.ISSUE_DATE = DateToSAPFormat(ISSUE_DATE);
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PAGINATION = Pagination;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.GSM = GSM;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.MATKL = MATKL;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.TEXT_CHANGES = TEXT;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.COLOUR_CHANGES = COLOUR;
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PAPER_USAGE = USAGE;
	
				wsAddPrintRun.ZNP_PRINT_RUN_ADD.send(); 		
		 	}
		}
  	} 

  	// accept a usage line
  	public function onReceiptLine(receiptLine:XML):void{
		var alert_text:String;
		var printOrder:int;
		var enteredDateString:String;
		var firstdecimal:int;
		var weightdecimal:int = -1;
		var weightsubstring:String;
		var weightlength:int;	
		var pagiCheck:int = new int;
		var year:String;	
	
		// if date is in format yyyy-mm-dd change to dd.mm.yyyy
		if (receiptLine.PRINT_DATE.substr(4,1) == '-' && receiptLine.PRINT_DATE.substr(7,1) == '-') {
			receiptLine.PRINT_DATE = receiptLine.PRINT_DATE.substr(8,2) + '.'
			+ receiptLine.PRINT_DATE.substr(5,2) + '.' + receiptLine.PRINT_DATE.substr(0,4);
		}
		
		if (receiptLine.PRINT_DATE.substr(6,4).length == 2) {
			receiptLine.PRINT_DATE = receiptLine.PRINT_DATE.substr(0,6) + '20' + receiptLine.PRINT_DATE.substr(6,2);
		}

		pagiCheck = parseInt(receiptLine.PAGINATION) % 2;

		// check the weight is in a valid format (nnnnnnnnn.nnn)
		weightlength = receiptLine.PAPER_USAGE.toString().length;
		firstdecimal = receiptLine.PAPER_USAGE.indexOf(".");
		if (firstdecimal > -1) {
			weightsubstring = receiptLine.PAPER_USAGE.substr(firstdecimal + 1, 9999);
			weightlength = weightsubstring.length;
			weightdecimal = weightsubstring.indexOf("."); }
		else {
			weightlength = 0;
		}
		
		// check the date is not a future date
		var todaysDate:Date = new Date();
		var enteredDate:Date = new Date(2010, 0, 1);
		var issueDate:Date = new Date();		

		var month:Number = new Number(receiptLine.PRINT_DATE.substr(3,2));
		month = month - 1; // January is 0 in flex
		
		//enteredDate.setDate(receiptLine.PRINT_DATE.substr(0,2));
		enteredDate.setMonth(receiptLine.PRINT_DATE.substr(3,2));
		// need to shift the date as jannuary is 0 in flex
		enteredDate.setMonth(enteredDate.getMonth()-1);
		enteredDate.setFullYear(receiptLine.PRINT_DATE.substr(6,4));
		enteredDate.setDate(receiptLine.PRINT_DATE.substr(0,2));

		//issueDate.setDate(receiptLine.ISSUE_DATE.substr(8,2));
		issueDate.setMonth(receiptLine.ISSUE_DATE.substr(5,2));
		// need to shift the date as jannuary is 0 in flex
		issueDate.setMonth(issueDate.getMonth()-1);
		issueDate.setDate(receiptLine.ISSUE_DATE.substr(8,2));
		issueDate.setFullYear(receiptLine.ISSUE_DATE.substr(0,4));
				
		printOrder = parseInt(receiptLine.PRINT_ORDER);
		// as flex adjusts the date to be valid - e.g invalid date of 31/02/2010 becomes 03/02/2010
		if ( enteredDate.getDate() != parseInt(receiptLine.PRINT_DATE.substr(0,2)) ||
			 enteredDate.getMonth() != month  || enteredDate.getFullYear().toString() != receiptLine.PRINT_DATE.substr(6,4) ) {
			alert_text = 'Invalid Date';
			Alert.show(alert_text);				 	
		} else if (enteredDate > todaysDate) {
			alert_text = 'You cannot enter a future date';
			Alert.show(alert_text);				
		} else if (enteredDate <= lastPostingDate) {
			alert_text = 'Period has already been closed, date must be after ' + lastPostingDate.toDateString();
			Alert.show(alert_text);				
		} else if (issueDate < enteredDate) {
			alert_text = 'The print date cannot be after the issue date';
			Alert.show(alert_text);	
		} else
		// check the user has entered some data - minimun is vendor, material, weight and reels
 		if (receiptLine.PRINT_ORDER == '' || parseInt(receiptLine.PRINT_ORDER) == 0) {
			alert_text = 'Please enter the print order';
			Alert.show(alert_text); 		
 		} else if (receiptLine.PAGINATION == '' || receiptLine.PAGINATION == '000') {
			alert_text = 'Please enter the pagination';
			Alert.show(alert_text); 			
		} else if (pagiCheck == 1) {
			alert_text = 'Pagination must be an even number';
			Alert.show(alert_text);	
		} else if (parseInt(receiptLine.PAGINATION) > maxPagination) {
			alert_text = 'Maximum pagination is ' + maxPagination;
			Alert.show(alert_text);	
 		} else if (receiptLine.GSM == '' || receiptLine.GSM == '0.0') {
			alert_text = 'Please enter the GSM';
			Alert.show(alert_text); 			
 		} else if (receiptLine.PAPER_USAGE == '' || receiptLine.PAPER_USAGE == '0.000'){
			alert_text = 'Please enter the actual usage';
			Alert.show(alert_text);		
		} else if (weightdecimal > -1) {
			alert_text = 'invalid weight for actual usage';
			Alert.show(alert_text);				
		} else if ( weightlength > 3 ) {
			alert_text = 'too many decimal places for the actual usage';
			Alert.show(alert_text);						
		} else if (printOrder > maxPrintOrder)  {
			alert_text = 'Maximun quantity of a print order is ' + maxPrintOrder;
			Alert.show(alert_text);	}
		// check the pagination is divisable by 2
		else {
			// set data to be passed into SAP to accept a print run
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.WERKS = receiptLine.WERKS;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PUBLICATION = receiptLine.PUBLICATION;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PRINT_ORDER = receiptLine.PRINT_ORDER;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PRINT_DATE = DateToSAPFormat(receiptLine.PRINT_DATE);
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.ISSUE_DATE = receiptLine.ISSUE_DATE;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PAGINATION = receiptLine.PAGINATION;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.GSM = receiptLine.GSM;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.MATKL = receiptLine.MATKL;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.TEXT_CHANGES = receiptLine.TEXT_CHANGES;
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.COLOUR_CHANGES = receiptLine.COLOUR_CHANGES;			
			wsAddPrintRun.ZNP_PRINT_RUN_ADD.request.I_PRINT_RUN.PAPER_USAGE = receiptLine.PAPER_USAGE;

			wsAddPrintRun.ZNP_PRINT_RUN_ADD.send();			
		} 		
  	} 
  	
  	// reverse a line
   	public function onReverseLine(reverseLine:XML):void{
		// set data to be passed into SAP to reverse a usage line
		wsReversePrintRun.ZNP_PRINT_RUN_REVERSE.request.I_PRINT_RUN.WERKS = reverseLine.WERKS;
		wsReversePrintRun.ZNP_PRINT_RUN_REVERSE.request.I_PRINT_RUN.PUBLICATION = reverseLine.PUBLICATION;
		wsReversePrintRun.ZNP_PRINT_RUN_REVERSE.request.I_PRINT_RUN.PRINT_DATE = reverseLine.PRINT_DATE;
		wsReversePrintRun.ZNP_PRINT_RUN_REVERSE.request.I_PRINT_RUN.ISSUE_DATE = reverseLine.ISSUE_DATE;

		wsReversePrintRun.ZNP_PRINT_RUN_REVERSE.send();
  	} 
  	
	// format waste allowance for output
    private function percentage(item:Object, column:DataGridColumn):String{
 		var valuePercentage:String;

 		if (item) {
		// add percentage symbol to the end
			valuePercentage = item[column.dataField].toString() + ' %';
		} 
		return valuePercentage; 
       }  		         

	// format pagination for output
    private function pages(item:Object, column:DataGridColumn):String{
 		var pages:String;

 		if (item) {
		// add pages to end of pagination
			pages = item[column.dataField].toString() + ' pages';
		} 
		return pages; 
       } 

	// set the maximum values for validation 
	private function setMaxValues(parameterXML:Object):void{
		var parametersXML:XMLList = parameterXML as XMLList;
        var xmlParametersLength:int = parametersXML.length();

        var i:Number=0;
        for (i=0; i< xmlParametersLength; i++){
            if (parametersXML[i].CONFIG.toString() == 'MAX_PAG') {
            	maxPagination = parametersXML[i].VALUE.toString();
            } else if (parametersXML[i].CONFIG.toString() == 'MAX_ORDER') {
	            maxPrintOrder = parametersXML[i].VALUE.toString();
            }
		}	
    }        