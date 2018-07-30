// ActionScript file
	import mx.events.IndexChangedEvent;		
	import mx.core.UIComponent;
	import mx.controls.CheckBox;

	public function PopulateWageTypes(docXML:XML):Array{

        var xmlDutyLength:int  = docXML.item.length();
        var aryWageTypes:Array = new Array();  

        var i:Number=0;

        for (i=0; i< xmlDutyLength; i++){

 			aryWageTypes.push({label: value, data: key});                                            
        }
	}           

   public function WageTypeChange(newValue:String,RowID:int):void{

        ClaimItems[i].LGART = newValue;


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
	
	       ClaimItems[RowID].ZZKOSTL = newValue;

	public function DateChanged(newSAPValue:String,newFlexValue:String,RowID:int,DateFld:UIComponent):void{
		
       	ClaimItems[i].BEGDA = newFlexValue;

        ServerRequest(cDate, newSAPValue, RowID,DateFld);

    }


    public function BeguzChange(newValue:String,RowID:int,BeguzDD:UIComponent):void{

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
   

	public function CheckShiftNo(ShiftNoField:TextInput,RowID:int):Boolean{
	