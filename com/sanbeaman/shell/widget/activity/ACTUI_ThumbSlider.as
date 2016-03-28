package com.sanbeaman.shell.widget.activity
{
	import com.greensock.loading.LoaderMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class ACTUI_ThumbSlider extends Sprite
	{
		
		private var _thumbNormalView:Bitmap;
		private var _thumbPrintView:Bitmap;
		
		private var _printViewOff:Boolean = true;
		
		public function ACTUI_ThumbSlider()
		{
			super();
		}
		
		public function build(bmp1:Bitmap, bmp2:Bitmap = null):void
		{
			_thumbNormalView = bmp1;
			var halfWidth:Number = int(_thumbNormalView.width *.5) * -1;
			var halfHeight:Number = int(_thumbNormalView.height *.5) * -1;
			_thumbNormalView.x = halfWidth;
			_thumbNormalView.y = halfHeight;
			if (bmp2 != null){
				_thumbPrintView = bmp2;
				_thumbPrintView.x = _thumbNormalView.x;
				_thumbPrintView.y = _thumbNormalView.y;// = halfHeight;
				this.addChild(_thumbPrintView);
			}
			this.addChild(_thumbNormalView);
		}

		public function get printViewOff():Boolean
		{
			return _printViewOff;
		}

		public function set printViewOff(value:Boolean):void
		{
			_printViewOff = value;
			_thumbNormalView.visible = _printViewOff;
			//_thumbPrintView.visible = _printViewOff;//
		}
		
		
	}
}