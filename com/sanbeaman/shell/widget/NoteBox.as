package com.sanbeaman.shell.widget
{
	
	
	import com.greensock.loading.LoaderMax;
	
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.Bitmap;
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
	
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.factory.TextFlowTextLineFactory;
	import flashx.textLayout.factory.TextLineFactoryBase;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class NoteBox extends BodyUI
	{
		/*
		[Embed (source="/masterShell/imgs/DONE_glyph14.png")]
		private static var Img:Class;
		*/
		private var _tlf:TLFTextField;
		private var _txt:String;
		
		private var _fontSize:Number;
		private var _fontColorCode:uint;
		
		private var _boxWidth:Number;
		private var _boxHeight:Number;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function NoteBox()
		{
			super();
		}
		
		public function init(str:String, fontsize:Number = 14, fontcolor:String = "white", boxwidth:Number = 600,boxheight:Number = 34, fontfamily:String = "Arial",langID:String = null):void
		{
		//	this.id = id;
			//this.order = order;
			//this.time = time;
			this.type = "notebox";
			var txt:String = str;
			_fontSize = fontsize;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
			
			_localeID = (langID != null)?langID:"en";
			
		
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			_boxWidth = boxwidth;
			_boxHeight = boxheight;
			
			//var tformatt:String = tformat.toLowerCase();
	
			_fontFamily = fontfamily;
		
			//var specialTxtArray:Array = new Array();
			var mainString:String;
			var _hasSpecialChars:Boolean = _checkForSpecialCharacters(str);
			if (_hasSpecialChars) {
				mainString = txt;
			//	specialTxtArray = str.split("✓");
				_addTextFlow(mainString);
				//mainString = specialTxtArray[0];
			} else {
				mainString = txt;
				_addText(mainString);
			}

			
		}
		
		private function _checkForSpecialCharacters(str:String):Boolean
		{
			
			var bol:Boolean;
			var spcIndex:int = str.indexOf("✓");
			trace('spcIndex = '+ spcIndex);
			if (spcIndex == -1) {
				bol = false;
			} else {
				bol = true;
			}
		
			
			//✓
			
			return bol;
		}
		private function _addTextFlow(str:String):void
		{
			var textFlow:TextFlow = new TextFlow();
			textFlow.verticalAlign = VerticalAlign.MIDDLE;
			textFlow.textAlign = TextAlign.CENTER;
			textFlow.direction = _txtDirection;//(_txtDirection == "rtl")?Direction.RTL:Direction.LTR;
			var specialTxtArray:Array = new Array();
			//var mainString:String;
			//var _hasSpecialChars:Boolean = _checkForSpecialCharacters(str);
			//if (_hasSpecialChars) {
			specialTxtArray = str.split("✓");
		//	mainString = 
			//} else {
			//	mainString = str;
			//}
			///////////////////////////
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			format.fontSize = _fontSize;// 14;
			format.color = _fontColorCode;//0xffffff;
			format.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;//"Arial";
			
			var para:ParagraphElement = new ParagraphElement();
			textFlow.addChild(para);
			
			var spanBefore:SpanElement = new SpanElement();
			spanBefore.text = specialTxtArray[0];
			spanBefore.format = format;
			para.addChild(spanBefore);
			
		//	if (_hasSpecialChars) {
				var inlineimg:InlineGraphicElement = new InlineGraphicElement();
				var img:Bitmap  = LoaderMax.getLoader("icon_done").rawContent;
				img.width = 14;
				img.height = 14;
			
				inlineimg.source = img;
				inlineimg.format = format;
				inlineimg.verticalAlign = VerticalAlign.MIDDLE;
				para.addChild(inlineimg);
			
				var spanAfter:SpanElement = new SpanElement();
				spanAfter.text = specialTxtArray[1];
				spanAfter.format = format;
				para.addChild(spanAfter);
			
		//	}
			
			var factory:TextFlowTextLineFactory = new TextFlowTextLineFactory();
			factory.compositionBounds = new Rectangle(0,0,_boxWidth,30);//, 100, 500, 100);
			factory.createTextLines(addTextLineCallback, textFlow);
			
			
		}
		// callback
		private function addTextLineCallback(textLine:DisplayObject):void {
			this.addChild(textLine);
		}
		
		private function _addText(str:String):void
		{
		
			_tlf  = new TLFTextField();
			_tlf.embedFonts = true;
			_tlf.antiAliasType =  AntiAliasType.ADVANCED;
			
			//_tlf.border = true;
			//_tlf.borderColor = 0xff0000;
			//addChild(myTLFTextField); 
			_tlf.width = _boxWidth;//SHELL_VARS.CONTENT_WIDTH;// SHELL_VARS.CONTENT_WIDTH;
			_tlf.height =_boxHeight;// 34;// 50;
			_tlf.wordWrap = true;
			_tlf.verticalAlign = VerticalAlign.MIDDLE;
		//	_tlf.autoSize = TextFieldAutoSize.LEFT;
			_tlf.selectable = false;
			
			
			_tlf.htmlText = str;
			
			///////////////////////////
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			format.fontSize = _fontSize;// 14;
			format.color = _fontColorCode;//0xffffff;
		
			//format.paddingTop = 4;
			//format.paddingBottom = 4;
			format.textAlign = TextAlign.CENTER;
			format.lineHeight = "110%";
			format.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;//"Arial";
			//	format.listStylePosition =  ListStylePosition.OUTSIDE;
			//format.listStyleType = ListStyleType.CIRCLE;
			
			
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.verticalAlign= VerticalAlign.MIDDLE;
			myTextFlow.hostFormat = format;
			myTextFlow.direction =_txtDirection;// (_txtDirection == "rtl")?Direction.RTL:Direction.LTR;
			
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(_tlf);
			
		}
		
		
	}
}