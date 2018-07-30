package CMS.generalClasses
{
	import ni.components.IterativeOperation;

	public class CMSIterativeOperation extends IterativeOperation
	{
		// Employees to check for
		private var pernrsArray:Array = [];
		
		// Number of lines to read ahead
		var linesToRead:int;
		
		/** To allow for parallel processing, we need to make sure we aren't sending two jobs in parallel
		 *  containing the same employee, else one job will lock the other one out of the employee record.
		 * 
		 *  Therefore, in each job, we get a list of employees in that job, then pull any claims for
		 *  those employees out of the proceeding lines.
		 */
		override protected function splitWithNormalStepSize(l_count:int, l_stepSize:int, l_lines:Array):Array
		{
			var linesToSend:Array = super.splitWithNormalStepSize(l_count, l_stepSize, l_lines);			
			pernrs = [];
			
			
			if (parallelProcesses == 1)
				return linesToSend; // We only need this logic if we are doing parallel processing
			
			// Get all the employees 
			for each (var obj:Object in linesToSend)
			{
				pernrs.push(obj.PERNR.toString());
			}
			
			// Number of lines to read ahead
			linesToRead = (this.parallelProcesses - 1) * this.stepSize;
			
			var matchingLines:Array
			do
			{
			+matchingLines = l_lines.slice(l_count + l_stepSize, l_count + ( 2 * l_stepSize ) ).filter(filterOnPernr);  ;	
			for each (var obj:Object in matchingLines)
				{
					// Move the line from where it is in the array to just after the ones we are already sendin
					
					// Step 1 - remove it from its current position
					l_lines.splice(l_lines.indexOf(obj, l_count), 1);
					
					// Step 2 - add it back in the right place
					l_lines.splice(l_count + linesToSend.length,0, obj);
					
					// Step 3 - add it to the array of what we are sending
					l_lines.push(obj);				
				}				
			}
			
			
			
			
			
			
		}
		
		// Check if a record's employee number is in our list
		private function filterOnPernr(item:*, index:int, array:Array):Boolean;
		{
			var pernr:String = item.PERNR.toString();
			for each (var match_pernr:String in pernrs)
			{
				if (match_pernr == pernr)
					return true;
			}
			// No match
			return false;
			
		}
		
		
	}
}