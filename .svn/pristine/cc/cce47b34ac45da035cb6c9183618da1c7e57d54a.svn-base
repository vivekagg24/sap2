// ActionScript file

		public const cGetClaims: String = 'GetClaims';
		public const cInitLoad: String = 'Init';
		public const cDay: String = 'Day';
		public const cDate: String = 'Date';
		public const cShiftNo: String = 'ShiftNo';
		public const cTime: String = 'Time';
		public const cRate:String = 'Rate';
		public const cProjcode:String = 'Projcode';
		public const cSave: String = 'S';
		public const cApprove: String = 'A';
		public const cReject: String = 'R';
		public const cSelect: String = 'Select';
		public const cSubmit: String = 'Submit';
		public const cErrorTitle:String = 'Claim Edit';				
		public const cDefaultTitle:String = "Claim Edit";        		
		public const cRejectStatus:String = '99';
		public const cApproved:String = '05';
		public const cWageTypes:String = 'WageTypes';
		public const cPrompt:String = 'Please choose...';	
		public const c_dev_server:String = "http://sapd11.ni.ad.newsint:8000";
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
    	import mx.messaging.channels.RTMPChannel;
		import mx.managers.PopUpManager;
 		import mx.collections.ArrayCollection;
        import mx.events.ListEvent;
     	import mx.rpc.events.FaultEvent;
     	import mx.utils.ArrayUtil;
		import flash.events.EventDispatcher;
		import mx.validators.*;
		import CMS.*; 
		import CMS.generalClasses.*;
   		import CMS.gridFields.*;
		import flash.utils.ByteArray;
		import mx.managers.CursorManager;

		[Bindable]
		public var Title:String;		

		[Bindable]
		public var arrayValues:Array;

		[Bindable]
		public var CCidx:int;

        [Bindable]
		public var aryCostcenters:Array;

        [Bindable]
		public var aOrigWageTypes:Array;
		
        [Bindable]
		public var aNewWageTypes:Array;		
			
		[Bindable]
		public var bEnableButtons:Boolean = true;

		[Bindable]
	 	public var xmlalldata: XML;

  	    [Bindable]
  		public var initXml:XML;
  		
  		[Bindable]
  		private var itemsXML:XML;
  		
        [Bindable]
        public var ClaimItems:Array; 
        public var OrigClaimItems:Array;
        public var PreSaveClaimItems:Array;
        
		[Bindable]
		private var allEditable:Boolean = false;

		[Bindable]
        public var xmlday: XML;
        public var xmltime: XML;
        public var oRequestCall:Object;    		

		[Bindable]
	 	public var xmlshiftno: XML;

		[Bindable]
	 	public var xmlrate: XML;

		[Bindable]
        public var xmlprojcode: XML;

		[Bindable]
        public var xmlMaintain: XML;
        		
		[Bindable]		
		public var CurrentPerNr:String;

		[Bindable]		
		public var CasualName:String;

		public var ErrorExists:Boolean;		
		
		public var MessageString:String;

		public var ClaimLine:ApprovalTree;
	
		[Bindable]
		public var exCostCentre:String;
		
		[Bindable]
		public var exStartTime:String;
	
		[Bindable]
		public var PSkey:Object;

		[Bindable]
		public var wsdl_prefix:String;	
				