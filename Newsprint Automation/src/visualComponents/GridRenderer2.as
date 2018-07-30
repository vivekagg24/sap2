package visualComponents
{
	import mx.controls.dataGridClasses.DataGridItemRenderer;

	public class GridRenderer2 extends DataGridItemRenderer
	{
		public function GridRenderer2()
		{
			super();
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			
  			if (data && data.editable) {
  				if (data.editable && data.editable == 'X')
				{
					this.borderColor = 0xFF0000;
					this.border = true;			
				}
				else
				{
					this.border = false;
					this.borderColor = 0xFFFFFF;
				} 
			}
		}
	}
}