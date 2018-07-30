package ecs.validators
{ 
	import mx.validators.Validator;
    import mx.validators.ValidationResult;
	
	public class ContributorNumberValiditor extends Validator
	{
		// Define Array for the return value of doValidation().
        private var results:Array;
		public var error:Boolean = false;
        // Constructor.
        public function ContributorNumberValiditor() {
            // Call base class constructor. 
            super(); 
        }
    	
        // Define the doValidation() method.
        override protected function doValidation(value:Object):Array {


            // Clear results Array.
            results = [];
			
            // Call base class doValidation().
            results = super.doValidation(value);        
            // Return if there are errors.
            if (results.length > 0) return results;
       		
       		if (error)
				results.push(new ValidationResult(true, null, "invalidContributor", "This is an invalid contributor number"));
             	
			
            return results;
        }
		
	}
}