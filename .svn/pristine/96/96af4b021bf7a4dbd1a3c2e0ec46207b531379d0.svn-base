package visualComponents
{
	import mx.controls.Image;
	import mx.controls.listClasses.BaseListData;

	[Embed (source="../images/redlight.gif" )]
	public static const RedIm:Class;

	[Embed (source="../images/redlight.gif" )]
	public static const GreIm:Class;
	
	[Embed (source="../images/redlight.gif" )]
	public static const AmbIm:Class;
	
	public class trafficIcon2 extends Image
	{

		override public function set listData(value:BaseListData):void
		{
			super.listData = value;
		
			this.enabled = false;
			this.visible = true;
			//this.source="@Embed('../images/redlight.gif')";
			if (value.label == null || value.label == "" || value.label == 'A' ){
				this.source=AmbIm;
				//this.source="@Embed('../images/redlight.gif')";
			}
			else if (value.label == 'R'){
				this.source=RedIm;
				//this.source="@Embed('../images/redlight.gif')";
			}
			else if (value.label == 'G'){
				this.source=RedIm;
				//this.source="@Embed('../images/redlight.gif')";
			}			
		}
	}	
}