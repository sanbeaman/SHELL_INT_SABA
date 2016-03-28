package com.sanbeaman.shell.ui
{
	import fl.text.*;
	import fl.text.TLFTextField;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.*;
	import flash.text.Font;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.*;
	import flashx.textLayout.formats.TextLayoutFormat;

	
	public class ToolTips extends Sprite
	{
		
		private var _frameColor:uint;
		private var _frameSize:Number;
		private var _frameAlpha:Number;
		
		private var _frameFillColor:uint;
		private var _frameFillAlpha:Number;
		
		private var _tfToolTip:TLFTextField;
		
		public function ToolTips()
		{
			super();
			
			//------------------
			// CREATE TLFTEXTFIELD:
			_tfToolTip = new TLFTextField();
			
		}
		
		public function createToolTip(str:String):void {
			
			//addChild(myTLFTextField); 
			
			//_tfToolTip.background = true;
		
			
			//_tfToolTip.backgroundColor =0xcccccc;
		//	_tfToolTip.backgroundAlpha = 0.6;
		//	_tfToolTip.border = true;
		//_tfToolTip.borderColor = SHELL_COLORS.CLR_BLUE;
		//	_tfToolTip.borderWidth = 1;
			_tfToolTip.selectable = false;
		
			_tfToolTip.multiline = false;
			//_tfToolTip.height = 14;
			_tfToolTip.text = str;
			
			
			
			trace("_tfToolTip.width = "+  _tfToolTip.width);
			trace("_tfToolTip.height = "+  _tfToolTip.height);
			trace("_tfToolTip.textHeight = "+  _tfToolTip.textHeight);
			trace("_tfToolTip.textWidth = "+  _tfToolTip.textWidth);
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontFamily = "Arial";
			format.fontSize = 12;
			format.color = 0x666666;
			format.textAlign = TextAlign.CENTER;
			format.verticalAlign = VerticalAlign.MIDDLE;
			
			var myTextFlow:TextFlow = _tfToolTip.textFlow;

			
			myTextFlow.hostFormat = format;
			myTextFlow.flowComposer.updateAllControllers();
			
			trace("afterFLOW.textHeight = "+ _tfToolTip.textHeight);
			trace("afterFLOW.textWidth = "+  _tfToolTip.textWidth);
			
			_tfToolTip.width = _tfToolTip.textWidth + 8; ;//+ 10;
			_tfToolTip.height = 20;//int(_tfToolTip.textHeight);
			
			var boxWidth:Number = _tfToolTip.width;// + 8;
			var boxHeight:Number = 20;
			
			var backSprite:Sprite= new Sprite();
			backSprite.graphics.lineStyle(1,SHELL_COLORS.CLR_BLUE);
			backSprite.graphics.beginFill(SHELL_COLORS.CLR_LTGREY,.8);
			backSprite.graphics.drawRect(0,0,boxWidth,boxHeight);
			this.addChild(backSprite);
			_tfToolTip.x = 2;
			_tfToolTip.y = 4;
			
			backSprite.addChild(_tfToolTip);
		
			
		}
	}
}