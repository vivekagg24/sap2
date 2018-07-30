// ActionScript file

	private function getClaimsCallBack(items:XML):void{		 	 	 		 	 	 
	 	 	 
    	var currItem:XML;
    	var itemObj:ClaimItem;
    	var i:int = 0;
    	var itemsList:XMLList = items.CH_T_ITEMS; 
    	var aWageTypes:Array;

	 	ClaimItems = new Array();

    	for each(currItem  in itemsList.item){
    		
    		itemObj = new ClaimItem();

			var sWageTypes:String    =  currItem.VALID_WAGE_TYPES.toString();
			
			var xmlWageTypes:XML     = new XML(sWageTypes);
			
	   		aWageTypes = PopulateWageTypes(xmlWageTypes);    		
    		
     		itemObj.PERNR 			 = currItem.PERNR.toString();
     		itemObj.SUBTY 			 = currItem.SUBTY.toString();
     		itemObj.OBJPS 			 = currItem.OBJPS.toString();
     		itemObj.SPRPS 			 = currItem.SPRPS.toString();
     		itemObj.ENDDA 			 = currItem.ENDDA.toString();
      		itemObj.BEGDA  			 = currItem.BEGDA.toString();
     		itemObj.SEQNR 			 = currItem.SEQNR.toString();
     		itemObj.SEL 			 = "";
     		itemObj.KTEXT_CC 		 = currItem.KTEXT_CC.toString();
     		itemObj.ZDAY			 = currItem.ZDAY.toString();			
     		itemObj.BEGUZ			 = currItem.BEGUZ.toString();
     		itemObj.ENDUZ			 = currItem.ENDUZ.toString();
     		itemObj.LGART			 = currItem.LGART.toString();
     		itemObj.KTEXT_WT 		 = currItem.KTEXT_WT.toString();         		
     		itemObj.ANZHL		 	 = currItem.ANZHL.toString();
     		itemObj.RATE		 	 = currItem.RATE.toString();         		         		
     		itemObj.HRATE			 = currItem.HRATE.toString();
    		itemObj.BETRG	  		 = currItem.BETRG.toString();
     		itemObj.GROSS			 = currItem.GROSS.toString();         		     		
     		itemObj.WAERS		     = currItem.WAERS.toString();         		     		
     		itemObj.STAT_DESC		 = currItem.STAT_DESC.toString();
     		itemObj.ZZKOSTL			 = currItem.ZZKOSTL.toString();         		
     		itemObj.ZZDUTY_CODE 	 = currItem.ZZDUTY_CODE.toString();
     		itemObj.ZZAUFNR 		 = currItem.ZZAUFNR.toString();
     		itemObj.ZZAPPROVAL		 = currItem.ZZAPPROVAL.toString();
     		itemObj.ZZDURATION		 = currItem.ZZDURATION.toString();         		
    		itemObj.UNAME			 = currItem.UNAME.toString();
     		itemObj.UPDATED 		 = currItem.UPDATED.toString();
			itemObj.ROW_NUMBER		 = i;
			itemObj.REJECT_TEXT		 = currItem.REJECT_TEXT.toString();
     		itemObj.VALID_WAGE_TYPES = aWageTypes;
     		itemObj.CASUAL_NAME		 = currItem.CASUAL_NAME.toString();
     		itemObj.ZQUERY           = currItem.ZQUERY.toString();
     		itemObj.ZQUERY_TEXT      = currItem.ZQUERY_TEXT.toString();

    		ClaimItems[i] = itemObj;
    		i++;
    	} 	

		OrigClaimItems 	  = clone(ClaimItems);
		
		PreSaveClaimItems = clone(ClaimItems);
     
    	dgItems.executeBindings();
       	dgItems.invalidateDisplayList();
	}


	private function ResetGrid():void{

		if(ClaimItems != null){
			
			var iLength:int = ClaimItems.length;
			
	    	for(var i:int = 0; iLength > i; i++){
	    		
	    		ClaimItems.shift();
	    	}
	    	
	    	dgItems.executeBindings();
	       	dgItems.invalidateDisplayList();	    	
	    	
		}
	}