package visualComponents.GridComponents
{
	import mx.controls.Label;
	import mx.controls.listClasses.BaseListData;

	public class DateLabel extends Label
	{
		override public function set listData(value:BaseListData):void
		{
			super.listData = value;
			
			if (value) {
				var sMonth:String;
				var sYear:String;
				var sDay:String;
				var sDate:String;

			// extract the individual values
				sYear = value.label.substr(0,4);
				sMonth = value.label.substr(5,2);
				sDay = value.label.substr(8,2);
				sDate = sDay + '-' + sMonth + '-' + sYear;
				value.label = sDate;
			}
		}
	}
}