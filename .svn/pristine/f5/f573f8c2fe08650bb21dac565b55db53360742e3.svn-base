	/*	
Application: ECS Payment approval (desk head and managing editor)
Author: 	 DJ McNamara 
Date:		 March 2007

Grid Functions:
	Actionscript functions for building and handling interaction with the ECS approval screen datagrid

	setUpGridColumns:
		Build array of columns for the datagrid		
	populateGridStructure
		Populate the data provider for the grid based on the results returned from the web service
		to get the report data (Z_ECS_GET_APPROVAL_DATA)
		Each cost centre has a node 
			Each batch has a node under it's cost centre
				Each payment has a node under it's batch
	openNodes
		Opens up nodes where the the isOpen flag is set to true.
		This involves calling the expandSection method which in turn appends all the node's immediate children below it (indented).
		A node's children are stored in it childListArray
	getCurrentRow
		Get the ApprovalTree structure for the current XML row in 
		the results returned from Z_ECS_GET_APPROVAL_DATA
	itemClick
		Called when either the image to expand/ contract section or the checkbox to select a row is clicked.
		If the select checkbox is clicked for a cost centre or batch line then all items for that grouping are 
		selected (and the tree is opened)
	expandSection
		Expand the current section in the tree hierarchy
		This is done by inserting the item's children directly below it in the grid.
		An item's children are stored in it
	closeSection
		Close the current tree section by removing an item's children from directly below it in the data provider
	expandGrid
		Expand all the children of the grid
	collapseGrid
		Collapse all the children of the grid
	contributorDataTipFunction
		Generate the tool tip to show both name1 and name2 of the contributor

/*
Build an aray of columns for the data grid
Itemrenderers are in ecs.approvalGridFields
*/
import VDG.VariantDataGridColumn;
import mx.core.ClassFactory;
import VDG.TipRenderer;
import mx.managers.LayoutManager;
import ecs.components.DataGridCheckBox;
import flash.geom.Point;
import ecs.generalClasses.ApprovalTree;

private function setUpGridColumns():void{
	var col:VariantDataGridColumn;
	
	columns = new Array();
	
// Have to apply mulitplier to the width
   var mult:Number = dg.width / 1250;
 	
	
//Expand / contract image 	
	col = new VariantDataGridColumn();
	col.headerText= " ";
	col.dataField="Image";
//Item renderer is the TreeGrid component
	col.itemRenderer = new ClassFactory(ecs.approval.components.TreeGrid);
	col.setStyle("textAlign", "center");
	col.width = 51 * mult;
	col.sortable=false;
	col.hideable = false;	
	columns.push(col);

// SELECT checkbox	
	col = new VariantDataGridColumn();
	col.dataField = "selected";
	col.headerText = "Sel";
// Item renderer is ecs extended version of the checkbox
	col.itemRenderer = new ClassFactory(ecs.components.DataGridCheckBox);
	col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
	col.setStyle("textAlign", "center");
	col.width = 21 * mult;
	col.sortable=false;
	col.hideable = false;
	columns.push(col);

	// story
	col = new VariantDataGridColumn();
	col.dataField = "story";
	col.headerText = "Story Line Text";
	col.width = 197 * mult;
	col.itemRenderer = new ClassFactory(ecs.approval.approvalGridFields.StoryLine);
	col.showDataTips=true;
	col.dataTipField= "story";
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	
	
	
					
	//Contributor name
	col = new VariantDataGridColumn();
	col.dataField = "contributorName";
	col.headerText = "Contributor Name";
	col.width = 175 * mult;
	col.showDataTips=true;
	//col.dataTipField="contributorName";
	col.dataTipFunction = contributorDataTipFunction;
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);		
						
	//Contributor number
	col = new VariantDataGridColumn();
	col.dataField = "contributor";
	col.headerText = "Contributor";
	col.width = 80 * mult;
	col.sortable=false;
	col.visible=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);		
			
	//'Input by' name
	col = new VariantDataGridColumn();
	col.dataField = "inputBy";
	col.headerText = "Input By";
	col.width = 84 * mult;
	col.showDataTips=true;
	col.dataTipField="inputBy";
	col.sortable=true;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);
	
	// Contributor Type
	col = new VariantDataGridColumn();
	col.dataField = "contributorType";
	col.headerText = "Type";
	col.width = 60 * mult;
	col.showDataTips=true;
	col.dataTipField= "contributorType";
	col.sortable=false;
	col.itemRenderer = new ClassFactory(ContribType);
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	
		
	// Item Category
	col = new VariantDataGridColumn();
	col.dataField = "icatDesc";
	col.headerText = "Category";
	col.width = 70 * mult;
	col.showDataTips=true;
	col.dataTipField= "icatDesc";
	col.sortable=false;
	col.visible=true;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);			
		
	// GL Account
	col = new VariantDataGridColumn();
	col.dataField = "glCode";
	col.headerText = "GL Code";
	col.width = 70 * mult;
	col.showDataTips=true;
	col.dataTipField= "glDesc";
	col.sortable=false;
	col.visible=true;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	
		
	//CPR number - is an action link to launch the CPR Entry screen
	col = new VariantDataGridColumn();
	col.dataField = "cpr";
	col.itemRenderer= new ClassFactory(ecs.approval.approvalGridFields.LinkToCPR);
	col.headerText = "Document";
	col.width = 66 * mult;
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);		

	
	//Amount
	col = new VariantDataGridColumn();
	col.visible = true;
	col.dataField = "amount";
	col.headerText = "Amount";
	col.itemRenderer= new ClassFactory(ecs.approval.approvalGridFields.AmountDisplay);
	col.width = 52 * mult;
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);	
	columns.push(col);
	
	//Publication date
	col = new VariantDataGridColumn();
	col.showDataTips=true;
	col.dataField = "publicationDate";
	col.dataTipField = "publicationDate";
	col.headerText = "Publ. Date";
	col.width = 52 * mult;
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	
	
	//Page numbers
	col = new VariantDataGridColumn();
	col.dataField = "pageNumbers";
	col.headerText = "Pages";
	col.width = 45 * mult;
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	

	//Urgent flag
	col = new VariantDataGridColumn();
	col.dataField = "urgent";
	col.headerText = "Urgent";
	col.width = 26 * mult;
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(urgentDisplay);
	//Tooltip is the reason the payment is urgent
	col.dataTipField="urgentReason";
	col.editable = false;
	col.showDataTips=true;
	col.setStyle("textAlign", "center");
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);

	//Urgent reason
	col = new VariantDataGridColumn();
	col.dataField = "urgentReason";
	col.headerText = "Reason";
	col.width = 51 * mult;
	col.dataTipField="urgentReason";
	col.showDataTips=true;
	col.setStyle("textAlign", "center");
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	
	
// ME only fields	
	if (managingEditor){
		//Status traffic light
		col = new VariantDataGridColumn();
		col.dataField = "status";
		col.headerText = "Status";
		//Item renderer displays traffic light image based on the ECS status
		col.itemRenderer = new ClassFactory(ecs.approval.approvalGridFields.ECSStatus);
		col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
		col.width = 40 * mult;
		col.sortable=false;
		col.visible=false;
		columns.push(col);
		
		//Check box indicates that the user who approved the payment at DH level is the user 
		//who entered the payment
		col = new VariantDataGridColumn();
		col.dataField = "approver";
		col.headerText = "Authoriser";
		col.width = 16 * mult;
		//Item renderer centres the checkbox and gives it a different colour
		col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
		col.itemRenderer = new ClassFactory(approverCreatedDisplay);
		col.setStyle("textAlign", "center");
		col.sortable=false;
		col.visible=false;
		columns.push(col);
	}
		 
	//Held item checkbox
	col = new VariantDataGridColumn();
	col.dataField = "held";
	col.headerText = "Held";
	col.editable = false;
	col.width = 31 * mult;
	col.visible=true;
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(heldDisplay);
	col.setStyle("textAlign", "center");
	col.sortable=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	
		
	//Flag - this is a new contributor
	col = new VariantDataGridColumn();
	col.dataField = "newContributor";
	col.headerText = "New";
	col.width = 30 * mult;
	col.editable = false;
	//Header renderer allows us to add in tooltips
	col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(newContributorDisplay);
	col.setStyle("textAlign", "center");
	col.sortable=false;
	columns.push(col);	
	
	//sreddy	//Govt. relation indicator
	col = new VariantDataGridColumn();
	col.dataField = "Relation";
	col.headerText = "Govt";
	col.width = 30 * mult;
	col.editable = false;
    //col.dataTipField = "Relation";
	//col.showDataTips=true;
	//Header renderer allows us to add in tooltips
	//col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(govtflagdisplay);
	col.setStyle("textAlign", "center");
	col.sortable=false;
	columns.push(col);	
	
		//sreddy	//Private Investigator IC 253683
	col = new VariantDataGridColumn();
	col.dataField = "PriInv";
	col.headerText = "PI";
	col.width = 30 * mult;
	col.editable = false;
    //col.dataTipField = "Relation";
	//col.showDataTips=true;
	//Header renderer allows us to add in tooltips
	//col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(govtflagdisplay);
	col.setStyle("textAlign", "center");
	col.sortable=false;
	columns.push(col);
	
	
	//sreddy	//Service Agent IC 253683
	col = new VariantDataGridColumn();
	col.dataField = "SerAgt";
	col.headerText = "SA";
	col.width = 30 * mult;
	col.editable = false;
    //col.dataTipField = "Relation";
	//col.showDataTips=true;
	//Header renderer allows us to add in tooltips
	//col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(govtflagdisplay);
	col.setStyle("textAlign", "center");
	col.sortable=false;
	columns.push(col);
	
	//Change Flag the CPR has been edited after creation
	col = new VariantDataGridColumn();
	col.dataField = "changed";
	col.headerText = "Changed";
	col.editable = false;
	col.width = 35 * mult;
	//Header renderer allows us to add in tooltips
	col.headerRenderer =  new ClassFactory(ecs.approval.approvalGridFields.ColumnHeader);
	//Item renderer centres the checkbox and gives it a different colour
	col.itemRenderer = new ClassFactory(CPRChangedFlagDisplay);
	col.setStyle("textAlign", "center");
	col.sortable=false;
	col.editable=false;
	columns.push(col);	
	
		

	//Status text
	col = new VariantDataGridColumn();
	col.dataField = "statusText";
	col.dataTipField= "statusText";
	col.headerText = "Status ";
	col.width = 36 * mult;
	col.sortable=false;
	col.visible=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);	


	// Project
	col = new VariantDataGridColumn();
	col.dataField = "project";
	col.headerText = "Project";
	col.width = 70 * mult;
	col.showDataTips=true;
	col.dataTipField= "project";
	col.sortable=false;
	col.visible=false;
	col.headerRenderer = new ClassFactory(VDG.TipRenderer);
	columns.push(col);


}

/*
populateGridStructure
	Populate the data provider for the grid based on the results returned from the web service
	to get the report data (Z_ECS_GET_APPROVAL_DATA)
	Each cost centre has a node 
		Each batch has a node under it's cost centre
			Each payment has a node under it's batch
	N.B. the grid obviously only has one structure, hence we use the field contributorName to 
	store the batch and cost centre descriptions
*/
private function populateGridStructure():void{
	
	var prevCostCentre:String = "xxx";		//Previous cost centre in loop
	var prevBatch:String = "xxx";			//Previous batch number in loop
	var itemsForCostCentre:int;				//Number of items for the cost centre
	var totalItems:int = 0;					//Total number for items in the report
	var currentBatch:ApprovalTree;			//Curent batch node
	var currentCostCentre:ApprovalTree;		//Current cost centre node
	var batchTotal:Number = 0;				//Items in batch
	var costCentreTotal:Number = 0;			//Items for cost centre
	var batchItemCOunt:int;					//£ value for the current cost centre
	var costCentreItemCount:int;			//£ value for the current batch
	
	//Refresh array
	dp = new ArrayCollection();
	
	//Go through results from Z_ECS_GET_APPROVAL_DATA
	for each(var cpr:XML in reportData.item) {
		
		if (prevCostCentre != cpr.KOSTL.toString()) {
// New cost centre			
			if (currentCostCentre!=null){
				//Add previous cost centre node to data provider
				if (managingEditor&& currentBatch!=null){
					//Add batch to previous cost centre node
					currentBatch.amount=currFormat.format(batchTotal);
					currentBatch.contributorName= batchItemCOunt + " items";
					//Reset counters for batch
					batchTotal=0;
				    batchItemCOunt=0;
				    //Set open flag if this node was already open before the list was redrawn
				    if (openBatches.contains(currentBatch.batch)||openBatches.contains(currentBatch.costCentre))
						currentBatch.isOpen=true;
					
					currentCostCentre.childList.addItem(currentBatch);
				} 
				
				if (managingEditor){
					//Create new batch node
					currentBatch=new ApprovalTree();
					currentBatch.batchLine=true;		//Flag indicates that this is a batch line
					currentBatch.batch = cpr.BATCH.toString();
					currentBatch.costCentre = cpr.KOSTL.toString();
					//Batch text - either batch name or "not batched"
					if (cpr.BATCH.toString()=="")  currentBatch.story = "Not Batched";
					else currentBatch.story = "Batch " + cpr.BATCH.toString(); 
				}
				//Add cost centre node to dp
				currentCostCentre.amount=currFormat.format(costCentreTotal);
				currentCostCentre.contributorName= costCentreItemCount + " items";
				//Reset cost centre counters
				costCentreTotal=0;
				costCentreItemCount=0;
				//Set open flag if this node was already open before the list was redrawn
				if (openCostCentres.contains(currentCostCentre.costCentre)) currentCostCentre.isOpen=true;
				dp.addItem(currentCostCentre);
			}
			//Create new cost centre node
			currentCostCentre=new ApprovalTree();
			//Cost centre description
			currentCostCentre.story= cpr.KOSTL.toString() + " ~ " + cpr.CCTEXT.toString();
			currentCostCentre.costCentreLine=true;
			currentCostCentre.costCentre = cpr.KOSTL.toString(); 
			
		}
		
		else if (managingEditor && prevBatch != cpr.BATCH.toString()) {
		// Same cost centre: new batch
			if (currentBatch!=null){
				//Add node for previous batch
				currentBatch.amount=currFormat.format(batchTotal);
				//Number of items - add to description
				currentBatch.contributorName= batchItemCOunt + " items";
				//Reset batch counters
				batchTotal=0;
				batchItemCOunt=0;
				//Set open flag if this node was already open before the list was redrawn
				if (openBatches.contains(currentBatch.batch)||openBatches.contains(currentBatch.costCentre))
					currentBatch.isOpen=true;	
				//Add batch to cost centre node
				currentCostCentre.childList.addItem(currentBatch);
			} 
			
			//Create new batch node
			currentBatch=new ApprovalTree();
			if (cpr.BATCH.toString()=="")  currentBatch.story = "Not Batched";
			else currentBatch.story = "Batch " + cpr.BATCH.toString(); 
			currentBatch.costCentre = cpr.KOSTL.toString();
			//Flag indicates that this a batch line
			currentBatch.batchLine=true;
			//Batch number
			currentBatch.batch = cpr.BATCH.toString();
			
		}
		if (managingEditor && currentBatch==null){
			//Create new batch node
			currentBatch=new ApprovalTree();
			if (cpr.BATCH.toString()=="")  currentBatch.story = "Not Batched";
			else currentBatch.story = "Batch " + cpr.BATCH.toString(); 
			currentBatch.batchLine=true;	
		}
		
		if (managingEditor){
			//Add current CPR to the batch and maintain counters
			currentBatch.childList.addItem(getCurrentRow(cpr));
			prevBatch= cpr.BATCH.toString();
			batchTotal += Number(cpr.DMBTR.toString());		//Add amount to total for batch
			batchItemCOunt++;
		}
		else{
			//Desk head - no batches - just add to cost centre line
			currentCostCentre.childList.addItem(getCurrentRow(cpr));
		}
		prevCostCentre= cpr.KOSTL.toString();
		//maintain cost centre counters
		costCentreTotal += Number(cpr.DMBTR.toString());
		costCentreItemCount++;
		
	}
	//Add final batch to grid dataprovider
	if (managingEditor && currentBatch!=null){
		//Add last batch to last cost centre
		currentBatch.amount=currFormat.format(batchTotal);
		currentBatch.contributorName= batchItemCOunt + " items";
		batchTotal=0;
		batchItemCOunt=0;
		//Set open flag if this node was already open before the list was redrawn
		if (openBatches.contains(currentBatch.batch)||openBatches.contains(currentBatch.costCentre))
			currentBatch.isOpen=true;		
		currentCostCentre.childList.addItem(currentBatch);
	} 
	//Add final cost cente
	if (currentCostCentre!=null){
		//amount
		currentCostCentre.amount=currFormat.format(costCentreTotal);
		// Description - with number of items
		currentCostCentre.contributorName= costCentreItemCount + " items";
		costCentreTotal=0;
		costCentreItemCount=0;
		//Set open flag if this node was already open before the list was redrawn
		if (openCostCentres.contains(currentCostCentre.costCentre)) currentCostCentre.isOpen=true;
		dp.addItem(currentCostCentre);
	} 
	
	//Go through and open up any nodes that were previously opened
	openNodes();
}			

/*
openNodes
	Opens up nodes where the isOpen flag is set to true.
	This involves calling the expandSection method which in turn appends all the node's immediate children below it (indented).
	A node's childrent are stored in it childListArray
*/
private function openNodes():void{
	var index:int;
	var item:ApprovalTree;
	//Do the cost centres first
	for each(item in dp){
		//If the cost centre section is open - append it children below it
		if (item.costCentreLine){
			if (item.isOpen){
				item.isOpen = false;              // We have to force isOpen to be false otherwise  
				expandSection(item,index,false);  // expandSection() won't do anything.
			}
		}
		index++;
	}	
	index=0;
	//Now do the batches
	for each(item in dp){
		
		if (item.batchLine){
			if (item.isOpen){
				item.isOpen = false;              // We have to force isOpen to be false otherwise  
				expandSection(item,index,false);  // expandSection() won't do anything.
			}
		}
		index++;
	}	
}

/*
	getCurrentRow
		Get the ApprovalTree structure for the current XML row in 
		the results returned from Z_ECS_GET_APPROVAL_DATA
		
*/
private function getCurrentRow(cpr:XML):ApprovalTree {

	var row:ApprovalTree = new ApprovalTree();
	
	//CPR Number
	row.cpr = cpr.BELNR.toString();
	//CPR Status
	row.status = cpr.STATUS.toString();
	
	//Entered by also approved it at desk head level
	if (cpr.AUTH.toString() != "") {
		row.approver = true;
	} else {
		row.approver = false;
	}
	
	//Story
	row.story = cpr.SGTXT.toString();
	//Amount in document currency
	row.amount = currFormat.format(cpr.DMBTR.toString());
	//AMount in local currency
	row.docamount = cpr.WRBTR.toString();
	//Contributor number
	row.contributor = removeleadingZeros(cpr.LIFNR.toString());
	//Contributor name
	row.contributorName = cpr.NAME1.toString();
	row.contributorName2 = cpr.NAME2.toString();
	//Entered by
	row.inputBy = cpr.NAME_TEXT.toString();	
	//Publication date
	row.publicationDate = dateFormat.format(cpr.PUBDATE.toString());
	//Reason the payment is urgent
	row.urgentReason = cpr.URGENT_REASON.toString();
	//Contributor type
	row.contributorType = cpr.CONTRIBUTOR_TYPE.toString();
	//Project
	row.project = cpr.PROJECT.toString();
	//Status Text
	row.statusText = cpr.STATUS_TEXT.toString();
	//On-query data
	if (cpr.ZQUERY == 'X')
	{
		row.onQuery = true;
		row.queryReason = cpr.ZQUERY_TEXT.toString();
	}
	// Govt relation Sreddy
	if (cpr.BRSCH.toString() != "" ){
		row.Relation = true; } else {
		row.Relation = false;	
	}
	// Private Investigator Sreddy IC 253683
	if (cpr.ZZPI.toString() != "" ){
		row.PriInv = true; } else {
		row.PriInv = false;	
	}
	// Service Agent Sreddy IC 253683
	if (cpr.ZZSA.toString() != "" ){
		row.SerAgt = true; } else {
		row.SerAgt = false;	
	}
	// row.Relation = cpr.GOVT_RELATION.toString();
	//General Ledger (GL) code
	row.glCode = cpr.SAKNR.toString();
	// Remove all leading zeros from GL Code
	while (row.glCode.charAt(0) == "0")
	{
		row.glCode = row.glCode.slice(1);
	}
	
	// General Ledger Name
	row.glDesc = cpr.TXT20_SKAT.toString();	
	//Item Category Description (Lineage / Pictures etc.)
	row.icatDesc = cpr.ZECSITCATDESCR.toString();
	
	//New contributor flag
	if (cpr.NEWCON.toString() != "") {
		row.newContributor = true;
	} else {
		row.newContributor = false;
	}
	
	//Held item flag
	if (cpr.HELD.toString() != "") {
		row.held = true;
	} else {
		row.held = false;
	}
	
	//Urgent item flag
	if (cpr.URGENT.toString() != "") {
		row.urgent = true;
	} else {
		row.urgent = false;
	}
	
	//Changed item flag
	if (cpr.CHANGE.toString() != "") {
		row.changed = true;
	} else {
		row.changed = false;
	}
	
	//If amount is above threshhold for publication then highlight (config in ZECSPUB)
	if (cpr.ABOVE_THRESHOLD=="X") row.highlightRow = true;
	else row.highlightRow = false;
	
	//Page numbers
	row.pageNumbers = cpr.PAGENOS.toString();
	row.pageNumbers = removeleadingZeros(row.pageNumbers);
	
	//Company Code
	row.company = cpr.BUKRS.toString();
	//Fiscal Year
	row.year = cpr.GJAHR.toString();
	//Batch number
	row.batch = cpr.BATCH.toString();
	//Selected flag - make sure false when creating..
	row.selected = false;
	
	return row; 
}

/*
	itemClick
		Called when either the image to expand/ contract section or the checkbox to select a row is clicked.
		If the select checkbox is clicked for a cost centre or batch line then all items for that grouping are 
		selected (and the tree is opened)
*/
 private function itemClickEvent(event:ListEvent):void {
 	
 	trace("itemClickEvent: " +  (new Date()).time);

	var batchItem:ApprovalTree;			//Current batch row
	var costCentreItem:ApprovalTree;	//Current cost centre row
	var currentIndex:int;				//Index of current row in the data provider
	
    // Remember how many rows changes
	var oldRows:uint = dp.length;
	
	//Store current row
	myRow = event.rowIndex;
	if (myRow == 0) // Header clicked, we don't want to handle this event.
		return;		
		
	// Don't trigger any updates until after we've calcualted everything
	dp.disableAutoUpdate();	
	
	currentIndex=myRow-1;
	if (event.columnIndex==1){
	//SELECT checkbox has been clicked
		if (dp[currentIndex].costCentreLine){
			//Select all items for a cost centre
			//Open the section if necessary
			if (!dp[currentIndex].isOpen) expandSection(dp[currentIndex],currentIndex,true);
			dp[currentIndex].isOpen=true;
			//Go through the cost centre row's children
			
			var tick_sel:Boolean = DataGridCheckBox(event.itemRenderer).selected; 
			for each(costCentreItem in dp[myRow-1].childList){
				//If it is a bactch line expand the section
				if (costCentreItem.batchLine){
					currentIndex++;
					//Open the section if necessary
					if (!costCentreItem.isOpen) {        						
						expandSection(costCentreItem,currentIndex,true);
						costCentreItem.isOpen=true;
						
					}
					//Move the current index on by adding the number of chilren (payments in the batch)
					currentIndex+=costCentreItem.childList.length;
					for each(batchItem in costCentreItem.childList){
						batchItem.selected = DataGridCheckBox(event.itemRenderer).selected;
						dp.itemUpdated(batchItem); 	
					}
					//Select the checkbox
					costCentreItem.selected = tick_sel;      
					
					// Update the data provider
					dp.itemUpdated(costCentreItem); 						
				}
				else
				{ // In Deskhead approval, we have no batches, so children of cost centres are 
				  // payments. We don't need to expand them, just check or uncheck them.
					costCentreItem.selected = tick_sel;   
					
					// Update the data provider for the "selected" box only
					dp.itemUpdated(costCentreItem.selected); 						
				}
 
				
			}
			
			dp.itemUpdated(dp[myRow-1]);
			
		}
		else if (dp[myRow-1].batchLine){
		//Batch line - go through and select all items in the batch
			for each(batchItem in dp[myRow-1].childList){
				batchItem.selected = DataGridCheckBox(event.itemRenderer).selected;
				dp.itemUpdated(batchItem);
			}
			//Open up the node if it is not open already
			if (!dp[myRow-1].isOpen) expandSection(dp[myRow-1],myRow-1,true);
			dp[myRow-1].isOpen=true;
			dp.itemUpdated(dp[myRow-1]);
			
		}
		
			
		if (dp.length == oldRows && 1 == 2){
			// If we haven't expanded or collapsed
			// any rows, only redraw the checkboxes, not the whole grid
			// If funny stuff starts happening after an upgrade, remove this code,
			// its just to improve performance.
			dg.skipNextDraw = true;
			var obj:Object;
			var itemInDp:uint;
			var l_line:Array = dg.getItemRenderedByColumn(1);					
			for (var i:uint = 0; i < l_line.length; i++)
			{
				obj = l_line[i];							

				if (obj is DataGridCheckBox && obj.parent && obj.visible)
				{
					var obj2:DataGridCheckBox = obj as DataGridCheckBox;
					//itemInDp = obj2.listData.rowIndex - 1 - dg.scrollPoistion				
					var _data:Object = dp.getItemAt(itemInDp);
					obj2.listData.label = _data.selected;
					obj2.data = _data;
					
					obj2.invalidateProperties();
				}
				LayoutManager.getInstance().validateNow();
			}			 

		}	

			
	}
			// Finally, let the datagrid know we've changed stuff	
		dp.enableAutoUpdate();
		trace("itemClickEvent end: " +  (new Date()).time);
		

	
}
	
/*
	expandSection
		Expand the current section in the tree hierarchy
		This is done by inserting the item's children directly below it in the grid.
		An item's children are stored in it's childList array
*/
public function expandSection(item:ApprovalTree, indexNum:Number, inclChildren:Boolean, forceOpenChildren:Boolean = false):void{
	var newIndex:int;	
	dg.skipNextDraw = false;
	
	// Is the item already open? If so, then we don't open it again, but we might open subnodes
	
	if (!item.isOpen)
	
	{
	// Change the item to open
	item.isOpen = true;
	
 	   //add the rows for the children at this level
	    for(var i:Number = 0; i < item.childList.length; i++){
 	         if(item.indent){
 	           item.childList[i].indent = item.indent + indent;
 	         }
 	         else{
 	           item.childList[i].indent = indent;
 	         }                   
 	         dp.addItemAt(item.childList[i], indexNum+1+i);
		}
	

//Also open out the children ? - 
//i.e. if it is a cost centre open out the batch rows
		if (inclChildren){
    		for(var j:Number = 0; j < item.childList.length; j++){
           	 if (item.childList[j].isOpen ){
            		
                	for(var k:Number = 0; k < item.childList[j].childList.length; k++){
                  	if(item.indent){
                    	item.childList[j].childList[k].indent = item.indent + indent;
                 	 }
                  	else{
                    	item.childList[j].childList[k].indent = indent;
                  	}                   
           	    	  newIndex++;
            	      dp.addItemAt(item.childList[j].childList[k], indexNum+1+j+newIndex);
                	  
        		}                        
            	}
        	    else if (forceOpenChildren)
        	    {
          	       
            		// Expand its nodes
            		expandSection(item.childList[j], indexNum+1+j+newIndex, true, true);
            		
            		// Open the element
            	    item.childList[j].isOpen = true;
            	    
            	    // Update the row count
        	    	newIndex += item.childList[j].childList.length;
        	    }
    		}
		}
	}
	else if (forceOpenChildren && inclChildren)
	{
		// Item was already open. We expand subnodes that aren't already expanded if forceOpenChildren = true
		for(var l:Number = 0; l < item.childList.length; l++)
					
		     {
		     	var wasOpen:Boolean =  item.childList[l].isOpen;
       	     	         	     
            	// Expand its nodes
            	expandSection(item.childList[l], indexNum+1+l+newIndex, true, true);
            	
            	// Open the element
                item.childList[l].isOpen = true;
            	
            	// Update the row count
        	   	newIndex += item.childList[l].childList.length;
        	}
	}
	

}

/*
closeSection
		Close the current tree section by removing an item's children from directly below it in the data provider
*/
public function closeSection(item:ApprovalTree, indexNum:Number):void{
	
	// Change the item to closed
	item.isOpen = false;
	dg.skipNextDraw = false;

	for(var i:Number = 0; i < item.childList.length; i++){
    	if(item.childList[i].isOpen == true){
        	closeSection(item.childList[i],indexNum);
        }
        dp.removeItemAt(indexNum+1);
  		}
}

/*
storeOpenNodes
	Keep track of open nodes in the tree (cost centres and batches) so that when the data is refreshed 
	they can be opened again
*/
private function storeOpenNodes():void{
	openCostCentres=new ArrayCollection;	//Open cost centres
	openBatches=new ArrayCollection;		//Open batches
	
	//Iterate through the data provider and if the cost centre or batch line is open then add it to 
	//the array collection
	for each (var item:ApprovalTree in dp){
		if (item.costCentreLine&&item.isOpen) openCostCentres.addItem(item.costCentre);
		else if (item.batchLine&&item.isOpen){
			if (item.batch=="") openBatches.addItem(item.costCentre);
			else openBatches.addItem(item.batch);
		} 
	}
}

/*
	expandGrid
		Expand all the children of the grid
*/
public function expandGrid():void {
	var i:int = 0;
	for each (var item:ApprovalTree in dp) {
		if (item.costCentreLine || item.batchLine) {
			if (item.isOpen == false) {
				expandSection(item, i, true);
				item.isOpen = true;
			}
		}
		i++;
	}
	storeOpenNodes();
	dp.enableAutoUpdate();
}
/*
	collapseGrid
		Collapse all the children of the grid
*/
public function collapseGrid():void {
	
	var i:int = 0;
	
	// Close the batches
	for each (var itemB:ApprovalTree in dp) {
		if (itemB.batchLine && itemB.isOpen) {
			closeSection(itemB, i);
			itemB.isOpen = false;
		}
		i++;
	}
	
	// Close the cost centres
	i = 0;
	for each (var itemC:ApprovalTree in dp) {
		if (itemC.costCentreLine && itemC.isOpen) {
			closeSection(itemC, i);
			itemC.isOpen = false;
		}
		i++;
	}
	storeOpenNodes();
	dp.enableAutoUpdate();
}

public function expandItem():void {
	// Expand a line and all its sublines
	var item:int = 	dg.selectedIndex;
	
	//if (!dp[item].isOpen) 
	//{
	
		
		 
		expandSection(dp[item], item, true, true);
		dp[item].isOpen = true;
		storeOpenNodes();	
		dg.skipNextDraw = false;
	

	//}
	
}

public function collapseItem():void {
	// Collapse a line and all its sublines
	var item:int = 	dg.selectedIndex;
	
	if (dp[item].isOpen)
	{
		dp[item].isOpen = false;
		closeSection(dp[item], item);
		storeOpenNodes();	
		dg.skipNextDraw = false;
	} 

}


public function contributorDataTipFunction(data:Object):String
{
	var tip:String = data.contributorName;
	if (data.contributorName2 && data.contributorName2.length > 0)
		{
			tip += "\n" + data.contributorName2;
		}
	return tip;
}

