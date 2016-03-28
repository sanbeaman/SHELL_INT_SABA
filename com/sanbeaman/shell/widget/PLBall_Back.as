package com.sanbeaman.shell.widget
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	
	public class PLBall_Back extends Sprite
	{
		[Embed (source="/masterShell/widget/preloader/plball_grey2.png")]
		private var _plBallBack:Class
		public var plBallBack:Bitmap = new _plBallBack;
		
		public function PLBall_Back()
		{
			super();
			this.addChild(plBallBack);
			
			this.cacheAsBitmap = true;
		}
	}
}