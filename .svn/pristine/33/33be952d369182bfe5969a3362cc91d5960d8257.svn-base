// Calls from external

import mx.controls.Alert;

/** Call from external wrapper to load new contributor details, either from a CPR or 
 *  from a contributor number
*/
public function updateFromExternal(im_mode:String, im_lifnr:String, im_cpr:String):void
{
	
	// Disable the application
	Application.application.enabled=false;
	
	// Remove any active popups
	removeAllPopups();	
	
	// Set the mode correctly
	switch (im_mode)
	{
		case "1":
			im_mode = cNew;
			break;
		case "2":
			im_mode = cEdit;
			break;
		case "3":
			im_mode = cView;
			break;		
	}

	
	// Check this is a valid display mode
	if (im_mode != cView 
	 && im_mode != cEdit
	 && im_mode != cNew
	 && im_mode != "")     // Mode "" means stay in whatever mode we're in
	 	return;
	
	// Set global data when contributor passed	
	if (im_lifnr && im_lifnr.length > 0)
	{
		tiSearchCon.text = im_lifnr;
		displayMode = im_mode;
		ServerRequest(cGetContributor);	
		ServerRequest(cGetContributorRecentCPRs);	
	}
	else if (im_cpr && im_cpr.length > 0)
	{
		CPRforNewContrib = im_cpr;
		displayMode = im_mode;
		ServerRequest(cGetNewContribFromCPR)
	}
	else 
	{
		displayMode = cView;
	}
	
	
	SetDefaultValues();
	
	//SetAuthorisationRights();				
	
	tiSearchCon.setFocus();
	
	
}


private function removeAllPopups():void 
{
	trace ("begin removing popups");
	// For some reason, we can't use systemManager.popupChildren, as this is empty.
	// We have to go through systemManager.rawChildren and remove any popups
	if (systemManager && systemManager.rawChildren && systemManager.rawChildren.numChildren > 0)
	{
			for (var i:int = 0; i <  systemManager.rawChildren.numChildren; i++)
		{
			var child:Object = systemManager.rawChildren.getChildAt(i);
			trace (child.toString());		
			var popup:UIComponent;
			if (child) {
				popup = child as UIComponent;
			} else continue;
			
			if (popup && popup.isPopUp)
			{
				trace("removing " + popup.id);
				PopUpManager.removePopUp(popup);
				popup.visible = false;
				if (popup.focusManager)
					popup.focusManager.deactivate();			
			}
		
		}
	}
	

	if (application.focusManager)
	{
		Application.application.focusManager.activate();
	}
	

}