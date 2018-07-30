package events
{
	import flash.events.Event;

    /**  Event triggered when the user changes the assignemnt of an employee to a shift pattern
    *    The could change the rota, or just the start date within the rota.
    */ 
	public class ShiftAssignmentEvent extends Event
	{
		public function ShiftAssignmentEvent(type:String, bubbles:Boolean, cancelable:Boolean, _index:int, _index_of_rota:int, _start_day_in_rota:int, _name_of_rota:String, _works_Bank_Holidays:Boolean )
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
			this.index = _index;
			this.index_of_rota = _index_of_rota;
			this.start_day_in_rota = _start_day_in_rota;
			this.name_of_rota = _name_of_rota;
			this.works_bank_holidays = _works_Bank_Holidays;
			
		}
		
		public var index:int;
		public var index_of_rota:int;
		public var start_day_in_rota:int;
		public var name_of_rota:String;
		public var works_bank_holidays:Boolean;
		
		
		override public function clone():Event
		{
			var e:Event = new ShiftAssignmentEvent(type, bubbles, cancelable, index, index_of_rota , start_day_in_rota, name_of_rota, works_bank_holidays);			
			return e;
		}
		
	}
}