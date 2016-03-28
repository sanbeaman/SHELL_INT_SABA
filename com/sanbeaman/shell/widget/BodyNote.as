package com.sanbeaman.shell.widget
{
	
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class BodyNote extends BodyUI
	{
		private var _txtWidth:Number;
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		
		private  var _tHeight:Number;
		private var tField:TLFTextField;
		
		private var _tWidth:Number;
		private var _textFormatType:String;
		
		
		private var _fontSize:Number;
		private var _fontColorCode:uint;
		
		public function BodyNote()
		{
			super();
		}
		
		public function init(str:String,
							 textWidth:Number = 600,tformat:String = "normal",
							 fontsize:Number = 14,fontcolor:String = "default", fontfamily:String="Arial", 
							 langID:String = null):void
		{
			this.type = "bodynote";
			var txt:String = str;
			_textFormatType = tformat;
			_txtWidth = textWidth;
			_fontSize = fontsize;
			//_fontColor = fontcolor;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
			_fontFamily = fontfamily;
			
			_localeID = (langID != null)?langID:"en";
			
			
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			_addText(txt);
			//this.cacheAsBitmap = true;
			
		}
		
		
		private function _addText(str:String):void
		{
			
			tField = new TLFTextField();
			tField.embedFonts = true;
			tField.autoSize =  _txtFieldASize;//TextFieldAutoSize.LEFT;
			tField.antiAliasType =  AntiAliasType.ADVANCED;
			tField.selectable = false;
			
			
			tField.wordWrap = true;
			tField.width = _txtWidth;
			tField.htmlText = str;//"أغنية لشعبولا عن مقتل معمر القذافي";
			
			
			var tlformat:TextLayoutFormat = new TextLayoutFormat();
			tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			tlformat.renderingMode = RenderingMode.CFF;
			tlformat.cffHinting = CFFHinting.NONE;
			tlformat.lineHeight = "100%";
			tlformat.fontSize = _fontSize;;
			tlformat.color = _fontColorCode;// 0x666666;
			
			tlformat.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
	
			var myTextFlow:TextFlow = tField.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.locale = _localeID;
			
			myTextFlow.direction = _txtDirection;// (_fontDirection == 'rtl')?Direction.RTL:Direction.LTR;
			//	myTextFlow.lineHeight = "100%";
			myTextFlow.hostFormat = tlformat;
			
			myTextFlow.flowComposer.updateAllControllers();
			addChild(tField)

		}
		
	}
}