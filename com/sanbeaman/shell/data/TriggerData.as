package com.sanbeaman.shell.data
{
	import com.sanbeaman.shell.widget.BodyUI;

	public class TriggerData
	{
		private var _triggerType:String;
		private var _triggerTime:Number;
		private var _triggerTarget:BodyUI;
		private var _trigerTimeIN:Number;
		private var _triggerTimOUT:Number;
		private var _triggerID:String;
		private var _triggerIndex:int;
		
		public function TriggerData()
		{
		}

		public function get triggerType():String
		{
			return _triggerType;
		}

		public function set triggerType(value:String):void
		{
			_triggerType = value;
		}

		public function get triggerTime():Number
		{
			return _triggerTime;
		}

		public function set triggerTime(value:Number):void
		{
			_triggerTime = value;
		}

		public function get triggerTarget():BodyUI
		{
			return _triggerTarget;
		}

		public function set triggerTarget(value:BodyUI):void
		{
			_triggerTarget = value;
		}

		public function get trigerTimeIN():Number
		{
			return _trigerTimeIN;
		}

		public function set trigerTimeIN(value:Number):void
		{
			_trigerTimeIN = value;
		}

		public function get triggerTimOUT():Number
		{
			return _triggerTimOUT;
		}

		public function set triggerTimOUT(value:Number):void
		{
			_triggerTimOUT = value;
		}

		public function get triggerID():String
		{
			return _triggerID;
		}

		public function set triggerID(value:String):void
		{
			_triggerID = value;
		}

		public function get triggerIndex():int
		{
			return _triggerIndex;
		}

		public function set triggerIndex(value:int):void
		{
			_triggerIndex = value;
		}


	}
}