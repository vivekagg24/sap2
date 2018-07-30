// ActionScript file - XML Functions - Functions for manipulating XML
import mx.collections.XMLListCollection;


/*** Save rotas on R3
 * 
 */
private function saveRotas():void
{	//ws1.ZHR_SAVE_ROTAS.request = new XML("<request/>");
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
		insert.END_TIME   = convertToSapTime(x.end_time);		insert.DURATION   = convertToSapTime(x.duration_time);  
		
		if (insert.SHORT.toString().length > 0)
			shiftDays.addItem(insert);		
	}	
	req.IM_SHIFT_DAYS = shiftDays.toArray(); 
	
	// Do the employee assignment	// n.b ALWAYS USE ARRAYS WHEN SENDING MULTIPLE ITEMS, FOR SOME REASON XMLLISTS DON'T WORK!!!
	req.IM_EMP_ASSIGNMENT = shiftAssignment.toArray();
	
	// Do the rotas
	var l_rotas:XMLListCollection = new XMLListCollection();
	for each (var y:XML in dp_rotas)
	{		if (y === dp_rotas.getItemAt(0)) continue; // Skip first item as this is the header		
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
				new_day.DAY_SHORT = l_x;					l_rotas.addItem(new_day);			
			} 			
		}		
	}	
	req.IM_ROTA_DETAILS = l_rotas.toArray();    req.IM_TRANSPORT = tiTransport.text;
	
	// Finally send
	ws1.ZHR_SAVE_ROTAS.send();
}
/*** Save rotas temporarily - dont submit  *  */public function saveRotasDraft():void{	var save_xml:XML = new XML(<save_temp><shift_days/><rotas/><assignment/></save_temp>);	var l:* = save_xml.shift_days[0];	for each (var s:XML in this.shift_types)	{		(save_xml.shift_days[0] as XML).appendChild(s);	}	save_xml.shift_assignment = shiftAssignment.source;	for each (s in this.dp_rotas)	{		(save_xml.rotas[0] as XML).appendChild(s);	}		save_xml.selected_org = orgViewer1.id_of_selected_org_unit;		draftXml = 	save_xml.toXMLString();	}/*** Load rotas from a previously saved draf *  */public function loadRotasFromDraft(xml_draft:XML):void{	//var save_xml:XML = new XML(<save_temp><shift_days/><rotas/><assignment/></save_temp>);		this.shift_types = new XMLListCollection(xml_draft.shift_days.children());	updateDurations();			// The rotas themselves	this.dp_rotas = new XMLListCollection(xml_draft.rotas.children());	// Assignment of rotas to employees	this.shiftAssignment = new XMLListCollection(xml_draft.shift_assignment);				// Choose the org unit	var org_unit:String = xml_draft.selected_org;	if (org_unit && org_unit.length > 0)	{		ws1.ZHR_SHIFTPLAN_EMPLOYEES.request.ROOT_OBJECTS.item.OBJID = org_unit;		orgViewer1.id_of_selected_org_unit = org_unit;					}	}		
private function convertToSapDate(val:Date):String
{
					var iMonth:Number;				var sMonth:String;				var sYear:String;								var iDay:Number;				var sDay:String;												sYear  = val.fullYear.toString();										iMonth = val.month + 1;						iDay   = val.date;								if(iMonth < 10){					sMonth = '0' + iMonth.toString()				}else{					sMonth = iMonth.toString()				}						if(iDay < 10){					sDay = '0' + iDay.toString()				}else{					sDay = iDay.toString()				}									var SAPDateField:String =  sYear + "-" + sMonth + "-" + sDay;				return SAPDateField;
	
	
}

private function convertToSapTime(val:String):String
{	if (!val || val.length == 0)	{		return "00:00:00";	}	
	return val + ":00";
	
}/** For each shift, update the duration so that it matches the difference between the times *  */ private function updateDurations():void{	for each (var x:XML in shift_types)	{		var start_time:String = x.start_time;		var end_time:String = x.end_time;		const time_string_length:int = 5; // Character length of the time string e.g. hh:mm				// Initial validation		if (!start_time ||		     start_time.length < time_string_length ||		     start_time.indexOf(":") == -1)		     {		     	start_time = "00:00";		     }		if (!end_time ||		     end_time.length < time_string_length ||		     end_time.indexOf(":") == -1 )			{				end_time = "00:00";			}					var start_hour:int = int(start_time.substr(0,2));		var end_hour:int = int(end_time.substr(0,2));		var start_minute:int = int(start_time.substr(3,2));		var end_minute:int = int(end_time.substr(3,2));					var hours_diff:int = end_hour - start_hour;				var minutes_diff:int = end_minute - start_minute;		if (minutes_diff < 0)		{				hours_diff  -= 1;			minutes_diff += 60;				}		if (hours_diff < 0)		{			hours_diff  += 24;		} 				var hours_diff_string:String = String(hours_diff);		if (hours_diff_string.length == 1) hours_diff_string = "0" + hours_diff_string;				var minutes_diff_string:String = String(minutes_diff);		if (minutes_diff_string.length == 1) minutes_diff_string = "0" + minutes_diff_string;						var duration_string:String = hours_diff_string + ":" + minutes_diff_string;		x.duration_time = duration_string;			
	}
}