package com.sanbeaman.shell.utils
{
	import flash.display.Sprite;
	import flash.display.Sprite;
	import flash.text.*;
	
	public class SlideTimeCode extends Sprite
	{
		private var _timecode_tf:TextField;
		private var _slideNumber_tf:TextField;
		
		private var _timeInMilliseconds:Number;
		private var _timecode_seconds:Number;
		
		public function SlideTimeCode()
		{
			super();			
		}
		
		public function init(str:String):void
		{
			_timecode_tf = _createTbox();
			//_slideNumber_tf = _createTbox();
			//_slideNumber_tf.text = "  "+ str;
			//_slideNumber_tf.x = 4;
			_timecode_tf.x = 0;
			_timecode_tf.text = "secs";
			
			//this.addChild(_slideNumber_tf);
			this.addChild(_timecode_tf);
				
		}

		private function _createTbox():TextField {
			
			var tf:TextField = new TextField();
			
			tf.height = 18;
			
			tf.width = 40;
			tf.multiline = false;
			tf.border = true;
			tf.background = true;
			tf.borderColor = 0x00ff00;
			tf.backgroundColor = 0x000000;
			tf.defaultTextFormat = _setTF();
			tf.selectable = false;
			return tf;
			
			
		}
		private function _setTF():TextFormat
		{
			var tformat:TextFormat = new TextFormat();
			tformat.leftMargin = 4;
			tformat.rightMargin = 4;
			tformat.size = 16;
			tformat.align = "right";
			
			tformat.bold = true;
			tformat.color = 0x00ff00;
			
			return tformat;
			
		}
		
		public function get timeInMilliseconds():Number
			
		{
			return _timeInMilliseconds;
		}
		
		public function set timeInMilliseconds(value:Number):void
			
		{
			_timeInMilliseconds = value;
			
			_timecode_seconds = _timeInMilliseconds * .001;
			_timecode_tf.text = _timecode_seconds.toFixed(2);
			
		}
		
		public function get timecode_seconds():Number
			
		{
			return _timecode_seconds;
		}
		
		public function set timecode_seconds(value:Number):void
			
		{
			_timecode_seconds = value;
			_timecode_tf.text = _timecode_seconds.toFixed(2);
		}
		
		
	}
}