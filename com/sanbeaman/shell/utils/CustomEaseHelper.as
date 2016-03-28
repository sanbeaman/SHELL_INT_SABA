package com.sanbeaman.shell.utils
{
	import com.greensock.easing.*;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.CustomEase;
	
	public class CustomEaseHelper
	{
		public var _quickBack:Function;
		public var _quickBack2:Function;
		
		public function CustomEaseHelper()
		{
			//_quickBack = CustomEase.create("QuickBack", [{s:0,cp:0.328,e:0.586},{s:0.586,cp:0.844,e:0.992},{s:0.992,cp:1.13999,e:1}]);
			//_quickBack2 = CustomEase.create("QuickBack2", [{s:0,cp:0.646,e:0.896},{s:0.896,cp:1.14599,e:1}]);
		}
		public static function find(str:String):Function
		{
			var easeString:String  = str.toLowerCase();
			var easeFunc:Function;
			
			if (easeString == 'quickback') {
				easeFunc =  CustomEase.create("QuickBack", [{s:0,cp:0.328,e:0.586},{s:0.586,cp:0.844,e:0.992},{s:0.992,cp:1.13999,e:1}]);
				
			} else if  (easeString == 'quickback2') {
				easeFunc = CustomEase.create("QuickBack2", [{s:0,cp:0.646,e:0.896},{s:0.896,cp:1.14599,e:1}]);
				
			} else {
				//easeFunc = EaseLookup.find(easeString);
			}
			
			return easeFunc;
			
		}
	}
}