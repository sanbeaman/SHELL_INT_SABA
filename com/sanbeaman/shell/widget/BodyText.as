package com.sanbeaman.shell.widget
{
	
	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.sanbeaman.shell.utils.CustomEaseHelper;
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
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.edit.SelectionState;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class BodyText extends BodyUI
	{
		private  var _tHeight:Number;
		private var tField:TLFTextField;
		
		private var _tWidth:Number;
		private var _textFormatType:String;
		
		
		private var _fontSize:Number;
		private var _fontColorCode:uint;
		private var _fontAlign:String;
		private var _fontStyle:String;
		private var _margin:Number;
		//private var _fontColorCode:uint;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		private var _txt:String;
		
		private var _textBOX:Sprite;
		
		private var _uiHeight:Number;
		private var _uiWidth:Number;
		
		public function BodyText()
		{
			super();
		}
		
		public function init(str:String, 
							 textWidth:Number = 600, textHeight:Number = 0, 
							 tformat:String = "normal", fontsize:Number = 16,fontcolor:String = "default", 
							 fontalign:String ="left",fontStyle:String = "regular",margin:Number =0, 
							 fontfamily:String = "Arial", langID:String = null):void
		{
			
			this.type = "bodytext";
			_txt = str;
			_tWidth = textWidth;
			_tHeight = textHeight;
			var tformatt:String = tformat.toLowerCase();
			_fontSize = fontsize;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
			_fontAlign = fontalign;
			_fontStyle = fontStyle;
			_margin = margin;
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_textBOX = new Sprite();
			trace("_tHeight====== "+ _tHeight);
			if (_tHeight != 0){
				
				_textBOX.graphics.beginFill(0xcccccc,.7);
				_textBOX.graphics.drawRect(0,0,_tWidth,_tHeight);
				_textBOX.graphics.endFill();
				
			}
			_addText(str,_tWidth,tformatt);
			
		}
		
		
		private function _addText(str:String, twidth:Number, tformattype:String):void
		{
			_textFormatType = tformattype;
	
			tField = new TLFTextField();
			tField.embedFonts = true;
			//tField.border = true;
			if (_tHeight == 0) {
				tField.autoSize = _txtFieldASize;// TextFieldAutoSize.LEFT;
			}
		
			tField.antiAliasType =  AntiAliasType.ADVANCED;
			
			tField.selectable = false;
			
			var bulletAdjust:Number;
			var lap:Number;
			var listType:String;
			var fSize:Number;
			var fColor:uint;
			var leftPad:Number;
			var textindeent:Number;
			 
			if (_textFormatType == "bullet") {
			//	addtext = "•   ";
				bulletAdjust = 0;
			//	textindeent =  -20;
				fSize = _fontSize;//16
				fColor = _fontColorCode;//0x666666;
			//	leftPad = 50;
			} else if (_textFormatType == "subbullet") {
				bulletAdjust = 20;
			//	lap = 100;
			//	listType =  ListStyleType.SQUARE
				fSize = _fontSize - 2;// 14
				fColor = _fontColorCode;//0x666666;
			//	textindeent =  -20;
			//	leftPad = 100;
			} else {
				bulletAdjust = 0;
				//addtext = "";
				//lap = 50;
				//listType =  ListStyleType.DISC
				fSize = _fontSize;
				fColor =_fontColorCode;// 0x666666;
				//textindeent =  0;
			//	leftPad= 0;
			}
			
			
		//	tField.direction =_txtDirection;// Direction.LTR;
			tField.wordWrap = true;
			tField.multiline = true;
			tField.verticalAlign = VerticalAlign.MIDDLE;
			
			if (_tHeight != 0){
				tField.height = _tHeight;
			}
			tField.width = twidth - bulletAdjust;
			//tField.width = twidth;
			//tField.x = (stage.stageWidth - tField.width)/2;
		//	tField.y = 100;
			tField.htmlText = str;//"أغنية لشعبولا عن مقتل معمر القذافي";
			
			
			var tlformat:TextLayoutFormat = new TextLayoutFormat();
			tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			tlformat.renderingMode = RenderingMode.CFF;
			tlformat.cffHinting = CFFHinting.NONE;
			
			if (_fontStyle == 'bold'){
				tlformat.fontWeight = FontWeight.BOLD;
			} else {
				tlformat.fontWeight = FontWeight.NORMAL;
			}
			
	//		tlformat.paddingLeft = leftPad;
			tlformat.fontSize = fSize;
			tlformat.color = fColor;// 0x666666;
			if (_fontAlign == 'center') {
				tlformat.textAlign = TextAlign.CENTER;
			} else if (_fontAlign == 'right') {
				tlformat.textAlign = TextAlign.RIGHT;
			} else {
				tlformat.textAlign = TextAlign.LEFT;
			}
		
			
			tlformat.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
			var myTextFlow:TextFlow = tField.textFlow;
			
			myTextFlow.invalidateAllFormats();
			myTextFlow.locale = _localeID;
			//myTextFlow.verticalAlign = VerticalAlign.MIDDLE;
			myTextFlow.direction = _txtDirection;// (_fontDirection == 'rtl')?Direction.RTL:Direction.LTR;
			//	myTextFlow.lineHeight = "100%";
			myTextFlow.hostFormat = tlformat;
			myTextFlow.paddingLeft = bulletAdjust;
			myTextFlow.paddingRight = bulletAdjust;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			//tField.x = bulletAdjust;
			addChild(tField)
}

		public function get tHeight():Number
		{
			_tHeight = int(tField.textHeight);
			return _tHeight;
		}
		
		//you build these functions into your objects (classes, MovieClips, whatever):
		public function animateIn():TimelineLite {
			var tl:TimelineLite = new TimelineLite();
			tl.append(TweenLite.from(this,1,{x:800,alpha:0,ease:CustomEaseHelper.find(this.ease)}));
			return tl;
		}
		
		public function animateOut():TimelineLite {
			var tl:TimelineLite = new TimelineLite();
			tl.append(TweenLite.to(this,1,{x:0,alpha:0,ease:CustomEaseHelper.find(this.ease)} ));
			return tl;
		}

		public function get uiHeight():Number
		{
			_uiHeight = int(tField.height);
			return _uiHeight;
		}

		public function set uiHeight(value:Number):void
		{
			_uiHeight = value;
		}

	
}
}