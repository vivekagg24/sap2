/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	BuildDropdowns.as - build data/label dropdown arrays that are bound to comboboxes or lists
	
	getRecentGLAccountList
		populate array of recent GL accounts the user has used
	getRecentProjectList
		populate array of recent projects the user has used
	setItemCategories
		Set the item categories dropdowns based on publication
	populateCostCentres
		Populate the list of cost centres value help array (allowed values for the user)
*/
import ecs.generalClasses.valueForDropdown;


/*
	getRecentGLAccountList
		populate array of recent GL accounts the user has used
*/
private function getRecentGLAccountList():Array{
	var listItem:valueForDropdown;
	var list:Array = new Array();
	for each (var item:XML in initXml.EX_T_GL_ACCOUNTS.item){
		listItem = new valueForDropdown();
		listItem.data = item.GL_ACCT.toString();
		listItem.label = item.GL_ACCT.toString() + " " + item.LABEL.toString();
		list.push(listItem);
	}
	return list;
}
/*
	getRecentProjectList
		populate array of recent projects the user has used
*/
private function getRecentProjectList():Array{
	var listItem:valueForDropdown;
	var list:Array = new Array();
	for each (var item:XML in initXml.EX_T_PROJECTS.item){
		listItem = new valueForDropdown();
		listItem.data = item.DATA.toString();
		listItem.label = item.DATA.toString() + " " + item.LABEL.toString();
		list.push(listItem);
	}
	return list;
}

/*
	setItemCategories
		Set the item categories dropdowns based on publication
*/
private function setItemCategories():void{
	var filteredList:Array=new Array();
	var nodes:XMLList;
	for (var i:int=0;i<itemCategories.length;i++){
		nodes = initXml.CH_T_GL_ACCOUNT.item.(ITEM_CAT==itemCategories[i].data && PUBID==comboPubID.selectedItem.data);
		if (nodes.length()> 0) 
			filteredList.push(itemCategories[i]);
	}
	itemCategories=filteredList;			
}

/*
	populateCostCentres
		Populate the list of cost centres value help array (allowed values for the user)
*/
private function populateCostCentres():void{
	var currentValue:valueForDropdown;
	var i:int;
	costCentres=new Array();
	for each(var item:XML in initXml.CH_T_COST_CENTRES.item){
		if (item.PUBID==comboPubID.selectedItem.data ){
			currentValue = new valueForDropdown();
			currentValue.data  = item.DATA.toString();
			currentValue.label = item.LABEL.toString();
			costCentres[i] = currentValue;
			i++;
		}
				
	}
	costCentresWithAll = costCentres.slice(0);
	currentValue = new valueForDropdown();
	currentValue.data = "";
	currentValue.label = "All Cost Centres";
	costCentresWithAll.splice(0,0,currentValue); // Add at the start
}
