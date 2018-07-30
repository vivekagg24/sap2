package ni.components
{
	import mx.rpc.soap.mxml.Operation;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import flash.display.InteractiveObject;
	import flash.events.EventDispatcher;
	import mx.collections.XMLListCollection;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import mx.core.IUIComponent;
	import mx.controls.ProgressBar;
	import mx.managers.PopUpManager;
	import mx.rpc.Fault;
	import mx.core.Application;
	import flash.display.DisplayObject;
	import mx.core.Container;
	import mx.containers.Canvas;
	import mx.containers.HBox;
	import mx.core.IFlexDisplayObject;
	import mx.controls.Label;
	import mx.binding.utils.BindingUtils;
	import mx.core.*;
	import mx.rpc.AsyncToken;
	import mx.messaging.messages.SOAPMessage;

// We have three finishing events, since we can have some calls failing and some completing successfully	
	[Event(name="All_operations_complete", type="mx.rpc.events.ResultEvent")]
	
	[Event(name="Some_operations_complete", type="mx.rpc.events.ResultEvent")]
	
	[Event(name="No_operations_complete", type="mx.rpc.events.FaultEvent")]
	
// We also have one event to report on progress	
	[Event(name="Progress", type="flash.events.ProgressEvent")]
	
	/** The iterative operation breaks the web service operation into smaller chunks to 
	 * avoid timeout and to show the user how far they have got.
	 * 
	 */
	public class IterativeOperation extends EventDispatcher
	{
		// Event types
		public static const FULL_COMPLETION:String = "All_operations_complete";
		public static const PARTIAL_COMPLETION:String = "Some_operations_complete";
		public static const ERROR:String = "No_operations_complete";
		public static const PROGRESS:String = "Progress_update";
	
		public function IterativeOperation()
		{		
		}	
	
		// The oeration that does the work
		protected var _innerOperator:mx.rpc.soap.mxml.Operation;
		public function get innerOperator():Operation
		{
			return _innerOperator;			
		}
		public function set innerOperator(op:Operation):void
		{
			
			if (op)
			{
			   op.addEventListener(ResultEvent.RESULT, handleResult);
			   op.addEventListener(FaultEvent.FAULT, handleFault);
			}
			else if (_innerOperator) // Remove event listeners if any exist
			{
			   _innerOperator.removeEventListener(ResultEvent.RESULT, handleResult);
			   _innerOperator.removeEventListener(FaultEvent.FAULT, handleFault);				
			}
			else 
			{
				
			}
			
			_innerOperator = op;

			 		
		}
		
		// Active status (are we running?)
		private var active:Boolean = false;
		
		// The number of steps to do each time
		public var stepSize:int = 10;
		
		// How many items have we processed
		private var count:int = 0;
		
		// The progress bar (or whatever indicator you like)
		public var progressIndiciatorUI:IUIComponent;
		public var showProgressBar:Boolean = true;
		public var progressText:String;
		public var progressFactory:IFactory = new ClassFactory(mx.controls.ProgressBar);

		
		
		// Continue on server error?
		public var continueOnError:Boolean = false;
		
		// Results of each operation
		public var result:Array = [];
		
		// The request where the user puts their data
		public var request:Object = new Object();	
		
		// Number of parallel processors
		public var parallelProcesses:uint = 1;
		
		// Number of active jobs
		private var _activeProcesses:uint = 0;
		
		// The token which points to the listeners
		private var _asyncToken:AsyncToken;
		
		// Kick everything off
		public function send():AsyncToken
		{		
			// Send mode is always "first"	
			if (active) return _asyncToken;
			
			active = true;
			
			result = [];
			
			count = 0;
			
			popupProgreessBar();	
			
			_activeProcesses = 0;
			
			// Only allow parallel processing if the web service allows it
			// (otherwise we get errors)
			if (_innerOperator.concurrency != "multiple")
			 	parallelProcesses = 1;
			
			// Kick off the parrallel processes		
			loop();	
			
			// Create the async token. We return this in all the events. It helps calling programs
			// know what call this is	
			_asyncToken = new AsyncToken(new SOAPMessage());
			return _asyncToken;
				
		}
		
		/** This is where the operation is set up and called
		 * 
		 */
		protected function loop(event:Object = ""):void
		{
			var opReq:Object = _innerOperator.request;
			var element:Object;
			var anythingToSend:Boolean = false;
			var elementName:String;
			
			// Not really a proper for loop, since we break at the end of the first pass
			for (elementName in request)
			{
				// Assign this object to the operation
				var lines:Array = this.request[elementName] as Array;
				var countLines:uint = lines.length;
				
				// Send the update event
				var progEvent:ProgressEvent;
				
				// When counting the number done, take into account the fact that we may have some 
				// processes still running. Only count those that have returned.
				var done:int = count - (stepSize * _activeProcesses); 
				if (done < 0)
					     done = 0;
				
				progEvent = new ProgressEvent(IterativeOperation.PROGRESS, false, false, done, countLines);
				this.dispatchEvent(progEvent);
				
				//  Update the progress bar
				var progObject:Object = progressIndiciatorUI as Object;		
				if (progObject.hasOwnProperty("setProgress"))
				{
					progObject.setProgress(done, countLines);
				} 									
				
				// Work out how many lines to send
				if (countLines > count + stepSize) // We have room to add a (stepSize) elements
				{	
					// Determine which elements to send next
					// Remember the array (lines) is passed by reference, so any changes made to it  
					// in the function (splitWithNormalStepSize) remain after the call returns.			
					opReq[elementName] = splitWithNormalStepSize(count, stepSize, lines);
					
					// Update count and send flag
					count += opReq[elementName].length;
					anythingToSend = true;
					
				}
				else if (countLines > count)  // We have room to add less than (stepSize) elements, but we can add some
				{
					opReq[elementName] = lines.slice(count, countLines);
					anythingToSend = true;
					count = countLines;
				}
				else // We don't have room to add any elements, so don't send any more requests
 				{
					anythingToSend = false;
				}
				
				
				// Call the request again?
				if (anythingToSend)	
				{
					_innerOperator.send();
					_activeProcesses ++;
					
					// If running in parallel, are we running as many processes as we could?
					if (_activeProcesses < parallelProcesses)
						loop();
						
				}	
					
					
				else 
				{  // We're finished sending. Are we finished receiving (maybe multiple parallel jobs)
					checkFinished();
					
				}
				break; // Only process the first element
			}				
		}
		
		/** splitWithNormalStepSize()
		 * Overrideable function that determines which records to send when we have more
		 * than (stepSize) elements left to send.
		 * 
		 * Default behaviour is just to take the next (stepSize) elements and send them.
		 * However we may want to override this if doing parallel processing to prevent locking.
		 * For example, if we sent two jobs in parallel that had the same employee number in,
		 * the first would lock the employee record, and the second would fail.
		*/ 
		protected function splitWithNormalStepSize(l_count:int, l_stepSize:int, l_lines:Array):Array
		{			
			return l_lines.slice(l_count, l_count + l_stepSize);
		}
		
		/** Check to see if we're finised
		 */
		private function checkFinished():void		
		{
			if (_activeProcesses == 0)
			{
				active = false;
				dispatchResultEvent();
				hideProgressBar();
			}
		}
			
		
		private function handleResult(event:ResultEvent):void
		{		
			// Handle the results
			// We can't aggregate the results, since its not possible to know which results to aggregate.
			// Just combine them all and the main program will aggregate them at the end.
			var obj:Object = new Object();
			obj.result = event.result;
			obj.date = new Date();
			obj.type = "Result";
			result.push(obj);		
			
			// reduce the list of active jobs, since one has come back
			_activeProcesses --;
			
			// Start the next loop if there's anything to loop. This also updates
			// the progress bar.
			loop();
			
		}
		
		private function handleFault(event:FaultEvent):void
		{
			// Store the fault
			var obj:Object = new Object();
			obj.fault = event.fault;
			obj.date = new Date();
			obj.type = "Fault";
			result.push(obj);	
			
			// reduce the list of active jobs, since one has come back
			_activeProcesses --;	
			
			// Handle the results
			if (continueOnError)
				loop();
			else // Don't send any more - are we finished yet?	Ther may be other parallel jobs 			  
			{    // running
				checkFinished();
			}							
				
				
		}
		
		protected function dispatchResultEvent():void
		{
			var countResults:uint = 0;
			var countFails:uint = 0;
			for each (var obj:Object in this.result)
			{
				if (obj.type == "Fault")
					countFails ++;
				
				if (obj.type == "Result")
					countResults ++;	
			}
			
			// Copy the array (creates a new array containing referesnces to the objects in the old array)
			var eventResult:Array = this.result.slice(0);	
			var event:Event;		
			
			// Determine what kind of event to create depending on how many results
			// and failures we have.
			if (countResults > 0 && countFails == 0)
			{
				event = new ResultEvent(IterativeOperation.FULL_COMPLETION, false, true, eventResult, _asyncToken);
			}
			else if (countResults > 0 && countFails > 0)
			{
				event = new ResultEvent(IterativeOperation.PARTIAL_COMPLETION, false, true, eventResult, _asyncToken);
			}
			else if (countResults == 0 && countFails > 0)
			{
				var fault:mx.rpc.Fault = new Fault("8","Web Service Error" );
				fault.rootCause =  eventResult;				
				event = new FaultEvent(IterativeOperation.ERROR, false, true, fault, _asyncToken);
			}
			else // no faults and no results, so don't create the event.
			{
				
			}
			
			if (event)
				this.dispatchEvent(event);
			
		}
		
		protected function popupProgreessBar():void
		{	// Create a progress bar and pops it up				
							
			if (!showProgressBar) 
				return;
			
			// Creates the progrss bar 
			progressIndiciatorUI = progressFactory.newInstance();
			
			PopUpManager.addPopUp(progressIndiciatorUI , Application.application as DisplayObject, false);
			PopUpManager.centerPopUp(progressIndiciatorUI);
			
			var obj:Object = progressIndiciatorUI  as Object;
			
			// Set the text (if we can)
			if (obj.hasOwnProperty("label"))
				obj.label = progressText;
				
			// Set it to work manually (if we can)	
			if (obj.hasOwnProperty("mode"))
				obj.mode = "manual";

			
			
		}
		
		protected function hideProgressBar():void
		{			
			PopUpManager.removePopUp(progressIndiciatorUI);		
		}
		
}
}