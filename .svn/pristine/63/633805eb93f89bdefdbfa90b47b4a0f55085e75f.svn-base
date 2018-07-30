// ActionScript file

		public const cGetClaims: String = 'GetClaims';
		public const cInitLoad: String = 'Init';
		public const cApprove: String = 'A';
		public const cReject: String = 'R';
		public const cSelect: String = 'Select';
		public const cSubmit: String = 'Submit';
		public const cErrorTitle:String = 'Claim Approval';				
		public const cDefaultTitle:String = "Claim Approval";        		
		public const cRejectStatus:String = '99';
		public const cApproved:String = '05';
		public const cPrompt:String = 'Please choose...';	
		public const cExtend:String = 'Extend';			
 		public const c_dev_server:String = "http://sapd11.ni.ad.newsint";
		public const c_sap_client:String = "sap-client=007&";
		public const c_wsdl_sicf_prefix:String = "/zni/bc/soap/wsdl11?"; 
	
		import flash.system.Security;
	 	import mx.core.Application;
	 	import mx.formatters.DateFormatter;
		import mx.controls.Text;
		import mx.rpc.events.ResultEvent;
		import mx.controls.Alert;
		import CMS.Components.DateField1;
    	import mx.collections.XMLListCollection;
		import mx.managers.PopUpManager;
 		import mx.collections.ArrayCollection;
        import mx.events.ListEvent;
        import mx.events.CloseEvent;
     	import mx.rpc.events.FaultEvent;
     	import mx.utils.ArrayUtil;
     	import flash.events.Event;
		import flash.events.EventDispatcher;
		import mx.validators.*;
		import CMS.*; 
		import CMS.generalClasses.*;
   		import CMS.gridFields.*;
		import flash.utils.ByteArray;
		import mx.managers.CursorManager;
		import mx.events.IndexChangedEvent;
		import mx.controls.DataGrid;
		import mx.controls.dataGridClasses.DataGridColumn;
		import CMS.Components.DataGridCheckBox;
		import CMS.generalClasses.DataProviderManager;
		import mx.managers.CursorManagerPriority;
		import mx.managers.CursorManager;
		import mx.core.UIComponent;
		import mx.printing.FlexPrintJob;
		import mx.printing.PrintDataGrid;	
	
		private var dateFormat:DateFormatter = new DateFormatter();
							
	 	[Embed(source="CMS/images/contract_tree.gif")]
	 	[Bindable]	private var contractIcon:Class;
		[Bindable]	private var columns:Array = new Array();
				 	
	 	[Embed(source="CMS/images/expand_tree.gif")]
	 	[Bindable] 	private var expandIcon:Class;
		[Bindable]	private var managingEditor:Boolean=false;	
		[Bindable]	private var deskhead:Boolean=false;	
		
	 	private var passedCCs:String = "";
	 	
		[Bindable]	private var runningStandalone:Boolean;
		[Bindable]	private var runningInCAS:Boolean=true;
		[Bindable]	private var publications:Array;	
		[Bindable]	private var createdByList:Array;
		
		[Bindable]	private var	deskHeadSel:String;
		[Bindable]	private var	manEdSel:String;	
		
		[Bindable]	private var	dhonlySel:String;	
		[Bindable]	private var	dhbothSel:String;
					
		[Bindable]	public var dp:ArrayCollection;
		
		public var myRow:int=0;
		public var messages:XMLList;
			
		[Bindable]	public var itemAreaHeight:int = 625;
		[Bindable]	private var cursorID:Number=0;
	
		private var arrSelected:Array = new Array();

		[Bindable]	public var arrayValues:Array;
		[Bindable]	public var CCidx:int;
        [Bindable]	public var aryCostcenters:Array;
        [Bindable]	public var costCentres:Array;
        [Bindable]	public var costCentresDisplay:Array;
        [Bindable]	public var costCentresDisplayMode:uint;
		[Bindable]	public var bEnableButtons:Boolean = true;
		[Bindable] 	public var xmlalldata: XML;
  	    [Bindable]	public var initXml:XML;
  		
  		[Bindable]	private var itemsXML:XML;
  		
        public var oRequestCall:Object;    		

		[Bindable] public var xmlMaintain: XML;
        		
		public var ErrorExists:Boolean;		
		public var MessageString:String;
		public var RejText:RejectionText;
		public var ClaimEdit:CasualClaim;
		public var XtendCasPopup:ExtCasual;
		
		[Bindable] public var ClaimItems:Array;

		public var FocusComponent:UIComponent;
		
		[Bindable] public var SelectedDept:String;
		
		public var passedDept:String;

		[Bindable] public var wsdl_prefix:String;	
		
		[Bindable] public var employee_from:String;
		[Bindable] public var employee_to:String;	
		protected var suppressMessageOnGetClaims:Boolean = false;	