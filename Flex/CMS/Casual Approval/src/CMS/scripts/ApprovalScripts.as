// ActionScript file
import CMS.generalClasses.ApprovalTree;
import mx.events.ListEvent;import VDG.VariantDataGridColumn;import mx.core.UIComponent;import mx.core.IUIComponent;
import mx.collections.ListCollectionView;import mx.controls.ComboBase;import mx.controls.Button;
/*    -----------------------------------------    FUNCTIONS    -----------------------------------------	startApp	getParameters	registerPortalFunctions	selAllCostCentres	selSpecificCostCentres	GetCostCentresForGetData	setUpGridColumns	setMEandDHflags	itemClickEvent	setDefaultsOnScreen	isGreaterThan */	private function startApp():void {
	
		getParameters();
		loadScreen();
		registerPortalFunctions();
		
	} 
		   	
	private function getParameters():void {
		
		passedCCs = Application.application.parameters.ccs;
		if (passedCCs == "" || passedCCs == null) {
			passedCCs = "";
		}				passedDept = Application.application.parameters.deptid;		if (passedDept == "" || passedDept == null) {			passedDept = "";		}								if (Application.application.parameters.cas == 'X') {			runningStandalone = false;			itemAreaHeight=500;		}		else{ // Do a double-check to make sure we aren't in portal			runningStandalone = true;			itemAreaHeight=600;				if (ExternalInterface.available) {				var inFrame:String;				inFrame =  ExternalInterface.call("checkInFrame");				if (inFrame == 'X')				{					runningStandalone = false;					itemAreaHeight=500;				}			}		} 	}
		
	private function registerPortalFunctions():void {
		if (ExternalInterface.available) {
			ExternalInterface.addCallback("Approve", Approve);
			ExternalInterface.addCallback("Reject", Reject);
			ExternalInterface.addCallback("Refresh", Refresh);
			Security.allowDomain("*");
		}				
	}

	private function selAllCostCentres(all:Boolean):void {
		if (all) {
			var indices:Array = new Array();
			for (var i:int = 0; i < costCentres.length; i++) {
				indices[i] = i;
			}
			lstCostCentres.selectedIndices = indices;
		} else {
			lstCostCentres.selectedIndices = new Array();
		}
	}
	
	private function selSpecificCostCentres():void {
		var indices:Array = new Array();
		var j:int = 0;
		for (var i:int = 0; i < costCentres.length; i++) {
			if (passedCCs.lastIndexOf('~' + costCentres[i].data) != -1) {
				indices[j++] = i;
			}
		}		passedCCs  = "";		passedDept = "";				lstCostCentres.selectedIndices = indices;
	}	private function GetCostCentresForGetData():Array{		var arrItems:Array = new Array();		var i:int = 0;		var cc:XML ;				for each(var item:valueForDropdown in lstCostCentres.selectedItems) {			cc = new XML("<item><KOSTL></KOSTL></item>");			cc.KOSTL = item.data;			arrItems[i] = cc;					i++;		}		return arrItems;	}					private function setUpGridColumns():void{		var col:VariantDataGridColumn;		columns = new Array();		col = new VariantDataGridColumn();		col.headerText= " ";		col.dataField="Image";		col.itemRenderer = new ClassFactory(CMS.Components.TreeGrid);		col.setStyle("textAlign", "center");		col.width = 50;		col.sortable=false;		col.hideable = false;				columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "SEL";		col.headerText = "Sel";		col.itemRenderer = new ClassFactory(CMS.Components.DataGridCheckBox);		col.setStyle("textAlign", "center");		col.width = 28;		col.sortable=false;		col.hideable = false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);								col = new VariantDataGridColumn();		col.dataField = "PERNR";		col.headerText = "Payroll No";		col.itemRenderer = new ClassFactory(CMS.gridFields.Pernr);
		col.width = 140;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "ZDAY";		col.headerText = "Day";		col.itemRenderer = new ClassFactory(CMS.gridFields.Day);
		col.width = 60;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);					col = new VariantDataGridColumn();		col.dataField = "BEGDA";		col.headerText = "Date";		col.width = 65;		col.setStyle("textAlign", "center");		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);		col = new VariantDataGridColumn();		col.dataField = "BEGUZ";		col.headerText = "Start";		col.width = 40;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "ENDUZ";		col.headerText = "End";		col.width = 40;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);								col = new VariantDataGridColumn();		col.dataField = "ZZDURATION";		col.headerText = "Hours";
		col.itemRenderer = new ClassFactory(CMS.gridFields.Duration);				col.width = 45;		col.sortable=false;		col.setStyle("textAlign", "center");		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "LGART";		col.headerText = "Duty Code";		col.width = 43;		col.dataTipField="LGART";		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "KTEXT_WT";		col.headerText = "Duty Type";		col.width = 65;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "ANZHL";
		col.itemRenderer = new ClassFactory(CMS.gridFields.Anzhl);				col.headerText = "Shifts";		col.width = 40;		col.setStyle("textAlign", "center");						col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "RATE";		col.headerText = "Shift rate";		col.width = 50;
		col.itemRenderer = new ClassFactory(CMS.gridFields.Rate);				col.sortable=false;		col.setStyle("textAlign", "right");					col.headerRenderer = new ClassFactory(VDG.TipRenderer);			columns.push(col);				col = new VariantDataGridColumn();		col.dataField = "BETRG";		col.headerText = "Amount";		col.width = 60;
		col.itemRenderer = new ClassFactory(CMS.gridFields.Betrg);				col.setStyle("textAlign", "right");						col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);        // sreddy		col = new VariantDataGridColumn();		col.dataField = "WAERS";  		col.headerText = "Currency";		col.width = 40;		col.itemRenderer = new ClassFactory(CMS.gridFields.Waers);				col.setStyle("textAlign", "right");						col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);                               // sreddy 		col = new VariantDataGridColumn();		col.dataField = "GROSS";
		col.itemRenderer = new ClassFactory(CMS.gridFields.Gross);				col.headerText = "Gross";		col.width = 60;		col.setStyle("textAlign", "right");						col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);										col = new VariantDataGridColumn();		col.dataField = "HRATE";		col.headerText = "Rate/hr";		col.width = 50;		col.setStyle("textAlign", "right");						col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);												col = new VariantDataGridColumn();		col.dataField = "STAT_DESC";		col.headerText = "Status";		col.width = 60;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);									
		col = new VariantDataGridColumn();
		col.dataField = "ZZAUFNR";
		col.headerText = "Project Code";
		col.width = 40;
		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);
		columns.push(col);																
				col = new VariantDataGridColumn();		col.dataField = "UNAME";		col.headerText = "Last Changed By";		col.width = 85;		col.sortable=false;		col.headerRenderer = new ClassFactory(VDG.TipRenderer);		columns.push(col);					// Force set columns		dg.columns = columns;																}	private function setMEandDHflags():void{/* 	Function module Z_CMS_GET_APPROVAL_INITDATA  (Output parameter EX_USER_IS_MANED)...		determines whether "managingEditor" is true/false		See also:	Class:  zcl_cms_user				Method: check_user_is_me*/			deskHeadSel = "";		manEdSel    = "";		if(managingEditor){                       // managingEditor is true						if(rbDeskHead.selected){              // deskhead radio button   i.e. You are an ME and want to see unvalidated claims (02-03 -> 05)					deskHeadSel = "X";					dhbothSel = "";					dhonlySel = "";			}else if(rbNotDeskHead.selected){     // i.e. You are an ME and want to see the deskhead validated claims, awaiting your approval (04 -> 05)					manEdSel    = "X";					dhbothSel = "";					dhonlySel = "";								} else if (1 == 2)                   // (rbAll.selected)			{								deskHeadSel = "X";				manEdSel	= "X";				}	    		}else{						deskHeadSel = "X"; 			    // input selection for FM Z_CMS_GET_CLAIMS_FOR_APPROVAL set to "deskhead"		}	}	 private function itemClickEvent(event:ListEvent):void {				myRow = event.rowIndex;		if (myRow == 0) // Header clicked, we don't want to handle this event.			return;
		var ClickedRowIdx:int = myRow - 1;						var ClickedRow:ApprovalTree = dp[ClickedRowIdx] 						if (event.columnIndex==1 && !ClickedRow.ClaimLine){				var CBValue:Boolean = DataGridCheckBox(event.itemRenderer).selected;
			if(CBValue == true && !ClickedRow.isOpen){				DataProviderManager.Expand(ClickedRow,ClickedRowIdx,true,CBValue);												}else{								DataProviderManager.SetCheckboxes(ClickedRow,CBValue);					//				dg.executeBindings();			}		}	 }
	 
private function setDefaultsOnScreen(defaults:XML):void{	var items:XMLList = defaults.item;	for each (var x:XML in items)	{		var fname:String = x.FNAME.toString();		var fval:String  = x.FVAL.toString();				if (application.hasOwnProperty(fname))  // If this field exists		{			var field:Object = application[fname];						// Check that the field is visible			if (field is IUIComponent && !field.visible)				continue;  						// Any text field			if (field is TextInput && field.text != fval)  			{				// Change the value				field.text = fval;				// Tell any listeners that the value has changed				(field as UIComponent).dispatchEvent(new Event(Event.CHANGE));							}							// RadioButton or Checkbox			else if (field is Button) 			{								if (fval == 'X' || fval == 'TRUE' || fval == 'x' || fval == 'true')				{										if (field.selected != true)					{						// Change the value						field.selected = true;						// Tell any listeners that the value has changed						(field as UIComponent).dispatchEvent(new Event(Event.CHANGE));						}														}				else				{					if (field.selected != false)					{						// Change the value						field.selected = false;						// Tell any listeners that the value has changed						(field as UIComponent).dispatchEvent(new Event(Event.CHANGE));						}				}													}						// Combo box			else if (field is ComboBox)			{				var dp:ListCollectionView = (field as ComboBase).dataProvider as ListCollectionView;				if (dp)				{					var ind:int = -1;					for (var j:int = 0; j < dp.length; j++)					{						var obj:Object = dp.getItemAt(j)						if (obj.data == fval || obj.label == fval)						{							ind = j;							j = dp.length; // Stop after we find the first one								}					}										if (ind > -1 && (field as ComboBox).selectedIndex != ind)					{						// Change the value						(field as ComboBox).selectedIndex = ind;						// Tell any listeners that the value has changed						(field as ComboBox).dispatchEvent(new ListEvent(ListEvent.CHANGE));					}				}							}						}			}	}/** Comparison function *  Used to bind properties, particularly for hiding and showing screen elements */private function isGreaterThan(a:int, b:int):Boolean{	return (a > b);	}/** Function to unhide or hide part of the screen */private function toggleHideShowText(obj:UIComponent, s:String, button:Object):void			{					if (obj.visible)					{						obj.visible = false;						obj.includeInLayout = false;						button.label = ('Show ' + s);					}										else					{						obj.visible = true;						obj.includeInLayout = true;						button.label = ('Hide ' + s);					}					topCanvas.autoLayout = true;									}