// ActionScript file

            /////////////////////////////////////////////////////////
			// Sorting, cloning and filtering functions for Arrays //
			////////////////////////////////////////////////////////
			
			protected function sortByColNo(a:Object, b:Object):int 
			{
				// Sort function used to sort an array by column number
				var ret:int;
				if (int(a.COL_NO) < int(b.COL_NO))
					ret = -1;
				if (int(a.COL_NO) > int(b.COL_NO))
					ret = 1;
				if (int(a.COL_NO) == int(b.COL_NO))
					ret = 0;		
				
				return ret;
			}
			
			protected  function sortByColOrder(a:Object, b:Object):int 
			{
				// Sort function used to sort an array by column number
				var ret:int;
				if (int(a.COL_ORDER) < int(b.COL_ORDER))
					ret = -1;
				if (int(a.COL_ORDER) > int(b.COL_ORDER))
					ret = 1;
				if (int(a.COL_ORDER) == int(b.COL_ORDER))
					ret = 0;		
				
				return ret;
			}
			
			protected  function removeEmptyNames(item:*, index:int, array:Array):Boolean
			{
				// Remove items from the array where NAME is empty
				var ret:Boolean = false;
				var obj:Object = Object(item)
				
				if (obj.hasOwnProperty("NAME") && obj.NAME != "")
					ret = true;
					
				return ret;
			}
			
			protected function clone(obj:Object):Object 
			{
				// Function to clone an object which contains only elementary elements
				// We use this if we want to add an element to an array, and subsequently change it, without changing the array
				var obj2:Object = new Object();
				obj2.originalWidth = obj.originalWidth;
				obj2.targetWidth = obj.targetWidth;
				obj2.index = obj.index;
				
				
				return obj2;
			}
			
			protected function removeItemAt(array:Array, index:uint):Array
			{
				var returnArray:Array;
				var l:uint = array.length;
				if (l == 0) return new Array();
				
				if (l == index + 1) // If we're removing the last element
				{
					returnArray = array.slice(0,l-1);
				}
				else if (index == 0) // If we're removing the fist element
				{
					returnArray = array.slice(1);
				}
				else
				{
					// Get the first section, before the element we are removing				
					returnArray = array.slice(0,index);
					returnArray = returnArray.concat(array.slice(index + 1))
					
					
				}
				
				return returnArray;
				
			}