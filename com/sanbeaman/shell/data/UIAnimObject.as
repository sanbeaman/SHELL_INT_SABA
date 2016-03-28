package com.sanbeaman.shell.data
{
	import com.sanbeaman.shell.widget.BodyUI;

	public class UIAnimObject
	{
		private var _id:String;
		private var _bodyui:BodyUI;
		
		public function UIAnimObject()
		{
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get bodyui():BodyUI
		{
			return _bodyui;
		}

		public function set bodyui(value:BodyUI):void
		{
			_bodyui = value;
		}


	}
}