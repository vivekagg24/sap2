package nihr.PersonSearchClasses
{
	import flash.events.Event;

	/** The personSearchEvent is an event dispatched by the personSearchPopUp when the user
	 *  clicks "Search". It contains information on the search that the user is requesting.
	 * 
	 * It is also dispatch when the user chooses a result from the results dropdown.
	 */
	public class PersonSearchEvent extends Event
	{
		public static const PERSON_SEARCH_REQUEST:String = "personSearchRequest";
		public static const PERSON_SEARCH_CHOSEN:String = "personSearchChosen";
		public static const PERSON_SEARCH_NOTFOUND:String = "personSearchNotFound";
		
		private var _firstName:String;
		private var _lastName:String;
		private var _pernr:String;
		private var _uname:String
		
		public function PersonSearchEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
		                         firstName:String = "", lastName:String = "", pernr:String = "", uname:String = "")
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
			this._firstName = firstName;
			this._lastName = lastName;
			this._pernr = pernr;
			this._uname = uname;
				
		}
		
		override public function clone():Event
		{
			var cloneEvent:PersonSearchEvent;
			cloneEvent = new PersonSearchEvent(this.type, this.bubbles, this.cancelable, this._firstName, this._lastName, this._pernr, this._uname)
			return cloneEvent;		
		}
		
		public function get firstName():String
		{
			return this._firstName;
		}
		public function get lastName():String
		{
			return this._lastName;
		}
		public function get pernr():String
		{
			return this._pernr;
		}				
		public function get uname():String
		{
			return this._uname;
		}				
		
		
	}
}