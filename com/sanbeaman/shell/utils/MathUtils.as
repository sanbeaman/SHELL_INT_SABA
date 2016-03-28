package com.sanbeaman.shell.utils
{
	public class MathUtils
	{
		public function MathUtils()
		{
		}
		
		public static function roundDecimal(num:Number, precision:int):Number{
			
			var decimal:Number = Math.pow(10, precision);
			
			return Math.round(decimal* num) / decimal;
			
		}
	}
}