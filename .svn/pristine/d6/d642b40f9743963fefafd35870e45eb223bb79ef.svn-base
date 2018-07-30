package ni.components
/**
* DateInputPlus.as
 * 
 * Component extends the standard date input component.
 * The additional functionality is to provide a listbox that contains an array of name value pairs.
 * As the user types the listbox appears. The selected index ion the list changes as values are exluded by 
 * pattern matching.
 * The listbox disappears if no possible values match the user input.
 * 
 * If the user presses ENTER when the listbox is displayed the selected item in the list is transferred to 
 * the text field.
 * 
 * DOWN ARROW/ BACKSPACE trigger the list box.
 * DOWN ARROW and UP ARROW scroll through the list items
*/
{
	import mx.controls.TextInput;
	import mx.controls.DateField;
	import mx.controls.List;
	import mx.core.IFlexDisplayObject;
	import mx.managers.PopUpManager;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import mx.events.ListEvent;
	import mx.controls.scrollClasses.*;
	import flash.utils.*;
	import mx.events.ValidationResultEvent;
	import mx.styles.*;
	import mx.events.DynamicEvent;
	import mx.events.CalendarLayoutChangeEvent;
	
	// Event triggered when user selects an item, either with the mouse, or by hitting Enter
	[Event(name="committingChange", type="flash.events.Event")]
	
	// Event triggered when user saves and a new object is added to the "Last 20" list
	[Event(name="objectAddedToLast20")]
	
		
	public class DateInputPlus extends DateField
	{
		public static const COMMITTING_CHANGE:String = "committingChange";
		public static const OBJECT_ADDED_TO_LAST20:String = "objectAddedToLast20";
		
		private var showList:Boolean;						//List is in view
		private var lstOptions:List = new List();			//Dropdown list
		protected static var _instances:Array = [];          //Array of all TextInputPluses
		public var recentEntries:Array;						//Data provider for list
		public var listWidth:int = 100;						//Default width of list
		public var listHeight:int = 200;					//Default height of list
		
		// Flag - Do we automatically update the Recent Payments List with the most
		// recently chosen entry? Default is TRUE.
		public var autoUpdateRecentList:Boolean = true;
		
		
		public function DateInputPlus(){
        	super();
        	_instances.push(this);
        	this.addEventListener(Event.REMOVED, onRemove);			
		}
		
		//Focus out of field - hide list
		override protected function focusOutHandler(event:FocusEvent):void{
			super.focusOutHandler(event);
			if (event.relatedObject != this.lstOptions)
				hideList(event);			
		}
		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			super.keyDownHandler(event);
			if (event.keyCode == Keyboard.TAB)
			{
				trace("Tab pressed in " + this.id + " at " + getTimer().toString() );
			}
		}
		
		override protected function keyUpHandler (event:KeyboardEvent):void{	
			
        	handleKeyUp(event);
		}	
		private function hideList(event:Event=null):void{
			showList=false;
			PopUpManager.removePopUp(lstOptions);
			
		}
		//List can be shown by calling this method from applicaiton code
		public function showDropdown():void{
			handleInput(null);
		}
		
		//Handle input into the text field - show list, scroll to matching item etc.
		private function handleInput(event:Event):void{			
			//Don't show if no values	
			if (recentEntries==null || recentEntries.length==0) return;
			
			var label:String;			//Description for item in list
			var textUpper:String = text.toLocaleUpperCase();
			var textLength:int = text.length;
			var i:int=0;
			var match:Boolean;			//Flag indicating there is still a match in the list
			var addList:Boolean = false;        // Flag - add this list?
			
			if (!showList){			//List not showing
			
				showList = true;
				addList = true;  // Set this to "true" for now, might set it back to false if no matches
			} 
			
			if (textLength > 0)
			{
				
				//Go through items and stop at first match. 
				for each(var item:Object in recentEntries)
				{
					label = item.label.toLocaleUpperCase();
					//If user value == list value hide the the list
					if (label==textUpper)
					{
						lstOptions.visible = false;
						addList = false; 
						return;
					}
					//If match - set the selected index on the list
					//***if (label.indexOf(textUpper,0)==0) {
					if (label.substring(0, textLength) == textUpper || item.extra.substring(0, textLength) == textUpper)
					{
						lstOptions.selectedIndex = i;
						match=true;
						break;						
					}
					i++;
				}	
				if (!match)
				{
					lstOptions.selectedIndex = -1;
					if (text!="")
					{
						hideList();	
						addList = false; 			
					}
				}
			} // End of : if (textLength > 0)			
			
			// If the list wasn't showing, and we want to show it, show it now
			if (addList)
			{
				lstOptions.dataProvider=recentEntries;			//data provider for list
				PopUpManager.addPopUp(lstOptions,this);			//show list as popup
				lstOptions.styleName =  "listFont";				//Set style for font
				lstOptions.rowHeight=18;
				lstOptions.width=listWidth;
				lstOptions.height=listHeight;
				lstOptions.visible=true;
				
				//Listen for click event on list - to select item
				lstOptions.addEventListener(MouseEvent.CLICK,selectFromList);
				//Listen for focus out on list - hide list
				lstOptions.addEventListener(FocusEvent.FOCUS_OUT,hideList);
				
				PopUpManager.centerPopUp(lstOptions);			//Centre the popup 
				//Set x and y co-ordinates of list
				lstOptions.y += (lstOptions.height / 2) + 	height - 8;
				if (listWidth > width) lstOptions.x += ( listWidth - width ) /2;
			}
				
			
		}
		
		//Select the value from the list- place in text box and set focus on text box	
		private function selectFromList(event:Object):void{
			// Don't return if the user was just scrolling
			if (event.target is ScrollThumb ||
			    event.target is ScrollBar ||
			    event.target.parent is ScrollBar)
				return;
			
			
						
			if (showList&& lstOptions.selectedItem!=null){
				text=lstOptions.selectedItem.data;
				var dateForEvent:Date = new Date(text);
				hideList();
				var calEvent:CalendarLayoutChangeEvent;
				calEvent = new CalendarLayoutChangeEvent(CalendarLayoutChangeEvent.CHANGE, false, false, dateForEvent, event as Event);
				dispatchEvent(calEvent);
				dispatchEvent(new Event(TextInputPlus.COMMITTING_CHANGE, true, true));
				setFocus();
			}	
			else if (event is KeyboardEvent && (event as KeyboardEvent).keyCode == Keyboard.ENTER)
			{ // If the user pressed enter but didn't pick an item - i.e. there were nothing in
			 // the list that matched the text. 
				dispatchEvent(new Event(TextInputPlus.COMMITTING_CHANGE, true, true));
			} 
		}
		
		
		//Handle keyup in text field
		private function handleKeyUp(event:KeyboardEvent):void{
			switch (event.keyCode) {
				case Keyboard.ENTER:{
					selectFromList(event);
					break;
				}
				case Keyboard.BACKSPACE:{
					handleInput(event);
					break;
				}
				case Keyboard.TAB:{
						break;
				}
				//Down arrow
				case 40:{
					if (!showList){
						handleInput(event);	
					}
					else if (lstOptions.selectedIndex!=recentEntries.length-1)lstOptions.selectedIndex++;
					break;
				}
				//Up arrow
				case 38:{
					if (lstOptions.selectedIndex!=0)lstOptions.selectedIndex--;
					break;
				}
				default:{
					handleInput(event);
				}
			}				
		}
		
		/** Adds the current item to the "Recent Items" list
		 *  The object that is returned is a reference to the
		 *  item that has been added to the list and can be altered
		 *  after it has been added. 
		 * 
		 *  This is useful if you wish to override this method:
		 *  in your override, first call
		 *  super.addCurrentToRecentList(), then change the object
		 *  returned as desired.
		 */
		public function addCurrentToRecentList():Object
		{
			// N.B Date will have been converted to dd/mm/yyyy format already by DateInput code 
			// before this code is called, so we can assume date is in this format
			
			if (!autoUpdateRecentList)
				return null;
			
			if (!recentEntries)
				recentEntries = [];
				
			// Check the item isn't empty
			if (this.text == "")
				return null;	

			// Remove slashes and replace with dots
			var date_text_with_dots_not_slashes:String = new String(this.text);
			date_text_with_dots_not_slashes = this.text.substr(0,2) + '.' + this.text.substr(3,2) + '.' + this.text.substr(6,4); // The date, with dots not slashes, eg 11/07/07 => 11.07.2007	
			
			// Check our item isn't already in the list
			// If so, just move it to the top		
			
			for (var i:int = 0; i< recentEntries.length; i++)
			{
				var o:Object = recentEntries[i];
				if (o.data == this.text || o.data == date_text_with_dots_not_slashes)
				{
					recentEntries.splice(i, 1); // Remove this entry
					recentEntries.unshift(o)  // Add this entry at the start of the list
					return null;
				}
					
			}		

				
			// Its not already here, so add it at the beginning of the array	
			var obj:Object = new Object();
			obj.data = this.text;
			obj.label = date_text_with_dots_not_slashes;
			obj.extra = this.text.substr(0,2) + this.text.substr(3,2) + this.text.substr(8,2); // The date, without the dots or slashes, eg 110707 = 11.07.2007					
			recentEntries.unshift(obj);
						
			// The list will display the new item next time it is displayed
			
			// Dispatch an event 
			var event:DynamicEvent = new DynamicEvent(TextInputPlus.OBJECT_ADDED_TO_LAST20, true, false);
			event.newItem = obj;
			this.dispatchEvent(event);
			
			// Return the object
			return obj;
		}	
		
		/** get instances 
		 * 
		 *  Returns all instances of the TextInputPlus
		 *  (including subclasses)
		 */ 
		public static function get instances():Array
		{
				return _instances;
		}
		
		
		/** onRemove(event:Event)
		 * 
		 *  Triggered when this object is removed from the display.
		 *  Remove the reference to it from the array so that it can be
		 *  garbage-collected.
		 * 
		 *  Especially important in datagrids.
		 */
		private function onRemove(event:Event):void
		{
			_instances = _instances.filter(onRemoveFilter);	
		}
		private function onRemoveFilter(item:*, index:int, array:Array):Boolean
		{
			if (item === this)
				return false;
			else
				return true;
		}
		
		/** Make sure that validation results don't affect the set/hold data border.
		 *  If the validation is valid, remove any override of the border colour or width.
		 *  If it is invalid, make the border appear red.
		 */
		 override public function validationResultHandler(event:ValidationResultEvent):void
		 {
		 	super.validationResultHandler(event);
		 	this.commitProperties();
		 	
 		 	if (event.type == ValidationResultEvent.VALID)
		 	{
		 		// First try "TextInput.<stylename>"
		 		var dec:CSSStyleDeclaration =  StyleManager.getStyleDeclaration("TextInput." + styleName.toString());
		 		
		 		// Now try ".<stylename>"
		 		if (!dec) 
		 		   dec =  StyleManager.getStyleDeclaration("." + this.styleName.toString());
		 		
		 		// Now try "TextInput"
		 		
		 		if (!dec) 
		 			dec = StyleManager.getStyleDeclaration("TextInput");		 			
		 		
		 		var val:*;
		 		
		 		val = undefined;
		 		if (dec)   val = dec.getStyle("borderColor");		 			
		 		if (val == undefined) val = 0xAAB3B3;	//Off - grey, default for text input	 		
		 		this.setStyle("borderColor", val);
		 		
		 		val = undefined;
		 		if (dec)  val = dec.getStyle("borderThickness");		 		
		 		if (val == undefined) val = 0;
		 		this.setStyle("border-thickness", val);
		 		
		 		val = undefined;
		 		if (dec) val = dec.getStyle("borderStyle");
		 		if (val == undefined) val = "inset";
		 		this.setStyle("border-style", val);
		 		
		 		
		 		
		 		this.validateNow(); // Update it NOW!!!
		 		
		 	}
		 	
		 	if (event.type == ValidationResultEvent.INVALID)
		 	{
		 		this.setStyle("borderColor", 0xFF0000);  //Red
		 		this.setStyle("border-thickness", 1);
		 		this.setStyle("border-style", "inset");
		 		this.invalidateProperties();
		 		this.invalidateDisplayList();
		 		this.validateNow(); // Update it NOW!!!
		 	} 
		 	
		 	
		 } 
		
		
		
	}
}