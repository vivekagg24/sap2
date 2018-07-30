package CMS.generalClasses{
        import mx.collections.ArrayCollection;
       
        public class ApprovalTree{
                
                public var Image:String;
                
	            public var PERNR:String;
				public var SUBTY:String;
				public var OBJPS:String;
				public var SPRPS:String;
				public var ENDDA:String; 					
				public var BEGDA:String; 					
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
				public var ZDAY:String;						
				public var BEGUZ:String;					
				public var ENDUZ:String;					
				public var LGART:String;					
				public var KTEXT_WT:String;
				public var ANZHL:String;					
				public var RATE:String;						
				public var HRATE:String;					
				public var BETRG:String;					
				public var GROSS:String;					
				public var WAERS:String;					
				public var STAT_DESC:String;				
				public var ZZKOSTL:String;					
				public var ZZDUTY_CODE:String; 
				public var ZZAUFNR:String;					
				public var ZZAPPROVAL:String; 
				public var ZZDURATION:String; 				
				public var UNAME:String;
				public var UPDATED:String;
				public var ROW_NUMBER:int;
				public var REJECT_TEXT:String;		
				public var VALID_WAGE_TYPES:Array;
				public var CASUAL_NAME:String;
				public var WKSTART:String;   
				public var AMOUNT_WARNING:String;   	
				public var IS_LOCKED:String;		
				
				public var PERSONNEL_NO:String;
				
				public var WeekStartLine:Boolean;
				public var costCentreLine:Boolean;
				public var CasualLine:Boolean;
				public var ClaimLine:Boolean=false;				
				
                //fields used by treeGrid renderer
                
                public var isOpen:Boolean=false;
                public var indent:Number;
                public var childList:ArrayCollection;
                public var highlightRow:Boolean;
                
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
                
                /************************************************************************
                /* constructor
                /*************************************************************************/        
                function ApprovalTree() {
                        childList = new ArrayCollection();
                        isOpen = false;
                        indent = 0;
                }                                                
        }
}
