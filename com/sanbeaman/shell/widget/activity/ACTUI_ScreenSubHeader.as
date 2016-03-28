package com.sanbeaman.shell.widget.activity
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
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class ACTUI_ScreenSubHeader extends Sprite
	{
		
		private var _txtWidth:Number;
		private var _txtHeight:Number;
		private var _tField:TLFTextField;
		private var _txt:String;
		
		private var _fontSize:Number;
		//private var _fontName:String;
	//	private var _fontColor:String;
		private var _fontColorCode:uint;
		private var _fontStyle:String;
		private var _fontAlign:String;
	//	private var _fontDirection:String;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function ACTUI_ScreenSubHeader()
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		
		public function addText(str:String,tw:Number,th:Number,
								fontsize:Number,fontcolor:String = "black", fontalign:String = "left",fontstyle:String = "reg", fontfamily:String = "Arial", 
								langID:String = null):void
		{
			
		
			_txt = str;
			_txtWidth = tw;
			_txtHeight = th;
			
			_fontSize = fontsize;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
			_fontAlign = fontalign;
			_fontStyle = fontstyle;
			_fontFamily = fontfamily;
			
			_localeID = (langID != null)?langID:"en";
			
		
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_tField = new TLFTextField();
			_tField.embedFonts = true;
			_tField.antiAliasType =  AntiAliasType.ADVANCED;
			_tField.selectable = false;
		
			if (_txtHeight > 0){
				_tField.autoSize =  _txtFieldASize;//TextFieldAutoSize.LEFT;
			} else {
				_tField.height = _txtHeight;
				_tField.verticalAlign = VerticalAlign.MIDDLE;
			
			}
		//	_tField.border = true;
			_tField.wordWrap = true;
			_tField.width = _txtWidth;
			
			_tField.htmlText = _txt;//"أغنية لشعبولا عن مقتل معمر القذافي";
			
			var tlformat:TextLayoutFormat = new TextLayoutFormat();
			tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			tlformat.renderingMode = RenderingMode.CFF;
			tlformat.cffHinting = CFFHinting.NONE;
			tlformat.lineHeight = "110%";
			if (_fontStyle == "bold"){
				tlformat.fontWeight = FontWeight.BOLD;
			}
			
			tlformat.fontSize = _fontSize;
			tlformat.color = _fontColorCode;// 0x666666;
			
			tlformat.fontFamily = _fontFamily;// SHELL_VAR
			
			if (_fontAlign == 'center'){
				tlformat.textAlign = TextAlign.CENTER;
			}
			
			var myTextFlow:TextFlow = _tField.textFlow;
			myTextFlow.invalidateAllFormats();
			
			myTextFlow.locale = _localeID;
			
			myTextFlow.direction = _txtDirection;// (_fontDirection == 'rtl')?Direction.RTL:Direction.LTR;
			//	myTextFlow.lineHeight = "100%";
			myTextFlow.hostFormat = tlformat;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			
			this.addChild(_tField);
			_tField.mouseEnabled = false;
			_tField.mouseChildren = false;
		
		}

		public function get txtHeight():Number
		{
			var tlfh:Number =_tField.height;
			//var tlfh:Number = _tField.textHeight;
			trace('subheadTextHeight = ' + _tField.textHeight);
			trace('subhead-Height = ' + _tField.height);
			_txtHeight = tlfh;
			return _txtHeight;
		}
		
	

		
	}
}

