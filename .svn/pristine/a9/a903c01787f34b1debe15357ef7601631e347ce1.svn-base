package ECS_Components_QAS
{
	import flash.events.Event;

    public final class AddressEvent extends Event // Event raised when address found
    {
    	public var address:XMLList;
    	public function AddressEvent (im_address:Object) {
    		super("AddressFound");
    			this.address = new XMLList(im_address);    			
    		
    		}
    	override public function clone ():Event {
    		return new AddressEvent(address);
    	}
    	
    }
}