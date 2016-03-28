package com.wbtmodules.ca.as3
{
	import flash.display.Sprite;
	import flash.text.*;
	
	public class Debugger extends Sprite
	{
		
		private var _db_tf:TextField;
		private var _db_string:String;
		
		public function Debugger()
		{
			super();
			_db_tf = new TextField();
			_db_tf.width = 200;
			_db_tf.border = true;
			_db_tf.background = true;
			
			_db_tf.autoSize = TextFieldAutoSize.LEFT;
			_db_tf.wordWrap = true;	
			
			this.addChild(_db_tf);
			_db_string = "Loading..."+ " \n ";
			_db_tf.htmlText = _db_string;
			
		}
		
		public function set db_string(debugmsg:String):void
		{
			//_db_string = _db_string + " \n " + debugmsg;
			_db_tf.htmlText += debugmsg;
			
		}
		
		public function displayText(debugmsg:String):void
		{
			//_db_string = _db_string + " \n " + debugmsg;
			_db_tf.htmlText += debugmsg;
			
		}
	}
}