package com.sanbeaman.shell.ui
{
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	
	public class GPSWindow extends Sprite
	{
		//[Embed (source="/masterShell/imgs/GPS_GraphicBackSimple.png")]
	//	private var _gps_back:Class
	//	public var gps_back:Bitmap = new _gps_back;
		private var _gps_window_x:Number = 23;
		private var _gps_window_y:Number =20;// 20;
		
		private var _scaleRect:Rectangle;
		
		private var _bmpLoader:BMPLoader;
		
		private var _gpsGraphicBack:BitmapSprite;
		

		private var _chrome:Sprite;
		
	
		
		private var _windowWidth:Number;
		private var _windowHeight:Number;
		private var _contentWidth:Number;
		private var _contentHeight:Number;
		
		private var _screenBack:Shape;
		
		public function GPSWindow()
		{
			super();
			
			_scaleRect = new Rectangle(20,20,360,220);
			

		}
		
		public  function buildGPSWindow(gpsimgpath:String,chromeW:Number,chromeH:Number,contentW:Number,contentH:Number,fillColorBack:String = "white",fillAlpha:Number = 0):void
		{
			_windowWidth = chromeW;
			_windowHeight = chromeH;
			_contentWidth = contentW;
			_contentHeight = contentH;
			var imgLink:String =gpsimgpath;// SHELL_VARS.FOLDER_SHELL_IMGS + gpsimgpath;
			var gpsbmp:Bitmap = LoaderMax.getLoader(imgLink).rawContent;
			this.addChild(gpsbmp);
			
		//	this.addChild(LoaderMax.getLoader(imgLink).content);
			//var loader:ImageLoader = LoaderMax.new ImageLoader(imgLink, {container:this});//, onComplete:_onLoadComplete});
		//	loader.load();
		//	_bmpLoader = new BMPLoader();
		//	var gpsgraphicpath:String = SHELL_VARS.FOLDER_SHELL_IMGS +  "GPS_GraphicBackSimple.png";
		//	_bmpLoader.init(gpsgraphicpath);
			
			//_gpsGraphicBack = new BitmapSprite(gpsbmp.bitmapData,_scaleRect);
			
			//_gpsGraphicBack.width =_windowWidth;// 735;
			//_gpsGraphicBack.height = _windowHeight;// 460;
			
			//this.addChild(_gpsGraphicBack);
			
			if (fillAlpha != 0) {
				var fillColorCode:uint = SHELL_COLORS.lookUpColor(fillColorBack);
				_screenBack = new Shape();
				_screenBack.graphics.beginFill(fillColorCode,fillAlpha);
				_screenBack.graphics.drawRect(0,0,_contentWidth,_contentHeight);
				_screenBack.graphics.endFill();
				_screenBack.x = _gps_window_x;
				_screenBack.y = _gps_window_y;
				this.addChild(_screenBack);
				
				
			}
			
			
		
		
		}
	}
}