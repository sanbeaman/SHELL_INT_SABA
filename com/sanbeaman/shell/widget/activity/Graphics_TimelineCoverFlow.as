package com.sanbeaman.shell.widget.activity
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class Graphics_TimelineCoverFlow
	{
		/*
		[Embed (source="/masterShell/widgetui/timelineArrow_normal1.png")]
		public static var normalClass:Class;
		[Embed (source="/masterShell/widgetui/timelineArrow_hover1.png")]
		public static var hoverClass:Class;
		*/
		private var _bitmapNormal:Bitmap;
		private var _bitmapHover:Bitmap;
		
		internal static var _BMPData:BitmapData;
		
		internal static var _BMPArrowLeft_normal:BitmapData;
		internal static var _BMPArrowLeft_hover:BitmapData;
		
		internal static var _BMPArrowRight_normal:BitmapData;
		internal static var _BMPArrowRight_hover:BitmapData;
		
		
	
		public function Graphics_TimelineCoverFlow()
		{
			
			
			

		}
		/*
		public static function getBMPArrowLeft_normal():BitmapData
		{
			
			var bmp:Bitmap = new normalClass();
			
			_BMPArrowLeft_normal = bmp.bitmapData;
			
			return _BMPArrowLeft_normal;
		}
		
		
		public static function getBMPArrowLeft_hover():BitmapData
		{
			
			var bmp:Bitmap = new hoverClass();
			
			_BMPArrowLeft_hover = bmp.bitmapData;
			
			return _BMPArrowLeft_hover;
		}
		
		public static function getBMPArrowRight_normal():BitmapData
		{
			var bmp:Bitmap = new normalClass();
			var bmpdata:BitmapData = _flipBitmapData(bmp.bitmapData);
			_BMPArrowRight_normal = bmpdata;
			
			return _BMPArrowRight_normal;
		}

		public static function getBMPArrowRight_hover():BitmapData
		{
			var bmp:Bitmap = new hoverClass();
			var bmpdata:BitmapData = _flipBitmapData(bmp.bitmapData);
			_BMPArrowRight_hover = bmpdata;
			return _BMPArrowRight_hover;
		}
		*/
		
/*
		internal static function _getBitmapData():BitmapData
		{
			//var bmp:Bitmap = new _BMPData;
			return bmp.bitmapData;
		}
		*/

		public static function flipBitmapData(original:BitmapData, axis:String = "x"):BitmapData
		{
			var flipped:BitmapData = new BitmapData(original.width, original.height, true, 0);
			var matrix:Matrix
			if(axis == "x"){
				matrix = new Matrix( -1, 0, 0, 1, original.width, 0);
			} else {
				matrix = new Matrix( 1, 0, 0, -1, 0, original.height);
			}
			flipped.draw(original, matrix, null, null, null, true);
			return flipped;
		}
	}
}