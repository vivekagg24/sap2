/*	
Application: ECS Payment approval (desk head and managing editor)
Author: 	 DJ McNamara 
Date:		 March 2007
	SetUpAndCAS.as: functions relating to the initial setup of the application and it's interaction
	with the Common Approval System
	
		startApp
			Run when the application starts (creation complete).
			Initialise the application, get any paramaeters passed into the iView,
			load the selection screen and register the functions that can be called from the Common Approval System
		setMEandDHFlags
			Set flags indicating whether or not to get data for desk head and managing editor level ,
			based on the user's selections and permissions
		loadScreen
			Get the selection screen
		getParameters
			Get the parameters passed in from CAS - portal paramater ccs passed in on query string
			by the approval BSP wrapper
		registerPortalFunctions
			CAS will call the following functions:
			Approve, Reject Refresh
		runCCEffects
			Run a glow effect on the cost centre selection choice labels to highlight
		Refresh
			CAS call to Refresh
		Reject
			No reject in ECS but still need to react to event from CAS

*/

/*		
		Refresh
			CAS call to Refresh
*/

private function Refresh():void {
	// Refresh the selected documents.
	if (this.enabled == false)
	{
		 return;
	} 
	
	getData();
}
	
/*
	Reject
		No reject in ECS but still need to react to event from CAS

*/
private function Reject():void {
	// No reject in ECS but still need to react to event.

	if (ExternalInterface.available) {
		var retVal:Object = ExternalInterface.call("alert", "'Reject' functionality is not available for CPRs");
	}
}

/*
startApp
	Run when the application starts (creation complete).
	Initialise the application, get any paramaeters passed into the iView,
	load the selection screen and register the functions that can be called from the Common Approval System
*/
private function startApp():void {
	fscommand("showmenu","false");				//Hide the flash player menu
	currFormat.currencySymbol = "";
	currFormat.precision = 2;
	dateFormat.formatString = "DD.MM.YYYY"
	getParameters();							//Get the cost centre selection passed in from CAS
	loadScreen();								//Load the selection screen 
	registerPortalFunctions();					//Register functions that can be called from the Portal
				
}			

/*
setMEandDHFlags
	Set flags indicating whether or not to get data for desk head and managing editor level ,
	based on the user's selections and permissions
*/
private function setMEandDHFlags():void{
	deskHeadSel = "";
	manEdSel = "";
	if (!managingEditor){
		manEdSel="";
		deskHeadSel="X";
	}  
	else{
		if (rbAll.selected) {
			deskHeadSel = "X";
			manEdSel = "X";	
		} else {
			if (rbDeskHead.selected) { 
				deskHeadSel=  "X"; 
			}
			if (rbNotDeskHead.selected) {
				manEdSel = "X";
			}
		}	
	}
}

/*
loadScreen
	Get the selection screen
*/
private function loadScreen():void {
	
	setMEandDHFlags();
	dp=new ArrayCollection;
	ws1.Z_ECS_GET_APPROVAL_SEL_SCREEN.send();
}

/*
getParameters
	Get the parameters passed in from CAS - portal paramater ccs passed in on query string
	by the approval BSP wrapper
*/
private function getParameters():void {
	
	if (Application.application.parameters.ccs) {
		passedCCs = Application.application.parameters.ccs;
	
		if (passedCCs == "" || passedCCs == null) {
			passedCCs = "";
		}			
	}
	
	//Set flag inidicating running standalone or in CAS
	if (Application.application.parameters.cas) {
		runningStandalone = false;
	}
	else{ // Do a double-check to make sure we aren't in portal
		runningStandalone = true;
		if (ExternalInterface.available) {
			var inFrame:String;
			inFrame =  ExternalInterface.call("checkInFrame");
			if (inFrame == 'X')
			{
				runningStandalone = false;
			}
		}
	} 
	setGridAreaHeight();
}

private function setGridAreaHeight():void{
	try{
		itemAreaHeight = application.height - tabSelectionCriteria.height - 20;
	}
	catch (err:Error){}
}
/*
	registerPortalFunctions
		CAS will call the following functions:
		Approve, Reject Refresh
*/	
private function registerPortalFunctions():void {
	if (ExternalInterface.available) {
		ExternalInterface.addCallback("Approve", confirmApprove);
		ExternalInterface.addCallback("Reject", Reject);
		ExternalInterface.addCallback("Refresh", Refresh);
		Security.allowDomain("*");
	}				
}

/*
	runCCEffects
		Run a glow effect on the cost centre selection choice labels to highlight
*/			
private function runCCEffects():void{
	effGlow.target = labelCCRange;
	effGlow.play();
//	effGlow.target = labelFomList;
	effGlow.play();
}
