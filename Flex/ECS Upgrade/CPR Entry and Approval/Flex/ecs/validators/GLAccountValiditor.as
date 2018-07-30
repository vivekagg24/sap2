package ecs.validators
{ 
	import mx.validators.Validator;
    import mx.validators.ValidationResult;
	
	public class GLAccountValiditor extends Validator
	{
		// Define Array for the return value of doValidation().
        private var results:Array;
		public var listGLAccounts:XMLList;
	 
        // Constructor.
        public function GLAccountValiditor() {
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
            if (results.length > 0)
                return results;
       		
       		if (listGLAccounts==null){
       			results.push(new ValidationResult(true, null, "invalidGL","Please select a publication"));
             	return results;
       		}
       		 
			var bFound:Boolean =false;
			var i:int=0;
			var formattedValue:String;
			for (i=0;i<listGLAccounts.children().length();i++){
				try{
					//Remove leading zeros for check
					formattedValue = value.toString().toUpperCase();
					while(formattedValue.substr(0,1) == "0")
					{
						formattedValue = formattedValue.substr(1); // Chop off the first character
					}					
					if (listGLAccounts[i].GL_ACCT.toString()==formattedValue){
						bFound = true;
						break;
					}
				}
				catch(err:Error){}
			}
			
			if (!bFound){
				results.push(new ValidationResult(true, null, "invalidGL", value +  " is not a valid GL account for this publication"));
             	return results;
			}
		 
            return results;
        }

	}
}