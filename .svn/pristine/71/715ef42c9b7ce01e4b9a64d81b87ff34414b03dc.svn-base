package CMS.Components{
	
   import mx.core.*;
   import mx.controls.dataGridClasses.*;
   import mx.controls.DataGrid;
   import flash.display.*;
   import mx.collections.ArrayCollection;
   
   // The Variant DataGrid classes are in the VDG_Library project. You need to import this project
   // into your workspace in order to run this program, otehrwise you will see messages telling you 
   // that Flex cannot find the class VariantdataGrid.
   import VDG.*;
   
   public class CMSDataGrid extends VariantDataGrid
   {

   	  
      override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number,
                                                   color:uint, dataIndex:int):void{
   
        // make any tests here, then change color accordingly. For example: color = 0xFF0000; 
        // call the super function to make it happen.
        var allData:ArrayCollection= (dataProvider as ArrayCollection);

        if (dataProvider!=null && allData.length>dataIndex){ 

	        var item:Object ;
	       
	        item = allData.getItemAt(dataIndex);
	        if (item.costCentreLine){

	            color = 0xADCBF8;   
	        	  
	        }else if (item.WeekStartLine){
	        	
	        	color = 0xC0D9F2;

	        }else if (item.CasualLine){

	        	color = 0xD3ECFE;
	        		          
	        }else if (item.highlightRow){
	        	
	        	color = 0xffcccc; 
	        	
	        }else{
	        	
	        	color = 0xFFFFFF; 
	        	
	        }
	        	       
        }
        super.drawRowBackground(s,rowIndex,y,height,color,dataIndex);

    } 

       
   }
}
