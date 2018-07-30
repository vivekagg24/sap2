/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	DataManipulation.as - formatting, calculating, changing data within the flex app. General functions.

	addVAT
		Calulate the VAT for the total
		(if the contributor is VAT registered and is UK based)
	defaultPublicationDate
		Default the publication date based on publication ID
		Store the deault so we can see if the user has entered a value	
	populateItems
		Populate the CPRItems (array of CPRItem)  - bound to the datagrid
	resetItems
		Reset the CPRItems (array of CPRItem)  - bound to the datagrid		
	formatPubdate
		Make sure publication date is DD/MM/YYYY
	getPublicationId
		Get the current publication date
	getPaymentDueDate
		Get the payment due date
	getPublicationDate
		get the publication date: SAP internal format
	addToRecentContribs
		adds the results of a single contributor to an array, for retreival later, to save us needing to wait 
		for SAP to go to the database.
	getFromRecentContribs
		retreives the results of a single contributor to an array, to save us needing to wait 
		for SAP to go to the database.
	setPaymentNotesLabel
		Sets text to the payments notes editor if it has been created, otherwise stores it for later
*/
import ecs.generalClasses.CPRItem;
import mx.formatters.*;
	


/*
	addVAT
		Calulate the VAT for the total
		(if the contributor is VAT registered and is UK based)
*/
private function addVAT():void{
	var total:Number;
	var format:NumberFormatter = new NumberFormatter();
	var vat:Number;
	var commas:RegExp = /,/g; 			// Regular expression to replace commas
	format.useThousandsSeparator=true;
	var precision:String = initXml.CH_T_CURRENCIES.item.(DATA==cprCurrency).DECIMALS;
	format.precision=int(precision);
	format.rounding =  NumberBaseRoundType.NEAREST;
	total=Number(totalAmount.replace(commas,""));
	totalNet=totalAmount;
	VATAmount=format.format("0.00");
	if (contributorDetails!=null){
    	if (contributorDetails.STCEG.toString()!="" && contributorDetails.LAND1 == "GB"){
    		vat = total *(VATRate / 1000);
    		total+=vat;
    		totalAmount=format.format(total);
    		VATAmount=format.format(vat);
    		    		
    	}
    	else
    	{// Just format, don't add vat
    		totalAmount=format.format(total);
    	}
	}	
}

/*

	defaultPublicationDate
		Default the publication date based on publication ID
		Store the deault so we can see if the user has entered a value
		Don't default if data is set or held
*/
private function defaultPublicationDate():void{
	if (holdData && holdData.publicationDate && holdData.publicationDate.length > 0)
		return; // Set / held date, so don't default
	
	var format:DateFormatter = new DateFormatter();
	var publicationDate:String = new String();
	if (!applicationEditable) return;
	
	publicationDate = initXml.CH_T_PUBLICATION_DATES.item.(PUBID==comboPubID.selectedItem.data).PUBDATE;	
	format.formatString="DD/MM/YYYY";
	publicationDate = format.format(publicationDate);
	dtPubDate.text = publicationDate;
	defaultPubDate = publicationDate;
}

/*
	
	populateItems
		Populate the CPRItems (array of CPRItem)  - bound to the datagrid

*/
private function populateItems():void{
			 	 	 
    var currItem:XML;			//Curr item from XML
    var itemObj:CPRItem;		//Item for data  datagrid
    var i:int = 0;
	var itemsList:XMLList = itemsXML.CH_T_ITEMS; //Items from ZECS_GET_CPR
	
	CPRItems = new Array();
    
    for each(currItem  in itemsList.item){
    		
    	itemObj = new CPRItem();
    	//amount
    	itemObj.amount  = currItem.AMOUNT.toString();
        if (Number(itemObj.amount)==0) itemObj.amount = "";
    	if (MODE!=CREATE && Number(itemObj.amount)==0) continue;
    	//currency
    	itemObj.currency  = currItem.CURRENCY.toString();
    	if (itemObj.currency=="")itemObj.currency = cprCurrency;
    	//cost centre	
    	itemObj.costCentre = currItem.COST_CENTRE.toString();
    	//item category
    	itemObj.itemCategory = currItem.ITEM_CATEGORY.toString();
    	//default is lineage
    	if (itemObj.itemCategory=="")itemObj.itemCategory=LINEAGE;
    	//project
    	itemObj.project = currItem.PROJECT.toString();
    	//GL account
    	itemObj.GLAccount = currItem.GL_ACCOUNT.toString();
    	//CPR number and year
    	itemObj.document = currItem.DOCUMENT.toString();
    	itemObj.year = currItem.YEAR.toString();
    	//item index
    	itemObj.index = i;	    
    	
    	if (MODE==DISPLAY){
    		//Set editable properties and style for "holdable" fields
    		itemObj.amountEditable = false;
    		itemObj.amountStyleName = "disabled";
    		itemObj.costCentreEditable =  false;
			itemObj.costCentreStyleName="disabled";
			itemObj.itemCategoryEditable = false;
			itemObj.itemCategoryStyleName="disabled";
			itemObj.GLAccountEditable = false;
			itemObj.GLAccountStyleName="disabled";
			itemObj.projectEditable = false;
			itemObj.projectStyleName="disabled";
    	}
    	     		
    	CPRItems[i] = itemObj;
    	i++;
    } 	
    //Execute the binding and update the display
    dgItems.enabled=true;
    dgItems.executeBindings();
	dgItems.invalidateProperties();
}

/*
	
	resetItems
		Reset the CPRItems (array of CPRItem)  - bound to the datagrid

*/

private function resetItems():void{
 
// Reset
 for (var i:int=0;i<CPRItems.length;i++){
  (CPRItems[i] as CPRItem).amountRenderer = null;
  (CPRItems[i] as CPRItem).GLRenderer = null;
  (CPRItems[i] as CPRItem).costCentreRenderer = null;
  (CPRItems[i] as CPRItem).projectRenderer = null;

  CPRItems[i].amount="";
  CPRItems[i].costCentre="";
  CPRItems[i].GLAccount="";
  CPRItems[i].project="";
  CPRItems[i].itemCategory=LINEAGE;
  CPRItems[i].currency= this.cprCurrency;  
   }


   
 //Execute the binding and update the display
    dgItems.enabled=true;
    dgItems.executeBindings();
    dgItems.invalidateProperties(); // <= invalidateProperties is safer and more through than invalidateDisplayList()
}



/*
	formatPubdate
		Make sure publication date is DD/MM/YYYY

*/
private function formatPubDate():void{
	var  dateString:String="";
	var pattern:RegExp = /[.]/g;
	//Replace . with /
	dateString = dtPubDate.text.replace(pattern,"/");
	if (dateString.length<6) return;
	var stringHelp:StringHelper = new StringHelper();
	dateString  = stringHelp.trim(dateString,"");
	//Add in / if not entered
	if (dateString.substr(2,1)!="/") 
		dateString = dateString.slice(0,2) + "/" + dateString.slice(2,dateString.length);
	if (dateString.substr(5,1)!="/") 
		dateString = dateString.slice(0,5) + "/" + dateString.slice(5,dateString.length);
	//Make 07 2007. Only works until 2099 but that'll do
	if (dateString.length == 8)
		dateString = dateString.slice(0,6) + "20" + dateString.slice(6,8);
	dtPubDate.text=dateString;
}

/*
	getPublicationId
		Get the current publication date
*/
public function getPublicationId():String{
	if (comboPubID && comboPubID.selectedItem)
	{
		return comboPubID.selectedItem.data;
	}
	else
	{
		return "";
	}
	
}

/*
	getPaymentDueDate
		Get the payment due date
*/
private function getPaymentDueDate():void{
	if (!applicationLoaded || CPRHeader.STATUS!=STATUS_POSTED){
		showDueDate=false;
		return;
	} 
	showDueDate=true;	
   	txtPaymentDue.text=formatDate(CPRHeader.PAYMENT_DUE.toString());
}

/* getPublicationDate
		get the publication date: SAP internal format

*/
private function getPublicationDate():String{
	formatPubDate();
	return dtPubDate.text.substr(6,4) + dtPubDate.text.substr(3,2) + dtPubDate.text.substr(0,2);
}


private function addToRecentContribs(result:Object):void
{
	// Get the contributor number
	var num:String = result.CH_T_CONTRIBUTOR_DETAIL.LIFNR;
	if (num == "")
		return; // Should never happen, but just in case there's a bug, make sure it doesn't fall over
	
	// Check if its already there. If so, delete and re-add (in caseit has changed)
	var isAlreadyThere:Object = retreiveFromRecentContribs(num);
	if (isAlreadyThere) // remove it
	{
		var index:int = recentContributorDetails.indexOf(isAlreadyThere);
		recentContributorDetails.splice(index, 1); // delete
	}		
		
	// Add it (to the end of the array)
	recentContributorDetails.push(new XML(result));
	
	// Make sure the list doesn't get too big
	if (recentContributorDetails.length > 30)
		recentContributorDetails.shift(); // Remove first element (the last used)
	
}

private function retreiveFromRecentContribs(contribNumber:String):Object
{
	// First remove any leading zeros
	while (contribNumber.length > 0 && contribNumber.charAt(0) == "0")
	{
		contribNumber = contribNumber.slice(1);
	}
	
	
	// Now search
	for each (var obj:Object in recentContributorDetails)
	{
		if (contribNumber == obj.CH_T_CONTRIBUTOR_DETAIL.LIFNR.toString())
			return obj;		
	}
	
	return null;
}

public function setPaymentNotesLabel():void
		{
			if (rteNotes && ( rteNotes.text.length > 0 || rteNotes.htmlText.length > 0) )
			{
				paymentNotesTxt = "Payment Notes";
				paymentNotesIcon = notesImgClass;		
			}
			else if (paymentNotesLongTxt.length > 0)
			{
				paymentNotesTxt = "Payment Notes";
				paymentNotesIcon = notesImgClass;	
			}
			else
			{
				paymentNotesTxt = "Payment Notes (empty)";
				paymentNotesIcon = null;
			}			
			
			// If it has been created, set its values, otherwise they will be set from the variables
			// when it is created
			if (tabPaymentNotes)
			{
				tabPaymentNotes.label = paymentNotesTxt;
				tabPaymentNotes.icon = paymentNotesIcon;
			}
			
			
			
		}

