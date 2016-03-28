package com.sanbeaman.shell.data
{
	public class SlideObject
	{
		
		private var _slideID:String;
		private var _slideType:String;
		private var _slideAnimType:String;
		
		private var _slideNumber:String;
		private var _slideIndex:int;
		private var _slideContent:XMLList;
		private var _isTracked:Boolean;
		private var _slideEndType:String;
		
		public function SlideObject()
		{
		}

		public function get slideEndType():String
		{
			return _slideEndType;
		}

		public function set slideEndType(value:String):void
		{
			_slideEndType = value;
		}

		public function get isTracked():Boolean
		{
			return _isTracked;
		}

		public function set isTracked(value:Boolean):void
		{
			_isTracked = value;
		}

		public function get slideID():String
		{
			return _slideID;
		}

		public function set slideID(value:String):void
		{
			_slideID = value;
		}

		public function get slideType():String
		{
			return _slideType;
		}

		public function set slideType(value:String):void
		{
			_slideType = value;
		}

		public function get slideNumber():String
		{
			return _slideNumber;
		}

		public function set slideNumber(value:String):void
		{
			_slideNumber = value;
		}

		public function get slideIndex():int
		{
			return _slideIndex;
		}

		public function set slideIndex(value:int):void
		{
			_slideIndex = value;
		}

		public function get slideContent():XMLList
		{
			return _slideContent;
		}

		public function set slideContent(value:XMLList):void
		{
			_slideContent = value;
		}

		public function get slideAnimType():String
		{
			return _slideAnimType;
		}

		public function set slideAnimType(value:String):void
		{
			_slideAnimType = value;
		}


	}
}