/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	Navigation.as
		Handle calls outside the Flex app - launch iViews, exit application

	exitApplication
		Exit the application (printing cash payment forms if validating or creating valid cash payment
	callIviewToPrintCashPaymentForms
		Launch portal iView to print the cash payment forms
		The cash payment forms are a SAPScript running within ABAP transaction
	displayFullContributorDetails
		Launch the contributor details iView (Flex app) if in the portal
		If running in SAPGUI just switch to the contributor details tab	
		If new contributor just launch Flex popup	
	displayFullContractDetails
		Launch SAP GUI transaction to display the contract.
		If portal launch via iView
		If GUI then parent page will send SAPGUI event handled by Z_ECS_EMBED_BSP_IN_GUI which calls Z_ECS_CPR_LAUNCH_CONTRACT_GUI
	printCashPaymentForms
		Print the cash payment forms (via SAP transaction in GUI [zcl_ecs_cpr=>print_cash_payment_form()] 
		or iView wrapper in portal)
	updateCPRNumberInSAP
		If running in a SAP GUI Window, send the newly created CPR Number back to SAP
	launchNewContributorScreen (cutdown popup)
		
*/


/*
	exitApplication
		Exit the application (printing cash payment forms if validating or creating valid cash payment
*/
import mx.controls.Alert;

private function exitApplication(message:String):void{
	
	if (inGUI=="X"){
		//Running in SAP GUI - reset change flags so no prompt for save data, then exit
		ExternalInterface.call("updateSAPguiImmediately", "", "X");
		if (saveLevel==2 && comboSpecialPayment.selectedIndex>0){
		//Validating a cash payment - print the forms (browser will give save message)
			printCashPaymentForms(message);	
		}
		else{
		//Back out
			ExternalInterface.call("closeWindow",message);
		}
	}
	else if (containing_popup_window) // Running in a flex popup in an SWF loader
	{
		(containing_popup_window as Object).doClose();
		Alert.show(message);
	}	
	else{
		//Portal iView
		if (saveLevel==2 && comboSpecialPayment.selectedIndex>0){
		//Creating a validated cash payment - print the forms
			printCashPaymentForms();
		}
		ExternalInterface.call("closePortalWindow",message);
	} 
}

/*
	callIviewToPrintCashPaymentForms
		Launch portal iView to print the cash payment forms
		The cash payment forms are a SAPScript running within ABAP transaction
*/
private function callIviewToPrintCashPaymentForms(cpr:String):void{
	var URL:String = "pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/com.ni.cas.cis.ecs.fd_ecssapguiiviews/com.ni.cis.ecs.PrintCashPayment?OKCODE=ENTER&ZECS-BELNR="
						 + cpr;    
 	var toolbarOptions:String="toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50"; 
 	ExternalInterface.call("portalNavigate",URL,"1",toolbarOptions);
}

/*
	displayFullContributorDetails
		Launch the contributor details iView (Flex app) if in the portal
		If running in SAPGUI just switch to the contributor details tab	
		If new contributor just launch Flex popup
*/
 private function displayFullContributorDetails():void{		
 	var URL:String;    
 	var toolbarOptions:String="toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50"; 
 	if (newContributor||chkNewContributor.selected){
 		//New contributor popup window
 		var win:NewContributorDetails = NewContributorDetails(PopUpManager.createPopUp(this, NewContributorDetails, true));
 	}
 	else if(txtContributor.text!="" && !contributorNumberError){
 		
 		if (inGUI){
 			//SAP GUI - get parent to switch the HTMLB tab
 			ExternalInterface.call("navigateToContributortab");
 		}
 		else{
 			//Launch portal iView
 			URL="pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/com.ni.cis.ecs.ecsbspiviews/com.ni.cas.cis.ecs.iv_bsp_contributeradmin?contributor_num=" + txtContributor.text;
 			ExternalInterface.call("portalNavigate",URL,"1",toolbarOptions);
 		}
 	}
 }

/*
	displayFullContractDetails
		Launch SAP GUI transaction to display the contract.
		If portal launch via iView
		If GUI then parent page will send SAPGUI event handled by Z_ECS_EMBED_BSP_IN_GUI which calls Z_ECS_CPR_LAUNCH_CONTRACT_GUI

*/
private function displayFullContractDetails():void{
	if (comboContract.selectedItem!=null){
		if (inGUI){
			ExternalInterface.call("guiDisplayContract",comboPubID.selectedItem.data,comboContract.selectedItem.data);
		}				     
		else {
			var iviewURL:String="pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/com.ni.cas.cis.ecs.fd_ecssapguiiviews/com.cis.ecs.ContractDisplay";
			iviewURL+= "?OKCODE=DISP&ZIPCONTRACT_ENTRY-PUBID=" + comboPubID.selectedItem.data;
			iviewURL+= "&ZIPCONTRACT_ENTRY-CONTRACT=" + comboContract.selectedItem.data;
			ExternalInterface.call("portalNavigate",iviewURL,"1","toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50","contract");
		}
	}
}

/*
	createContributor
		Validating a payment: if "new contrributor", switch to contributor tab to create the new 
		contributor. Contributor number will be passed back via updateContributor when the new 
		contributor has been saved.
*/
private function createContributor():void{
	var URL:String;    
 	var toolbarOptions:String="toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50"; 
 	
 	if (!inGUI){	 
 		URL="pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/com.ni.cis.ecs.ecsbspiviews/com.ni.cas.cis.ecs.iv_bsp_contributeradmin?cpr=" + cpr;
 		ExternalInterface.call("portalNavigate",URL,"1",toolbarOptions);
 	}
}

/*
	printCashPaymentForms
		Print the cash payment forms (via SAP transaction in GUI [zcl_ecs_cpr=>print_cash_payment_form()] or iView wrapper in portal)	
*/
private function printCashPaymentForms(message:String=""):void{
	if (inGUI)
	{
		ExternalInterface.call("printCashPayment",cpr,year,company,message);
		//Alert.show("Create cash payment in gui");
		
	}	 
	else
	{
		callIviewToPrintCashPaymentForms(cpr);
	}
	 
}

private function updateCPRNumberInSAP(CPR:String, do_exit:Boolean = false):void
{
	var exit_string:String = "";
	if (do_exit)
	{
		exit_string = "X";
	} 	
	ExternalInterface.call("tell_SAP_CPR_Created", CPR, exit_string);
}

     
public function launchNewContributorScreen():void{
	var win:NewContributorDetails = NewContributorDetails(PopUpManager.createPopUp(this, NewContributorDetails, true));
 	
}