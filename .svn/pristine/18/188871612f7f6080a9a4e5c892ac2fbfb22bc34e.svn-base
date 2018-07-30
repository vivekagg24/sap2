/*	
Application: CPR Entry
Author: 	 DJ McNamara 
Date:		 March 2007

	Messages.as
		Handle messages to the user/ prompts
		
	confirmDelete
	showMessage
	contributorWarnings - warnings about a contributor
*/
import ecs.components.Message;
import ecs.components.SuppressableMessage;
import ecs.generalClasses.MessageSuppression;
import mx.managers.IFocusManagerComponent;
import mx.core.IUIComponent;
import flash.display.DisplayObject;


private function confirmDelete():void{
 	
 	var confirmWindow:Confirm = Confirm(PopUpManager.createPopUp(this, Confirm, true));
	confirmWindow.question="Please confirm that you wish to delete this payment."
	confirmWindow.addEventListener("selectedYes", deleteCPR);
	confirmWindow.defaultButtonS = "no";
	confirmWindow.trueParentApp = this;

 }
 	
private function showMessage(message:String, error:Boolean, setFocusField:DisplayObject=null, raiseEvent:String="", suppression:MessageSuppression=null):Message{
	application.focusManager.deactivate();
	var messageWindow:Message;
	
	// Get ride of the info message
	if (message != infoMessage_message)
		clearInfoMessage();
	
	
	// Is it a supressable message?
	if (suppression)
	{
		if (suppression.suppression)
		{ // Message supresseed, so just set focus, dispatch the event, and show an info message
			
			// Set focus
			if (setFocusField)
			{
				(setFocusField as IFocusManagerComponent).setFocus();
				if (setFocusField.hasOwnProperty("editable") && (setFocusField as Object).editable == false) // If its not editable, tab to the first field that is
				{
					var focNext:IFocusManagerComponent = focusManager.getNextFocusManagerComponent();
					if (focNext) focNext.setFocus();				
				}				
			}
			
			// Raise event
			if (raiseEvent.length > 0)
			{
				dispatchEvent(new Event(raiseEvent));
			}
			
			// Show info message (not a popup)
			showInfoMessage(message, error, setFocusField, raiseEvent, suppression);			
			return null;
		}
		else //Not supressed
		{
			messageWindow = SuppressableMessage(PopUpManager.createPopUp(this, SuppressableMessage, true));	
			(messageWindow as SuppressableMessage).suppression = suppression;
		}
		
	}	
	else
	{
		messageWindow = Message(PopUpManager.createPopUp(this, Message, true));	
	}
	
	
	messageWindow.message=message;
	messageWindow.error = error;
	messageWindows.push(messageWindow); // Add this to the list of open message boxes
	focusField=setFocusField;
	focusEvent=raiseEvent;
	
	messageWindow.trueParentApp = this;
	return messageWindow;
} 

private function contributorWarnings():void{
	if (contributorDetails.SPERR!=""|| contributorDetails.ZAHLS!=""){
		//Is there a block on the contributor
		var messageWindow:Message = Message(PopUpManager.createPopUp(this, Message, true));
		messageWindow.trueParentApp = this;
		messageWindow.message="The contributor is blocked for payment. No payment will be made until the block is removed. ";
		messageWindow.error = true;
		messageWindow.trueParentApp = this;
		messageWindows.push(messageWindow); // Add this to the list of open message boxes
		
	}
}

// Variables to remember details for the info message 
private var infoMessage_message:String;
private var infoMessage_error:Boolean;
private var infoMessage_setFocusField:DisplayObject;
private var infoMessage_raiseEvent:String;
private var infoMessage_suppression:MessageSuppression;

// Show a message to the user, but not as a popup
private function showInfoMessage(message:String, error:Boolean, setFocusField:DisplayObject=null, raiseEvent:String="", suppression:MessageSuppression=null):void
{
	var shortMessage:String = message.toString();	
	shortMessage = shortMessage.replace(/\n/, " "); // Replace carriage returns with spaces;	
	lblInfoMessage.text = shortMessage;
	lblInfoMessage.visible = true;	
	lblInfoMessage.invalidateProperties();
	lblInfoMessage.invalidateSize();
	
	efGlowForMessage.play();
	
	// Remember values in case message is clicked on
	infoMessage_message = message;
	infoMessage_error = error;
	infoMessage_setFocusField = setFocusField;
	infoMessage_raiseEvent = raiseEvent;
	infoMessage_suppression = suppression;		
}

// If the user clicks on the event, then we show the popup event;
public function infoMessageClickHandler():void
{
	// First check we have a message;
	if (lblInfoMessage.text.length == 0)
		return;
		
	// Create a suppression object first, so we can open it as a suppressable message, then
	// pass the suppression to it afterward.
	var suppression:MessageSuppression = new MessageSuppression();		
	var message:SuppressableMessage = showMessage(infoMessage_message, infoMessage_error, infoMessage_setFocusField, infoMessage_raiseEvent, suppression) as SuppressableMessage;
	message.suppression = infoMessage_suppression;
}

private function clearInfoMessage():void
{
	lblInfoMessage.text = "";
	infoMessage_message = "";
	infoMessage_error = false;
	infoMessage_setFocusField = null;
	infoMessage_raiseEvent = "";
	infoMessage_suppression = null;		
}
	
  
