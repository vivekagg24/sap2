package events
{
	import flash.events.Event;
	import mx.controls.listClasses.BaseListData;	
	

	public class DeleteEvent extends Event	
	{
		public var listData:BaseListData;
		public static const delete_event:String = "DELETE_SUBSTITUTE";
		
		public function DeleteEvent(type:String, _listData:BaseListData, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.listData = _listData;
		}
		
	}
}