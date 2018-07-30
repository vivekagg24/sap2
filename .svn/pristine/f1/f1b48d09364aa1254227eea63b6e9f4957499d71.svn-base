// ActionScript file

	private function Approve():void{

		if(ValidateDataOnSubmit() && bEnableButtons){

			CreateClaimItemsForServerTrip();
		
			if (ClaimItems.length > 0){
	
				ServerRequest(cApprove,'',0,null);
	
			}else{
				
				FormatError(btnApprove,"Please select an item to approve");
	
				return;
				
			}
		}
	}

	private function Reject():void{

		if(ValidateDataOnSubmit() && bEnableButtons){	

			CreateClaimItemsForServerTrip();			
			
			if (ClaimItems.length > 0){

				RejectionTextPopup(0);
				
			}else{
				
				FormatError(btnReject,"Please select an item to reject");
	
			}
		}
	}
	
	private function Refresh():void{
	
		if(bEnableButtons){

			getData();
		}
	}

	private function CallClaimEdit(event:ListEvent):void{
		
		if(myRow == 0) return;
		
		var ClickedRow:int = myRow - 1;
		
		if(ValidateDataOnSubmit()){
		
			if (dp[ClickedRow].ClaimLine && dp[ClickedRow].IS_LOCKED != 'X'){
				
				var Pernr:String = dp[ClickedRow].PERSONNEL_NO;
				var Kostl:String = dp[ClickedRow].ZZKOSTL;
				var Date:String  = DateToSAPFormat(dp[ClickedRow].BEGDA);
				var Beguz:String = TimeToSAPFormat(dp[ClickedRow].BEGUZ);
	
				ClaimEdit = CasualClaim(PopUpManager.createPopUp(this, CasualClaim ,true));
				
				ClaimEdit.ClaimLine = dp[ClickedRow];
				
				ClaimEdit.aryCostcenters = costCentres;
	
				PopUpManager.centerPopUp(ClaimEdit);
			}
		}
	}


	private function ClaimAudit():void{
		
		if(myRow == 0) return;
				
		var ClickedRow:int = myRow - 1;
		
		if (!dp[ClickedRow].ClaimLine){

			Alert.show("Please select a claim to view its audit history",cDefaultTitle);
					
		}else{
		
			var Pernr:String = dp[ClickedRow].PERSONNEL_NO;
			var Kostl:String = dp[ClickedRow].ZZKOSTL;
			var Date:String  = DateToSAPFormat(dp[ClickedRow].BEGDA);
			var Beguz:String = TimeToSAPFormat(dp[ClickedRow].BEGUZ);
		
			// Call to VC app
			if(ExternalInterface.available){
				
				var VCparams:String =  '&_paramsXmlStr_=<Params><Row DATE="' + Date + '" PERNR="' + Pernr + '" BEGUZ="' + Beguz + '" KOSTL="' + Kostl + '" ></Params>';
				
				var URL:String = "pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/CMSVC/com.NI.VC.CMS.4IF.Iv_casualauditreport?mode=3" + VCparams
				
				ExternalInterface.call("portalNavigate",URL,"1","toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50","ClaimAudit");			
			}
		}	
	}
	
	private function ViewClaims():void{

		if(myRow == 0) return;
		
		var ClickedRow:int = myRow - 1;
		var Kostl:String = dp[ClickedRow].ZZKOSTL;	
				
		var Begda:String;
		var Endda:String;
		var Pernr:String;
		
		if(dp[ClickedRow].costCentreLine){
			
			Begda = dfClaimFrom.SAPDateField;
			Endda = dfClaimTo.SAPDateField;
			
		}else if(dp[ClickedRow].WeekStartLine){
			
			Begda = DateToSAPFormat(dp[ClickedRow].WKSTART);
			Endda = GetWeekEndDate(dp[ClickedRow].WKSTART);
			
		}else if(dp[ClickedRow].CasualLine){
			
			Begda = DateToSAPFormat(dp[ClickedRow].WKSTART);
			Endda = GetWeekEndDate(dp[ClickedRow].WKSTART);
			Pernr = dp[ClickedRow].PERSONNEL_NO;	
			Kostl = "";
						
		}else if(dp[ClickedRow].ClaimLine){
			
			Begda = dfClaimTo.SAPDateField;
			Endda = dfClaimTo.SAPDateField;			
			Pernr = dp[ClickedRow].PERSONNEL_NO;			
		}

		// Call to VC app
		if(ExternalInterface.available){

			var VCparams:String =  '&_paramsXmlStr_=<Params><Row BEGDA="' + Begda + '" PERNR="' + Pernr + '" ENDDA="' + Endda + '" KOSTL="' + Kostl + '" ></Params>';
			
			var URL:String = "pcd:portal_content/com.ni.cis.NIDevelopment/com.ni.cis.ecs.ECS/CMSVC/com.NI.VC.CMS.4GA.Iv_casualsanalysisreport?mode=3" + VCparams;
				
			ExternalInterface.call("portalNavigate",URL,"1","toolbar=no,width=1000,height=800,resizable=yes,left=50,top=50","ViewClaims");			
		}			
	
	}
		
	private function ExtendCasual():void{
		
		XtendCasPopup = ExtCasual(PopUpManager.createPopUp(this, ExtCasual ,true));
		
		XtendCasPopup.title = "Extend casual claim period";
		
		XtendCasPopup.showCloseButton = true;	

		PopUpManager.centerPopUp(XtendCasPopup);

	}

	private function Collapse():void{

		if(myRow == 0) return;
	
		var ClickedRow:Number = myRow-1

        var item:ApprovalTree = dp[ClickedRow];

		if ( ( item.costCentreLine || item.WeekStartLine ||  item.CasualLine  ) &&  item.isOpen   )	
		{

			DataProviderManager.closeItem(item,ClickedRow);
	
		}
    }	

    	
	private function ExpandSelected():void{
		
		if(myRow == 0) return;

		var ClickedRow:Number = myRow -1;
		var item:ApprovalTree = dp[ClickedRow];
		
		DataProviderManager.Expand(item,ClickedRow,false,false);
	}
