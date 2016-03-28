package com.sanbeaman.shell.widget
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
	import flash.display.Sprite;
	
	public class StaticImage extends Sprite
	{
		private var _fullImgPath:String;
		
		private var _iLoader:ImageLoader;
		
		private var _centerIt:Boolean;
		private var _effect:String;
		
		public function StaticImage()
		{
			super();
		}
		
		public function init(imagePath:String, centerit:Boolean = false, effect:String = "none"):void
		{
			_fullImgPath =imagePath;
			_centerIt = centerit;
			_effect = effect;
			_iLoader = new ImageLoader(_fullImgPath, {container:this, centerRegistration:_centerIt, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
		}
		
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			if (_effect == "fade") {
				TweenMax.fromTo(this,0,{alpha:0},{alpha:.2});
			}
			trace('Static Image Loaded');
		}
		
	}
}
