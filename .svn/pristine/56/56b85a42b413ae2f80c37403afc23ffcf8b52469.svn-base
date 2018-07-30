package visualComponents {
     import mx.controls.DataGrid;
     import flash.display.Sprite;
     import flash.display.Shape;
     import mx.core.FlexShape;
     import flash.display.Graphics;
     import mx.controls.listClasses.ListBaseContentHolder;
     import mx.utils.GraphicsUtil;

     public class MyDataGrid extends DataGrid
     {
         public function MyDataGrid()
         {
             super();
         }
         override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void
         {
             var contentHolder:ListBaseContentHolder = ListBaseContentHolder(s.parent);
             var background:Shape;
             if (rowIndex < s.numChildren)
             {
                 background = Shape(s.getChildAt(rowIndex));
             }
             else
             {
                background = new FlexShape();
                background.name = "background";
                s.addChild(background);
            }
            background.y = y;

            // Height is usually as tall is the items in the row, but not if
            // it would extend below the bottom of listContent
            var height:Number = Math.min(height, contentHolder.height - y);

            var g:Graphics = background.graphics;

            g.clear();

// line item colour
            var color2:uint;
            if(dataIndex<this.dataProvider.length)
            {
                if(this.dataProvider.getItemAt(dataIndex).REJECTED && this.dataProvider.getItemAt(dataIndex).REJECTED == "X")
                {
					color2 = 0xFFE0E0; //FED6D6; // red
                }
                else
                {
					color2 = 0xE6F5FC; //E6F7FF; //B0F7C9; //FFFFFF;
                }
            }
            else
            {
                color2 = 0xFFFFFF; //B0F7C9; //FFFFFF;
            }
            g.beginFill(color2, getStyle("backgroundAlpha"));
            g.drawRect(0, 0, contentHolder.width, height);
            g.endFill();

        }
    }
}
