package com.sanbeaman.shell.ui
{
	import flash.display.Sprite;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	
	public class ShellBack extends Sprite
	{
		private var _imgLink:String;
		
		public function ShellBack()
		{
			super();
			_imgLink = SHELL_VARS.FOLDER_SHELL_IMGS + "ShellBack.jpg";
			
			trace('_imgLink=' + _imgLink);
			var loader:ImageLoader = new ImageLoader(_imgLink, {container:this, onComplete:_onLoadComplete});
			loader.load();
			
		}
		private function _onLoadComplete(event:LoaderEvent):void {
			trace('_onLoadComplete= ' + _imgLink);
			
		}
	}
}