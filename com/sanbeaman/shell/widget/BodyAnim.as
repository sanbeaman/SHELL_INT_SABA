package com.sanbeaman.shell.widget
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Sprite;
	
	public class BodyAnim extends BodyUI
	{
		private var _fullMediaPath:String;
		private var _iLoader:SWFLoader;
		private var _mediaItem:ContentDisplay;
		
		
		public function BodyAnim()
		{
			super();
		}
		
		public function init(mediaPath:String, iwidth:Number, iheight:Number):void
		{
			
		
			this.type = "bodyanim";
			
			_fullMediaPath =mediaPath;
			
			_loadMedia(_fullMediaPath,iwidth,iheight);
			
		}
		private function _loadMedia(mediapath:String,w:Number,h:Number ):void{
			_iLoader = new SWFLoader(mediapath, {container:this, width:w,height:h, onComplete:_mediaLoadComplete_handler});
			_iLoader.load();
		}
		private function _mediaLoadComplete_handler(evt:LoaderEvent):void
		{
			_mediaItem = evt.target.content;
			
			_mediaItem.x = 0;
			_mediaItem.y = 0;
			
			this.addChild(_mediaItem);
			trace("mediaLoaded");
		}
		public function gotoAndPlayFramelabel(frmLbl:String):void
		{
			_mediaItem.rawContent.gotoAndPlay(frmLbl);
			
		}
		public function gotoAndStopFramelabel(frmLbl:String):void
		{
			_mediaItem.rawContent.gotoAndStop(frmLbl);
			
		}

		
	}
}