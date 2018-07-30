package visualComponents
{
	import mx.containers.HBox;
	import mx.collections.*;
	import mx.core.UIComponent;

	public class RepeatingHBox extends HBox
	{


    //----------------------------------
    //  dataProvider
    //----------------------------------

    /**
     *  @private
     *  Storage for the 'dataProvider' property.
     */
    private var collection:ICollectionView;

    [Bindable("collectionChange")]
    [Inspectable(category="General", defaultValue="null")]

    /**
     * @inheritDoc
     */
    public function get dataProvider():Object
    {
        return collection;
    }

    /**
     *  @private
     */
    public function set dataProvider(value:Object):void
    {
        var hadValue:Boolean = false;

        if (collection)
        {
            hadValue = true;
            collection.removeEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler);
            collection = null;
            iterator = null;
        }

        if (value is Array)
        {
            collection = new ArrayCollection(value as Array);
        }
        else if (value is ICollectionView)
        {
            collection = ICollectionView(value);
        }
        else if (value is IList)
        {
            collection = new ListCollectionView(IList(value));
        }
        else if (value is XMLList)
        {
            collection = new XMLListCollection(value as XMLList);
        }
        else if (value is XML)
        {
            var xl:XMLList = new XMLList();
            xl += value;
            collection = new XMLListCollection(xl);
        }
        else if (value != null)
        {
            // convert it to an array containing this one item
            var tmp:Array = [value];
            collection = new ArrayCollection(tmp);
        }

        if (collection)
        {
            // weak reference
            collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangedHandler, false, 0, true);
            iterator = collection.createCursor();
        }

        dispatchEvent(new Event("collectionChange"));

        if (collection || hadValue)
        {
            execute();
        }
    }		
    
    /**
     *  @private
     *  Handles "Change" event sent by calls to Collection APIs
     *  on this Repeater's dataProvider.
     */
    private function collectionChangedHandler(collectionEvent:CollectionEvent):void
    {
        switch (collectionEvent.kind)
        {
            case CollectionEventKind.UPDATE:
            {
                break;
            }

            default:
            {
                execute();
            }
        }
    }    
    

	/** Create componenents
	 * 
	 */ 
	protected function execute():void
	{
		var newComponent:UIComponent;
		for each (var x:Object in this.collection)
		{
			
			
		}
		
	}
				
		
		
	}
}