private const LINEAGE:String="1";											//Lineage item category
private const PICTURES:String="2";											//pictures item category
public const CREATE:String="1";												//mode: create
public const CHANGE:String="2";												//mode:change
public const DISPLAY:String="3";											//mode:display
private const DONTKNOW:String="DONTKNOW";									//Contract: DONTKNOW
private const MESSAGE_TITLE:String="CPR Entry";								//Message box title
private const HIDDEN:String="H";											//Field is hidden (page numbers)
private const MANDATORY:String="M";											//Field is mandatory (page numbers)
private const STATUS_VALIDATED:String="2";									//ECS status - validated
private const STATUS_APPROVED:String="3";									//ECS status - approved
private const STATUS_POSTED:String="5";										//ECS status - posted
private const AGENCY:String="A";											//Contributor type agency
private const FREELANCE:String="F";											//Contributor type freelance
private const SO_LAST20:String = "last20";                    			    // Shared object identiier for last 20 contribtors
private const SUPPRESS_SAVE_MESSAGE:String = 'SAVM';           				// User parameter to suppress the message shown after save

////////////////////////////////////////
// Constants for connecting to SAP 
////////////////////////////////////////
//private const DEV_SERVER:String = "http://sapr3d.ni.ad.newsint:8080";		//URL for dev server - no load balancing
private const DEV_SERVER:String = "http://sapd11.ni.ad.newsint:8000";		//URL for dev server - no load balancing
private const UAT_SERVER:String = "http://asapd1.ni.ad.newsint:8021";	    //URL for test server - no load balancing
private const LIVE_SERVER:String = "http://sapr3p.ni.ad.newsint:80";
//private const UAT_SERVER:String = "http://saptest1.ni.ad.newsint";	        //URL for test server - load balancing

// Note - If we want to test without load balancing, specify the specific server, and
//   specify the http port after the url (e.g. 8001 for saptest1, 8080 for sapr3d).
// If don't specify a port, it will default to 80, which is the web dispatcher, which will 
// test with load balancing.
private const SAP_CLIENT:String = "sap-client=007&";						//Client for dev
//private const WSDL_SICF_PREFIX:String = "/sap/bc/soap/wsdl11?"; 			//WSDL path
private const WSDL_SICF_PREFIX:String = "/zni/bc/soap/wsdl11?"; 			//WSDL path


// Module swf files to load
public const SWFMODULE_CONTRIB_SEARCH:String =  "/sap/bc/bsp/sap/zecs_cpr/ContributorSearch.swf";
public const SWFMODULE_CONTRIB_SEARCH_LOCAL:String =  "ContributorSearch.swf";
public const SWFMODULE_COMM_HIST:String = "/sap/bc/bsp/sap/zecs_generic/CommunicationHistory.swf";
