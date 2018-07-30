package ecs.components
{
	import mx.validators.Validator;
	import mx.validators.ValidationResult;
	import mx.controls.ComboBox;

	public class ComboValidator extends Validator
	{
		
		public function ComboValidator()
		{
			super();
		}
		

		override protected function doValidation(value:Object):Array
		{
			var result:Array = new Array();
			
			var combo:ComboBox = source as ComboBox;
			// If there is data, but nothing is selected, then error
			if ( combo && combo.dataProvider.length > 0 && combo.selectedIndex < 0)
			{
				var error:ValidationResult = new ValidationResult(true, "", "", "You mst select an entry from the dropdown");
				result.push(error);
			}
			
			
			return result;
		}
		
		
	}
}