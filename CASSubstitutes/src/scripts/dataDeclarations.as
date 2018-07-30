// ActionScript file
import mx.collections.XMLListCollection;
import mx.core.IUIComponent;
import mx.core.IFlexDisplayObject;


// Constants
public const c_dev_server_R3:String = "http://sapd11.ni.ad.newsint";
public const c_dev_server_Portal:String = "http://sappod.ni.ad.newsint";
public const c_cas_xml_url:String = "/irj/portalapps/CASPortalService/XML/CASConfig.xml";


 // Key globals
 [Bindable]
 public var wsdl_root:String = "";                  // url of web services no SAP R3
 
 [Bindable]
 public var userName:String = "GYORK";              // System username on R3 and Portal
 
 [Bindable]
 public var user_cas_systems:XMLListCollection;     // List of systems the user has access to
 
 public var portal_url:String = "";                 // Root url of portal
 
 public var possibleSubs:XMLListCollection;			// List of possible substitutes
 
// XML Config
public var cas_config:XML;                          // XML object containing CAS information