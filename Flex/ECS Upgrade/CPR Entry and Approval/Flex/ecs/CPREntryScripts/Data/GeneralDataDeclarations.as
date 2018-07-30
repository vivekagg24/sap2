
import mx.core.IFlexDisplayObject;
import mx.managers.IFocusManagerComponent;
import ecs.generalClasses.CPRKey;

private var inGUI:String="";							//Running in SAP GUI html control
private var applicationLoaded:Boolean = false;			//Application has finished loading (initial data loaded)
private var cprToLoadAfterInitialization:CPRKey;        //Key of CPR to load after application has finished loading
private var invalidGLCodes:int;							//Count of invalid GL Codes
private var invalidProjectCodes:int;					//Count of invalid Project Codes
private var invalidAmounts:int;							//Count of invalid Amount 
private var invalidCostCentres:int;						//Count of invalid Cost Centres
private var allowPost1:Boolean;							//Allow create stage 1
private var allowPost2:Boolean;							//Allow create stage 2
private var allowPost3:Boolean;							//Allow create stage 3 (approved)
private var allowEdit:Boolean;							//Allow edit button
private var allowValidate:Boolean;						//Allow validate button
private var allowDelete:Boolean;						//Allow delete button
private var allowPrint:Boolean;							//Allow cash payment print button
private var allowUrgent:Boolean;						//Allow urgent flag update on ME Approved CPR
private var saveLevel:int;								//Save level 0 (edit), 1 (initial), 2 (validated), 3 (approved)
private var VATRate:Number;								//VAT Rate
public var quickSearchResults:Object;					//Quick Search results
private var bestFitContract:String="";					//Best fit contract
private var invalidPubDate:Boolean=false;				//Publication date is invalid
public var prevContributor:String;						//Previous contributor that we got details for
public var currentItemIndex:int;						//Current item index in array
public var focusField:DisplayObject;					//Field to focus on after showing message
public var focusEvent:String="";						//Focus event to raise after showing message
private var holdData:EntryScreenHoldData;				//Data that the user is "hold"ing or set"ting" on the scren
private var defaultPubDate:String;						//Default publication date
private var pubDateJustChanged:Boolean=false;			//The publication date has just changed 
private var fromUpload:Boolean=false;					//App is being laumched from upload program
private var gotContracts:Boolean=false;					//have already selected the contract list			
private var paymentNotesTxt:String="Payment Notes";     // The string for the payment notes field
private var paymentNotesLongTxt:String = "";            // The actual text - not bindable
private var paymentNotesIcon:Class;                     // The icon for the payment notes field
public var last20Stories:Array = [];                    // Last 20 stories
public var last20Amounts:Array = [];                    // Last 20 amounts
public var last20PageNos:Array = [];                    // Last 20 page numbers
public var last20PubDates:Array = [];                   // Last 20 publication dates
public var last20OnBehalfOf:Array = [];                 // Last 20 "on behalf of"'s
public var last20ContribRef:Array = [];                 // Last 20 "contributor references"'s
public var last20CostCentres:Array = [];                // Last 20 Cost Centres
public var messageWindows:Array = [];					// Open message popups
public var createScreenInit:XMLList;                    // XML that comes back when you create a payment
public var recentContributorDetails:Array = [];			// Array of XML Objects containing Contributor details from SAP
public var contribSearchPopup:IFlexDisplayObject;       // Contributor Search popup;
public var swfmodule_contrib_search:String;             // Url of Contrib Search module swf
public var lastSearchResults:Object;                    // Results of the last contributor search
private var focusFieldMemory:IFocusManagerComponent;    // Field with focus
private var currencyConversionInProgress:Boolean;       // Are we waiting for SAP to convert a currency