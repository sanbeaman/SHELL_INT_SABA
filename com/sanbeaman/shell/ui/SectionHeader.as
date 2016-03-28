package com.sanbeaman.shell.ui
{
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
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
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class SectionHeader extends Sprite
	{
		private var _back:Sprite;
		
		
		
		private var _headerType:String;
		
		private var _tlf:TLFTextField;
		private var _tlformat:TextLayoutFormat;
		
		
		private var _fontSize:Number;
		private var _fontColorCode:uint;// = SHELL_COLORS.CLR_WHITE;
		private var _fillColorCode:uint;// = SHELL_COLORS.CLR_BLUE;
		private var _fillAlpha:Number;
		
		private var _fontFX:String;
		private var _fontStyle:String;
		private var _fontName:String;
		
		private var _padx:Number;
		private var _pady:Number;
		
		private var _twidth:Number;
		private var _theight:Number;
		
		private var _tHasBack:Boolean;
		
		private var _txt:String;
		
		private var _hasFX:Boolean = false;
		private var _FXon:Boolean = false;
		private var _printView:Boolean = false;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _txtFlow:TextFlow;
		
		public function SectionHeader()
		{
			super();

		}
		public function init(headerXML:XMLList, headerTxt:String, langID:String = null):void
		{
			_txt = headerTxt;
			
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			var fontColor:String = (headerXML.hasOwnProperty("@fontColor"))?headerXML.@fontColor:"white";
			_fontSize = (headerXML.hasOwnProperty("@fontSize"))?headerXML.@fontSize:20;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontColor);
			_fontStyle = (headerXML.hasOwnProperty("@fontStyle"))?headerXML.@fontStyle:"reg";
			_fontFX = (headerXML.hasOwnProperty("@fontFX"))?headerXML.@fontFX:"x";
			_fontName = (headerXML.hasOwnProperty("@fontName"))?headerXML.@fontName:SHELL_VARS.SHELL_FONT_FAMILY;
			_headerType =  (headerXML.hasOwnProperty("@type"))?headerXML.@type:"simple";
			
			
		
			_padx= (headerXML.hasOwnProperty("@xPad"))?headerXML.@xPad:10;
			_pady = (headerXML.hasOwnProperty("@yPad"))?headerXML.@yPad:2;
			
			
			var fillcolor:String= (headerXML.hasOwnProperty("@fillColor"))?headerXML.@fillColor:"blue";
			_fillColorCode = SHELL_COLORS.lookUpColor(fillcolor);
			_fillAlpha = (headerXML.hasOwnProperty("@fillAlpha"))?headerXML.@fillAlpha:1;
			
			_twidth= (headerXML.hasOwnProperty("@width"))?headerXML.@width:755;
			_theight = (headerXML.hasOwnProperty("@height"))?headerXML.@height:30;
			
			_back = new Sprite();
			
			
			_tHasBack = (_fillAlpha == 0)?false:true;
			_back.graphics.beginFill(_fillColorCode,_fillAlpha);
			_back.graphics.drawRect(0,0,_twidth,_theight);
			_back.graphics.endFill();
			this.addChild(_back);
	
			_tlf  = new TLFTextField();
			_tlf.embedFonts = true;
			_tlf.antiAliasType =  AntiAliasType.ADVANCED;
			
			//addChild(myTLFTextField); 
			_tlf.width =_twidth;// 755;
			_tlf.height =_theight;// 50;
			//_tlf.border = true;
			_tlf.verticalAlign = VerticalAlign.MIDDLE;
			
			_tlf.selectable = false;
		
			//_tlf.background = tbacktrue;
		//	_tlf.backgroundColor = _backColorCode;//0x15A5C9;
			_tlf.htmlText = _txt;
	
			
			// TEXTLAYOUT FORMAT
			_tlformat = new TextLayoutFormat();
			
			_tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlformat.renderingMode = RenderingMode.CFF;
			_tlformat.cffHinting = CFFHinting.NONE;
			
			_tlformat.fontSize = _fontSize;// 24;
			_tlformat.color = _fontColorCode;// 0xffffff;
		//	_tlformat.textAlign = TextAlign.LEFT;
			_tlformat.lineHeight = "100%";
			_tlformat.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
			
			//_tlformat.paddingLeft = 10;
			
			_tlformat.fontFamily = _fontName;//  SHELL_VARS.SHELL_FONT_FAMILY;
			
			if (_tHasBack) {
				_tlformat.backgroundColor = _fillColorCode;//SHELL_COLORS.CLR_BLUE;// 0x15A5C9;
				_tlformat.backgroundAlpha = 1;
			}
			
		
			
			//TEXTFLOW
			_txtFlow = _tlf.textFlow;
			_txtFlow.invalidateAllFormats();
			_txtFlow.paddingTop =_pady;
			_txtFlow.paddingLeft = _padx;
			_txtFlow.paddingRight = _padx;
			_txtFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
			_txtFlow.direction = _txtDirection;
			_txtFlow.hostFormat =_tlformat ;
		
			
			_txtFlow.flowComposer.updateAllControllers();
			//_tlf.x = 10;
			this.addChild(_tlf);
			
			
			if (_fontFX.toLowerCase() == 'dropshadow'){
				_hasFX = true;
				this.applyFX();
				//this.hasFilter = true;
			}

		}
		
		public function changeHeader(newHeader:String):void
		{
			_txt = newHeader;
			_tlf.htmlText = newHeader;
			//TEXTFLOW
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.paddingTop = _pady;
			myTextFlow.paddingLeft = _padx;
			myTextFlow.paddingRight = _padx;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
			myTextFlow.direction = _txtDirection;
			myTextFlow.hostFormat =_tlformat ;
			myTextFlow.flowComposer.updateAllControllers();
			
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
		//	var angle:Number = 120;
			var alpha:Number = 0.8;
			var blurX:Number = 2;// 3;
			var blurY:Number = 2;//3;
			var distance:Number = 0;
			var strength:Number = 4;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			return new GlowFilter(color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
			/*
			return new DropShadowFilter(distance,
			angle,
			color,
			alpha,
			blurX,
			blurY,
			strength,
			quality,
			inner,
			knockout);*/
		}
		
		private function _applyFilter():void
		{
			var filter:BitmapFilter = getBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			_tlf.filters = myFilters;
		}
		
		public function set printView(pv:Boolean):void
		{
			_printView = pv;
			
			if (pv) {
				
				
				var tfprint:TextLayoutFormat = new TextLayoutFormat();
				
				tfprint.fontLookup = FontLookup.EMBEDDED_CFF;
				tfprint.renderingMode = RenderingMode.CFF;
				tfprint.cffHinting = CFFHinting.NONE;
				
				tfprint.fontSize = _fontSize;// 24;
				tfprint.color = 0x000000;// 0xffffff;
				tfprint.textAlign = TextAlign.LEFT;
				tfprint.lineHeight = "100%";
				tfprint.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
				
				//_tlformat.paddingLeft = 10;
				
				tfprint.fontFamily = _fontName;//  SHELL_VARS.SHELL_FONT_FAMILY;
				tfprint.backgroundColor = 0xffffff;//SHELL_COLORS.CLR_BLUE;// 0x15A5C9;
				//_tlformat.backgroundAlpha = 1;
				//TEXTFLOW
				
				_txtFlow.invalidateAllFormats();
				_txtFlow.paddingTop =_pady;
				_txtFlow.paddingLeft = _padx;
				_txtFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
				_txtFlow.hostFormat =tfprint ;
				_txtFlow.flowComposer.updateAllControllers();
			
				
				
				if (_hasFX) {
					this.removeFX();
				}
				
			} else {
				//_txtFlow = _tlf.textFlow;
				_txtFlow.invalidateAllFormats();
				_txtFlow.paddingTop =_pady;
				_txtFlow.paddingLeft = _padx;
				_txtFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
				_txtFlow.hostFormat =_tlformat ;
				_txtFlow.flowComposer.updateAllControllers();
				
				//_tf.setTextFormat(_tformat); ;
				if (_hasFX) {
					this.applyFX();	
				}
				
			}
		}
		public function get printView():Boolean
		{
			var pv:Boolean = _printView;
			return pv;
		}
		public function applyFX():void
		{
			if (!_FXon){
				var filter:BitmapFilter = getBitmapFilter();
				var myFilters:Array = new Array();
				myFilters.push(filter);
				_tlf.filters = myFilters;
				
				_FXon = true;
			}
		}
		public function removeFX():void
		{
			if (_FXon){
				_tlf.filters = null;
				_FXon = false;
			}
		}
		
		
	}
}