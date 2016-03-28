package com.sanbeaman.shell.widget
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	
	public class PLBall_Blue extends Sprite
	{
		[Embed (source="/masterShell/widget/preloader/plball_blue2.png")]
		private var _plBallBlue:Class;
		public var plBallBlue:Bitmap = new _plBallBlue;
		
		public function PLBall_Blue()
		{
			super();
			this.addChild(plBallBlue);
			
			this.cacheAsBitmap = true;
		}
	}
}
