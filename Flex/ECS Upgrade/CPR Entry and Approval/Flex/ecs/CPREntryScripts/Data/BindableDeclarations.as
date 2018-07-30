// Bindable data declarations
	[Bindable]
	public var MODE:String;								//Display mode
	[Bindable]
	public var wsdlRoot:String="";						//WSDL path
	[Bindable]
	public var formIsvalid:Boolean=true;				//Data on form is valid flag
	[Bindable]
	public var textInputStyle:String="";				//Style name for textinputs		
	[Bindable]
	public var comboStyleName:String="";				//Style name for comboboxes
	[Bindable]			
	public var cpr:String="";							//CPR Number
	[Bindable]
	public var year:String="";							//Year
	[Bindable]
	public var company:String="";						//Company
	[Bindable]
	public var applicationEditable:Boolean=true;		//Application - global editable flag
  	[Bindable]
  	public var initXml:XML;								//Initialization XML - cost centres, GL accounts etc.
  	[Bindable]	
  	private var itemsXML:XML;							//Items XML (actually XML from ZECS_GET_CPR
  	[Bindable]
  	public var CPRHeader:XML;							//CPR header data
    [Bindable]
    private var CPRItems:Array;						 	//CPR Items : array of CPR Item
    [Bindable]
    public var itemCategories:Array;					//Item categories - for publication
    [Bindable]
    public var costCentres:Array;						//Cost centres - for publication
    [Bindable]
    public var costCentresWithAll:Array;				//Cost centres - for publication, includes an "all" option
    [Bindable]
    private var publications:Array;						//User's publications
    [Bindable]
    private var specialPaymentTypes:Array;				//Special payment types
    [Bindable]
    public var contributorDetails:XML;					//Contributor details (from Z_ECS_CPR_GET_CONTRIBUTOR_DET)
    [Bindable]
    private var contributorType:String;					//Contributor type description		
	[Bindable]
	private var totalAmount:String = "";				//Total Amount (gross)
	[Bindable]
	private var totalNet:String = "";					//Total Amount (net)
	[Bindable]
	private var VATAmount:String = "";					//VAT amount
	[Bindable]
	private var contributorCurrency: String = "";		//Contributor's currency
	[Bindable]	
	private var cprCurrency: String = "GBP";	       	 //CPR Currency currency	
	[Bindable]
	public var contributorName:String="";				//Contributor's name
	[Bindable]
	private var contributorCPRs:XML; 					//Recent CPRS for the contributor
	[Bindable]
	public var currencies:Array;						//Currencies
	[Bindable]
	public var glAccounts:XMLList;						//GL accounts for publication
	[Bindable]
	private var postingDate:String;						//Posting date for FI document
	[Bindable]
	private var entryDate:String;						//CPR Entry date
	[Bindable]
	private var firstCostCentre:String;					//First cost centre in items
	[Bindable]
	private var publicationDate:String;					//Publication date
	[Bindable]
	public var doublePayments:XMLList;					//Potential double payments list
	[Bindable]
	private var contractList:Array;						//Contracts
	[Bindable]
	private var contractReasonVisible:Boolean=false;	//Contract DONT KNOW reason visible
	[Bindable]
	private var saveButtonStyle:String = "button";		//Style for the save buttons
	[Bindable]
	private var contributorNumberError:Boolean = false;	//Error with the contributor number
	[Bindable]
	public var allowNewContributor:Boolean = false;		//Allow new contributor (cutdown entry)
	[Bindable]
	public var newContributor:Boolean=false;			//new contributor flag
	[Bindable]
	public var showDueDate:Boolean=false;				//Show the payment due date
	[Bindable]
	private var pageNumbersRequired:Boolean=true;		//page numbers are required
	[Bindable]
	private var sentDate1:String;						//Email 1 to contributor sent date (contract)
	[Bindable]
	private var sentDate2:String;						//Email 2 to contributor sent date (payment details)
	[Bindable]
	private var sentTime1:String;
	[Bindable]
	private var sentTime2:String;
	[Bindable]
	private var viewEmail1:Boolean;						//Enable View email 1
	[Bindable]
	private var viewEmail2:Boolean;						//Enable View email 2		
	[Bindable]
	private var heldAllowed:Boolean=true;				//Held flag is allowed
	[Bindable]
	private var last20ForDropDown:Array;				//Last 20 contributors for recent history (TextInputPlus)
	[Bindable]
	private var last20NamesDropDown:Array;				//Last 20 contributor names for recent history (TextInputPlus)
	[Bindable]
	public var recentProjects:Array;					//Projects for recent history (TextInputPlus)
	[Bindable]
	public var recentGLAccounts:Array;					//GL accounts for recent history (TextInputPlus)
	[Bindable]
	private var aliasVisible:Boolean=true;				//Alias field is visible
	[Bindable]
	private var name2Label:String="Name 2";				//name 2 label
	[Bindable]
	private var name2:String="";						//Name 2 text
	[Bindable]
	public var urgentEditable:Boolean=true;				//Urgent checkbox and reason - editable flag
	[Bindable]
	public var allowedSaves:ArrayCollection;            // Allowed save buttons
	[Bindable]
	public var isFinanceUser:Boolean = false;           // User is a finance (accounts payable) user (i.e. Peterborough)      
	[Bindable]
	public var saveMesageSuppressed:MessageSuppression = new MessageSuppression(); // Indicator - is save confirmation message supressed?
	[Bindable]
	public var lastRearchRepeatable:Boolean;           // Flag - can we repeat the last contributor search - determines if "repeat last search" button is enabled