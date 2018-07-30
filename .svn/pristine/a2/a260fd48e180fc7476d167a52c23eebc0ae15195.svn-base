package ecs.validators
{ 
	import mx.validators.Validator;
    import mx.validators.ValidationResult;
	
	public class CostCentreValidator extends Validator
	{
		// Define Array for the return value of doValidation().
        private var results:Array;
		public var listCostCentres:Array;
	 
        // Constructor.
        public function CostCentreValidator() {
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
       		       		 
			var bFound:Boolean =false;
			var i:int=0;

			for (i=0;i<listCostCentres.length;i++){
				try{
					if (listCostCentres[i].data==value.toUpperCase()){
						bFound = true;
						break;
					}
				}
				catch(err:Error){}
			}
			
			if (!bFound){
				results.push(new ValidationResult(true, null, "invalidCosCentre", value +  " is not a valid cost centre"));
             	return results;
			}
		 
            return results;
        }

	}
}