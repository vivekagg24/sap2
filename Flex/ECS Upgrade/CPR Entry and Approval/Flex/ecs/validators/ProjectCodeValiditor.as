package ecs.validators
{ 
	import mx.validators.Validator;
    import mx.validators.ValidationResult;
	
	public class ProjectCodeValiditor extends Validator
	{
		// Define Array for the return value of doValidation().
        private var results:Array;
		public var error:Boolean = false;
        // Constructor.
        public function ProjectCodeValiditor() {
            // Call base class constructor. 
            super(); 
        }
    	
        // Define the doValidation() method.
        override protected function doValidation(value:Object):Array {

            // Clear results Array.
            results = [];
			if (value=="")return results;
            // Call base class doValidation().
            results = super.doValidation(value);        
            // Return if there are errors.
            if (results.length > 0) return results;
       		
       		if (error)
				results.push(new ValidationResult(true, null, "invalidProject", "This is an invalid project code"));
             	
			
            return results;
        }
		
	}
}