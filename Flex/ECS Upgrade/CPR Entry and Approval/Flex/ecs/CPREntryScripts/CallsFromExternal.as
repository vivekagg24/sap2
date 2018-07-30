/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	CallsFromExternal.as - calls from the html page to the flex app
*/	

/*
	updateContributorNumber
		When a new contributor has been saved during validation of a stage payment (based
		on new contributor details entered by the comissioning editor) 
		update the CPR entry screen with the new contributor
	
	loadNewCPR
		When this application is called from SAP, to save us repeatedly reloading the application,
		this function can be called to load a new CPR. All existing data is lost, and the user is not
		prompted to save their data.	
		
*/
import mx.managers.SystemManager;
import mx.managers.PopUpManager;
import mx.managers.FocusManager;
import mx.core.Application;
import flash.display.DisplayObject;
import mx.core.UIComponent;
import mx.managers.IFocusManagerContainer;
import ecs.generalClasses.CPRItem;
import ecs.generalClasses.CPRKey;



public function updateContributorNumber(lifnr:String):void{
	txtContributor.text=lifnr;
	gotContracts = false;
	getContributorDetails(false);
	if(lifnr!="")chkNewContributor.selected=false;
	setNewContributorFlag();	
    getContributorDetails(false);
}



public function loadNewCPR(_cpr:String, _year:String, _company:String, _mode:String):void
{	
	if (applicationLoaded)
	{
		//trace("Load new cpr " + _cpr + " - " + _year);
		
		// Disable the application
		this.enabled=false;	
		
		// Remove any active popups
		removeAllPopups();	
		
		// Set Gobal variables
		var old_MODE:String = MODE;
		
		cpr = _cpr;
		year = _year;
		company = _company;
		MODE = _mode;
		
		// Set up screen
		if (old_MODE != MODE)
		{
			switch (MODE)
			{
				case CREATE:
					if (initXml && initXml.EX_ALLOW_POST1)
					{
						if (initXml.EX_ALLOW_POST1=="X") allowPost1=true;
						if (initXml.EX_ALLOW_POST2=="X") allowPost2=true;
						if (initXml.EX_ALLOW_POST3=="X") allowPost3=true;
					}	
					applicationEditable=true;
					textInputStyle="enabled";
					comboStyleName="";				
					setUpScreen();
					setToolBar();
					openUpApplication();
					break;
				case CHANGE:
				    applicationEditable=true;				
					textInputStyle="";
					comboStyleName="";
					setUpScreen();
					setToolBar();
					openUpApplication();
					break;
				case DISPLAY:
					applicationEditable=false;
	 				heldFieldEditable=false;
	 				setUpScreen();
	 				setToolBar();
	 				btnPrint.enabled=true;
	 				break;
			}
		}
		initXml = new XML(wsAllBusyCursor.Z_ECS_INITIALISE_CPR_SCREEN.lastResult);		
		resetApplication();
		//reset data changed flag
	    setDataChanged(false,false);		
	}
	else // We haven't initalized the program yet, so don't load a CPR yet	
	{
		// Remember this CPR and load it once the program is initialized
		cprToLoadAfterInitialization = new CPRKey;
		cprToLoadAfterInitialization.company_code = _company;
		cprToLoadAfterInitialization.docNo = _cpr;
		cprToLoadAfterInitialization.year = _year;
		cprToLoadAfterInitialization.access_mode = _mode;
		
		// This function is called again at the end of the initDataCallBack() method
		
	}
	
}


private function removeAllPopups():void 
{
	trace ("begin removing popups");
	for each (var obj:Object in messageWindows)
	{
		if (obj.hasOwnProperty("handleClose"))
			obj.handleClose();	
	}
	messageWindows = [];
	
	
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
			
			
			
			// If its a popup, get rid of it, as long as getting rid of it wouldn't close this application
			if (popup && popup.isPopUp)
			{
				// Make sure that we aren't getting rid a component that parents this application
				var popupIsInParentTree:Boolean = false;
				var componentInTree:UIComponent = this;
				while (componentInTree != null && popupIsInParentTree == false) // Loop up the heirarchy
				{
					if (componentInTree == this)
					{
						popupIsInParentTree = true;
					}
					else // Go up the tree
					{
						componentInTree = componentInTree.parent as UIComponent; // We're only interested in the parent if it is also a UIComponent
					}	
				}
				
				if (!popupIsInParentTree) // We know its safe to get rid of this popup
				{
					trace("removing " + popup.id);
					PopUpManager.removePopUp(popup);
					popup.visible = false;
					if (popup.focusManager)
						popup.focusManager.deactivate();
					systemManager.removeFocusManager(popup as IFocusManagerContainer);					
				}
			}		
		}
	}
	

	if (this.focusManager)
	{
		this.focusManager.activate();
	}
	

}
