// ActionScript file - XML Functions - Functions for manipulating XML
import mx.collections.XMLListCollection;


/*** Save rotas on R3
 * 
 */
private function saveRotas():void
{
	var req:* = ws1.ZHR_SAVE_ROTAS.request;
	req.IM_ORG_UNIT = orgViewer1.id_of_selected_org_unit;  
	req.IM_ASSIGNMENT_DATE = convertToSapDate(this.dtAssignment.selectedDate);
	
	// Do the shift days
	var shiftDays:XMLListCollection = new XMLListCollection();
	for each (var x:XML in shift_types)
	{
		var insert:XML = new XML(<item/>);
		insert.SHORT = x.abbreviation.toString();
		insert.DESC =  x.name.toString();
		insert.START_TIME = convertToSapTime(x.start_time);
		insert.END_TIME   = convertToSapTime(x.end_time);
		
		if (insert.SHORT.toString().length > 0)
			shiftDays.addItem(insert);		
	}	
	req.IM_SHIFT_DAYS = shiftDays.toArray(); 
	
	// Do the employee assignment
	req.IM_EMP_ASSIGNMENT = shiftAssignment.toArray();
	
	// Do the rotas
	var l_rotas:XMLListCollection = new XMLListCollection();
	for each (var y:XML in dp_rotas)
	{
		var cols:XMLList = y.children();
		var l_name:String = cols[0].val.toString();
		if (l_name.length > 0) // Make sure column has a length		
		{
			for (var i:String in cols)
			{
				if (i == "0") continue; // First line is the label
				
				var l_x:String = cols[i].val;
				if (l_x.length == 0) break; // Stop at the first empty cell
				var new_day:XML = new XML(<item/>);
				new_day.ROTA_NAME = l_name;
				new_day.DAY_NUM   = i;
				new_day.DAY_SHORT = l_x;	
			} 			
		}		
	}	
	req.IM_ROTA_DETAILS = l_rotas.toArray();
	
	// Finally send
	ws1.ZHR_SAVE_ROTAS.send();
}

private function convertToSapDate(val:Date):String
{
	
	
	
}

private function convertToSapTime(val:String):String
{
	return val + ":00";
	
}
	}
}