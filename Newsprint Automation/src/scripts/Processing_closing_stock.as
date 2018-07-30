// ActionScript file
	// week number combo box
	[Bindable]
	private var weekList:Array;
					
	[Bindable]
	public var SelectedWeek:String;
	public var passedWeek:String;
	
	[Bindable]
	public var dateFrom:String;
	[Bindable]
	public var dateTo:String;	
	[Bindable]
	public var yearTo:String;
	[Bindable]
	public var weekTo:String;
	[Bindable]
	public var yearFrom:String;
	[Bindable]
	public var weekFrom:String;	

	[Bindable]
	public var postFigures:String;

	[Bindable]
	public var week:XMLList;
	
	[Bindable]
	public var closingStock:XMLList;
	
	[Bindable]
	public var XMLGrammageTot:XMLList; 
	
	//Process messages and error from SAP function calls
	public function processingReturned(event:ResultEvent):void {
		// We have the result of a rejection or an approval back from SAP
 		var b:XML = new XML(event.result[0]);
		var d:String;
		var XMLMessList:XMLList;
		var messagePopup:Message;
	
 		if (event.target.service == "ZNP_PLANT_AUTH_CHECKService") {
			XMLMessList = wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.RE_T_MESSAGES.item;
	        PopulatePlant(wsGetPlants.ZNP_PLANT_AUTH_CHECK.lastResult.ET_WERKS.item);
			SelectPlant();
			
			if (XMLMessList && XMLMessList[0] != null) {
				messagePopup =  PopUpManager.createPopUp(this, Message) as Message;
				messagePopup.messageTab = XMLMessList;	
			}

		} else if (event.target.service == "ZNP_GET_WEEKService") {
			XMLMessList = wsGetWeek.ZNP_GET_WEEK.lastResult.RE_T_MESSAGES.item;
	        PopulateWeek(wsGetWeek.ZNP_GET_WEEK.lastResult.ET_WEEK_NO.item);
			SelectWeek();
		}		
 		else if (event.target.service == "ZNP_VALIDATE_STOCKService") {
 			closingStock = 	wsValidateClosingStock.ZNP_VALIDATE_STOCK.lastResult.I_CLOSING_STOCK.item;
			XMLMessList = wsValidateClosingStock.ZNP_VALIDATE_STOCK.lastResult.RE_T_MESSAGES.item;
		} 
		
		// output messages		
		if (XMLMessList && XMLMessList[0] != null) {
			messagePopup =  PopUpManager.createPopUp(this, Message) as Message;
			messagePopup.messageTab = XMLMessList;	
		}
		doRefresh(); 
	}  

	public function closingReturned(event:ResultEvent):void {
		// We have the result of a rejection or an approval back from SAP
 		var b:XML = new XML(event.result[0]);
		var d:String;
		var XMLMessList:XMLList;
		var messagePopup:Message;
	
		if (event.target.service == "ZNP_GET_WEEKService") {
			XMLMessList = wsGetWeek.ZNP_GET_WEEK.lastResult.RE_T_MESSAGES.item;
    	    PopulateWeek(wsGetWeek.ZNP_GET_WEEK.lastResult.ET_WEEK_NO.item);
			SelectWeek();
		}
		
		// output messages		
		if (XMLMessList && XMLMessList[0] != null) {
			messagePopup =  PopUpManager.createPopUp(this, Message) as Message;
			messagePopup.messageTab = XMLMessList;	
		}
		getClosingStock();	
	}

	// when refresh button clicked, refresh the screen
	public function doRefresh():void
	{
 		CursorManager.setBusyCursor();
		// Refresh display
		currentState = '';

		// Get closingstock for site
		getWeekNo();
    	CursorManager.removeBusyCursor(); 
	} 
	
	// display the results
	public function showResults(event:ResultEvent):void {
		// This is the result of the webservice called by getClosingStock();
		var XMLMessList:XMLList;
		closingStock = 	wsGetClosingStock.ZNP_CLOSING_STOCK_READ.lastResult.CLOSING_STOCK.item;	
		XMLGrammageTot = wsGetClosingStock.ZNP_CLOSING_STOCK_READ.lastResult.GRAMMAGE_TOTALS.item;
	}	
	
	// get deliveries for site selected
	public function getClosingStock():void {
    	// This function is run when the application is first opened	
		wsGetClosingStock.ZNP_CLOSING_STOCK_READ.send();
	}				        

	// get week numbers for site selected
	public function getWeekNo():void {
    	// This function is run when the application is first opened	
		wsGetWeek.ZNP_GET_WEEK.send();
	}
	
	// set the week drop list to selected value
	public function setWeekCombo():void {
		comboWeek.setFocus();
		
		if(comboWeek.selectedItem != null){
			dateFrom = comboWeek.selectedItem.data1;
			dateTo = comboWeek.selectedItem.data2;		
		}
	}

	// set the week to be returned when calling getDeliveries
	private function SelectWeek():void{
        for (var i:int = 0; i< weekList.length; i++){	      	
        	if(weekList[i].data1 == dateFrom && weekList[i].data2 == dateTo) {
        		comboWeek.selectedIndex = i;
        		return;
        	}
        }
    	comboWeek.selectedIndex = 0;
		dateFrom = weekList[0].data1;
		dateTo = weekList[0].data2;  
		yearTo = weekList[0].data5;	
		weekTo = weekList[0].data6;
		yearFrom = weekList[0].data3;	
		weekFrom = weekList[0].data4;	
	}
	
	// set the week drop list of sites the user is authorised to receipt
	private function PopulateWeek(weekXML:Object):void{
		var weeksXML:XMLList = weekXML as XMLList;
         var xmlWeekLength:int  = weeksXML.length();
        weekList = new Array();

         var i:Number=0;
        for (i=0; i< xmlWeekLength; i++){ 
            var value:String = 'Weeks ' + weeksXML[i].ZWEEK.toString() + ' to ' + weeksXML[i].ZWEEK_TO.toString()
            	+ ' ' + weeksXML[i].DATE_FROM.toString().substr(8,2) + '/'
            	+ weeksXML[i].DATE_FROM.toString().substr(5,2) + '/'
            	+ weeksXML[i].DATE_FROM.toString().substr(0,4)
            	+ ' - ' + weeksXML[i].DATE_TO.toString().substr(8,2) + '/'
            	+ weeksXML[i].DATE_TO.toString().substr(5,2) + '/'
            	+ weeksXML[i].DATE_TO.toString().substr(0,4);            	
            var key1:String = weeksXML[i].DATE_FROM.toString();		            
            var key2:String = weeksXML[i].DATE_TO.toString();  
            var key3:String = weeksXML[i].ZYEAR.toString();
            var key4:String = weeksXML[i].ZWEEK.toString()
            var key5:String = weeksXML[i].ZYEAR_TO.toString();
            var key6:String = weeksXML[i].ZWEEK_TO.toString();                        
            weekList.push({label: value, data1: key1, data2: key2, data3: key3, data4: key4, data5: key5, data6: key6});
 		} 
    }

	// display grammage usage total
	public function displayTotals():void{ 
		var grammagePopup:GrammageTotals;
		
		grammagePopup =  PopUpManager.createPopUp(this, GrammageTotals) as GrammageTotals;
		grammagePopup.grammageTab = XMLGrammageTot;		
	}

   	// submit figures
  	public function onSubmit(post:String):void{		
       	var Items:Array = new Array();
       	var allItems:XMLList = new XMLList(this.closingStock);
		var alert_text:String;
		// make sure user is not trying to post the current weeks figure before the week has ended
		// check the date is not a future date
		var todaysDate:Date = new Date();
		var endDate:Date = new Date();
		var error:Boolean = false;
		var firstdecimal:int;
		var weightdecimal:int = -1;
		var reeldecimal:int = -1;
		var weightsubstring:String;
		var weightlength:int;
		var reelsubstring:String;
		var reellength:int;		
		
		endDate.setDate(dateTo.substr(8,2));
		endDate.setMonth(dateTo.substr(5,2));
		// need to shift the date as jannuary is 0 in flex
		endDate.setMonth(endDate.getMonth()-1);
		endDate.setFullYear(dateTo.substr(0,4));
		
		if (endDate > todaysDate && post == 'X') {
//			alert_text = 'End date' + endDate + 'todays date' + todaysDate;
//			Alert.show(alert_text);		
					
			alert_text = 'Current week has not ended';
			Alert.show(alert_text);				
		} else {		
			postFigures = post;
	
	       	for each (var x:XML in allItems)
	       	{
       			var y:XML = new XML("<item/>");
				if (error == false ) {
					// validate the weight and reels for invalid entries
					// check the weight is in a valid format (nnnnnnnnn.nn)
					weightlength = x.CLOSING_WEIGHT.toString().length;
					firstdecimal = x.CLOSING_WEIGHT.indexOf(".");
					if (firstdecimal > -1) {
						weightsubstring = x.CLOSING_WEIGHT.substr(firstdecimal + 1, 9999);
						weightlength = weightsubstring.length;
						weightdecimal = weightsubstring.indexOf("."); }
					else {
						weightlength = 0;
					}
					
					// check the reels is in a valid format (nnn.nn)
					reellength = x.CLOSING_REEL.toString().length;
					firstdecimal = x.CLOSING_REEL.indexOf(".");
					if (firstdecimal > -1) {
						reelsubstring = x.CLOSING_REEL.substr(firstdecimal + 1, 9999);
						reellength = reelsubstring.length;
						reeldecimal = reelsubstring.indexOf("."); }
					else {
						reellength = 0;
					}
	
					if (weightdecimal > -1) {
						alert_text = 'invalid weight';
						Alert.show(alert_text);		
						error = true;		
					} else if ( weightlength > 3 ) {
						alert_text = 'too many decimal places for the weight';
						Alert.show(alert_text);
						error = true;
					} else if (reeldecimal > -1) {
						alert_text = 'invalid number of reels';
						Alert.show(alert_text);	
						error = true;			
					} else if ( reellength > 2 ) {
						alert_text = 'too many decimal places for reels';
						Alert.show(alert_text);
						error = true;
					} else {
						y = x;
	           			Items.push(y);					
					}	
				}			          			
       		} 
	
			if ( error == false ) {
				wsValidateClosingStock.ZNP_VALIDATE_STOCK.request.I_CLOSING_STOCK = Items;
				wsValidateClosingStock.ZNP_VALIDATE_STOCK.send();				 		
			}
		}
  	}			