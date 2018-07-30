// ActionScript file
import mx.collections.XMLListCollection;
import mx.core.IUIComponent;
import mx.core.IFlexDisplayObject;


// Constants
public const c_dev_server_R3:String = "http://sapd11.ni.ad.newsint";
public const c_dev_server_Portal:String = "http://sappod.ni.ad.newsint";public const c_cas_xml_url_R3:String = "/sap/bc/bsp/sap/zcassubstitutes/CASConfig.xml";
public const c_cas_xml_url:String = "/irj/portalapps/CASPortalService/XML/CASConfig.xml";public const c_cas_xml_url_crossdomain:String = "/irj/portalapps/CASPortalService/XML/crossdomain.xml";
public const c_cas_R3_url:String = "/sap/bc/soap/wsdl11?SERVICES=Z_CAS_GET_POSSIBLE_SUBS,Z_CAS_GET_SUBSTITUTES_CURRENT,Z_CAS_MAINTAIN_SUBSTITUTES";

 // Key globals [Bindable] public var messages:XMLList;                       // Messages 
 [Bindable]
 public var wsdl_root:String = "";                  // url of web services no SAP R3
 
 [Bindable]
 public var userName:String = "GYORK";              // System username on R3 and Portal
  [Bindable] public var showPanel:Boolean;                      // SHow the top level panel 
 [Bindable]
 public var user_cas_systems:XMLListCollection;     // List of systems the user has access to  [Bindable] public var user_cas_groups:XMLListCollection;      // List of system-groups the user has access to
 
 public var portal_url:String = "";                 // Root url of portal
  [Bindable] 
 public var possibleSubs:XMLListCollection;			// List of possible substitutes
  public var popUp:IFlexDisplayObject;               // The popup  [Bindable] public var dirtyFlag:Boolean;                      // Data has changed but not saved [Bindable]public var messageTitle:String;					// value for title of message popup box	 
// XML Config
public var cas_config:XML;                          // XML object containing CAS information