// Utility functions
import ecs.generalClasses.*;
import mx.formatters.DateFormatter;
import mx.controls.CheckBox;
import mx.controls.Text;

//Build drop down list: data provider is array of DATA/ LABEL pairs from XML List
public function buildDropdownList(list:XMLList,blank:Boolean):Array{
	var arrayValues:Array = new Array();
	var currentValue:valueForDropdown;
 
	var item:XML;
	//Blank line for first row?
	if (blank) {
		currentValue = new valueForDropdown();
		currentValue.data="";
		currentValue.label=" ";
		arrayValues.push(currentValue);
	}
	//Go through XML and build the dropdown
	for each(item in list.item){
		currentValue = new valueForDropdown();
		
		currentValue.data  = item.DATA.toString();
		currentValue.label = item.LABEL.toString();
	
		if (currentValue.label!="") arrayValues.push(currentValue);
				 
	}
	
	return arrayValues;
}

//Format the date (internal SAP to DD/MM/YYYY)
public function formatDate(date:String):String{
	var format:DateFormatter = new DateFormatter();
	format.formatString="DD/MM/YYYY";
	return format.format(date);
}

//remove leading zeros from a string
public function removeleadingZeros(value:String):String{
	var pattern:RegExp = /[^ 0]/;
	var pos:int = value.search(pattern);
	if (pos > 0) {
		value = value.substr(pos);
	} else {
	 //	value = "";
	}
	return value;
}

// Format date YYYYMMDD for SAP
public function getDateForSAP(date:String):String{
	return date.substr(6,4) + date.substr(3,2) + date.substr(0,2);
}

//Retuen X or space flag for a checkbox value
private function checkboxChange(checkbox:CheckBox, value:String):void {
	if (checkbox.selected) {
		value="X";
	} else {
		value = " ";
	}
}
public function ifBothTrue(bool1:Boolean, bool2:Boolean):Boolean
{
	if (bool1 && bool2)
		return true;
	else
		return false;	
}

public function ifTrue(Input:int, text:String):Boolean
{
	if (Input > 0 && text == "")
	   return true;
	else
	   return false;	     
}
