// ActionScript file

	import mx.rpc.events.FaultEvent;
	import mx.events.CloseEvent;
	import mx.controls.Alert;
	import flash.external.*;
 	import mx.rpc.events.ResultEvent;
 	import mx.managers.PopUpManager;
	import mx.rpc.events.AbstractEvent; 	
	import mx.styles.StyleManager;
    import mx.events.ValidationResultEvent;
	import mx.core.UIComponent;
	import mx.utils.StringUtil;
	import ECS_Components_QAS.QAS_Component;
    import ECS_Components_QAS.AddressEvent;    		
	import mx.managers.CursorManager;
	import mx.collections.ArrayCollection;
    import mx.events.ListEvent;
  	import mx.core.Application;
  	import flash.events.MouseEvent;
	      
	public const cView: String = 'V';
	public const cEdit: String = 'E';
	public const cNew: String = 'N';
	public const cViewOnly: String = '0';	
	public const cGetDetail: String = 'V';
	public const cFull: String = 'F';       // See r/3 function module Z_ECS_CONTRIB_INIT_DATA
	public const cPartial: String = 'P';	// + transaction SU01 user group e.g. ACCOUNTS PAY => FULL
	public const cNone:String = '0';	
	
	
	public const cGetContributor: String = 'GetContributor';	
	public const cGetContributorRecentCPRs: String = 'GetContributorCPRs';
	public const cGetNewContribFromCPR:String = 'GetContribFromCPR';
	public const cInitLoad: String = 'Init';
	public const cSearchContributor:String = 'SearchCon';
	public const cSave: String = 'Save';	
	public const cIBANFromBank: String = 'IBAN';	
	public const cBankFromIBAN: String = 'Bank';		
	public const cVATNo:String = 'VATno';
	public const cAddress: String = 'Address';		
	public const cBankAddress:String = 'BankAddress';
	public const cPrompt:String = "Please choose...";
	public const cNewContributor:String = "NEW Contributor";
	public const cUnsavedDataWarning:String = "Unsaved data will be lost.  Continue?"
	public const cDefaultPayTerms:String = "Z30N";
	public const cBankErrorTitle:String = "Bank Details";
	public const cDefaultTitle:String = "Contributor Detail";
	public const cBACS:String =	"B";
	public const cWorldCheque:String = "U";	
	public const cConSearchChooseError:String = "Please choose a line and click 'Choose' or double click on a line";
	public const cWarning:String = "Warning";
	public const cAuthError:String = "Authorisation Error";

	
	[Bindable]
	public var ServerTripMode: String;
		
	[Bindable]
	public var CurrentConNr: String;
	
	[Bindable]		
	public var Title:String = cDefaultTitle;

	[Bindable]	
	public var bEnableFields:Boolean;
	
	[Bindable]	
	public var bEnablePartialRightsFields:Boolean;	
	
	[Bindable]	
	public var bEnableServerTripButtons:Boolean;

	[Bindable]	
	public var bEnableSaveButton:Boolean;

	[Bindable]	
	public var bEnableDispChanButton:Boolean;
		
	[Bindable]
	public var bPaymToVisible:Boolean;

	[Bindable]
	public var xmlConDetails: XML;
	
	[Bindable]
	public var xmlConCPRs:XML;    		 // Recent CPRs for this contributor
	
	[Bindable]
	public var xmlLastConDetails:XML;
	
	[Bindable]										
	public var ContactTypes: Array;

	[Bindable]
 	public var xmlInitData: XML;

	[Bindable]
	public var deleteFlag:String;

	[Bindable]
	public var postBlock:String;

	[Bindable]
	public var confirmDetails:String;
	
	[Bindable]
	public var NoEmailFlag:String;	 

	[Bindable]
	public var NoContactFlag:String;	 

	[Bindable]
	public var CheckDuplicates:String;

	[Bindable]
	public var CPRforNewContrib:String;
	
	[Bindable]
	public var bShowButtons:Boolean = true;

	[Bindable]
	public var bVendorTypeVisible:Boolean;  // sreddy IC#00145795
	[Bindable]
	public var bnoemailvisible:Boolean;  // sreddy IC#00145795
	[Bindable]
	public var govtflag:String;  // sreddy IC#00145795
	[Bindable]
	public var pisetflag:String;  // sreddy IC#00180440	
	[Bindable]
	public var setsaflag:String; // sreddy IC#0000223665	
	[Bindable]	
	public var bEnablevendortype:Boolean;  // sreddy IC#00145795
	[Bindable]
	public var bEnableprivate:Boolean;  // sreddy IC#00223669
	[Bindable]
	public var bEnableagent:Boolean;  // sreddy IC#0000223665	
    public var FocusComponent:UIComponent;
	public var dataChanged:String;
	public var dbUpdated:String = "";			
	public var displayMode:String;	
	public var bIBANInvalid:Boolean;
	public var bBankInvalid:Boolean;	
	public var bVatNoInvalid:Boolean;	
	public var popup:QAS_Component;
	public var ConList:ContribList;
	public var aCPRs:ArrayCollection;
	public var editRights:String;
	public var createRights:String;
	public var viewRights:String;	
	public var chequeRights:String;	
	public var firsttime:Boolean; //sreddy IC279394
	public var nogovtflag:String; //sreddy IC279394

    /* 
      For Communication History tab 
    */
	[Bindable]	public  var   cpr:String="";				// CPR Number
	[Bindable]	public  var   year:String="";				// Year
	[Bindable]	public  var   company:String="";			// Company
	[Bindable]	private var   sentDate1:String;				// Email 1 to contributor sent date (contract)
	[Bindable]	private var   sentDate2:String;				// Email 2 to contributor sent date (payment details)
	[Bindable]	private var   sentTime1:String;				// Time 1
	[Bindable]	private var   sentTime2:String;				// Time 2
	[Bindable]	private var   sentCPR1:String;				// CPR 1
	[Bindable]	private var   viewEmail1:Boolean;			// Enable View email 1
	[Bindable]	private var   viewEmail2:Boolean;			// Enable View email 2		
            	private const STATUS_VALIDATED:String="2";	// ECS status - validated
                private const STATUS_POSTED:String="5";		// ECS status - posted

	