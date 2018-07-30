package ecs.components
{
	import ni.components.TextInputPlus;
	
	/** Class for inputting contributor name and number
	 * 
	 */
	public class ContributorTextInputPlus extends TextInputPlus
	{
		public function ContributorTextInputPlus()
		{
			super();
		}
		
		/** Modify the standard behaviour of adding entries to the "Recent Entries" list.
		 *  Important to check that the object returned by super() isn't null. If the item
		 *  is already present in the list, it won't be added
		 */ 
		override public function addCurrentToRecentList():Object
		{
			var obj:Object = super.addCurrentToRecentList();
			if (obj)
			{
				obj.value = parentApplication.txtContributor.text;
				obj.label = parentApplication.txtContributorName.text;				
			}
			
			
			return obj;
		}
		
		override public function set editable(value:Boolean):void
		{
			super.editable = value;
		}
		
	}
}