package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.utils.CustomEaseHelper;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
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
	import flash.geom.Rectangle;

	public class BodyImage extends BodyUI
	{
		public static const IMG_LOAD_COMPLETE:String = "imgLoadComplete";
		
		private var _fullImgPath:String;
		private var _iLoader:ImageLoader;
		private var _scaleFactor:Number;		
		
		
		public var iwidth:Number;
		public var iheight:Number;	
		
		private var _img_width:Number;
		private var _img_height:Number;	
		
		private var _scaleIt:Boolean;
		private var _scaleMode:String;
		private var _centerImg:Boolean;
		private var _cropImage:Boolean;
		private var _imgLoaded:Boolean;

		private var _imageEffect:String;
		private var _imageStyle:String;
		
		private var _rigidDimensions:Boolean;
		
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
		
		public function BodyImage()
		{
			super();
			this.contentReady = false;
			
		}

		public function init(imagePath:String, scaleMode:String ="proportionalInside",  scaleFactor:Number = 1,imgwidth:Number = 100, imgheight:Number = 100,imgstyle:String = "none", imgeffect:String="none",  centerImg:Boolean = false):void
		{
			_imgLoaded = false;
			this.type = "bodyimage";
			
			iwidth = imgwidth;
			iheight = imgheight;
			_img_width = imgwidth;
			_img_height = imgheight;
			
			_fullImgPath =imagePath;
			_scaleFactor = scaleFactor;
			_scaleMode = scaleMode;
			
			
			_imageStyle = imgstyle;
			_imageEffect = imgeffect;
			
			_centerImg = centerImg;
			_cropImage = false;
			_rigidDimensions = false;
			if (_scaleMode == 'width') {
				_scaleMode = "proportionalOutside";
				_scaleIt = true;
				_cropImage = true;
				_rigidDimensions = true;
			} else if (_scaleMode == 'proportionalInside') {
				_scaleMode = "proportionalInside";
				_scaleIt = true;
				_cropImage = false;
				_rigidDimensions = false;
			} else if (_scaleMode == "none")  {
				_scaleIt = false;
				_rigidDimensions = false;
			} else {
				_scaleIt = true;
				_rigidDimensions = false;
			}
			if (_scaleIt == true && _scaleFactor == 1) {
				_iLoader = new ImageLoader(_fullImgPath, {container:this, width:iwidth,height:iheight,scaleMode:_scaleMode, centerRegistration:_centerImg,  crop:_cropImage, onComplete:_imgLoadComplete_handler});
			} else if (_scaleIt == true && _scaleFactor != 1) {
				_iLoader = new ImageLoader(_fullImgPath, {container:this, scaleX:_scaleFactor,scaleY:_scaleFactor,scaleMode:_scaleMode, centerRegistration:_centerImg, crop:_cropImage, onComplete:_imgLoadComplete_handler});
				
			} else {
				_iLoader = new ImageLoader(_fullImgPath, {container:this, centerRegistration:_centerImg, onComplete:_imgLoadComplete_handler});
				
			}
		//	_iLoader = new ImageLoader(iconpath, {container:this, width:w,height:h,scaleMode:"proportionalInside", centerRegistration:false, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
		}
		/*
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			iwidth = this.width;
			iheight = this.height;
			_imgLoaded = true;
			this.contentReady = true;
			//trace("imageloadd = iwidth= " + iwidth + " iheight= " + iheight);
		}
		*/
		
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			
			var imgbox:Sprite = new Sprite();
			var rawbitmap:Bitmap  = _iLoader.rawContent as Bitmap;
			
			var styleBox:Sprite = new Sprite();
			
			
			if (_imageStyle != "none") {
				styleBox = _addStyle(rawbitmap, _imageStyle);
			}
			
			trace('_imageEffect= ' + _imageEffect);
			switch (_imageEffect){
				case 'shadow':
					imgbox =  _addShadow(rawbitmap);
					//imgbox =  _addShadow(_iLoader.rawContent);
					break;
				case 'shadow2':
					//shadow2 uses the displayObject instead of raw bitmap
					imgbox = _addShadow2(_iLoader.content);
					break;
				case 'reflect':
					imgbox =  _addReflection(rawbitmap);
					//imgbox =  _addReflection(_iLoader.rawContent);
					
					break;
				case 'redbox':
					imgbox =  _addBox(rawbitmap, 'red');
				//	imgbox =  _addBox(_iLoader.content, 'red');
					
					break;
				default:
				//	imgbox = _addNOeffect(_iLoader.content);
					imgbox = _addNOeffect(_iLoader.content);
			}
			
			
			this.iwidth = imgbox.width;
			this.iheight = imgbox.height;
			
			this.addChild(imgbox);
			this.addChild(styleBox);
			this.contentReady = true;
		}
		
		
		private function _addStyle(bmp:Bitmap, istyle:String):Sprite
		{
			var stylebx:Sprite = new Sprite();
			var iw:Number;
			var ih:Number;
			
			if (_rigidDimensions){
				iw = _img_width;
				ih = _img_height;
			} else {
				var bmpBounds:Rectangle = bmp.getBounds(this);
				trace('bmpBounds x=' + bmpBounds.x + ' y=' + bmpBounds.y + ' width='+ bmpBounds.width + ' height=' + bmpBounds.height);
				iw = bmpBounds.width;
				ih = bmpBounds.height;
			}
			var styleShape:Shape;
			switch (istyle){
				case 'blackframe':
					styleShape = new Shape();
					styleShape.graphics.lineStyle(1,0x000000,1,true,LineScaleMode.NONE, CapsStyle.SQUARE,JointStyle.MITER);
					styleShape.graphics.drawRect(0,0,iw, ih);
					stylebx.addChild(styleShape);
					break;
				case 'redframe':
					styleShape = new Shape();
					styleShape.graphics.lineStyle(1,0xff0000,1,true,LineScaleMode.NONE, CapsStyle.SQUARE,JointStyle.MITER);
					styleShape.graphics.drawRect(0,0,iw, ih);
					stylebx.addChild(styleShape);
					break;
				
			}
			
			return stylebx;
		}
		/*
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
		
		
		
		
		*/
		
		private function _addNOeffect(rawContent:DisplayObject):Sprite
		{
			var spr:Sprite = new Sprite();
			
			//var imgBM:Bitmap  = rawContent;
			spr.addChild(rawContent);
			
			return spr;
			
			
			
		}
		private function _addBox(rawContent:DisplayObject, boxColor:String = 'black'):Sprite
		{
			
			var spr:Sprite = new Sprite();
			
			var dobj:DisplayObject = rawContent;
			spr.addChild(dobj);
			
			var sprRect:Rectangle = dobj.getRect(spr);
			var box:Sprite = new Sprite();
			
			//var imgBM:Bitmap  = rawContent;
			/*
			var picWidth:Number= dobj.width;
			var adjX:Number = picWidth * -.5;
			
			var picHeight:Number = dobj.height;
			var adjY:Number = picHeight * -.5;
			*/
			
			box.graphics.lineStyle(2,0xff0000,1,true,"none");
			box.graphics.beginFill(0xff0000,0);
			box.graphics.drawRect(sprRect.x,sprRect.y,sprRect.width,sprRect.height);
			//box.graphics.drawRect(adjX,adjY,picWidth,picHeight);
			box.graphics.endFill();//(0xff0000,1);
			
			spr.addChild(box);
			
			return spr;
			
			
		}
		
		
		private function _addShadow2(rawContent:DisplayObject):Sprite
		{
			var spr:Sprite = new Sprite();
			var sprRect:Rectangle = rawContent.getBounds(this);
			trace('sprRect='+ sprRect.toString());
			
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
		private function _addShadow(rawContent:Bitmap):Sprite
		{
			var spr:Sprite = new Sprite();
			var imgBM:Bitmap  = rawContent;
			
			var picWidth:Number= imgBM.width;
			
			var picHeight:Number = imgBM.height;
			
			spr.addChild(imgBM);
			
			var shadowWidth:Number = int(picWidth /3) * 2;
			var shadowDistance:Number = 20;
			var shadow:Sprite = new Sprite();
			var ellip:Shape = new Shape();
			var ellipWidth:Number= shadowWidth;
			var ellipHeight:Number= int(shadowWidth * .03);//8;
			trace("ellipHeight= " + ellipHeight);
			var fillType:String = GradientType.RADIAL;
			var colors:Array = [0x666666, 0xcccccc ];
			var alphas:Array = [.4, .2];
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
			
			
			var glowf:BitmapFilter = _getGLOWBitmapFilter();
			shadow.filters = [glowf];
			
			shadow.x = int(_img_width /2 ) - int(shadow.width/2);
			shadow.y = _img_height + shadowDistance;
			//shadow.x = int(iwidth /2) - int(shadow.width/2);
			//shadow.y = iheight + shadowDistance;
			spr.addChild(shadow);
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
			var color:Number = 0x666666;
			var alpha:Number = 0.6;
			var blurX:Number = 60;
			var blurY:Number = 10;
			var strength:Number = 2;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.MEDIUM;
			//var quality:Number = BitmapFilterQuality.HIGH;
			
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
		public function get imgLoaded():Boolean
		{
			return _imgLoaded;
		}

		
	}
}