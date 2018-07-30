package visualComponents.GridComponents
{
	import mx.controls.Image;
	import mx.controls.listClasses.BaseListData;

	[Embed (source="../../HR/images/substituted.gif" )]
	public static const SubIm:Class;

	public class subIcon extends Image
	{
		override public function set listData(value:BaseListData):void
		{
			super.listData = value;
		
			this.enabled = false;
			this.source=SubIm; //"@Embed('../../HR/images/substituted.gif')";
			if (value.label == null || value.label != ""){
				this.visible = false;
			}
			else {
				this.visible = true;
			}
		}
	}	
}