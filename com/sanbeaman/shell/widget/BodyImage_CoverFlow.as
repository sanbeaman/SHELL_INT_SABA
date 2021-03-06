package com.sanbeaman.shell.widget
{
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	
	public class BodyImage_CoverFlow extends BodyUI
	{
		private var _angle:Number;
		private var _image:DisplayObject;
		private var _mirror:DisplayObject;
		public var _name:String = "";
		
		
		private var _fullImgPath:String;
		
		
		private var _iLoader:ImageLoader;
		
		private var _scaleFactor:Number;
		
		
		public var iwidth:Number;
		public var iheight:Number;
		
		
		private var _scaleIt:Boolean;
		
		private var _scaleMode:String;
		
		private var _imageEffect:String;
		private var _centerImg:Boolean;// = true;
		
		private var _reflection:Bitmap;
		
		private var _backgroundColor:uint = 0xe1e1e1;
		private var _img:Sprite;
		
		private var _imgwidth:Number;
		private var _imgheight:Number;
		
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
		
		public function BodyImage_CoverFlow()
		{
			super();
			TweenPlugin.activate([TransformAroundCenterPlugin,TransformAroundPointPlugin,ShortRotationPlugin]);
		}
		
		public function init(imagePath:String, scaleMode:String ="proportionalInside",  scaleFactor:Number = 1,imgwidth:Number = 200, imgheight:Number = 200, imgeffect:String="normal", centerIt:Boolean = true):void
		{
			this.type = "bodylogo";
			_imgwidth = imgwidth;
			_imgheight = imgheight;
			
			iwidth = imgwidth;
			iheight = imgheight;
			
			//this.graphics.lineStyle(1,0xff0000);
			//this.graphics.drawRect(0,0,imgwidth,imgheight);
			//this.graphics.endFill();
			
			_fullImgPath =imagePath;
			_scaleFactor = scaleFactor;
			_centerImg = centerIt;
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
			_img = new Sprite();
			//	this.addChild(_img);
			_loadImageIcon(_fullImgPath, _scaleIt);
			
		}
		
		private function _loadImageIcon(iconpath:String, toScale:Boolean ):void{
			if (toScale == true && _scaleFactor == 1) {
				_iLoader = new ImageLoader(iconpath, {container:_img, width:iwidth,height:iheight,scaleMode:_scaleMode,  vAlign:"middle",hAlign:"center", centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
			} else if (toScale == true && _scaleFactor != 1) {
				_iLoader = new ImageLoader(iconpath, {container:_img, scaleX:_scaleFactor,scaleY:_scaleFactor,scaleMode:_scaleMode, vAlign:"middle",hAlign:"center", centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
				
			} else {
				_iLoader = new ImageLoader(iconpath, {container:_img, width:iwidth,height:iheight, vAlign:"middle",hAlign:"center",scaleMode:_scaleMode, centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
				
			}
			//	_iLoader = new ImageLoader(iconpath, {container:this, width:w,height:h,scaleMode:"proportionalInside", centerRegistration:false, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
		}
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			//iwidth = _img.width;
			//iheight = _img.height;
			//trace("imageloadd = iwidth= " + iwidth + " iheight= " + iheight);
			var logoBox:Sprite = new Sprite();
			//logoBox.width = iwidth;
			//logoBox.height = iheight;
			
			
			
			switch (_imageEffect){
				case 'shadow':
					logoBox =  _addShadow(_iLoader.content);
					break;
				case 'reflect':
					logoBox =  _addReflection(_iLoader.rawContent);
					
					break;
				default:
					logoBox = _addNOeffect(_iLoader.content);
					//logoBox = new Sprite();
					//	logoBox.x = this.width /2;
					//logoBox.y = this.height/2;
					//logoBox.addChild(_iLoader.content);
			}
			
			this.addChild(logoBox);
			//	
			
			
		}
		
		
		private function _addNOeffect(rawContent:DisplayObject):Sprite
		{
			var spr:Sprite = new Sprite();
			
			//var imgBM:Bitmap  = rawContent;
			spr.addChild(rawContent);
			
			return spr;
			
			
			
		}
		
		
		
		private function _addShadow(rawContent:DisplayObject):Sprite
		{
			var spr:Sprite = new Sprite();
			//var imgBM:Bitmap  = rawContent;
			
			var picWidth:Number= rawContent.width;
			
			var picHeight:Number = rawContent.height;
			
			spr.addChild(rawContent);
			
			var shadowWidth:Number = picWidth;// int(picWidth /3) * 2;
			var shadowDistance:Number = int(picHeight/8);
			var shadow:Sprite = new Sprite();
			
			var ellipWidth:Number= shadowWidth;
			var ellipHeight:Number=8;
			var fillType:String = GradientType.RADIAL;
			
			var mat:Matrix = new Matrix();
			
			var colors:Array = [0x000000, 0xcccccc ];
			var alphas:Array = [.6, .2];
			var ratios:Array = [0,255];
			
			
			
			
			
			//x- and y- scaling of a radial gradient will automatically happen
			//if you use a non-square 'gradientBox' for radial gradient, as in
			//ellip below. The radial gradient will be vertically squeezed
			//by the factor of 2 as ellipHeight is twice smaller than ellipWidth.
			//In additon, the size of the gradientBox is smaller than the size of
			//the ellipse, 'ellip'. The gradient will spread according to
			//SpreadMethod.REFLECT. Note the translation parameters that move
			//the center of the gradient to the center of 'ellip'.
			//var shadowW:Number = int(ellipWidth /3) * 2;
			mat.createGradientBox(ellipWidth,ellipHeight,_toRad(-90),0,0);//3*ellipWidth/8,3*ellipHeight/8);
			var ellip:Shape = new Shape();
			ellip.graphics.lineStyle();
			ellip.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat, 
				SpreadMethod.PAD);
			var adjY:Number = int(ellipHeight/2) *-1;
			var adjX:Number = int(ellipWidth/2) * -1;
			ellip.graphics.drawEllipse(0,0,ellipWidth,ellipHeight);
			ellip.graphics.endFill();
			ellip.x = adjX;
			ellip.y = adjY;
			
			shadow.addChild(ellip);
			
			
			var glowf:BitmapFilter = _getGLOWBitmapFilter();
			shadow.filters = [glowf];
			
			shadow.x = 0;// int(picWidth /2);// - shadow.width;
			shadow.y = int(picHeight/2) + shadowDistance;
			spr.addChild(shadow);
			
			
			TweenLite.to(shadow, 0, {transformAroundCenter:{scale:.7, alpha:.7}});
			
			spr.cacheAsBitmap = true;
			
			return spr;
			
		}
		private function _addDropShadow():void
		{
			
			
			var filter:BitmapFilter = _getDSBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			filters = myFilters;
			
		}
		private function _getGLOWBitmapFilter():BitmapFilter {
			var color:Number = 0x333333;
			var alpha:Number = 0.8;
			var blurX:Number =40;
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
		
		
		// adding a simple reflection
		private function _addReflection(rawContent:Bitmap):Sprite
		{
			
			var spr:Sprite = new Sprite();
			
			var imgBM:Bitmap  = rawContent;
			
			var picWidth:Number= imgBM.width;
			
			var picHeight:Number = imgBM.height;
			
			//The gap, in pixels betwen the image and its refelection.
			
			var gap:Number=2;
			
			/*
			'Shuttle' is a BitmapData object which can be instantiated at runtime. 
			This is what we are doing in the next line. Then we create two Bitmaps,
			'topImg' and 'reflImg', to hold the image and its reflection, repectively.
			*/
			
			
			var imgBD:BitmapData= imgBM.bitmapData;
			
			//new logo_fiat(picWidth,picHeight);
			
			var topImg:Bitmap=new Bitmap(imgBD);
			
			var reflImg:Bitmap=new Bitmap(imgBD);
			
			spr.addChild(topImg);
			
			spr.addChild(reflImg);
			
			/*
			To flip the reflection image horizontally, we use scaleY=-1 which
			reverses the sign of the y coordinate of each point within 'reflImg'.
			That causes the flip about the horizontal axis. Note that the flip moves 
			the registration point of the flipped 'reflImg' to its lower left corner.
			(In FP10, we could use reflImg.rotationX=180 to accomplish the flip.)
			*/
			
			reflImg.scaleY=-1;
			
			/*
			We position the image 80 pixels above the center of the Stage
			and its reflection beneath the image.
			*/
			
			
			topImg.x=0;// (this.width /2) - (picWidth/2);//250-picWidth/2;
			
			topImg.y=0;// (this.height /2) - (picHeight) - (picHeight/2);//220-picHeight/2-80;
			
			reflImg.x=topImg.x;
			
			reflImg.y=topImg.y+2*picHeight+gap;
			
			/*
			In order to create a gradient effect for the reflection,
			we will create a gradient mask for 'reflImg'. 
			*/
			
			var maskingShape:Shape=new Shape();
			
			//Even though the mask itself will not be visible, it MUST be
			//added to the Display List.
			
			spr.addChild(maskingShape);
			
			maskingShape.scaleY=-1;
			
			maskingShape.x=reflImg.x;
			
			maskingShape.y=reflImg.y;
			
			
			//in 'maskingShape'.
			
			var mat:Matrix= new Matrix();
			
			var colors:Array=[0xFF0000,0xFF0000];
			
			//var alphas:Array=[0,0.7];
			
			//var alphas:Array=[0,1];
			var alphas:Array=[0,0.5];
			//var ratios:Array=[10,255];
			
			//var ratios:Array=[100,255];
			//var ratios:Array=[0,100];
			
			var ratios:Array = [127, 255];
			mat.createGradientBox(picWidth,picHeight,90*(Math.PI/180));
			
			maskingShape.graphics.lineStyle();
			
			maskingShape.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,mat);
			
			maskingShape.graphics.drawRect(0,0,picWidth,picHeight);
			
			maskingShape.graphics.endFill();
			
			/*
			The next two lines are crucial for a gradient mask to bahave
			properly: both a masked Display Object and a masking Display Object
			must be cached as Bitmaps. Otherwise, the whole area of the gradient
			(except for the completely transparent areas) will fully reveal 
			the underlying image, and the gradient effect will not happen.
			*/
			
			reflImg.cacheAsBitmap=true;
			
			maskingShape.cacheAsBitmap=true;
			
			//We assign 'maskingShape' to be a mask of 'reflImg'.
			
			reflImg.mask=maskingShape;
			
			/*
			The function defined below draws a linear gradient in 'maskingShape'.
			If you wish to see the gradient drawn, comment out the line above.
			You see a linear gradient that goes from transparent red to full red,
			rotated 90 degrees. The rotation happens within
			the gradient box:
			
			mat.createGradientBox(picWidth,picHeight,90*(Math.PI/180));
			
			90 degress is converted to radians: 90*(Math.PI/180).
			*/
			spr.cacheAsBitmap = true;
			
			return spr;
			
		}
		private function _toRad(a:Number):Number {
			return a*Math.PI/180;
		}
		
		
	}
}

