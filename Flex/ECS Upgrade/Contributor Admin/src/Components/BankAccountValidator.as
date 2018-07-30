package Components
{
    import mx.validators.Validator;
    import mx.validators.ValidationResult;
    import mx.core.Application;

	public class BankAccountValidator extends Validator
	{
		// Validates a bank account number depending on the currency
		// For details of international bank account standards, see http://www.ecbs.org
		
		[Inspectable]
		public var country:String;
		
		// Define Array for the return value of doValidation().
        private var results:Array;
	
		
		public function BankAccountValidator()
		{
			super();
		}
			 
		protected override function doValidation(value:Object):Array
		{
			 // Convert value to a String.
            var inputValue:String = new String(value);

            // Clear results Array.
            results = [];

            // Call base class doValidation().
            results = super.doValidation(value);        
            // Return if there are errors.
            if (results.length > 0)
                return results;
            
            // If field is empty, don't do any further validation. 
            // Only validate non-empty fields, since an empty value may be valid
            // and if an empty value is not valid, this was already picked up in the "Required Field"
            // check in the super.doValidation() call.
            if (inputValue == null || inputValue == "")
            	return []; // Return empty array
                
			
			//
			//debug
			var a:Object = Application.application.comboCurrency;
			var b:Object = a.data;
			
			// Now, depending on the country, do validation
			switch (country) {
				case 'GB':
				// British bank accounts must be numeric and betweeen 7 and 9 digits. 
				// 9 digit account numbers are actually 8-digit account numbers followed by
				//  a check digit.
				
					if (isNaN(Number(inputValue)) || Number(inputValue) < 0)
					{
						// value passed is not a number
						  results.push(new ValidationResult(true, null, "NaN", 
                    	  "GB Account numbers must only contain numeric digits (i.e. 0-9)"));
                		  return results;
					}
					
					if (inputValue.length > 9)
					{
						// Value passed is longer than 9 characters
						  results.push(new ValidationResult(true, null, "long", 
                    	  "GB Account numbers must be no longer than nine digits (Most GB account number have eight digits)"));
                		  return results;
					}
					
					if (inputValue.length < 7)
					{
						// Value passed is shorter than 7 characters
						  results.push(new ValidationResult(true, null, "long", 
                    	  "GB Account numbers must be no shorter than seven digits (Most GB account number have eight digits)"));
                		  return results;
					}
				
			}
			return results;
			
		}
		
					
		
		
	}
}