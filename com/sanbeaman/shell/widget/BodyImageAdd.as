package com.sanbeaman.shell.widget
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.widget.BodyUI;
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	public class BodyImageAdd extends BodyUI
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
		
		public function BodyImageAdd()
		{
			super();
		}
		
		public function init(imagePath:String, scaleMode:String ="proportionalInside",  scaleFactor:Number = 1,imgwidth:Number = 200, imgheight:Number = 200,imgstyle:String = "none", imgeffect:String="none", centerIt:Boolean = false):void
		{
			this.type = "imageadd";
			trace('BodyImage1= ' + imagePath + '-sm-'+ scaleMode + '-sf' + scaleFactor + '-iw-' + imgwidth + '-ih-' + imgheight);
			iwidth = imgwidth;
			iheight = imgheight;
			
			
			_imageStyle = imgstyle;
			_imageEffect = imgeffect;
			_fullImgPath =imagePath;
			_scaleFactor = scaleFactor;
			_scaleMode = scaleMode;
			
			if (_scaleMode == 'width') {
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
				_iLoader = new ImageLoader(iconpath, {container:this, width:iwidth,height:iheight,scaleMode:_scaleMode, centerRegistration:false, onComplete:_imgLoadComplete_handler});
			} else if (toScale == true && _scaleFactor != 1) {
				_iLoader = new ImageLoader(iconpath, {container:this, scaleX:_scaleFactor,scaleY:_scaleFactor,scaleMode:_scaleMode, centerRegistration:false, onComplete:_imgLoadComplete_handler});
				
			} else {
				_iLoader = new ImageLoader(iconpath, {container:this, centerRegistration:false, onComplete:_imgLoadComplete_handler});
				
			}
			//	_iLoader = new ImageLoader(iconpath, {container:this, width:w,height:h,scaleMode:"proportionalInside", centerRegistration:false, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
		}
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			iwidth = this.width;
			iheight = this.height;
			trace("imageloadd = iwidth= " + iwidth + " iheight= " + iheight);
			
			if (_imageStyle != "none"){
			_addStyle(_imageStyle);
			}
			/*if (_imageEffect != "none"){
			_addEffect(_imageEffect);
			}*/
		
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
		
	}
}