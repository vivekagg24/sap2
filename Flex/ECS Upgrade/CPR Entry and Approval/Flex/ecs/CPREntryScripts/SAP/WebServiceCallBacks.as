/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

WebServiceCallBacks.as: functions called by the web services when they have completed (asycnhronous SOAP)

	callError
		Error handler for web service calls
		initDataCallBack
	
	initDataCallBack (from Z_ECS_INITIALISE_CPR_SCREEN)
		Setup the application ready for use, having retrieved:
			VAT Rate
			User's access permissions
			blank strcuture for contributor details (Flex app doesn't need to create model0
			user's publications
			user's cost centres
			currencies
			GL accounts (mapped to publication and item category)
			the item categories
			default publication dates for the publications the user is in
		Call Z_ECS_GET_CPR
		
	getCPRCallBack (from Z_ECS_GET_CPR)
		Retrieved all data for a CPR (header, notes, workflow history, change history,
		edit flags for current user, communication history, recent gl accounts and projects
		for the current user.
		If no CPR number was passed - retrieved 1 blank item (for new item create) - means
		the Flex application does not need to create data models - just uses those
		returned by the RFC

	getCPRForCopyCallBack (Z_ECS_GET_CPR)
		Populate data when copying an existing CPR	

	saveCPRCallBack (Z_ECS_SAVE_CPR)
		process messages after save
		launch cash payment print if necessary
		exit application if not in create mode
	
	getContributorDetailsCallBack (Z_ECS_CPR_GET_CONTRIBUTOR_DET)
		Populate the contributor fields having successfully retrieved a contributor

	searchContributorsCallBack (Z_ECS_SEARCH_CONTRIBUTORS)
		searching by post code
		if just one contributor then populate screen
		otherwise pass results to advanced search screen

	searchContributorsNewCallBack (Z_ECS_CONTRIB_SEARCH)
		searching by name
		if just one contributor then populate screen
		otherwise pass results to advanced search screen
		
	getContractsCallback (Z_ECS_CPR_GET_CONTRACTS)
		Populate contract dropdown
		Default in the best fit contract
		
	doublePaymentCheckCallback (Z_ECS_CHECK_DOUBLE_PAYMENT) 
		After checking for double payment  - show possible duplicates or continue save
	 
	getLast20CallBack (Z_ECS_GETLAST20)
		populate the value help lists for contribuor number and name
 
	getContributorEmailCallBack (Z_ECS_CPR_GET_EMAIL_TEXT)
		Set html property for html control to display the contributor email

	currencyConvertCallBack (Z_ECS_CONVERT_CURRENCY) 
		Currency convert called for each line item
		add result to total
		
	deleteCPRCallBack (Z_ECS_DELETE_CPR)

	saveAsUrgentCallBack (Z_ECS_SAVE_AS_URGENT)
		Saves an ME Approved CPR as urgent and updates the payment due date to today

*/
import mx.controls.Alert;
import mx.managers.IFocusManagerComponent;
import mx.core.Container;
import mx.managers.FocusManager;
import flash.events.Event;
import flash.events.FocusEvent;
import mx.core.UITextField;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.net.SharedObject;
import mx.rpc.events.FaultEvent;
import mx.rpc.soap.mxml.Operation;
import mx.core.UIComponent;
import mx.rpc.soap.WebService;


/*
	callError
		Error handler for web service calls
*/
private function callError(event:FaultEvent):void{
	// First check if its a redirection error
	// We may need to load the crossdomina policy file from the new server
	if (event.fault.faultString == "Security error accessing url")
	{
		// load the crossdomain security file
		loadCrossPolicyFile(event);
		// Call it again
		// The event needs to be captured at the Operation level, not the web service
		if (event.currentTarget is mx.rpc.soap.Operation
		   || event.currentTarget is mx.rpc.soap.mxml.Operation)
			event.currentTarget.send();
			Alert.show("Redirected");
			return;		
	}

 	this.enabled=true;
 	var error_string:String = event.fault.message;	
 	if (event.currentTarget is mx.rpc.soap.mxml.Operation)
 		error_string = "(while attempting to call " + (event.currentTarget as mx.rpc.soap.mxml.Operation).name + ") \n" + error_string;
 	
	Alert.show("An error occured connecting to the SAP system \n" + error_string ,MESSAGE_TITLE);
 	
}

// Error occured at the 
private function wsError(event:FaultEvent):void
{
	// We only want faults coming from the web service, not from the operations
	if (event.currentTarget == event.target)
		event.stopImmediatePropagation();

	// First check if its a redirection error
	// We may need to load the crossdomina policy file from the new server		
	if (event.fault.faultString == "Security error accessing url")
	{
		// load the crossdomain security file
		loadCrossPolicyFile(event);
		// Call it again
		// The event needs to be captured at the Operation level, not the web service
		if (event.currentTarget is mx.rpc.soap.mxml.WebService)
			(event.currentTarget as mx.rpc.soap.mxml.WebService).initialize()
			Alert.show("Redirected");
			return;
		
	}	
		
	
	var reply_string:String = event.token.result.toLocaleString();
	var fault_string:String = "An error occured initialising the connection to the SAP system \n" + event.fault.message;
	if (reply_string.length > 0)	
	fault_string += "\n \n The following data was returned from the SAP system: \n";
	fault_string +=	reply_string;
	
	Alert.show(fault_string, "Web Service Error");
}

/*
	initDataCallBack (from Z_ECS_INITIALISE_CPR_SCREEN)
		Setup the application ready for use, having retrieved:
			VAT Rate
			User's access permissions
			blank strcuture for contributor details (Flex app doesn't need to create model0
			user's publications
			user's cost centres
			currencies
			GL accounts (mapped to publication and item category)
			the item categories
			default publication dates for the publications the user is in
		Call Z_ECS_GET_CPR
*/
private function initDataCallBack(result:Object):void{
	trace("Data back from sap " + getTimer());
	initXml = new XML(wsAllBusyCursor.Z_ECS_INITIALISE_CPR_SCREEN.lastResult);		 	
	 	
	itemCategories=buildDropdownList(initXml.CH_T_ITEMCAT,false);
	publications=buildDropdownList(initXml.CH_T_PUBLICATIONS,false);
	specialPaymentTypes = buildDropdownList(initXml.CH_T_PAYMENT_TYPES,true);
	contributorDetails = new XML(initXml.EX_CONTRIBUTOR_DET);	
	VATRate = Number(initXml.EX_VAT_RATE.toString());

	trace("Built first lot of dropdowns " + getTimer());
	//Default publication to first
	if (publications.length>=1) comboPubID.selectedIndex=0;
	setItemCategories(); 	
	trace("Item Categories set " + getTimer());
	defaultPublicationDate();
	currencies=buildDropdownList(initXml.CH_T_CURRENCIES,false);
	trace("Built second lot of dropdowns " + getTimer());
	
	// Finance Peterborough user
	if (initXml.EX_PBORO_USER.toString() == 'X')
		isFinanceUser = true;
	else
		isFinanceUser = false;
	
	
	// Allowed save types 	
	if (MODE==CREATE){
		if (initXml.EX_ALLOW_POST1=="X") allowPost1=true;
		if (initXml.EX_ALLOW_POST2=="X") allowPost2=true;
		if (initXml.EX_ALLOW_POST3=="X") allowPost3=true;
	 }
    setFormIsValid();
    applicationLoaded=true;
    
    //Call Z_ECS_GET_CPR
    trace("Calling loadData() " + getTimer());
    if (cprToLoadAfterInitialization)
    {
    	loadNewCPR(cprToLoadAfterInitialization.docNo,
    	           cprToLoadAfterInitialization.year, 
    	           cprToLoadAfterInitialization.company_code,
    	           cprToLoadAfterInitialization.access_mode)
    }
    else
    {
    	loadData();
    }
    
    trace("Called loadData() " + getTimer());
    
    // Recent values lists
    // Set up some of the last20 dropdowns
    var x:XML;
    var y:Object;
    for each (x in initXml.EX_T_AMOUNTS_LAST20.item)
    {
    	if (x.DATA)
    	{
    		//y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data = x.DATA.toString();
    		y.label = x.LABEL.toString();
    		last20Amounts.push(y);
    	}     	
    }
    for each (x in initXml.EX_T_STORIES_LAST20.item)
    {
    	if (x.DATA)
    	{
    		//y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data =  x.LABEL.toString();  // Use the LABEL field for both, since it contains the longer text
    		y.label = y.data;
    		last20Stories.push(y);
    	}     	
    }
    for each (x in initXml.EX_T_PAGENOS_LAST20.item)
    {
    	if (x.DATA)
    	{
    		//y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data = x.LABEL.toString(); // Use the LABEL field for both, since it contains the longer text
    		y.label = y.data;
    		last20PageNos.push(y);
    	}     	
    }
    for each (x in initXml.EX_T_PUBDATE_LAST20.item)
    {
    	if (x.DATA)
    	{
    		///y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data = x.DATA.toString();
    		y.label = x.LABEL.toString();
    		y.extra = y.label.substr(0,2) + y.label.substr(3,2) + y.label.substr(8,2); // The date, without the dots or slashes						
			
    		last20PubDates.push(y);
    	}     	
    }
    for each (x in initXml.EX_T_BEHALF_LAST20.item)
    {
    	if (x.DATA)
    	{
    		//y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data = x.DATA.toString();
    		y.label = x.LABEL.toString();
    		last20OnBehalfOf.push(y);
    	}     	
    }
    for each (x in initXml.EX_T_CONTRIB_REF_LAST20.item)
    {
    	if (x.DATA)
    	{
    		//y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data = x.DATA.toString();
    		y.label = x.LABEL.toString();
    		last20ContribRef.push(y);
    	}     	
    }  
    for each (x in initXml.EX_T_COSTCENTRE_LAST20.item)
    {
    	if (x.DATA)
    	{
    		//y = new Object();
    		y = new valueForDropdown(); // Faster to use sealed class
    		y.data = x.DATA.toString();   
    		y.label = initXml.CH_T_COST_CENTRES.item.(DATA == y.data).LABEL;     				
    		//y.label = x.LABEL.toString();
    		last20CostCentres.push(y);
    	}     	
    }            
    
    recentGLAccounts=getRecentGLAccountList();
    recentProjects=getRecentProjectList();
    
    // Does the user want to see the save message popup for every CPR?
    for each (var xsm:XML in initXml.EX_T_USR_PARAMS.item)
    {
    	if (xsm.CONFIG == SUPPRESS_SAVE_MESSAGE)
    	{
    		if (xsm.VALUE == "X")
    			saveMesageSuppressed.suppression = true;
    		else
    			saveMesageSuppressed.suppression = false;
    		
    	}
    }
     trace("End of hanlder for INITILIASIZE CPR SCREEN " + getTimer());             
   
   	// Load "Contributor Search" module in a bit
   	var t:Timer = new Timer(600,1);
   	t.addEventListener(TimerEvent.TIMER_COMPLETE, preloadContributorSearch);
	
}	

/*
	getCPRCallBack (from Z_ECS_GET_CPR)
		-Retrieved all data for a CPR (header, notes, workflow history, change history,
		edit flags for current user, communication history, recent gl accounts and projects
		for the current user.
		-If no CPR number was passed - retrieved 1 blank item (for new item create) - means
		the Flex application does not need to create data models - just uses those
		returned by the RFC
		-Sets dataChanged flag to unchanged
		
*/
public function getCPRCallBack(result:Object):void{
	//Clear out current contract options
	contractList=null;
	
	// Store if mode = create
	if (MODE == CREATE)
		createScreenInit = new XMLList(result);
	
	this.enabled=true;	//re-enable the application
   
   	//Set Edit flags 	
    if (result.EX_ALLOW_DELETE=="X") allowDelete=true;
    if (result.EX_ALLOW_EDIT=="X") allowEdit=true;
    if (result.EX_ALLOW_VALIDATE=="X") allowValidate=true;
    if (result.EX_ALLOW_PRINT_CP=="X") allowPrint=true;
    if (result.EX_ALLOW_URGENT == "X") {
    	allowUrgent = true;
    } else {
    	allowUrgent = false;
    }
    
    // Set payment notes
    paymentNotesLongTxt = result.EX_NOTES;
    if (rteNotes)
    	rteNotes.htmlText = paymentNotesLongTxt;
    
    // Set header data (story, contributor etc.) 	 
    CPRHeader = new XML(result.EX_HEADER);
    taContractReason.text = CPRHeader.CONTRACT_REASON;
    txtStory.text=CPRHeader.STORY;
    txtContributor.text=CPRHeader.LIFNR;
    txtContributorReference.text=CPRHeader.XBLNR;
    txtOnBehalfOf.text=CPRHeader.ONBEHALFOF;
    txtUrgentReason.text=CPRHeader.URGENTREASON;
    
    // Set up key fields
    cpr = CPRHeader.BELNR;
    company = CPRHeader.BUKRS;
    year = CPRHeader.GJAHR;
    
    //Get the contributor details (unless we've set contributor )
    if (CPRHeader.NEW_CONTRIB!="X" )
    {
    	if (holdData && holdData.contributorNumber && holdData.contributorNumber.length > 0)
    	{
    		// Don't get details as we already have them
    		trace("Don't get contributor details");
    	}
    	else
    	{
    		trace("Get contributor details");
    		getContributorDetails(false);
    	}
    	
    } 
    
    txtPageNumbers.text=CPRHeader.PAGENOS;
    
    //If not create populate publication date
    if (MODE!=CREATE) dtPubDate.text=formatDate(CPRHeader.PUBDATE);
        
    //Set dropdown index for special payment
    if (specialPaymentTypes!=null){       
		for (var j:int=0;j<specialPaymentTypes.length;j++){
	    	if (specialPaymentTypes[j].data==CPRHeader.CASH){
	        	comboSpecialPayment.selectedIndex=j;
	        	break;
	        } 
	    }
    }
    
    //Set dropdown index for publications
    if (publications!=null){       
		for (var k:int=0;k<publications.length;k++){
	    	if (publications[k].data==CPRHeader.PUBID){ 
	        	comboPubID.selectedIndex=k;
	        	break;
	        }
	    }
	}
	
	//Populate cost centres for recent value history (TextInputPlus)
    populateCostCentres();
        
    if (CPRHeader.URGENT=="X") chkUrgent.selected=true;
    else chkUrgent.selected=false;
        
    if (CPRHeader.HELD=="X") chkHeld.selected=true;
    else chkHeld.selected=false;
    
// New contributor - populate the contributor details (bound to input fields in popup)
    if (CPRHeader.NEW_CONTRIB=="X"){
    	chkNewContributor.selected=true;
    	allowNewContributor=true;
    	newContributor=true;
    	contributorName = CPRHeader.NEW_NAME1.toString();
		contributorDetails.NAME2 = CPRHeader.NEW_NAME2.toString();
		contributorDetails.NAME4 = CPRHeader.NEW_NAME4.toString();
		contributorDetails.STRAS = CPRHeader.NEW_STRAS.toString();
		contributorDetails.ORT01 = CPRHeader.NEW_ORT01.toString();
		contributorDetails.PSTLZ = CPRHeader.NEW_PSTLZ.toString();
		contributorDetails.TELF1 = CPRHeader.NEW_TELF1.toString();
		contributorDetails.EMAIL = CPRHeader.NEW_EMAIL.toString();
		contributorDetails.EMAIL1 = CPRHeader.NEW_EMAIL1.toString();
    }  
    else{
    	chkNewContributor.selected=false;
    	newContributor=false;
    } 
        	
    //Populate the CPRItems data structure bound to the data grid
  	itemsXML = new XML(result);	
    if (MODE==CREATE&& CPRItems!=null&&CPRItems.length>0) resetItems();
    else populateItems();
    	 
    //Story is a mandatory field
    validTxtStory.validate();

	//Make sure currency is set for new contributor   
    if (CPRHeader.NEW_CONTRIB=="X"||MODE==CREATE){
    	resetCurrency();
    	amountChanged(null);
    } 
    
    //Setup the toolbar
    setToolBar();
    
    //Get the GL accounts
    glAccounts=initXml.CH_T_GL_ACCOUNT.item.(PUBID==getPublicationId());
    //Visibilty of reason for DONTKNOW contract choice
    if (CPRHeader.CONTRACT==DONTKNOW) contractReasonVisible=true;
    
    //reset data changed flag
    setDataChanged(false,false);
    
    //Set the visible property and mandatory flag for page numbers	
    setPageNumberDisplay();
    
    if (MODE!=CREATE){ 
    	//Displaying - get the communication history
    	populateCommunicationHistory(itemsXML.EX_T_COMMUNICATION);
    	//Format posting date and entry date - used for payment due calculation
    	postingDate=getDateForSAP(formatDate(CPRHeader.POSTEDDATE.toString()));
    	entryDate=getDateForSAP(formatDate(CPRHeader.ERDAT.toString()));
 	}
 	
 	//Setup the display of the held checkbox
    setHeldCheckBoxDisplay();
    
    //If the user is "holding" data populate the fields and set the display accordingly
    if (MODE==CREATE){
    	if (holdData!=null){
    		populateScreenFromHeldData();
    		updateGrid();
    	}
    }

    //New CPR XML from mass upload ?
	if (Application.application.parameters.new_cpr!=""&&Application.application.parameters.new_cpr!=null)
		populateScreenFromUploadProgram(Application.application.parameters.new_cpr);
		 
	// Set the urgent checkbox and reason fields to editable if it is allowed
	urgentEditable = allowUrgent;
	// And make it look editable if allowed
	txtUrgentReason.styleName = textInputStyle;
	if (txtUrgentReason)
		txtUrgentReason.styleName = "enabled";
	
	// Set up the publication date field (i.e. make it mandatory or uneditable as required)
	// based on the 'held' checkbox. If 'held' is ticked, the publication date should be empty and
	// not editable, otherwise publication date should be mandatory
	application.callLater(heldChanged);
	
	// Set the label of the notes tab as appropriate
	application.callLater(setPaymentNotesLabel);
	
 	// Set focus to the Contributor text
 	// Only do this if there are no popups active,  since it stops us being able to 
 	// close the "CPR Created" box by hitting return. 		
 	if (!messageWindows || messageWindows.length == 0)
 	   txtContributorName.setFocus();
 	   
 	// Set the data changed flag to "false"
 	var array:Array = [];
 	array.push(false);
 	application.callLater(setDataChanged, array); 
}	

/*
	getCPRForCopyCallBack (Z_ECS_GET_CPR)
		Populate data when copying an existing CPR
*/
private function getCPRForCopyCallBack(result:Object):void{
	txtStory.text = result[0].EX_HEADER.STORY.toString();
	itemsXML = new XML(wsGetCPRDataForCopy.Z_ECS_GET_CPR.lastResult);	
    populateItems();	
    amountChanged(null);
    setFormIsValid();
}

/*
	saveCPRCallBack (Z_ECS_SAVE_CPR)
		process messages after save
		launch cash payment print if necessary
		exit application if not in create mode
*/

public function saveCPRCallBack(result:Object):void{
	var resultXML:XML = new XML(wsAllBusyCursor.Z_ECS_SAVE_CPR.lastResult);
	var message:String = "The following CPRs have been created:\n";
	var errorMessages:String = "The following errors occurred when saving the document: \n";
	var docsCreated:Boolean=false;		//CPRs were created
	var pubDateError:Boolean;			//Error with the publication date (not valid for the title)

			
	/** Update the recentEntries list of all the TextInputPlus components
	 (the ones where you can see a list of recent items by hitting backspace)
	*/
	if (result.EX_ERRORS.toString() == "0")
	{
		var obj:Object;
		for each (obj in TextInputPlus.instances)
		{
			obj.addCurrentToRecentList();
		}
		for each (obj in DateInputPlus.instances)
		{
			obj.addCurrentToRecentList();
		}
	}

	
	this.enabled=true;	//re-enable the application
	
	//Store the new CPR key if we are creating a new CPR
	if (MODE == CREATE || result.EX_NEW_CPR.toString().length > 0)
	{
		cpr=result.EX_NEW_CPR;
		year=result.EX_NEW_YEAR;
		company=result.EX_NEW_COMPANY;
	}

	
	if (MODE==CREATE){		
		//Build message string to display CPRs created (can be more than one)	
		//and update the CPR number in SAP if running in GUI
		if (result.EX_T_CPRS_CREATED.item.length()>0){
			for each(var item:XML in result.EX_T_CPRS_CREATED.item){
				if (item.DOCUMENT_NUMBER!=""){
					docsCreated=true;
					message+= item.DOCUMENT_NUMBER + "\n";
					if (inGUI)  // If running in SAP GUI, tell the GUI the new CPR number
					{
						trace("Tell SAP the new CPR number");
						trace(item.DOCUMENT_NUMBER);
						if (fromUpload)
						{
							// Update CPR number and Exit
							updateCPRNumberInSAP(item.DOCUMENT_NUMBER, true);
						}
						else
						{	// Update CPR number, no Exit
							updateCPRNumberInSAP(item.DOCUMENT_NUMBER, false);
						}						
						
						
					}
					
				} 
			}				
		}
	}
		
	if (result.EX_ERRORS=="0"){
		//Save was successful
		
		//Add in warning for payments over £10k
		if (result.EX_AMOUNT_WARNING!="")message+= result.EX_AMOUNT_WARNING;
		
		if (MODE!=CREATE||fromUpload){
		//Exit back to parent application if not in create mode
			this.enabled = false;
			var calls:Array = [];
			if (fromUpload){
				calls.push(message)
				
			}
			else 
			{
				if (saveLevel == 2 && this.btnValidate && btnValidate.visible)
					calls.push("The document has been validated");	
				else				
					calls.push("The document has been saved");				
			}
			application.callLater(exitApplication, calls);
		}  
		else {
		//Create mode
		//Show message for any new CPRs (suppressable)
			if (docsCreated) {
				showMessage(message, false, txtContributorName, "", saveMesageSuppressed);
			}
		//Print cash payment forms if it is a cash payment and not an unvalidated CPR
			if (comboSpecialPayment.selectedIndex > 0 && year != "" && result.EX_NEW_LEVEL != '1'	){
				printCashPaymentForms();				
			}
		//reset the application
			resetApplication();
		}
		 
	}
	else{
		//ERRORS
		//Build error messa	ge string
		for each(var err:XML in result.EX_T_ERRORS.item){
			if (err.MESSAGE!="" ) errorMessages+= err.MESSAGE + "\n";
			//Indicates there was an error with the publication date
			if (err.ERROR=="P") pubDateError=true;
		}
		
		if (pubDateError) showMessage(errorMessages,true,dtPubDate);
		else showMessage(errorMessages,true);
	}
		 
}

/*
	getContributorDetailsCallBack (Z_ECS_CPR_GET_CONTRIBUTOR_DET)
		Populate the contributor fields having successfully retrieved a contributor
*/
private function getContributorDetailsCallBack(result:Object, addToRecent:Boolean = true, suppressWarningMessages:Boolean = false):void{
	
	if (chkNewContributor.selected){
		//Not relevant when new contributor checkbox is selected
		contractList=null;
		return;
	}	

   	contributorDetails = new XML(result.CH_T_CONTRIBUTOR_DETAIL);
   	contributorType= result.EX_CONTRIBUTOR_TYPE;

	// Focus on story field?
	focusOnStoryWhenContributorRetreived();   	
 
	//Set name 2 labels based on whether or not the contributor is an agency
   	if (contributorDetails.CONTRIB_TYPE==AGENCY){
   		contributorName = contributorDetails.AGENCY ;
   		if (contributorName=="")
  			contributorName = contributorDetails.FIRST_NAME + " " + contributorDetails.LAST_NAME;

   		name2Label="Agency contact";
   		name2=contributorDetails.AGENCY_CONTACT;
   	}
   	else {
   		contributorName = contributorDetails.FIRST_NAME + " " + contributorDetails.LAST_NAME;
   		if (contributorName	== " " || contributorName == "")
   		{
   			name2Label="";
   			name2 = "";
   			if (contributorDetails.AGENT_NAME && contributorDetails.AGENT_NAME.toString().length > 0 ) 
   			{
   				contributorName = contributorDetails.AGENT_NAME;
   			}
   		}
   		else
   		{
   			name2Label="Agent";
   			name2=contributorDetails.AGENT_NAME;
   		}

   	}
   	//Alias field is visible for freelancers
   	if (contributorDetails.CONTRIB_TYPE!=FREELANCE) aliasVisible=false;
   	else aliasVisible = true;
   		      
   	txtContributorName.text=contributorName;
   	
   	// Save the result in the Recent Contributor Details array
	if (addToRecent)
	{
		result.CH_T_CONTRIBUTOR_DETAIL.NAME1_READONLY = contributorName;
		addToRecentContribs(result);
	}   	

   	//Is there an error with the contributor number ?
   	if (contributorDetails.LIFNR==""||contributorDetails.LIFNR=="0000000000") contributorNumberError=true;
   	else contributorNumberError=false;
  	
  	//Contributor and CPR currencys
  	if (contributorDetails.TELTX!=null && contributorDetails.TELTX!="")
  	 	contributorCurrency=contributorDetails.TELTX;
	else
		contributorCurrency = "";	
		
	if (contributorCurrency == "")
		cprCurrency = "GBP";
	else
		cprCurrency = contributorCurrency;
	
	
	txtContributorName.executeBindings();
	txtEmail.executeBindings();
	txtinfoAddressLine.executeBindings();
	txtInfoContributorType.executeBindings();
	txtInfoTelNumber.executeBindings();
	txtPostCode.executeBindings();
	txtName2.executeBindings();
	txtAlias.executeBindings();
	
   	validTxtContributor.validate(txtContributor);
   	//Set form is valid flag
   	setFormIsValid();
   	//recalculate the amounts as currency may have changed
   	amountChanged(null);
   	//Show payment due date
   	getPaymentDueDate();
   	//Get contracts list for contributor
   	getContracts();
   	//make sure items have the new currency for the contributor
   	resetCurrency();
   	//Display any warnings
   	if (!suppressWarningMessages)
   		contributorWarnings();   	
   	
	
}	

/** getContributorCPRsCallBack (Z_ECS_GET_CONTRIB_RCNT_CPRS)
 *      get 20 most recent payments (if any) for this contributor
 */
private function getContributorCPRsCallBack(result:Object):void
{
	//Recent CPRs for the contributor
   	contributorCPRs = new XML(result.CH_T_CPRS);  	
   	
   	if (contributorCPRs.item.length() == 0)
   	{
   		contributorCPRs = new XML("<CH_T_CPRS/>");
   		contributorCPRs.appendChild(new XML("<item/>"));
   		contributorCPRs.item.STORY = "No values found";
   		contributorCPRs.item.STATUS = "none";
   	}
}


/*
	searchContributorsNewCallBack (Z_ECS_CONTRIB_SEARCH)
		searching by name or postcode
		if just one contributor then populate screen
		otherwise pass results to advanced search screen
*/
import mx.modules.*;
import mx.events.ModuleEvent;
private function searchContributorsNewCallBack(result:Object):void{	
	try{
		if (result[0].EX_T_CON_DETAIL.item.length()==1)
		{  // Contributor Name Search
			txtContributor.text = result[0].EX_T_CON_DETAIL.item[0].LIFNR;
			getContributorDetails(false);			
		}
		else if (result[0].T_CONTRIBS.item.length()==1)
		{  // Contributor Postcode Search
			txtContributor.text = result[0].T_CONTRIBS.item[0].LIFNR;
			getContributorDetails(false);
			
		}
		else{
			var win:*;
			var postcodeSearch:String = result[0].T_CONTRIBS.toString();
			var nameSearch:String = result[0].EX_T_CON_DETAIL.toString();
			
			if (nameSearch.length > 0)
			{
				quickSearchResults = result[0].EX_T_CON_DETAIL;
			}
			else if (postcodeSearch.length > 0)
			{
				quickSearchResults = result[0].T_CONTRIBS;
			}
			else
			{
				quickSearchResults = new XMLList();
			}
				
			
			
			win = launchContributorSearchSWF(true);
			
			if (win.child)
				win.child.justShowResults=true;
			else			
				win.addEventListener(ModuleEvent.READY, function():void {win.child.justShowResults=true;} )
		}
	}
	catch(err:Error){
	trace(err.message);
	}
	
	// If we have mor than one result, user can bring the results straight back
	lastRearchRepeatable = false;
	lastSearchResults = null;
	try {
		if (result[0].EX_T_CON_DETAIL.item.length() > 1 )
			lastRearchRepeatable = true;
			lastSearchResults = result;
	}
	catch (err:Error)
	{}
		
	
}

private function getDueDateCallback(result:Object):void{       		 
   	var paymentDueDate:String;
  	//actually we are no longer calculating payment die date in this way
   	paymentDueDate = result.EX_PAYMENT_DUE;
   	paymentDueDate = formatDate(paymentDueDate);
   	txtPaymentDue.text = paymentDueDate;
   		
 }
 
/*
	getContractsCallback (Z_ECS_CPR_GET_CONTRACTS)
		Populate contract dropdown
		Default in the best fit contract
*/
 private function getContractsCallback(result:Object):void{     	
 	var i:int;
	var selectedContract:String;			//Change to this contract	
	var currentContractKeeping:String;		// Current Contract that we will keep if we can
	var currenctContract2:String;           // Current Contract
	var keepExisting:Boolean=false;			// Stick with the user's choice, or what was there before we opened the CPR
	
	
	// Store whatever the current contract is
	if (comboContract.selectedIndex>-1 && comboContract.selectedItem!=null)
		currenctContract2 = comboContract.selectedItem.data;
	
	//Current contract to be kept - store if the user is only changing the publication date
	if (comboContract.selectedIndex>-1 && comboContract.selectedItem!=null && pubDateJustChanged) {
		currentContractKeeping=comboContract.selectedItem.data;
		pubDateJustChanged=false;
	} 	
	
 	
 	// How many "best fit" contracts do we have?
 	var bestFitContracts:XMLList = new XMLList(result.EX_T_BEST_FIT.item);
 	if (bestFitContracts.length() == 1)
 	{
 		bestFitContract = bestFitContracts[0];
 	}
 	else if (bestFitContracts.length() == 0)
 	{
 		bestFitContract = "";
 	}
 	else // Several "Best Fits", check if one of them is already selected, and if it is, save it
 	{
 		bestFitContract = "";
 		for each (var best_ctrct:XML in bestFitContracts)
 		{
 			var s:String = best_ctrct.toString()
 			if (comboContract.selectedItem && s == comboContract.selectedItem.data)
 			{
 				currentContractKeeping = comboContract.selectedItem.data;
 			}
 		}
 		 		
 	}
 	
 	// Get list for dropdown
 	contractList = buildDropdownList(result.EX_T_CONTRACTS,false);
 	
  	
  	// Contract already saved (we're in change or display mode)?
  	// Make sure hasn't changed since we opened it
  	var contractInHeader:String = CPRHeader.CONTRACT.toString();
  	if (contractInHeader && contractInHeader.length > 1 && MODE!=CREATE &&  (currenctContract2 == null || currenctContract2 == contractInHeader)   )
  	{
  		selectedContract = CPRHeader.CONTRACT;
  		keepExisting=true;	
  	} 
  	
  	else{
  		//Allow them to keep choice
  		for (i=0;i<contractList.length;i++){
  			if (contractList[i].data == currentContractKeeping){
  				keepExisting=true;
  				break;
  			}
  		}
  		if (keepExisting)
  		{
  			selectedContract = currentContractKeeping;  			
  		} 
  		else if (bestFitContract != "") 
  		{
  			selectedContract = bestFitContract;
  		}
  		else
  		{
  			selectedContract = null;
  		}
  	} 
  	
  	//Set combobox
  	if (selectedContract)
  	{  		
  		for (i=0;i<contractList.length;i++){
  			if (contractList[i].data == selectedContract){ 
  				comboContract.selectedIndex=i;
  				comboContract.prompt = null;
  				break;
  			}
  		}
  	}
  	else
  	{
  		comboContract.prompt = "Please choose a contract...";
  		comboContract.selectedIndex=-1;
  	}
  	
  	//Contract changed handler - display justification box etc.
  	if (!keepExisting)
  		contractChanged();
  	
}

/* 
	doublePaymentCheckCallback (Z_ECS_CHECK_DOUBLE_PAYMENT) 
		After checking for double payment  - show possible duplicates or continue save
*/
public function doublePaymentCheckCallback(result:Object):void{
  	var win:DoublePaymentWarning;
  	trace("Double payment check back.");
  	
	if (result.RE_T_CPRS.item.length()>0){
		this.enabled=true;
		doublePayments=result.RE_T_CPRS;
		application.focusManager.deactivate();
		win = DoublePaymentWarning(PopUpManager.createPopUp(this,DoublePaymentWarning,true));
	}
	else{
		saveCPR(saveLevel);
	}	
}

/** getLast20FromLocal
 *  Gets the last 20 from the users hard drive
 */
private function getLast20FromLocal():void
{
	try{
		var so:SharedObject = SharedObject.getLocal(SO_LAST20);
		if (so.data.CONTRIBS)
		{
			var xmlList:XMLList = new XMLList(so.data.CONTRIBS);
			getLast20CallBack(xmlList);	
		}
	} catch (e:Object)
	{
		
	}
		
}



/** 
	getLast20CallBack (Z_ECS_GETLAST20)
		populate the value help lists for contribuor number and name

*/
private function getLast20CallBack(result:Object):void{
	var item:valueForDropdown;
	last20ForDropDown=new Array();
	last20NamesDropDown=new Array();	
	for each (var contributor:XML in result){
		
		item = new valueForDropdown();
		item.data = removeleadingZeros(contributor.LIFNR);
		item.label = item.data + " " + contributor.NAME1;
		last20ForDropDown.push(item);
	//	last20ForDropDown.sortOn("data"); - GYORK - don't sort, use the order provided
		
		item = new valueForDropdown();
		item.data = contributor.NAME1;
		item.label = contributor.NAME1;
		item.extra = contributor.LIFNR;
		last20NamesDropDown.push(item);
	//	last20NamesDropDown.sortOn("data");	- GYORK - don't sort, use the order provided	
	}
	
	// Save it as a shared object
	try{
		var shareObjectString:String = new XMLList(result).toXMLString();
		var so:SharedObject = SharedObject.getLocal(SO_LAST20);
    	so.data.CONTRIBS = shareObjectString;
    	so.flush();
	} catch (e:Error) 
	{
		
	}

	
}

/*
	getContributorEmailCallBack (Z_ECS_CPR_GET_EMAIL_TEXT)
		Set html property for html control to display the contributor email
*/
private function getContributorEmailCallBack(result:Object):void{
//**	html1.htmlText = result.EX_HTML;
}

/*
	currencyConvertCallBack (Z_ECS_CONVERT_CURRENCY) 
		Currency convert called for each line item
		add result to total
*/        
private function currencyConvertCallBack(result:Object):void{
	var index:int = int(result.index);
	var total:Number;
	var format:NumberFormatter = new NumberFormatter();
	format.useThousandsSeparator=true;
	
	total=Number(totalAmount);
	total+= Number(result[0].EX_AMOUNT.toString());
	totalAmount=format.format(total);
	addVAT();
	currencyConversionInProgress = false;
}

/*
	deleteCPRCallBack (Z_ECS_DELETE_CPR)
*/
private function deleteCPRCallBack(result:Object):void{
 	if (result.EX_ERROR=="0"){
 		exitApplication("The payment has been deleted");
 	}
 	else{
 		Alert.show("An error occurred deleting the payment",MESSAGE_TITLE);
 		this.enabled=true;
 	}
}
/*
	saveAsUrgentCallBack (Z_ECS_SAVE_AS_URGENT)
		Saves an ME Approved CPR as urgent and updates the payment due date to today
*/
private function saveAsUrgentCallBack(result:Object):void {
	
	var errorMessages:String = "The following errors occurred when saving the document: \n";
	
	this.enabled=true;	//re-enable the application
	if (result.EX_ERRORS=="0"){
		//Save was successful
		showMessage("CPR updated successfully.", true);
	} else {
		//ERRORS
		//Build error message string
		for each(var err:XML in result.EX_T_ERRORS.item){
			if (err.MESSAGE!="" ) errorMessages+= err.MESSAGE + "\n";
		}
		
		showMessage(errorMessages, true);		
	}
	
}

/** When contributor retreived, if focus is on contributor name or
 *  contributor number, and no popups active, move focus to Story text
 */
private function focusOnStoryWhenContributorRetreived():void
{
  	/////////////////////////////////////////////
	// Focus on the story field?
	// Only if we are in Contributor Number or Contributor Name fields, or if no field has focus.
	// Also, only if no popups are open
	if (this.focusManager == null) return; // So we don't error if we're a popup or invisislbe
	
	var currentFocus:UIComponent = this.focusManager.getFocus() as UIComponent;
	var currentFocusId:String = "";
	if (currentFocus && currentFocus.hasOwnProperty("id"))
	{
		currentFocusId = currentFocus.id;
		if (currentFocusId && currentFocusId.length == 0 && currentFocus.parent && currentFocus.parent.hasOwnProperty("id"))
			currentFocusId = (currentFocus.parent as Object).id;
	}			
					
	if (currentFocusId == "txtContributorName" || currentFocusId == "txtContributor" || !currentFocus)
	{
		if (messageWindows.length == 0) // Check no popups are open
		{
			txtStory.setFocus();
			txtStory.callLater(txtStory.setFocus);
			trace("txtStory.setFocus() in getContributorDetailsCallBack, focus moved from ");
		}
		else
			trace("Not doing txtStory.setFocus() in getContributorDetailsCallBack as popup(s) exist");
	}
	else
	{
		trace("Not doing txtStory.setFocus() in getContributorDetailsCallBack as have tabbed out of field");
	}
			
	
}