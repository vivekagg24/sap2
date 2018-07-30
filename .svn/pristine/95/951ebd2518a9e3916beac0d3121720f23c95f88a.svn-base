// ActionScript file - Convert between display and internal SAP values
import mx.collections.XMLListCollection;


public function convertActiveToSAP(s:String):String{
	
	if (s.toLocaleLowerCase() == "active")
		return "X";
	else
		return "";
	
	}
	
public function convertActiveFromSAP(s:String):String{
	
	if (s.toLocaleLowerCase() == 'x')
		return "Active";
	else
		return "Passive";
	
	}
	
public function convertDateToSAP(s:String):String
{	
	var ret:String = s.substr(6,4) + "-" + s.substr(3,2) + "-" + s.substr(0,2);
	return ret;
}
	
	
public function convertDateFromSAP(s:String):String
{
	var ret:String = s.substr(8,2) + "/" + s.substr(5,2) + "/" + s.substr(0,4);
	return ret;
}	

// You can't pass an XMLList to a Web Service, as it only picks up the first value,
// you have to pass an array instead. Its an annoying bug ni Flex
public function convertXmlToArray(xmlListC:XMLListCollection):Array
{
	var a:Array = [];
	for each (var x:XML in xmlListC)
	{
		a.push(x);
	}
	return a;
}