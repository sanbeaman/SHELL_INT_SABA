package com.sanbeaman.shell.data
{
	public class TextBoxObject
	{
		
		private var _type:String;
		
		private var _box_width:Number;
		private var _box_height:Number;
		private var _box_x:Number;
		private var _box_y:Number;
		private var _box_xpad:Number;
		private var _box_ypad:Number;
	
		private var _box_fillColor:String;
		private var _box_fillAlpha:Number;
		private var _box_frameSize:Number;
		private var _box_frameColor:String;
		private var _box_frameAlpha:Number;
		
		
		private var _box_fontName:String;
		private var _box_fontColor:String;
		private var _box_fontSize:Number;
		private var _box_fontStyle:String;
		private var _box_fontAlign:String;
		
		private var _box_fontFX:String;
		
		private var _box_langid:String;
		
		public function TextBoxObject()
		{
			
		}

		public function init(inxml:XMLList):void
		{
			this.box_width =  inxml.@width;
			this.box_height = inxml.@height;
			this.box_x =  inxml.@x;
			this.box_y = inxml.@y;
			this.box_xpad = inxml.@xPad;
			this.box_ypad = inxml.@yPad;
			
			this.box_fillColor = inxml.@fillColor;
			this.box_fillAlpha = inxml.@fillAlpha;
			this.box_frameSize = inxml.@frameSize;
			this.box_frameColor = inxml.@frameColor;
			this.box_frameAlpha = inxml.@frameAlpha;
			
			
			this.box_fontName = inxml.@fontName;
			this.box_fontColor = inxml.@fontColor;
			this.box_fontSize = inxml.@fontSize;
			this.box_fontStyle = inxml.@fontStyle;
			this.box_fontAlign = (inxml.hasOwnProperty("@fontAlign"))?inxml.@fontAlign:"left";
			this.box_fontFX = inxml.@fontFX;
		}
		public function get box_x():Number
		{
			return _box_x;
		}

		public function set box_x(value:Number):void
		{
			_box_x = value;
		}

		public function get box_y():Number
		{
			return _box_y;
		}

		public function set box_y(value:Number):void
		{
			_box_y = value;
		}

		public function get box_xpad():Number
		{
			return _box_xpad;
		}

		public function set box_xpad(value:Number):void
		{
			_box_xpad = value;
		}

		public function get box_ypad():Number
		{
			return _box_ypad;
		}

		public function set box_ypad(value:Number):void
		{
			_box_ypad = value;
		}

		public function get box_width():Number
		{
			return _box_width;
		}

		public function set box_width(value:Number):void
		{
			_box_width = value;
		}

		public function get box_height():Number
		{
			return _box_height;
		}

		public function set box_height(value:Number):void
		{
			_box_height = value;
		}

		public function get box_fillColor():String
		{
			return _box_fillColor;
		}

		public function set box_fillColor(value:String):void
		{
			_box_fillColor = value;
		}

		public function get box_fillAlpha():Number
		{
			return _box_fillAlpha;
		}

		public function set box_fillAlpha(value:Number):void
		{
			_box_fillAlpha = value;
		}

		public function get box_frameSize():Number
		{
			return _box_frameSize;
		}

		public function set box_frameSize(value:Number):void
		{
			_box_frameSize = value;
		}

		public function get box_frameColor():String
		{
			return _box_frameColor;
		}

		public function set box_frameColor(value:String):void
		{
			_box_frameColor = value;
		}

		public function get box_frameAlpha():Number
		{
			return _box_frameAlpha;
		}

		public function set box_frameAlpha(value:Number):void
		{
			_box_frameAlpha = value;
		}

		public function get box_fontName():String
		{
			return _box_fontName;
		}

		public function set box_fontName(value:String):void
		{
			_box_fontName = value;
		}

		public function get box_fontColor():String
		{
			return _box_fontColor;
		}

		public function set box_fontColor(value:String):void
		{
			_box_fontColor = value;
		}

		public function get box_fontSize():Number
		{
			return _box_fontSize;
		}

		public function set box_fontSize(value:Number):void
		{
			_box_fontSize = value;
		}

		public function get box_fontStyle():String
		{
			return _box_fontStyle;
		}

		public function set box_fontStyle(value:String):void
		{
			_box_fontStyle = value;
		}

		public function get box_fontFX():String
		{
			return _box_fontFX;
		}

		public function set box_fontFX(value:String):void
		{
			_box_fontFX = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get box_langid():String
		{
			return _box_langid;
		}

		public function set box_langid(value:String):void
		{
			_box_langid = value;
		}

		public function get box_fontAlign():String
		{
			return _box_fontAlign;
		}

		public function set box_fontAlign(value:String):void
		{
			_box_fontAlign = value;
		}


	}
}