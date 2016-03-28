package com.sanbeaman.shell.ui
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class BMPLoader extends Sprite
	{
		private var _bmp:Bitmap;
		
		private var _bmpdata:BitmapData;
		public function BMPLoader()
		{
			super();
		}
		
		
		public function init(imglink:String, path:String = null):void
		{
			var fullpath:String;
			if (path != null){
				fullpath = SHELL_VARS.FOLDER_SHELL_IMGS + imglink;// "ShellBack.jpg";
			} else {
				fullpath = path + imglink;
			}
			var loader:ImageLoader = new ImageLoader(fullpath, {onComplete:_onLoadComplete});
			loader.load();
			
		}
		
		private function _onLoadComplete(event:LoaderEvent):void {
		
			trace('_bmp loaded='+ event.target);
			_bmp  = event.target.rawContent as Bitmap;
			
		}
		
		public function get bmpdata():BitmapData
		{
			_bmpdata = _bmp.bitmapData;
			return _bmpdata;
		}

	}
}