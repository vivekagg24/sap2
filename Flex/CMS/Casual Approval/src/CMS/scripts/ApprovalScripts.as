// ActionScript file
import CMS.generalClasses.ApprovalTree;
import mx.events.ListEvent;
import mx.collections.ListCollectionView;

	
		getParameters();
		loadScreen();
		registerPortalFunctions();
		
	} 
		   	
	private function getParameters():void {
		
		passedCCs = Application.application.parameters.ccs;

			passedCCs = "";
		}	
		
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
		}
	}
		col.width = 140;
		col.width = 60;
		col.itemRenderer = new ClassFactory(CMS.gridFields.Duration);		
		col.itemRenderer = new ClassFactory(CMS.gridFields.Anzhl);		
		col.itemRenderer = new ClassFactory(CMS.gridFields.Rate);		
		col.itemRenderer = new ClassFactory(CMS.gridFields.Betrg);		
		col.itemRenderer = new ClassFactory(CMS.gridFields.Gross);		
		col = new VariantDataGridColumn();
		col.dataField = "ZZAUFNR";
		col.headerText = "Project Code";
		col.width = 40;
		col.sortable=false;
		columns.push(col);																
		
		var ClickedRowIdx:int = myRow - 1;

	 
private function setDefaultsOnScreen(defaults:XML):void