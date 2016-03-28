package com.sanbeaman.shell.data
{
	public class ColorSortObject
	{
		private var _colorStringName:String;
		private var _colorIndex:int;
		
		
		public function ColorSortObject(clrindex:int,clrname:String)
		{
			_colorIndex = clrindex;
			_colorStringName = clrname;
			
		}
		
		public function get colorStringName():String
			
		{
			return _colorStringName;
		}
		
		public function set colorStringName(value:String):void
		{
			_colorStringName = value;
		}
		public function get colorIndex():int
			
		{
			return _colorIndex;
		}
		
		public function set colorIndex(value:int):void
			
		{
			_colorIndex = value;
		}
		
		
	}
}