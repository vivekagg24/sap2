package
{
	import mx.rpc.soap.mxml.Operation;

	/** The iterative operation breaks the operation into smaller chunks to 
	 * avoid timeout.
	 * 
	 */
	public class IterativeOperation 
	{
	
		public function IterativeOperation()
		{
		}	
	
	
		// The oeration that does the work
		public var innerOperator:mx.rpc.soap.mxml.Operation;
		
		public var resultsStore:XML = new XML("combinedResult");
		
		public var request:XML;
		
		public function start()
		{		
			innerOperator.request = new XML();
		

			// Loop at the model and set up the operation
			for each (var element:XML in model)
			{
				// Is this a parameter from the model that we split, or one that we pass in full?
				
			}	
				
						
		}
		
}