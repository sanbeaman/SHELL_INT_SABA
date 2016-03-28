package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.widget.BodyUI;
	
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class ScreenCopy extends Sprite
	{
		
		private var _txtWidth:Number;
		private var _txtHeight:Number;
		private var _tField:TLFTextField;
		
		public function ScreenCopy()
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		public function addText(str:String,tw:Number,tsize:Number,tcolor:uint = 0x666666):void
		{
			
			_tField = new TLFTextField();
			_tField.embedFonts = true;
			_tField.autoSize =  TextFieldAutoSize.LEFT;
			_tField.antiAliasType =  AntiAliasType.ADVANCED;
			_tField.selectable = false;
			
			_tField.direction = Direction.LTR;
			_tField.wordWrap = true;
			_tField.width =  tw;
			_tField.htmlText = str;//"أغنية لشعبولا عن مقتل معمر القذافي";
		
			
			var tlformat:TextLayoutFormat = new TextLayoutFormat();
			tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			tlformat.renderingMode = RenderingMode.CFF;
			tlformat.cffHinting = CFFHinting.NONE;
		
			tlformat.fontSize = tsize;
			tlformat.color = tcolor;// 0x666666;
			
			tlformat.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
		
			var myTextFlow:TextFlow = _tField.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.hostFormat = tlformat;
			myTextFlow.flowComposer.updateAllControllers();
			
			
			this.addChild(_tField)
			_tField.mouseEnabled = false;
			_tField.mouseChildren = false;
		}

		public function get txtHeight():Number
		{
			
			var tlfh:Number = _tField.textHeight;
			
			trace('tlfTXTh = ' + _tField.textHeight);
			trace('tlfh = ' + _tField.height);
			_txtHeight = tlfh;
			return _txtHeight;
		}

		
	}
}

