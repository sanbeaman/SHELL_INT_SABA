package com.sanbeaman.shell.widget.activity
{
	import com.sanbeaman.shell.widget.BoxCopy;
	
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.formats.Direction;
	
	public class ACTUI_FeedBackBox extends Sprite
	{
		
		private var stxt:BoxCopy;
		private var _xpad:Number;
		private var _ypad:Number;
		private var _boxHeight:Number;
		
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function ACTUI_FeedBackBox()
		{
			super();
		}
		
		public function init(str:String,w:Number,h:Number,
							 frameSize:int,frameColorCode:uint,
							 fillColorCode:uint,fillAlpha:Number,
							 fontSize:Number,fontColorCode:uint,
							 xpadding:Number = 10,ypadding:Number=10, fontalign:String = "center", fontfamily:String = "Arial", langID:String = null):void
		{
			_xpad = xpadding;
			_ypad = ypadding;
			
			
			_localeID = (langID != null)?langID:"en";
			
			
			//_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
		//	_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			stxt = new BoxCopy();
			
			stxt.addText(str,w,fontSize,fontColorCode,_xpad,_ypad,h,fontalign,_fontFamily,_localeID);
			
			_boxHeight = stxt.txtHeight;
			trace("feedback text height =  " + _boxHeight);
			var frSize:int = frameSize;
			var frameAlpha:Number;
			if (frSize > 0) {
				frameAlpha = 1;
			} else {
				frameSize = 0;
			}
			this.graphics.lineStyle(frSize,frameColorCode,frameAlpha);
			this.graphics.beginFill(fillColorCode,fillAlpha);
			this.graphics.drawRect(0,0,w,_boxHeight);
			
			this.addChild(stxt);
			
		}

		public function get boxHeight():Number
		{
			return _boxHeight;
		}

	}
}