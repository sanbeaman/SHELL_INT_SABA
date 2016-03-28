package com.sanbeaman.shell.widget
{
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	
	TweenPlugin.activate([TransformAroundCenterPlugin,TransformAroundPointPlugin,ShortRotationPlugin]);
	
	public class Image_CoverFlow extends Sprite
	{
		public var cfname:String;
		//public var thumbnailLoader:ImageLoader;
		public var imageLoader:ImageLoader;
		//public var thumbnail:ContentDisplay;
		public var image:Sprite;
		
		private var _imgID:String;
		private var _imgIndex:int;
		
		
		public function Image_CoverFlow()
		{
			super();
		}
		
		public function get imgIndex():int
		{
			return _imgIndex;
		}
		
		public function set imgIndex(value:int):void
		{
			_imgIndex = value;
		}
		
		public function get imgID():String
		{
			return _imgID;
		}
		
		public function set imgID(value:String):void
		{
			_imgID = value;
		}
		
		public function init(name:String, imgid:String, contDisplay:ContentDisplay):void {
			this.cfname = name;
			//this.imageLoader = imageLoader;
			this._imgID = imgid
			this.image = new Sprite();
			this.image.addChild(contDisplay);
			this.addChild(image);
			//this.image.x = int(contDisplay.width * .5) * -1;
			//this.image.y = int(contDisplay.height * .5) * -1;
		}
	
		public function dispose():void {
			this.imageLoader.dispose(true);
		}
		
	}
}


