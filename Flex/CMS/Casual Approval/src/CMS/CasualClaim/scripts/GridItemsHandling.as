// ActionScript file	import mx.controls.TextInput;
	import mx.events.IndexChangedEvent;			import mx.events.CloseEvent;
	import mx.core.UIComponent;
	import mx.controls.CheckBox;
	public var ErrorField:UIComponent;	public var returnValue:int;	public var i:int;
	public function PopulateWageTypes(docXML:XML):Array{

        var xmlDutyLength:int  = docXML.item.length();        
        var aryWageTypes:Array = new Array();  

        var i:Number=0;

        for (i=0; i< xmlDutyLength; i++){
            var value:String = docXML.item[i].VALUE.toString();			var key:String   = docXML.item[i].KEY.toString();
 			aryWageTypes.push({label: value, data: key});                                            
        }        return aryWageTypes;
	}           

   public function WageTypeChange(newValue:String,RowID:int):void{
		i = RowID;
        ClaimItems[i].LGART = newValue;
        ClaimItems[i].UPDATED        = 'X';        PreSaveClaimItems[i].UPDATED = 'X';   }

	public function PopulateClaimEditKostls():void{

        var xmlCostLength:int  = xmlalldata.EX_T_COST_CENTERS.item.length();

        aryCostcenters = new Array();

        var i:Number=0;

        for (i=0; i< xmlCostLength; i++){

            var value:String = xmlalldata.EX_T_COST_CENTERS.item[i].VALUE.toString();

            var key:String = xmlalldata.EX_T_COST_CENTERS.item[i].KEY.toString();                         

            aryCostcenters.push({label: value, data: key});
		}

    }

      public function CostCentreChange(newValue:String,RowID:int):void{
	
	       ClaimItems[RowID].ZZKOSTL = newValue;		       ClaimItems[RowID].UPDATED     	= 'X';	       PreSaveClaimItems[RowID].UPDATED = 'X';		       ServerRequest(cWageTypes,null,RowID,null);	      }
	public function WageTypesChanged(RowID:int):void{		i = RowID;   		var currLGART:String = ClaimItems[i].LGART;       	ClaimItems[i].VALID_WAGE_TYPES = aNewWageTypes;       	           		   		ClaimItems[i].LGART = "";       	        dgItems.executeBindings();			                          	       	for(var j:int = 0; j < aNewWageTypes.length;j++){       		       		if(aNewWageTypes[j].data == currLGART){       			           		ClaimItems[i].LGART = currLGART;   	            dgItems.executeBindings();					           		       			return;       		}       		       	}				}
	public function DateChanged(newSAPValue:String,newFlexValue:String,RowID:int,DateFld:UIComponent):void{
				i = RowID;		           	
       	ClaimItems[i].BEGDA = newFlexValue;

        ServerRequest(cDate, newSAPValue, RowID,DateFld);

    }


    public function BeguzChange(newValue:String,RowID:int,BeguzDD:UIComponent):void{
		i = RowID;		
        ClaimItems[i].BEGUZ = newValue;

        newValue = 'S' + newValue + ClaimItems[i].ENDUZ;

        ServerRequest(cTime, newValue,RowID,BeguzDD);
    }

    public function EnduzChange(newValue:String,RowID:int,EnduzDD:UIComponent):void{

        var i:int;

        for (i = 0; i < ClaimItems.length; i++){

	       if(i == RowID){

                ClaimItems[i].ENDUZ = newValue;

                newValue = 'E' + ClaimItems[i].BEGUZ + newValue;

                ServerRequest(cTime, newValue, RowID,EnduzDD);
           }
        }                                   
    }
      public function ProcessRate(Rate:String,RowID:int):Boolean{		//	var newValue:String = RateField.text;		   		ServerRequest(cRate, Rate, RowID, null);						return true;	   					   }   public function CheckRates(Field:TextInput):int{
		if (int(Field.text) == false){			            FormatError(Field, 'Invalid amount! \nPlease re-enter using only digits (and a decimal place if necessary).');            return 4;        }        if (parseFloat(Field.text) < 0){        	            FormatError(Field, 'Negative numbers not allowed!');            return 4;        }        var DecPointPos:int  = Field.text.indexOf(".");        var NumberLength:int = Field.text.length;        if ( (NumberLength > 3 && DecPointPos == -1) || (DecPointPos == 5) || (DecPointPos == 4) ){            FormatError(Field,'You cannot enter more than £999.99.');            return 4;        }        var Number:Number = parseFloat(Field.text);                Field.text = Number.toFixed(2);        return 0;    }  
	public function CheckShiftNo(ShiftNoField:TextInput,RowID:int):Boolean{
			if(CheckShift(ShiftNoField) == 0){							var newValue:String = ShiftNoField.text;			   			ServerRequest(cShiftNo, newValue, RowID, null);						return true;					}else{						return false;		}			}		private function CheckShift(ShiftField:TextInput):int{		if (int(ShiftField.text) == false){			            FormatError(ShiftField, 'Invalid amount! \nPlease re-enter using only digits (and a decimal place if necessary).');            return 4;        }        if (parseFloat(ShiftField.text) < 0){        	            FormatError(ShiftField, 'Negative numbers not allowed!');            return 4;        }		if (parseFloat(ShiftField.text) > 5){            FormatError(ShiftField,"You cannot enter more than 5 shifts");            return 4;        }        var Number:Number = parseFloat(ShiftField.text);                ShiftField.text = Number.toFixed(2);        return 0;    }      	private function FormatError(Component:UIComponent, ErrorString:String):void{	  			ErrorField = Component;	  			Alert.show(ErrorString,cErrorTitle,0,this,HandleValidationAlertClose);   		}	private function HandleValidationAlertClose(event:CloseEvent):void{			ErrorField.setFocus();				focusManager.showFocus();						ErrorField = null;			}