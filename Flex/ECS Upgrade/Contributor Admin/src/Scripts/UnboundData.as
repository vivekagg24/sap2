// ActionScript file
import mx.controls.Alert;


/*	Functions - Summary
    ===================
    
	private function SetUnboundData
	private function SetCheckboxes
	private function UpdatePostBlock
  	private function NoEmailFlagChange
	private function UpdateDelFlag
	private function UpdateNoContactFlag
	private function SetSelfBillDate - rearranges an SAP date format into a "flex" format 
	private function SetVATflag
*/

	private function SetUnboundData():void{

		SetCheckboxes();
		SetSelfBillDate();		
		SetVATflag();
		
	}
	
	private function SwitchOnCheckboxConfirmDetails():void{
		
		if (editRights == cFull)
		{
	    	cbConfirmDetails.enabled   = true;   //  this is limiting access to this checkbox to ACCOUNTS PAY only
		}else{
			cbConfirmDetails.enabled   = false; 
		}
	}

// ************ SET FLAGS WHEN RECEIVING DATA FROM SERVER ************ 
// ************ ************ ************ ************ ************ **
	private function SetCheckboxes():void{

		// cofirm details
		if (xmlConDetails.CH_CONTRIB_DETAIL.CONFIRMDETAILS == "X"){
			cbConfirmDetails.selected = true;
		}else{
			cbConfirmDetails.selected = false;
		}

		// Posting block
		if (xmlConDetails.CH_CONTRIB_DETAIL.SPERR == "X"){
			cbPostBlock.selected = true;
		}else{
			cbPostBlock.selected = false;
		}
  
		// Deletion flag
		if (xmlConDetails.CH_CONTRIB_DETAIL.LOEVM == "X"){
			cbDelFlag.selected = true				
		}else{
			cbDelFlag.selected = false				
		}			
		

		// No email checkbox  - NB that we also set / reset validation for this 
		// field here
		if (xmlConDetails.CH_CONTRIB_DETAIL.NOEMAIL == "X"){

			cbNoEmail.selected = true				
			
			EmailCheck.required = false;
			EmailCheck.validate();			
			
		}else{

			cbNoEmail.selected = false			
			
			EmailCheck.required = true;			
			EmailCheck.validate();
		}			
	// Government checkbox  -  - Sreddy		// field here		if (xmlConDetails.CH_CONTRIB_DETAIL.BRSCH == "ZG02"){			comboVendorType.selected = true							}	if (xmlConDetails.CH_CONTRIB_DETAIL.BRSCH == "ZG01"){					
			comboVendorType.selected = false				       		}// Satrt sreddy 19.11.2014 Govt flag alert IC#279394			if (xmlConDetails.CH_CONTRIB_DETAIL.BRSCH == ""){								comboVendorType.selected = false							nogovtflag = "X";		// End sreddy IC#279394       		}		 //  nogovtflag =  xmlConDetails.CH_CONTRIB_DETAIL.BRSCH.toString();     //sreddy IC279394					  // Private Investigator flag -  sreddy 	IC~180440	  		if (xmlConDetails.CH_CONTRIB_DETAIL.ZZPI == "X"){			privateInves.selected = true							} else	{  privateInves.selected = false	    		}    // Search Agent flag -  sreddy 	IC~	223665      		if (xmlConDetails.CH_CONTRIB_DETAIL.ZZSA == "X"){			searchAgent.selected = true							} else	{  searchAgent.selected = false	    		}		if (xmlConDetails.CH_CONTRIB_DETAIL.DONOTCONTACT == "X"){

			cbNoContact.selected = true				
			
		}else{

			cbNoContact.selected = false				
		}			
		
	}

// ************ UPDATE FLAGS ON USER INTERACTION ***** ************ **
// ************ ************ ************ ************ ************ **


 	private function UpdateConfirmDetails():void{
  
		if (cbConfirmDetails.selected == true){
			confirmDetails = "X"			
		}else{
			confirmDetails = ""						
		}
  	}
 	
	private function UpdatePostBlock():void{
  
		if (cbPostBlock.selected == true){
			postBlock = "X"			
		}else{
			postBlock = ""						
		}
  	}

	private function NoEmailFlagChange():void{

		if (cbNoEmail.selected == true){
			
			NoEmailFlag = "X"			
			EmailCheck.required = false;
								
		}else{

			NoEmailFlag = ""						
			EmailCheck.required = true;			
		}		

		EmailCheck.validate();		
	}

	private function UpdateDelFlag():void{

		if (cbDelFlag.selected == true){
			
			deleteFlag = "X"			
					
		}else{
			deleteFlag = ""	;			if (comboPayMeth.value == "C")			{
				Alert.show("Please consider choosing another payment type other than Cheque") ;			}					
		}
	}

	private function UpdateNoContactFlag():void{

		if (cbNoContact.selected == true){
			
			NoContactFlag = "X"			
					
		}else{
			NoContactFlag = ""						
		}		
		
	}

// ************ SET DATE WHEN RECEIVING DATA FROM SERVER ************* 
// ************ ************ ************ ************ ************ **
	private function SetSelfBillDate():void{
		
		var SelfBillDate:String = xmlConDetails.CH_CONTRIB_DETAIL.GBDAT;
		
		var sYear:String  = SelfBillDate.substr(0,4);
		var sMonth:String = SelfBillDate.substr(5,2);
		var sDay:String	  = SelfBillDate.substr(8,2);

		dfSelfBilling.SAPDateField = sYear + sMonth + sDay;		

		if (dfSelfBilling.SAPDateField == '00000000'){

	  		dfSelfBilling.selectedDate = null;

		}else{

			var iMonth:int = int(sMonth) - 1;		
			
			sMonth = String(iMonth);
		
			dfSelfBilling.selectedDate = new Date(sYear,sMonth,sDay);
		}

	}
	
	
	private function SetVATflag():void{

		if(xmlConDetails.CH_CONTRIB_DETAIL.STCEG != ""){
//          No VAT number: flag false to swtich off selfbill date later on			
			bVatNoInvalid = false;                  // b is for boolean
			
		}else{
//          VAT number: flag true to swtich on selfbill date later on			
			bVatNoInvalid = true;					
		}
	}
