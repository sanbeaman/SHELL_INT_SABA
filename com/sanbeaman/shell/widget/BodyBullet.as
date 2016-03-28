package com.sanbeaman.shell.widget
{
	
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	import flash.text.engine.FontWeight;
	import fl.text.TLFTextField;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	import flashx.textLayout.formats.TextLayoutFormat
	
	public class BodyBullet extends BodyUI
	{
		private  var _tHeight:Number;
		private  var _uiHeight:Number;
		private var tField:TLFTextField;
		
		private var _tWidth:Number;
		private var _textFormatType:String;
		
		
		private var _fontSize:Number;
		private var _fontColorCode:uint;
		
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		public function BodyBullet()
		{
			super();
		}
		
		public function init(str:String,textWidth:Number = 600, tformat:String = "normal", fontsize:Number = 16,fontcolor:String = "default", fontfamily:String="Arial", langID:String = null):void
		{
			this.type = "bodybullet";
			
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			var tformatt:String = tformat.toLowerCase();
			_fontSize = fontsize;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
			
			_tWidth = textWidth;
			_fontFamily = fontfamily;
			
			_addText(str,_tWidth,tformatt);
			
		}
		
		
		private function _addText(str:String, twidth:Number, tformattype:String):void
		{
			_textFormatType = tformattype;
	
			tField = new TLFTextField();
			tField.embedFonts = true;
			tField.autoSize =  _txtFieldASize;//TextFieldAutoSize.LEFT;
			tField.antiAliasType =  AntiAliasType.ADVANCED;
			tField.selectable = false;
			//tField.border = true;
			
			//var applyFont:Font = new Arabic();
			var bulletAdjust:Number;
			var lap:Number;
			var listType:String;
			var fSize:Number;
			var fColor:uint;
			var leftPad:Number;
			var textindeent:Number;
			var fweight:String;
			
			if (_textFormatType == "bullet") {
			//	addtext = "•   ";
				bulletAdjust = 0;
			//	textindeent =  -20;
				fSize = _fontSize;//16
				fColor = _fontColorCode;//0x666666;
				fweight = FontWeight.NORMAL;
			//	leftPad = 50;
			} else if (_textFormatType == "subbullet") {
				bulletAdjust = 20;
			//	lap = 100;
			//	listType =  ListStyleType.SQUARE
				fSize = _fontSize - 2;// 14
				fColor = _fontColorCode;//0x666666;
			//	textindeent =  -20;
			//	leftPad = 100;
				fweight = FontWeight.NORMAL;
			} else if(_textFormatType == "bold") {
				bulletAdjust = 0;
				//addtext = "";
				//lap = 50;
				//listType =  ListStyleType.DISC
				fSize = _fontSize;
				fColor =_fontColorCode;// 0x666666;
				//textindeent =  0;
				//	leftPad= 0;
				fweight = FontWeight.BOLD;
			}else {
				bulletAdjust = 0;
				//addtext = "";
				//lap = 50;
				//listType =  ListStyleType.DISC
				fSize = _fontSize;
				fColor =_fontColorCode;// 0x666666;
				//textindeent =  0;
			//	leftPad= 0;
				fweight = FontWeight.NORMAL;
			}
			
			tField.wordWrap = true;
			
			tField.width = twidth;// - bulletAdjust;
			//tField.width = twidth;
			//tField.x = (stage.stageWidth - tField.width)/2;
		//	tField.y = 100;
			tField.htmlText = str;//"أغنية لشعبولا عن مقتل معمر القذافي";
			
			
			var tlformat:TextLayoutFormat = new TextLayoutFormat();
			tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			tlformat.renderingMode = RenderingMode.CFF;
			tlformat.cffHinting = CFFHinting.NONE;
			tlformat.lineHeight = "110%";
			//tlformat.direction =
	//		tlformat.paddingLeft = leftPad;
			tlformat.fontWeight = fweight;
			tlformat.fontSize = fSize;
			tlformat.color = fColor;// 0x666666;
			
			tlformat.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
			//tlformat.textIndent = textindeent;
		//	tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
		//	tlformat.listAutoPadding = lap;// 50;
		//	tlformat.listStylePosition =  ListStylePosition.OUTSIDE;
		//	tlformat.listStyleType =  listType;//ListStyleType.DISC;
			var myTextFlow:TextFlow = tField.textFlow;
			myTextFlow.invalidateAllFormats();
			//myTextFlow.locale = _localeID;
			
			myTextFlow.direction = _txtDirection;// (_fontDirection == 'rtl')?Direction.RTL:Direction.LTR;
		//	myTextFlow.lineHeight = "100%";
			myTextFlow.hostFormat = tlformat;
			if (_localeID == "ar"){
				myTextFlow.paddingRight = bulletAdjust;
			} else {
				myTextFlow.paddingLeft = bulletAdjust;
			}
			
			myTextFlow.flowComposer.updateAllControllers();
			
		//	tField.x = bulletAdjust;
			addChild(tField)
			
			
			
		_tHeight =int( tField.textHeight);
		
	
		
	
	}

		public function get tHeight():Number
		{
			var th:Number = int(tField.textHeight);
			return _tHeight;
		}

		public function get uiHeight():Number
		{
			_uiHeight = int(tField.height);
			return _uiHeight;
		}

	
}
}