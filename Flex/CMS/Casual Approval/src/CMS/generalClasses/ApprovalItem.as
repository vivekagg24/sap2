package CMS.generalClasses
{
	public class ApprovalItem
	{
		public var PERNR:String;
		public var SUBTY:String;
		public var OBJPS:String;
		public var SPRPS:String;
		public var ENDDA:String; 					// PREVIOUS FIELD NAMES
		public var BEGDA:String; 					//	date
		public var SEQNR:String;
		
		//public var SEL:Boolean;
		protected var _selected:Boolean;			//Checkbox selected (approve)
        // Can't set when on query
        public function set SEL(val:Boolean):void
        {
        	if (!this.onQuery)
        	{
        		_selected = val;
        	}
        		
        }         
        public function get SEL():Boolean
        {
        	return _selected;
        }   
		
		public var KTEXT_CC:String;
		public var ZDAY:String;						//day
		public var BEGUZ:String;					//starthours + startmins	
		public var ENDUZ:String;					//endhours + endmins	
		public var LGART:String;					//dutycode
		public var KTEXT_WT:String;
		public var ANZHL:String;					//shiftno
		public var RATE:String;						//shiftrate
		public var HRATE:String;					//hourly
		public var BETRG:String;					//amount
		public var GROSS:String;					//grossAmount
		public var WAERS:String;					//currency	
		public var STAT_DESC:String;				//status
		public var ZZKOSTL:String;					//comboCostcenters
		public var ZZDUTY_CODE:String; 
		public var ZZAUFNR:String;					//projcode
		public var ZZAPPROVAL:String; 
		public var ZZDURATION:String; 				//hours
		public var ZZCASUAL_NAME:String;
		public var ZZUPDATED_BY:String;
		public var UPDATED:String;
		public var ROW_NUMBER:int;
		public var REJECT_TEXT:String;		
		public var VALID_WAGE_TYPES:Array;
		public var CASUAL_NAME:String;
		public var WKSTART:String;
		
        //on query functionality
        protected var _onQuery:Boolean;             //Is on query
        public function set onQuery(val:Boolean):void
        {
        	_onQuery = val;
        	_selected = false;
        }
        public function get onQuery():Boolean
        {
        	return _onQuery;
        }
		        
        public var queryReason:String;          //Query reason		
	
	}
}