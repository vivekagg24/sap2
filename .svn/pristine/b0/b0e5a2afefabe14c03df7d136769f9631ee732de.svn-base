// ActionScript file shared by also newprint screen
// Handles processing 

	import visualComponents.*;
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.events.ResultEvent;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import mx.events.DynamicEvent;
	import mx.managers.PopUpManager; 
	import flash.events.MouseEvent;
	import mx.events.CloseEvent;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.events.DataGridEvent;
	import mx.collections.XMLListCollection;
	import mx.managers.CursorManager;
	import mx.core.Application;
	import mx.rpc.soap.LoadEvent;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.rpc.soap.WebService;
	import mx.rpc.soap.Operation;
	
	// constants
	public const c_test_server:String = "http://vectci";
	public const c_dev_server:String = "http://vecdci.ds.newsint:8000";
	public const c_sap_client:String = "sap-client=007&";
	public const c_wsdl_sicf_prefix:String = "/sap/bc/soap/wsdl11?"; 

	[Bindable]
	public var wsdl_prefix:String;

	[Bindable]
	public var bEnableButtons:Boolean = true;

	// Array of result messages
	//private var resultMessages:Array;
	//private var errorMessages:Array;

	// plant combo box
	[Bindable]
	private var plantsList:Array;
					
	[Bindable]
	public var SelectedPlant:String;
	public var passedPlant:String;

	[Bindable]
	public var plants:XMLList;

	[Bindable]
	public var lastPostingDate:Date = new Date();	

	public function init():void {
		// Called at the "init" event of the application
		// We need to tell the web services where to get their WSDls from.			
		if (Security.sandboxType == Security.REMOTE)  // Remote remotely in a BSP
			wsdl_prefix = c_wsdl_sicf_prefix + "services=";
		else  // Running locally
			wsdl_prefix = c_dev_server       // Which SAP server should we connect to?
            	  	    + c_wsdl_sicf_prefix
             		    + c_sap_client       // Which SAP client should we connect to?
            	    	+ "services=" ;  
	}

	// display error message if web service errors
	public function webServiceFault(event:Event,service:String):void {
		var alert_text:String = 'Error with web service ' + service;
		Alert.show(alert_text);
	} 

	public function creationComplete():void {		
		// Called at the "creationComplete" event of the application
		getPlants();
	}
	
	// get the plant a user is authorised to receipt
	public function getPlants():void {
    	// This function is run when the application is first opened	
		wsGetPlants.ZNP_PLANT_AUTH_CHECK.send();
  
  		// clear the output messages
	   	//resultMessages = new Array();
 		//errorMessages = new Array();
	}
	
	// set the plant drop list to selected value
	public function setCombo():void {
		comboPlant.setFocus();
		
		if(comboPlant.selectedItem != null){
			SelectedPlant = comboPlant.selectedItem.data;						
		}else{
			SelectedPlant = passedPlant;			
		}
		doRefresh();				
	}

	// set the plant to be returned when calling getDeliveries
	private function SelectPlant():void{
        for (var i:int = 0; i< plantsList.length; i++){	      	
        	if(plantsList[i].data == SelectedPlant){
        		comboPlant.selectedIndex = i;
        		return;
        	}
        }
    	comboPlant.selectedIndex = 0;
    	SelectedPlant = plantsList[0].data;
	}
	
	// set the plant drop list of sites the user is authorised to receipt
	private function PopulatePlant(plantXML:Object):void{
		var plantsXML:XMLList = plantXML as XMLList;
        var xmlPlantLength:int  = plantsXML.length();
        plantsList = new Array();

        var i:Number=0;
        for (i=0; i< xmlPlantLength; i++){
            var value:String = plantsXML[i].WERKS.toString()
            	+ '-' + plantsXML[i].NAME1.toString();
            var key:String = plantsXML[i].WERKS.toString();                         
            plantsList.push({label: value, data: key});
		}
    }
    
	// format the date into SAP
	private function DateToSAPFormat(sDate:String):String{
		var SAPDate:String;
		if (sDate.substr(4,1) == '-' && sDate.substr(7,1) == '-') {
			SAPDate = sDate.substr(0,4) + sDate.substr(5,2) + sDate.substr(8,2);
		} else {
			SAPDate = sDate.substr(6,4) + sDate.substr(3,2) + sDate.substr(0,2) 
		}
		return SAPDate;	
	}
	
	// format the time into SAP
	private function TimeToSAPFormat(sTime:String):String{
		var SAPTime:String = sTime.substr(0,2) + sTime.substr(3,2) + '00';
		return SAPTime;	
	}
	
	// format date for output (DD.MM.YYYY)
    private function dateLabel(item:Object, column:DataGridColumn):String{
 		var sMonth:String;
		var sYear:String;
		var sDay:String; 
		var sDate:String;
 		if (item && item[column.dataField].substr(4,1) == '-' && item[column.dataField].substr(7,1) == '-') {
		// extract the individual values
			sYear = item[column.dataField].substr(0,4);
			sMonth = item[column.dataField].substr(5,2);
			sDay = item[column.dataField].substr(8,2);
			sDate = sDay + '.' + sMonth + '.' + sYear;
		} else {
			sDate = item[column.dataField].toString();
		} 
		return sDate; 
       }		
       
	// generic popup 'Are you sure?' prompt
  	public function onDeleteLine(reverseLine:XML):void{
       	var messagePopup:areYouSurePrompt =  PopUpManager.createPopUp(this, areYouSurePrompt) as areYouSurePrompt;
       	messagePopup.data = reverseLine;
    }        
    
  	public function onShowLineDetail(detailLine:XML):void{
//       	var messagePopup:detailPopup =  PopUpManager.createPopUp(this, areYouSurePrompt) as areYouSurePrompt;
//       	messagePopup.data = detailLine;
		var sComment: String;
		sComment = detailLine.COMMENT_TEXT;
		if (sComment == "") {
			sComment = "None provided";
		}
		Alert.show(sComment, "Comment");
    }        
    
    public function forceSecureWSDL(event:LoadEvent):void
    {
    	var url:String = Application.application.url;
    	var port_url:String ;
    	var found_http:int;
    	url = url.toLocaleLowerCase();
    
        // - Step 1 - Force HTTPS in the returned WSDL
     	if (url.indexOf("https") > -1 )  // If application is HTTPS then all WSDL calls must be HTTPS
    	{
    		for each (var services:Object in event.wsdl.services)
    		{
    			for each (var port:Object in services.ports);
    			{
    				port_url = "";
    				found_http = -1;
    				port_url = (port.endpointURI as String);
    				found_http = port_url.toLocaleLowerCase().indexOf("http:");
    				if (found_http > -1)
    				{
    					port_url = "https" + port_url.substr(found_http + 4, 99999);
    					port.endpointURI = port_url;  					
    				}
    			}
    		}
    		
    		// - Step 2 - Force HTTPS in each Web Service Operation
    		for each (var op:mx.rpc.soap.mxml.Operation in event.target.operations)
    		{
    				port_url = "";
    				found_http = -1;
    				port_url = (op.endpointURI as String);
    				found_http = port_url.toLocaleLowerCase().indexOf("http:");
    				if (found_http > -1)
    				{
    					port_url = "https" + port_url.substr(found_http + 4, 99999);
    					op.endpointURI = port_url;
    									
    				}    			
    		}	
    	}    	
    }
