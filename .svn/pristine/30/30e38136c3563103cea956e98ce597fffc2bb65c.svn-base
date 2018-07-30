package CMS.generalClasses
{
	import mx.collections.ArrayCollection;
	import mx.formatters.DateFormatter;	
	import flash.external.ExternalInterface;
	
	public class DataProviderManager
	{
		
		private static const cStaff:String = 'STAFF';

		private static var dateFormat:DateFormatter = new DateFormatter();

		private static var prevCostCentre:String = "xxx";
		private static var prevWeekStart:String  = "xxx";
		private static var prevCasual:String	 = "xxx";	
		//private static var prevCurr:String	     = "xxx"; //sreddy	

		private static var currentCostCentre:ApprovalTree;
		private static var currentWeekStart:ApprovalTree;
		private static var currentCasual:ApprovalTree;	
        //sreddy	
        //private static var Casualcurr:String = "xxx";
        
		private static var WeekStartTotal:Number = 0;
		private static var costCentreTotal:Number = 0;
		private static var CasualTotal:Number = 0;		
		

		private static var costCentreGrossTotal:Number = 0;
		private static var WeekStartGrossTotal:Number = 0;  
		private static var CasualGrossTotal:Number = 0;     

		private static var costCentreHoursTotal:Number = 0;
		private static var WeekStartHoursTotal:Number = 0;  
		private static var CasualHoursTotal:Number = 0;     

		private static var costCentreShiftTotal:Number = 0;
		private static var WeekStartShiftTotal:Number = 0;  
		private static var CasualShiftTotal:Number = 0;     

		private static var WeekStartItemCount:int;
		private static var CasualItemCount:int;
		private static var costCentreItemCount:int;

		private static var TotalClaims:int = 0;

		private static var dpNew:ArrayCollection;
		private static var dpCurrent:ArrayCollection;

		private static var indent:Number = 10;  

		dateFormat.formatString = "DD.MM.YYYY"		

/* Build the data provider for the grid using the data returned from the 
** server.  This function will create an array collection that will 
** be returned to the calling program to be displayed in the data grid
** Initial creation for MEs will return a collapsed structure with cost centres
** the highest level.  
** The initial creation for deskheads or interim approvers will return a fully
** expanded structure.
** If data has already been returned and approved, rejected etc, this
** method will return a data provider with all nodes that were open still open
*/
		public static function  getClaimsCallBack(dpCurr:ArrayCollection,items:XML,bShowCollapsed:Boolean):ArrayCollection{		 	 	 		 	 	 

			dpCurrent = dpCurr;

			TotalClaims = 0;
								
			dpNew = new ArrayCollection();
	
	    	var currItem:XML;
	    	var itemsList:XMLList = items.CH_T_ITEMS; 

	    	for each(currItem in itemsList.item){
	  		
	    		if (prevCostCentre != currItem.ZZKOSTL.toString()) {
	    			
	    			if (currentCostCentre!=null){
						
						FinalisePernrLine(currItem);
	
						FinaliseWkStartLine(currItem);

						FinaliseCostCentreLine(currItem);
											
	    			}

					createPernrLine(currItem);
					
					createNewWkStartLine(currItem);
	    			
					createNewCostCentreLine(currItem);

				}else if(prevWeekStart != currItem.WKSTART.toString()){				
					
					FinalisePernrLine(currItem);
					FinaliseWkStartLine(currItem);						
					
					createPernrLine(currItem);
					createNewWkStartLine(currItem);

				}else if(prevCasual != currItem.PERNR.toString()){				

					FinalisePernrLine(currItem);
					createPernrLine(currItem);
				}
			
				currentCasual.childList.addItem(getCurrentRow(currItem));
				//sreddy
				//if (prevCurr != currItem.WAERS.toString()) {
				//Casualcurr = "XXX";					
				//}
				//sreddy
				prevWeekStart  = currItem.WKSTART.toString(); 	
				prevCostCentre = currItem.ZZKOSTL.toString();
				prevCasual	   = currItem.PERNR.toString();	
				//prevCurr       = currItem.WAERS.toString();
				DoTotalling(currItem);
	    	}
			
			FinalTotalling(currItem);
	    	
	    	ClearAll();

			ExpandNodes(bShowCollapsed);

			if (ExternalInterface.available){
	
	 			ExternalInterface.call("TabDescription",String(TotalClaims));
			}
			
	    	return dpNew;
	    }			

/* This method will expand all nodes of the tree below the selected item
** Nb that if a node is already open, but nodes beneath it are closed, this 
** method will not then expand those items,  The user will need to close the node
** first then reopen to see all expanded.  
** It is also called when a checkbox is selected and will expand all closed
** nodes below the selected checkbox
*/
		public static function Expand(item:ApprovalTree,Row:Number,Select:Boolean,CBValue:Boolean):Number{
							
			var LineNo:Number;
			
			if (item.costCentreLine && !item.isOpen){
				
				LineNo = ExpandCostCentre(item, Row, Select, CBValue);
				
			}else if(item.WeekStartLine && !item.isOpen){
				
				LineNo = ExpandWeekStart(item, Row, Select, CBValue)					
				
			}else if(item.CasualLine && !item.isOpen){
			
				LineNo = ExpandPernr(item, Row, Select, CBValue)	
			}

			return LineNo;
		}

		public static function SetCheckboxes(item:ApprovalTree,CBValue:Boolean):void{
			
			if(item.costCentreLine){
				
				UpdateWkStartNodesCBxs(item,CBValue);
				
			}else if(item.WeekStartLine){
				
				UpdatePernrNodeCBxs(item,CBValue)
				
			}else if(item.CasualLine){
				
				UpdateClaimCBxs(item,CBValue)		
			}

			dpNew.itemUpdated(item)
		}

	   public static function closeItem(item:ApprovalTree,deleteIndex:Number):void{
	
			item.isOpen = false;
			
	        for(var i:Number = 0; i < item.childList.length; i++){
	        	
	            if(item.childList[i].isOpen == true){
	                closeItem(item.childList[i],deleteIndex);
	             }

				dpNew.removeItemAt(deleteIndex+1);
	        }
	    }
	
		public static function openItem(item:ApprovalTree,indexNum:Number):void{

			item.isOpen = true;
			
            for(var i:Number = 0; i < item.childList.length; i++){

				  addTreeItem(item.childList[i],indexNum+i,item.indent)
	        }
		}
	
		private static function createNewCostCentreLine(currItem:XML):void{

			currentCostCentre			     = new ApprovalTree();
			currentCostCentre.PERNR			 = currItem.ZZKOSTL.toString() + " ~ " + currItem.KTEXT_CC.toString();
			currentCostCentre.costCentreLine = true;
			currentCostCentre.ZZKOSTL 		 = currItem.ZZKOSTL.toString(); 
			currentCasual.PERSONNEL_NO  	 = currItem.PERNR.toString();			

		}

		private static function FinaliseCostCentreLine(currItem:XML):void{

			currentCostCentre.BETRG 	 = (costCentreTotal.toFixed(2)).toString()
			currentCostCentre.GROSS 	 = (costCentreGrossTotal.toFixed(2)).toString()			
			currentCostCentre.ZZDURATION = (costCentreHoursTotal.toFixed(2)).toString();    	 
			currentCostCentre.ANZHL	     = (costCentreShiftTotal.toFixed(2)).toString();    	 

			currentCostCentre.ZDAY  = costCentreItemCount + " items";
                        // sreddy
    		//if (Casualcurr != "xxx") {
    		//currentCostCentre.WAERS      = "GBP"; //(currItem.WARES).toString();	
    		//}    		
    		//sreddy
			costCentreItemCount=0;
						
			costCentreTotal=0;
			costCentreHoursTotal=0;
			costCentreGrossTotal=0;
			costCentreShiftTotal=0;
			
			dpNew.addItem(currentCostCentre);
			
		}
			 
		private static function createNewWkStartLine(currItem:XML):void{

			currentWeekStart				= new ApprovalTree();
			currentWeekStart.WeekStartLine	= true;
			currentWeekStart.ZZKOSTL 		= currItem.ZZKOSTL.toString();			
			currentWeekStart.WKSTART 		= dateFormat.format(currItem.WKSTART.toString());
			currentWeekStart.PERNR 			= "W/C " + currentWeekStart.WKSTART;
			currentCasual.PERSONNEL_NO  	= currItem.PERNR.toString();						

		}
    		     
		private static function FinaliseWkStartLine(currItem:XML):void{

    		currentWeekStart.BETRG      = (WeekStartTotal.toFixed(2)).toString();
    		currentWeekStart.GROSS      = (WeekStartGrossTotal.toFixed(2)).toString();    		
			currentWeekStart.ZZDURATION = (WeekStartHoursTotal.toFixed(2)).toString();    	 
			currentWeekStart.ANZHL	    = (WeekStartShiftTotal.toFixed(2)).toString();    	 

    		currentWeekStart.ZDAY = WeekStartItemCount + " items";
            // sreddy
    		//if (Casualcurr != "xxx") {
    		//currentWeekStart.WAERS      = "GBP";//(currItem.WARES).toString();	
    		//}    		
    		//sreddy
    		WeekStartItemCount=0;
    		    		
    		WeekStartTotal=0;
    		WeekStartGrossTotal=0;
			WeekStartHoursTotal=0;
			WeekStartShiftTotal=0;
    		
    		currentCostCentre.childList.addItem(currentWeekStart);			
		}

		private static function createPernrLine(currItem:XML):void{

			currentCasual = new ApprovalTree();
			currentCasual.CasualLine 	= true;
			currentCasual.ZZKOSTL 		= currItem.ZZKOSTL.toString();			
			currentCasual.WKSTART    	= dateFormat.format(currItem.WKSTART.toString());
			currentCasual.PERNR      	= currItem.CASUAL_NAME;
			//currentCasual.WAERS         = "GBP"; //currItem.WAERS.toString(); //SREDDY
			currentCasual.IS_LOCKED 	= currItem.IS_LOCKED;			
			currentCasual.PERSONNEL_NO  = currItem.PERNR.toString();
			
			currentCasual.queryReason = currItem.ZQUERY_TEXT.toString();
			if (currItem.ZQUERY == "X")
				currentCasual.onQuery = true;
			else
				currentCasual.onQuery = false;


		}
		
		private static function FinalisePernrLine(currItem:XML):void{

    		currentCasual.BETRG 	 = (CasualTotal.toFixed(2)).toString();
    		// sreddy
    		//if (Casualcurr != "xxx") {
    		//currentCasual.WAERS      = (currItem.WARES).toString();	
    		//}    		
    		//sreddy
    		currentCasual.GROSS 	 = (CasualGrossTotal.toFixed(2)).toString();    
			currentCasual.ZZDURATION = (CasualHoursTotal.toFixed(2)).toString();    	 
			currentCasual.ANZHL 	 = (CasualShiftTotal.toFixed(2)).toString();    	 
				 
    		currentCasual.ZDAY = CasualItemCount + " items";

    		CasualItemCount = 0;
    		
    		CasualTotal	= 0;    		
			CasualGrossTotal=0;
			CasualHoursTotal=0;
			CasualShiftTotal=0;
    		
    		currentWeekStart.childList.addItem(currentCasual);			
			
		}

		private static function DoTotalling(currItem:XML):void{

			costCentreTotal += Number(currItem.BETRG.toString());
			WeekStartTotal  += Number(currItem.BETRG.toString());
    		CasualTotal	    += Number(currItem.BETRG.toString());

			costCentreGrossTotal += Number(currItem.GROSS.toString());
			WeekStartGrossTotal  += Number(currItem.GROSS.toString());
    		CasualGrossTotal     += Number(currItem.GROSS.toString());

			costCentreHoursTotal += Number(currItem.ZZDURATION.toString());
			WeekStartHoursTotal  += Number(currItem.ZZDURATION.toString());
			CasualHoursTotal	 += Number(currItem.ZZDURATION.toString());

			costCentreShiftTotal += Number(currItem.ANZHL.toString());
			WeekStartShiftTotal  += Number(currItem.ANZHL.toString());
			CasualShiftTotal	 += Number(currItem.ANZHL.toString());
    					
			costCentreItemCount++;
			WeekStartItemCount++;			
    		CasualItemCount++;
    		
    		TotalClaims++;

		}

		private static function FinalTotalling(currItem:XML):void{

	    	if (currentCasual !=null){
	    		
				FinalisePernrLine(currItem)
	    	} 
	    	
	    	if (currentWeekStart!=null){
	    		
				FinaliseWkStartLine(currItem)	    		
	    	} 
	    	
	    	if (currentCostCentre!=null){
	    	
		    	FinaliseCostCentreLine(currItem);
	    	} 
			
		}

		private static function ClearAll():void{

			currentCostCentre = null;
			currentWeekStart  = null;
			currentCasual	  = null;	
		
			prevCostCentre = "xxx";
			prevWeekStart  = "xxx";
			prevCasual	   = "xxx";		
			//prevCurr       = "xxx"; //Sreddy
	
			WeekStartTotal	= 0;
			costCentreTotal = 0;
			CasualTotal	    = 0;		
	
			costCentreGrossTotal = 0;
			WeekStartGrossTotal  = 0;  
			CasualGrossTotal     = 0;     
	
			costCentreHoursTotal = 0;
			WeekStartHoursTotal  = 0;  
			CasualHoursTotal     = 0;     
	
			costCentreShiftTotal = 0;
			WeekStartShiftTotal  = 0;  
			CasualShiftTotal     = 0;     
	
			WeekStartItemCount  = 0;
			CasualItemCount     = 0;
			costCentreItemCount = 0;
			
		}

		
		private static function getCurrentRow(claim_line:XML):ApprovalTree {
	
			var row:ApprovalTree = new ApprovalTree();
		
	 		row.PERNR 			 = claim_line.PERNR.toString();
	 		row.SUBTY 			 = claim_line.SUBTY.toString();
	 		row.OBJPS 			 = claim_line.OBJPS.toString();
	 		row.SPRPS 			 = claim_line.SPRPS.toString();
	 		row.ENDDA 			 = dateFormat.format(claim_line.ENDDA.toString());
	  		row.BEGDA  			 = dateFormat.format(claim_line.BEGDA.toString());
	 		row.SEQNR 			 = claim_line.SEQNR.toString();
	 		row.KTEXT_CC 		 = claim_line.KTEXT_CC.toString();
	 		row.ZDAY			 = claim_line.ZDAY.toString();			
	 		row.BEGUZ			 = (claim_line.BEGUZ.toString()).substr(0,5);
	 		row.ENDUZ			 = (claim_line.ENDUZ.toString()).substr(0,5);
	 		row.LGART			 = claim_line.LGART.toString();
	 		row.KTEXT_WT 		 = claim_line.KTEXT_WT.toString();         		
	 		row.ANZHL		 	 = claim_line.ANZHL.toString();
	 		row.RATE		 	 = claim_line.RATE.toString();         		         		
	 		row.HRATE			 = claim_line.HRATE.toString();
			row.BETRG	  		 = claim_line.BETRG.toString();
	 		row.GROSS			 = claim_line.GROSS.toString();         		     		
	 		row.WAERS		     = claim_line.WAERS.toString();         		     		
	 		row.STAT_DESC		 = claim_line.STAT_DESC.toString();
	 		row.ZZKOSTL			 = claim_line.ZZKOSTL.toString();         		
	 		row.ZZDUTY_CODE 	 = claim_line.ZZDUTY_CODE.toString();
	 		row.ZZAUFNR 		 = claim_line.ZZAUFNR.toString();
	 		row.ZZAPPROVAL		 = claim_line.ZZAPPROVAL.toString();
	 		row.ZZDURATION		 = claim_line.ZZDURATION.toString();         		
			row.UNAME			 = claim_line.UNAME.toString();
	 		row.UPDATED 		 = claim_line.UPDATED.toString();
			row.ROW_NUMBER		 = 0;
			row.REJECT_TEXT		 = claim_line.REJECT_TEXT.toString();
	 		row.CASUAL_NAME		 = claim_line.CASUAL_NAME.toString();
	 		row.WKSTART			 = dateFormat.format(claim_line.WKSTART.toString());
			row.ClaimLine		 = true;
			row.AMOUNT_WARNING   = claim_line.AMOUNT_WARNING.toString();
			row.IS_LOCKED		 = claim_line.IS_LOCKED.toString();
			row.PERSONNEL_NO     = claim_line.PERNR.toString();

			row.queryReason = claim_line.ZQUERY_TEXT.toString();
			if (claim_line.ZQUERY == "X")
				row.onQuery = true;
			else
				row.onQuery = false;


			if (claim_line.CASUAL_TYPE == cStaff){
				row.highlightRow = true;
			}else{
				row.highlightRow = false;
			}

			return row; 
		}
		
		private static function ExpandNodes(bShowCollapsed:Boolean):void{
			
			var CostCentreNode:ApprovalTree;
			var LineNo:Number = 0;
			var NoOfCostCentres:int = dpNew.length;

			for (var i:int = 0; i < NoOfCostCentres ;i++){
	
				CostCentreNode = dpNew[LineNo];

				if(!bShowCollapsed){
	
	 				LineNo = Expand(CostCentreNode,LineNo,false, false);
								
				}else{
					
			    	LineNo = ExpandCurrentOpenNodes(CostCentreNode,LineNo);
				}
 				LineNo++;
			}
		}
		
		private static function ExpandCostCentre(item:ApprovalTree,Idx:Number,Select:Boolean, CBValue:Boolean):Number{
	
			var WeekStartNode:ApprovalTree;
			var LineNo:Number = Idx;
			
			item.isOpen = true;
										
			for each(WeekStartNode in item.childList){
				
				if(Select == true){

					WeekStartNode.SEL = CBValue;					
				}
								
				LineNo = addTreeItem(WeekStartNode, LineNo, item.indent)
				
				LineNo = ExpandWeekStart(WeekStartNode, LineNo, Select, CBValue);
			}
			return LineNo;
		}
	
		private static function ExpandWeekStart(item:ApprovalTree,Idx:Number,Select:Boolean, CBValue:Boolean):Number{
	
			var PernrNode:ApprovalTree;
			var LineNo:Number = Idx;
	
			item.isOpen = true;
						
			for each(PernrNode in item.childList){

				if(Select == true && PernrNode.IS_LOCKED != 'X'){

					PernrNode.SEL = CBValue;					
				}
				
				LineNo = addTreeItem(PernrNode, LineNo,item.indent);
			
				LineNo = ExpandPernr(PernrNode, LineNo, Select, CBValue);
			}
	
			return LineNo;
		}
	
	    private static function ExpandPernr(item:ApprovalTree,indexNum:Number,Select:Boolean, CBValue:Boolean):Number{
	    	
			var ClaimLine:ApprovalTree;
			var LineNo:Number = indexNum;
			
			item.isOpen = true;
			
			for each(ClaimLine in item.childList){

				if(Select == true && ClaimLine.IS_LOCKED != 'X'){

					ClaimLine.SEL = CBValue;					
				}
				
				LineNo = addTreeItem(ClaimLine, LineNo,item.indent);				
	
			}    	
	
			return LineNo;		
	    }
	
	    private static function addTreeItem(item:ApprovalTree,indexNum:Number,HigherLevelIndent:Number):Number{
	
			var NewLineNo:Number = indexNum+1;
				
			item.indent = indent + HigherLevelIndent;
				
	        dpNew.addItemAt(item, NewLineNo);
	
	        return NewLineNo;
	     
	    }

		private static function ExpandCurrentOpenCostCentre(CostCentreLine:ApprovalTree,CurrentCCLine:ApprovalTree,Idx:Number):Number{
		
			var LineNo:Number = Idx;
			var WeekStartNode:ApprovalTree;
			var CurrentWkStartLine:ApprovalTree;
			
			CostCentreLine.isOpen = true;

			for each(WeekStartNode in CostCentreLine.childList){
			
				LineNo = addTreeItem(WeekStartNode, LineNo, CostCentreLine.indent);

				for each(CurrentWkStartLine in CurrentCCLine.childList){

					if(WeekStartNode.WKSTART == CurrentWkStartLine.WKSTART
					&& CurrentWkStartLine.WeekStartLine
					&& CurrentWkStartLine.isOpen){
	
						LineNo = ExpandCurrentOpenWkStart(WeekStartNode,CurrentWkStartLine,LineNo);

						break;
					}
				}
			} 

			return LineNo;			
		}

		private static function ExpandCurrentOpenWkStart(WeekStartLine:ApprovalTree,CurrentWkStLine:ApprovalTree,Idx:Number):Number{

			var LineNo:Number = Idx;
			var WeekStartNode:ApprovalTree;
			var CurrentPernrNode:ApprovalTree;
			var PernrNode:ApprovalTree;
			
			WeekStartLine.isOpen = true;

			for each(PernrNode in WeekStartLine.childList){
			
				LineNo = addTreeItem(PernrNode, LineNo, WeekStartLine.indent);

				for each(CurrentPernrNode in CurrentWkStLine.childList){

					if(PernrNode.PERNR == CurrentPernrNode.PERNR
					&& CurrentPernrNode.CasualLine
					&& CurrentPernrNode.isOpen){

						LineNo = ExpandPernr(PernrNode,LineNo, false, false);
						
						break;
					}
				}
			} 

			return LineNo;			
			
		}

	    private static function ExpandCurrentOpenNodes(dpNewCostCentreLine:ApprovalTree,Idx:Number):Number{

			var dpCurrentLine:ApprovalTree;
			var LineNo:Number = Idx;

			if(dpCurrent != null){

				for each(dpCurrentLine in dpCurrent){				
					
					if(dpNewCostCentreLine.ZZKOSTL == dpCurrentLine.ZZKOSTL 
					&& dpCurrentLine.costCentreLine
					&& dpCurrentLine.isOpen){

						LineNo = ExpandCurrentOpenCostCentre(dpNewCostCentreLine,dpCurrentLine,LineNo);
						
						break;						
					}
				}
			}

		    return LineNo;
	    }
	 
		private static function UpdateWkStartNodesCBxs(items:ApprovalTree,CBValue:Boolean):void{
	
			var WeekStartNode:ApprovalTree;
			
			for each(WeekStartNode in items.childList){
			
				WeekStartNode.SEL = CBValue;	
				
				UpdatePernrNodeCBxs(WeekStartNode,CBValue);
			}
		}
		
						 
		private static function UpdatePernrNodeCBxs(items:ApprovalTree,CBValue:Boolean):void{
	
			var CasualNode:ApprovalTree;  
	
			for each(CasualNode in items.childList){
	
				if(CasualNode.IS_LOCKED != 'X'){
	
					CasualNode.SEL = CBValue;	

					UpdateClaimCBxs(CasualNode,CBValue)
					
				}
			}
		}
	
		private static function UpdateClaimCBxs(items:ApprovalTree,CBValue:Boolean):void{
	
			var ClaimItem:ApprovalTree;
	
			for each(ClaimItem in items.childList){
				
				if(ClaimItem.IS_LOCKED != 'X'){
							
					ClaimItem.SEL = CBValue;	
				}
			}
		}
	
		public static function ResetGrid():void{
	
			if(dpNew != null){
				
				var iLength:int = dpNew.length;
				
		    	for(var i:int = 0; iLength > i; i++){
		    		
		    		dpNew.removeAll();
		    		
		    	}
			}
		}
	    
	}
}
