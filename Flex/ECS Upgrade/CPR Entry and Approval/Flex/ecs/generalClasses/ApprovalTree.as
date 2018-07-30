package ecs.generalClasses{
        import mx.collections.ArrayCollection;
        //Structure for approval data grid
        public class ApprovalTree{
                
                public var Image:String;				//Traffic light 
                public var status:String;				//ECS status
				public var approver:Boolean;			//Approved by user who entered the payment
				public var cpr:String;					//Document number
				public var costCentre:String;			//Cost centre
				public var story:String;				//Story text
				public var amount:String;				//Amount
				public var contributor:String;			//Contributor 
				public var contributorName:String;		//Contributor name  (lfa1-name1)
				public var contributorName2:String;		//Contributor name2 (lfa1-name2)
				public var inputBy:String               // Person who initially enetered the payment
				public var newContributor:Boolean;		//new contributor flag
				public var changed:Boolean;				//Payment has been editied since creation flag
				public var held:Boolean;				//Held item flag
				public var urgent:Boolean;				//Urgent payment
				public var urgentReason:String;			//Reason the payment is urgent
				public var pageNumbers:String;			//Page numbers
				public var publicationDate:String;		//Publication date
				public var Relation:Boolean;             // Sreddy Govt. relation
				public var PriInv:Boolean;              // Sreddy Private Investigator IC 253683
				public var SerAgt:Boolean;              // Sreddy Service Agent IC 253683
				
				public var company:String;				//Company code
				public var year:String;					//Year
				public var batch:String;				//Batch number
				public var docamount:String;			//Amount in document currency
				public var batchLine:Boolean;			//This line in the grid is a batch summary?
				public var costCentreLine:Boolean;		//This line in the grid is a cost centre summary
				public var contributorType:String;		//Contributor type
				public var project:String;				//Project code
				public var statusText:String;			//Status text
				public var glCode:String;				//General Ledger code
				public var glDesc:String;               //General Ledger description
				public var icatDesc:String;				//Item Category Text ("lineage", "pictures" etc.)
                //fields used by treeGrid renderer
                public var isOpen:Boolean=false;		//Section is open
                public var indent:Number;				//Indentatio width
                public var childList:ArrayCollection;	//Child items (e.g. for cost centre)
                public var highlightRow:Boolean;		//Highlight the amount if above threshold
                
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
                
                
                protected var _selected:Boolean;			//Checkbox selected (approve)
                // Can't set when on query
                public function set selected(val:Boolean):void
                {
                	if (!this.onQuery)
                	{
                		_selected = val;
                	}
                		
                }         
                public function get selected():Boolean
                {
                	return _selected;
                }                         
        }
}
