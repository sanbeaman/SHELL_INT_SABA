package com.sanbeaman.shell.utils
{
	public dynamic class SimpleUtils
	{
		
		public static function convertString2Boolean(value:String):Boolean
		{
			
			var valueStrg:String = value.toLowerCase();
		
			switch(valueStrg) {
				case "1":
				case "true":
				case "yes":
					return true;
				case "0":
				case "false":
				case "no":
					return false;
				default:
					return Boolean(value);
			}

		}
		
		/**
		 * This static method can be used to help position a UI element based on an relative position
		 * 
		 * @param position String  a term representing a position in on the x-axis or y-axis.
		 * @param stageDimension Number  the width or height of the area that the ui will be placed in
		 * @param uiDimensionNumber  the width or height of the UI Element that will be placed
		 * @param pad Number representing any padding that needs to be applied
		 * @return Number  either the x or y value for UI element
		 */
		public static function relativeLayoutConverter(position:String, stageDimension:Number, uiDimension:Number = 0, pad:Number = 0, layoutMod:String = null):Number
		{
			var pos:String = position.toLowerCase();
			var value:Number;
			var layoutmod:String = (layoutMod != null)?layoutMod:"none";
			switch (pos) {
				case 'left':
					if (layoutmod == "flipx"){
						value = stageDimension - (uiDimension + pad);
					} else {
					value = pad;
					}
					break;
				case 'right':
					if (layoutmod == "flipx"){
						value = pad;
					} else {
					value = stageDimension - (uiDimension + pad);
					}
					break;
				case 'center':
					value = (stageDimension * .5) - (uiDimension * .5);///pad;
					break;
				case 'top':
					value = pad;
					break;
				case 'middle':
					value = (stageDimension* .5) - (uiDimension * .5);
					break;
				case 'bottom':
					value = stageDimension - (uiDimension + pad);
					break;
			}
			
			return int(value);
		}
		
		public static  function customSortAlgo(objA:Object, objB:Object):int {
			if (objA.order < objB.order) {
				return -1;
			} else if (objA.order > objB.order) {
				return 1;
			} else {
				return 0;
			}
		}
		
		public static function renderArr(items:Array):void {
			
			for(var i:Number = 0; i < items.length; i++){
				
				trace('order= ' + items[i].name);
				
			}
			
		}
		
	}
}