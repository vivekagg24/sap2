package Components
{
	import mx.validators.*;
	

	public class CurrencyValidator extends Validator
	{
		[Bindable]
		public var allowGBP:Boolean = true;
		
		public function CurrencyValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array
		{
			var array:Array = super.doValidation(value);
			var currency:String
				
			try {
				currency = value.data[0].toString();
			
				if (!allowGBP && currency == "GBP")
				{
				 	array.push(new ValidationResult(true, null, "GBP not allowed", 
                    	  "'Currency GBP not permitted for the selected payment method'"));          		  				
				}
			}	
			catch (e:Error)
			{
			 // No data to validate, so don't do anything.
			 // Blank entries are already handled by super.doValidation()
			}

				
					
						
			
			return array;
		}
		
		
		
		
	}
}