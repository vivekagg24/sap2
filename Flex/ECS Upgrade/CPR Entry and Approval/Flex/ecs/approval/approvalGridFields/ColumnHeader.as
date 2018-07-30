package ecs.approval.approvalGridFields {
/**************************************************************************************
 * ColumnHeader
 * Renderer for the column headers - set the tooltip for the column
 * ************************************************************************************/
    import mx.controls.Text;
    import mx.controls.listClasses.IDropInListItemRenderer;
    

    public class ColumnHeader extends Text implements mx.controls.listClasses.IDropInListItemRenderer
    {
        public function ColumnHeader() {
            height = 20;
        }
        

        override public function set data(value:Object):void {
            super.data = value;
               
            switch (this.text) {  
            	//Select checkbox
                       case "Sel" :
                           this.toolTip = "Click here to select the item for approval. Click on a batch or cost centre section to select all the items for that section.";
                           break;
                //Authoriser created the payment checkbox
                       case "Authoriser" :
                       	   this.toolTip = "A tick here means that the same person entered and approved the payment.";
                           break;
                //New contributor checkbox
                       case "New" :
                       	   this.toolTip = "A tick here means that this is a new contributor.";
                           break;
                //Payment has been edited since creation chgeckbox
                       case "Changed" :
                       	   this.toolTip = "A tick here means that the payment has been edited after entry.";
                           break;
              // Govt Flag           
                        case "Govt" :
                      	   this.toolTip = "A tick here means that the Contributor is Government related";
                           break;     
               // Govt Flag           
                        case "Private Inv." :
                      	   this.toolTip = "A tick here means that the Contributor is a Private Investigator";
                           break;  
              // Govt Flag           
                        case "Service Agent" :
                      	   this.toolTip = "A tick here means that the Contributor is a Service Agent";
                           break;                                        
                //ECS status traffic light
                       case "Status" :
                       	   this.toolTip = "A red light means that the payment has not been approved by the desk head. A yellow light means it has been approved by the deskhead.";
                           break;
                       default :
                          break;
            }
           
            super.invalidateDisplayList();
        }
    }
}


