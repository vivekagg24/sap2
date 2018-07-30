
//Title for message alerts
private const MESSAGE_TITLE_APPROVAL:String="ECS Approval";


	
//WSDL prefix and suffix - local and for deploying to the SAP server
//Local means the file is obtained from the local file system and therefore the application
//does not need to be deployed to the server to be tested
[Bindable]
private var WSDLPrefix:String=""; 	// 
[Bindable]
private var pubid:String = "";		//Publication ID
[Bindable]
private var publications:Array;		//Array of publications the user belongs to
[Bindable]
private var costCentres:Array;		//Array of cost centrs the user belongs to
[Bindable]
private var batches:Array;			//Array of batch numbers (for sel screen)
[Bindable]
private var createdByList:Array;	//Array of user names (for sel screen) - users who entered the payments
[Bindable]
private var deskHeadSel:String;		//Flag - desk head approval
[Bindable]	
private var manEdSel:String;		//Flag - managing editor approval
[Bindable]
private var excludeNotBatchedSel:String;	//Exclude payments not batched
[Bindable]
private var urgentOnlySel:String;	//Flag - select only urgent payments
[Bindable]
private var costCentresXML:XMLList; //XML list of cost centres for selection
[Bindable]
private var managingEditor:Boolean=false;	//Flag - the user is a managing editor
[Bindable]
private var interimDeskHeadOnly:Boolean = false; // Flag, user can't apporve, only interim approve
[Bindable]
private var interimSel:String;    // Flag - Include payments awaiting interim approval only
[Bindable]
private var noInterimSel:String;  // Flag - Exclude payments awaiting interim approval only
[Bindable] 
private var interimNoInterimSel:String;  // Flag - Include both payments awaiting interim approval and payments awaiting approval
[Bindable] 
private var columns:Array = new Array();	//Datagrid columns
[Bindable]
private var batchDate:String = "";	//Batch date (for selection)
[Bindable]
private var runningStandalone:Boolean=false;	//Flag - application is not running as part of CAS
[Bindable]
private var maxParallelProcesses:int=1;			//Number of parallel processes allowed for approval
[Bindable]
private var approvalJobSize:int=0;				// Minimum job size when sending CPRs for approval in blocks, rather than all together
												// A value of 0 indicates that they should be sent all together


//Minimise grid section image
 [Embed(source="images/contract_tree.gif")]
 [Bindable]
 private var contractIcon:Class;
 
 //Maximise grid section image
 [Embed(source="images/expand_tree.gif")]
 [Bindable]
 private var expandIcon:Class;

//Data provider for the grid
[Bindable]
public var dp:ArrayCollection;
[Bindable]
public var itemAreaHeight:int = 510;	//Height of the items area section

//XML returned by web service to get the list
private var reportData:XMLList;
private var getPublications:Boolean = true;	//Flag - get the list of publications when building the sel screen

//Cost centres passed in from CAS
 private var passedCCs:String = "";
 //Currency formatter
private var currFormat:CurrencyFormatter = new CurrencyFormatter();
//Date formatter
private var dateFormat:DateFormatter = new DateFormatter();

//Store of open cost centres nodes in grid (used when redrawing the list)
public var openCostCentres:ArrayCollection;
public var openBatches:ArrayCollection;

public var myRow:int=0;	//Current row user has selected

//Array of selected items from the grid
private var arrSelected:Array = new Array();
//Messages returned from SAP after approval
public var messages:XMLList;

public var indent:Number = 10;	//Indentation (pixels) for each hierachy level

public var cprScreenPreloaded:Boolean; // preload cpr entry swf for speed