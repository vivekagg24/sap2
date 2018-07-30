package ecs.generalClasses
{
	import ecs.gridFields.AmountInput;
	import ecs.gridFields.CostCentreCombo;
	import ecs.gridFields.GLAccountInput;
	import ecs.gridFields.ProjectInput;
	import ecs.gridFields.ItemCatCombo;
	
	//CPR item (used in data grid)
	public class CPRItem
	{
		
		public var amount:String = "";						//Amount
		public var currency:String= "";
		public var currencyEditable:Boolean = true;	
		public var currencyStyleName:String = "";					
		public var costCentre:String= "";
		public var itemCategory:String= "";
		public var project:String= "";
		public var GLAccount:String= "";
		public var deleteFlag:Boolean=false;				//Delete this line (to delete event is triggered, this field is checked)
		public var document:String;
		public var year:String;
		public var index:int;
		public var amountEditable:Boolean=true;				//Amount is editable field
		public var costCentreEditable:Boolean=true;			
		public var itemCategoryEditable:Boolean=true;
		public var projectEditable:Boolean=true;
		public var GLAccountEditable:Boolean=true;
		public var amountStyleName:String="";				//Style for Amount field - e.g. disabled
		public var costCentreStyleName:String="";			
		public var itemCategoryStyleName:String="";
		public var projectStyleName:String="";
		public var GLAccountStyleName:String="";		
		public var receiveFocus:Boolean;
		public var amountRenderer:AmountInput;				// Item renderes
		public var costCentreRenderer:CostCentreCombo;
		public var GLRenderer:GLAccountInput;
		public var projectRenderer:ProjectInput;
		public var itemCategoryRenderer:ItemCatCombo;
	}
}