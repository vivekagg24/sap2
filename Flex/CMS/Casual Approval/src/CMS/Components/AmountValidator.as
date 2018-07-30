package CMS.Components
{
	import mx.validators.NumberValidator;
    import mx.validators.ValidationResult;
    
	public class AmountValidator extends NumberValidator
	{

        private var results:Array;
        
		public function AmountValidator()
		{
			//TODO: implement function

			super();
		}
		
       // Define the doValidation() method.
        override protected function doValidation(value:Object):Array {

            // Clear results Array.
            results = [];
			
			if(CommaExists(value)){

				results.push(new ValidationResult(true, null,'Comma', "Number contains invalid character ','"));				

				return results;				
			}
			
            // Call base class doValidation().
            results = super.doValidation(value);        

			return results;
            
        }		
		
		private function CommaExists(value:Object):Boolean{
	
			var sValue:String = value.toString();
			
			if(sValue.indexOf(',') != -1){
				return true;				
			}
	
			return false;
		}
		
	}	
	
}