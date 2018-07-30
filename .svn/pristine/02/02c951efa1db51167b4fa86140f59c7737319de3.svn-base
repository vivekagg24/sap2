// ActionScript file
		
			public static function sortByTOTAL_PAYMENTS2(o1:Object, o2:Object):int
			{
				return numericSortCompareFunction(o1.TOTAL_PAYMENTS2, o2.TOTAL_PAYMENTS2);				
			}
			
			public static function sortByNO_OF_PAYMENTS(o1:Object, o2:Object):int
			{
				return numericSortCompareFunction(o1.NO_OF_PAYMENTS, o2.NO_OF_PAYMENTS);				
			}

			public static function numericSortCompareFunction(o1:Object, o2:Object):int {
				// Used on numeric columns (such as currency) to ensure that they are sorted numerically instaead of by character
				var str1:String;
				var str2:String;
				var num1:Number;
				var num2:Number;
				var returnVal:int;
				
				str1 = o1.toString();
				str2 = o2.toString();
				
				num1 = Number(str1);
				if (isNaN(num1))
				{
					// Keep chopping leading characters off the strnig until we get a number
					// This is to deal with currencies
					num1 = Number(str1);
					while ( str1.length > 0 && isNaN(num1) )
					{
						str1 = str1.slice(1);
						num1 = str1 as Number;
					}
				}
				
				num2 = Number(str2);
				
				if (isNaN(num2))
				{
					// Keep chopping leading characters off the strnig until we get a number
					// This is to deal with currencies
					num1 = Number(str2);
					while ( str2.length > 0 && isNaN(num2) )
					{
						str2 = str2.slice(1);
						num2 = str2 as Number;
					}
				}
				
				if ( isNaN(num1) || isNaN(num2) || num2 == num1 )
					returnVal = 0;
				else if (num1 < num2)
					returnVal = -1;
				else if (num1 > num2)
					returnVal = 1;
				
				return returnVal;			
			}