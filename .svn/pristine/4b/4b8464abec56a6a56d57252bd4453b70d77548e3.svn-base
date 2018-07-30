// ActionScript file
/** Supports Cross Domain access to Web Services
 * 
 *  Methods: 
 *  loadCrossPolicyFile(event:Object = ""):void
 *     Loads a cross domain policy file
 *  getHost(url:String):String
 *     Returns the host part of a url
 */



	import flash.system.Security;
	import mx.rpc.soap.LoadEvent;
	
	public var SecurityLoaded:Array = [];


    public function loadCrossPolicyFile(event:Object = ""):void
	{
		var loadEvent:LoadEvent = event as LoadEvent;
		var url:String;
		var host_url:String;
		var xml_url:String;
		var wsdl_host_url:String;
		var services:Object;
		var i1:int;
		if (loadEvent)
		{
			url = loadEvent.target.endpointURI;
			host_url = getHost(url);
			wsdl_host_url = getHost(loadEvent.target.wsdl);		
			// If we're in the same domain, we don't need to load crossdomain
			if (wsdl_host_url == host_url)
				return;
			
			// Don't load a crossdomain more than once
			// Check if we have already loaded it			
			i1 = SecurityLoaded.lastIndexOf(host_url);
			if (i1 == -1) // Not found, so load it
			{
				xml_url = host_url + "zni/crossdomain";
				Security.loadPolicyFile(xml_url);
				SecurityLoaded.push(new String(host_url));
				
			}	
		}	
	}
	
	// Returns the host part of a url (e.g. http://www.somethihng.org:8080/ )
	private function getHost(url:String):String
	{
			var host_url:String;
			var i1:int = url.indexOf("//");
			if (i1 == -1) i1 = 0;
			var i2:int = url.indexOf("/", i1 + 2);
			host_url = url.substring(0, i2 + 1);
			return host_url;
	}