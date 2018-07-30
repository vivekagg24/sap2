package ecs.generalClasses
{
	import flash.events.Event;

	public class ContributorEvent extends Event
	{
		/** Event Types 
		 * 
		 *  CONTRIBUTOR_SEARCH_CANCELLED
		 *  	The search ended without the user choosing a contributor 
		 * 
		 *  CONTRIBUTOR_CHOSEN_FROM_SEARCH
		 * 		The user chose an existing contributor
		 * 
		 *  CONTRIBUTOR_CREATED
		 * 		The user has created a new contirbutor with a contributor number
		 * 
		 * 
		 */
		 
		public static const CONTRIBUTOR_SEARCH_CANCELLED:String = "contribSearchCancelled";
		public static const CONTRIBUTOR_CHOSEN_FROM_SEARCH:String = "contribChosen";
		public static const CONTRIBUTOR_CREATED:String = "contribCreated";
		
		/** Event details
		 * 
		 */
		 
		private var _contributor:ContributorDataModel; 
		
		
		public function ContributorEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
		{
			super(type, bubbles, cancelable);
		}
		
		
		
		
	}
}