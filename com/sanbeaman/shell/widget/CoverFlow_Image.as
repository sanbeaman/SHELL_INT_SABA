package com.sanbeaman.shell.widget
{
	import com.greensock.*;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.display.ContentDisplay;
	import com.greensock.plugins.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	TweenPlugin.activate([TransformAroundCenterPlugin,TransformAroundPointPlugin,ShortRotationPlugin]);

	public class CoverFlow_Image extends Sprite
	{
		public var cfname:String;
		//public var thumbnailLoader:ImageLoader;
		public var imageLoader:ImageLoader;
		//public var thumbnail:ContentDisplay;
		public var image:Sprite;
		
		private var _imgID:String;
		private var _imgIndex:int;
		
		public function CoverFlow_Image()
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

		public function init(name:String, imgid:String, imageLoader:ImageLoader):void {
			this.cfname = name;
			this.imageLoader = imageLoader;
			this._imgID = imgid
			_buildImage();
		}
		
		//The image is actually a Sprite that contains some description text at the bottom. If it has descriptive text, we put a 30% opaque black bar behind the white text to make it more readable too. 
		private function _buildImage():void {
			//this.visible = false;
			this.image = new Sprite();
			this.image.addChild(this.imageLoader.content);
			this.addChild(image);
		
		}
		
		public function dispose():void {
			this.imageLoader.dispose(true);
		}
		
	}
}
