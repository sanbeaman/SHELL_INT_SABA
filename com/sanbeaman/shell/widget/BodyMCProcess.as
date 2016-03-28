package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.widget.MCprocessAnim;
	
	import flash.display.MovieClip;
	
	public class BodyMCProcess extends BodyUI
	{
		
		private var _mcProcess:MCprocessAnim;
		private var _frameLabel:String;
		
		public function BodyMCProcess()
		{
			super();
			_mcProcess = new MCprocessAnim;
			this.type = "bodymcprocess";
			
			this.addChild(_mcProcess);
		}
		
		
		public function get frameLabel():String
		{
			return _frameLabel;
		}

		public function set frameLabel(value:String):void
		{
			_frameLabel = value;
			_mcProcess.gotoAndPlay(_frameLabel);
		}

	}
}