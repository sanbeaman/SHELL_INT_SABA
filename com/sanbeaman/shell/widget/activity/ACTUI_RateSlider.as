package com.sanbeaman.shell.widget.activity
{
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.sanbeaman.shell.ui.BMPLoader;
	import com.sanbeaman.shell.ui.BTN_BMPScale9SimpleState;
	import com.sanbeaman.shell.ui.BTN_BMPSimpleState;
	import com.sanbeaman.shell.ui.BTN_SpriteSimpleState;
	import com.sanbeaman.shell.widget.BodySlider;
	import com.sanbeaman.shell.widget.BodyUI;
	import com.sanbeaman.shell.widget.activity.ACTUI_ThumbSlider;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	public class ACTUI_RateSlider extends BodyUI
	{
		
		
		//private var  _bSlider:BodySlider;
		private var  _bSlider:ACTUI_BodySlider;
		//private var _btnStateQue:LoaderMax;
		
		private var _thumbSprite:Sprite;
		
		
		private var _sliderBack:Sprite;
		
		private var _ticks:Sprite;
		
		
		private var _snapIncrement:int = 30;
		
		private var _tickGraphic:Sprite;
		
		private var _bigTickLast:Boolean = true;
		
		public function ACTUI_RateSlider()
		{
			super();
			
			_sliderBack = new Sprite();
			//	_sliderBack.graphics.lineStyle(2,0x0000dd,1);
			_sliderBack.graphics.beginFill(0xffffff,0);
			_sliderBack.graphics.drawRect(0,0,300,32);
			_sliderBack.graphics.endFill();
			
			this.addChild(_sliderBack);
			
		//	var imgLink = SHELL_VARS.FOLDER_SHELL_IMGS + "SldrThumb_normal.gif";
			_thumbSprite  = new Sprite();
			
			
			///new ImageLoader(imgLink, {container:_thumbSprite,centerRegistration:true});
		//	loader.load();
		//	var thumbLoader:ImageLoader = new ImageLoader(RateSlider_thumb.gif", {container:_thumbSprite,centerRegistration:true});
		//	thumbLoader.load();
			
			/*
			var thumbSkinNormal:BMPLoader = new BMPLoader();
			thumbSkinNormal.init('SldrThumb_normal.gif');
			var thumbSkinHover:BMPLoader = new BMPLoader();
			thumbSkinHover.init('SldrThumb_hover.gif');
			var thumbSkinDown:BMPLoader = new BMPLoader();
			thumbSkinDown.init('SldrThumb_down.gif');
			
			var thumbBTN:BTN_SpriteSimpleState = new BTN_SpriteSimpleState('SldrThumb_normal.gif','SldrThumb_hover.gif','SldrThumb_down.gif');
			*/
			// _thumbSprite = new Sprite();
		
			var trackback:Sprite = new Sprite();
			trackback.graphics.lineStyle(1,SHELL_COLORS.lookUpColor("dkgrey"),1,true,LineScaleMode.NONE);
			trackback.graphics.beginFill(0xcccccc,1);
			trackback.graphics.drawRoundRectComplex(0,0,280,10,4,4,4,4);
			trackback.graphics.endFill();
			//	trackback.addChild(trackShape);
			trackback.cacheAsBitmap = true;
			var toShape:Shape = new Shape();
			var trackover:Sprite = new Sprite();
			
			
			
			/*
			//	var halfHeight:Number = _btnHeight * 0.5;
			var matr:Matrix = new Matrix();
			var halfHeight:int = 5;//10/2;
			matr.createGradientBox(40,10,gradRotation,0,0);
			//matr.createGradientBox(20, 20, 0, 0, 0);
			var spreadMethod:String = SpreadMethod.REFLECT;
			var interop:String = InterpolationMethod.RGB;
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [SHELL_COLORS.lookUpColor('dkorange'),SHELL_COLORS.lookUpColor('orange')];
			
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			
			var gradRotation:Number = new Number(0);
			gradRotation = (Math.PI / 180) * 90;  // This turns it 90 degrees clockwise
			
			toShape.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interop,0);//,"rgb",gradRotation);
			*/
			var barColorCode:uint = SHELL_COLORS.lookUpColor("orange");
			toShape.graphics.lineStyle(1,SHELL_COLORS.lookUpColor("dkgrey"),1,true,LineScaleMode.NONE);
			toShape.graphics.beginFill(barColorCode,1);
		//	toShape.graphics.drawRoundRect(0,0,12,10,4,4);
		//	toShape.graphics.drawRect(0,0,30,10);//(0,0,20,10,4,0,4,0);
			toShape.graphics.drawRoundRectComplex(0,0,270,10,4,0,4,0);
			toShape.graphics.endFill();
			
			var grid:Rectangle = new Rectangle(4,4,260,2);
			trackover.addChild(toShape);
			trackover.scale9Grid = grid;
		
			//trackover.scale9Grid = grid;
			
			
			/*
			
			
			_ticks = new Sprite();
			var ix:Number = 0;
			do {
			var tck:Sprite = _buildTick();
			tck.x = ix;
			_ticks.addChild(tck);
			ix += _snapIncrement;
			} while (ix <= 270);
			
			*/
			
			
			///new ImageLoader(imgLink, {container:_thumbSprite,centerRegistration:true});
			//	loader.load();
			//	var thumbLoader:ImageLoader = new ImageLoader(RateSlider_thumb.gif", {container:_thumbSprite,centerRegistration:true});
			//	thumbLoader.load();
			var bmp1load:Bitmap = LoaderMax.getLoader("RateSlider_thumb").rawContent;
			var bmpData1:BitmapData = bmp1load.bitmapData;
			var bmpData1Clone:BitmapData = bmpData1.clone();
			
			var bmp1:Bitmap = new Bitmap(bmpData1Clone);
			/*
			var bmp2load:Bitmap = LoaderMax.getLoader("RateSlider_thumbPrint").rawContent;
			var bmpData2:BitmapData = bmp2load.bitmapData;
			var bmpData2Clone:BitmapData = bmpData2.clone();
			
			var bmp2:Bitmap = new Bitmap(bmpData2Clone);
			*/
			var thmbSlider:ACTUI_ThumbSlider = new ACTUI_ThumbSlider();
			thmbSlider.build(bmp1);
			_bSlider = new ACTUI_BodySlider();
			//_bSlider = new BodySlider();
			_bSlider.init(trackback,trackover,thmbSlider,270,10,_snapIncrement);
		//	_bSlider.init(trackback,trackover,bmpData,270,10,_snapIncrement);
			_bSlider.y = (_sliderBack.height * .5)
			_bSlider.x = 10;//10;
			//	_ticks.x = 10;
			
			this.addChild(_bSlider);
			/*
			_ticks.mouseChildren = false;
			_ticks.mouseEnabled = false;
			_ticks.alpha = .5;
			
			this.addChild(_ticks);
			
			*/
		}
		
		/*
		private function _buildTick():Sprite
		{
			var spr:Sprite = new Sprite();
			var tline:Shape = new Shape();
			var sliderHeight:Number = 32;
			var lineThick:int;
			var lineHeight:int;
			var lineX:Number;
			var lineY:Number;
			
			if (_bigTickLast){
				lineThick = 1;
				lineHeight = 28;
				lineX = 0;
				lineY = 2;
				_bigTickLast = false;
			} else {
				lineThick = 3;
				lineHeight = 32;
				lineX = -1;
				lineY = 0;
				_bigTickLast = true;
			}
			tline.graphics.lineStyle(lineThick,0x000000,1,true,"none");
			tline.graphics.lineTo(0,lineHeight);
			tline.y = lineY;
			tline.x = lineX;//-1;
			spr.addChild(tline);
			
			return spr;
		}
		*/
		public function switchPrintView(printON:Boolean):void
		{
			_bSlider.printView = printON;
		}
		
		
	}
}

