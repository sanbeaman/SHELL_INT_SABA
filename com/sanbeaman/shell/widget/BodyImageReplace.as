package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.utils.CustomEaseHelper;
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	public class BodyImageReplace extends BodyUI
	{
		private var _fullImgPath:String;
		
		
		private var _iLoader:ImageLoader;
		
		private var _scaleFactor:Number;
		
		
		public var iwidth:Number;
		public var iheight:Number;
		
		
		private var _scaleIt:Boolean;
		
		private var _scaleMode:String;
		
		private var _imageEffect:String;
		private var _imageStyle:String;
		
		private var _centerImg:Boolean;// = false;
		
		/**
		 * 
		 *  	heightOnly  Stretches the object's height to fill the area vertically, but does not affect its width
		 *  	none Does not scale the object at all
		 * 		proportionalInside Scales the object proportionally to fit inside the area (its edges will never exceed the bounds of the area).
		 * 		proportionalOutside Scales the object proportionally to completely fill the area, allowing portions of it to exceed the bounds when its aspect ratio doesn't match the area's.
		 * 		stretch Stretches the object to fill the area completely in terms of both width and height.
		 * 		 widthOnly Stretches the object's width to fill the area horizontally, but does not affect its height
		 * 
		 * */
		
		public function BodyImageReplace()
		{
		
			super();

		}
		
		
		
		public function init(imagePath:String, scaleMode:String ="proportionalInside",  scaleFactor:Number = 1,imgwidth:Number = 200, imgheight:Number = 200,imgstyle:String = "none", imgeffect:String="none", centerIt:Boolean = false):void
		{
			this.type = "bodyimage";
			
			iwidth = imgwidth;
			iheight = imgheight;
			
			_fullImgPath =imagePath;
			_scaleFactor = scaleFactor;
			_centerImg = centerIt;
			_imageStyle = imgstyle;
			_imageEffect = imgeffect;
			if (scaleMode == 'width') {
				_scaleMode = "proportionalOutside";
				_scaleIt = true;
			} else if (_scaleMode == "none")  {
				_scaleIt = false;
			} else {
				_scaleIt = true;
				_scaleMode = scaleMode;
			}
			
			_loadImageIcon(_fullImgPath, _scaleIt);
			
		}
		
		private function _loadImageIcon(iconpath:String, toScale:Boolean ):void{
			if (toScale == true && _scaleFactor == 1) {
				_iLoader = new ImageLoader(iconpath, {container:this, width:iwidth,height:iheight,scaleMode:_scaleMode, centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
			} else if (toScale == true && _scaleFactor != 1) {
				_iLoader = new ImageLoader(iconpath, {container:this, scaleX:_scaleFactor,scaleY:_scaleFactor,scaleMode:_scaleMode, centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
				
			} else {
				_iLoader = new ImageLoader(iconpath, {container:this, centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
				
			}
			//	_iLoader = new ImageLoader(iconpath, {container:this, width:w,height:h,scaleMode:"proportionalInside", centerRegistration:false, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
		}
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			iwidth = this.width;
			iheight = this.height;
			//	trace("imageloadd = iwidth= " + iwidth + " iheight= " + iheight);
			if (_imageStyle != "none"){
				_addStyle(_imageStyle);
			}
			if (_imageEffect != "none"){
				_addEffect(_imageEffect);
			}
	
		}
		private function _addStyle(istyle:String):void
		{
			switch (istyle){
				case 'blackframe':
					var blackframe:Shape = new Shape();
					blackframe.graphics.lineStyle(1,0x000000,1,true,LineScaleMode.NONE, CapsStyle.SQUARE,JointStyle.MITER);
					blackframe.graphics.drawRect(0,0,this.width, this.height);
					this.addChild(blackframe);
					break;
				
			}
		}
		
		private function _addEffect(ifx:String):void
		{
			switch (_imageEffect){
				case 'shadow':
					_addShadow();
					break;
				case 'reflect':
					_addReflection();
					break;
				default:
					
			}
			
			//_addShadow();
		}
		private function _addReflection():void
		{
			trace('rflect');
			
		}
		private function _addShadow():void
		{
			
			var shadow:Sprite = new Sprite();
			var ellip:Shape = new Shape();
			var ellipWidth:Number=244;
			var ellipHeight:Number=8;
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0x000000, 0xcccccc ];
			var alphas:Array = [.6, .2];
			var ratios:Array = [0,255];
			var mat:Matrix = new Matrix();
			
			
			//x- and y- scaling of a radial gradient will automatically happen
			//if you use a non-square 'gradientBox' for radial gradient, as in
			//ellip below. The radial gradient will be vertically squeezed
			//by the factor of 2 as ellipHeight is twice smaller than ellipWidth.
			//In additon, the size of the gradientBox is smaller than the size of
			//the ellipse, 'ellip'. The gradient will spread according to
			//SpreadMethod.REFLECT. Note the translation parameters that move
			//the center of the gradient to the center of 'ellip'.
			mat.createGradientBox(ellipWidth,ellipHeight,_toRad(-90),0,0);//3*ellipWidth/8,3*ellipHeight/8);
			ellip.graphics.lineStyle();
			ellip.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat, 
				SpreadMethod.PAD);
			ellip.graphics.drawEllipse(0,0,ellipWidth,ellipHeight);
			ellip.graphics.endFill();
			
			shadow.addChild(ellip);
			/*
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0xffffff, 0x000000];
			var alphas:Array = [0, 1];
			var ratios:Array = [0x00, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(20, 20,Math.PI / 2 , 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			//	this.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);       
			//	this.graphics.drawRect(0,0,100,100);
			
			var shadow:Sprite = new Sprite();
			shadow.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);  
			shadow.graphics.drawEllipse(0,0,244,6);
			*/
			
			var glowf:BitmapFilter = _getGLOWBitmapFilter();
			shadow.filters = [glowf];
			
			shadow.x = int(iwidth /2) - int(shadow.width/2);
			shadow.y = iheight + 20;
			this.addChild(shadow);
			
		}
		private function _addDropShadow():void
		{
			
			
			var filter:BitmapFilter = _getDSBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			filters = myFilters;
			
		}
		private function _getGLOWBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var alpha:Number = 0.8;
			var blurX:Number = 60;
			var blurY:Number = 10;
			var strength:Number = 2;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			return new GlowFilter(color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
		
		
		private function _getDSBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var angle:Number = 90;
			var alpha:Number = 0.8;
			var blurX:Number = 8;
			var blurY:Number = 8;
			var distance:Number = 60;
			var strength:Number = 0.65;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			return new DropShadowFilter(distance,
				angle,
				color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
		
		
		private function _toRad(a:Number):Number {
			return a*Math.PI/180;
		}
		//you build these functions into your objects (classes, MovieClips, whatever):
		public function animateIn():TimelineLite {
			var tl:TimelineLite = new TimelineLite();
			tl.append(TweenLite.from(this,1,{autoAlpha:0,ease:CustomEaseHelper.find(this.ease)}));
			//tl.append( new TweenMax(this, 1, {autoAlpha:1,ease:CustomEaseHelper.find(this.ease)}) );
			return tl;
		}
		
		public function animateOut():TimelineLite {
			var tl:TimelineLite = new TimelineLite();
			tl.append(TweenLite.to(this,1,{autoAlpha:0,ease:CustomEaseHelper.find(this.ease)} ));
			//tl.append( new TweenMax(this, 1, {autoAlpha:0,ease:CustomEaseHelper.find(this.ease)}) );
		//	tl.append( new TweenMax(this, 3, {autoAlpha:0}) );
			return tl;
		}
		
	}
}

