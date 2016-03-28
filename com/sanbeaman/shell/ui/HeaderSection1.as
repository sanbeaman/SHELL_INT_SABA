package com.sanbeaman.shell.ui
{
	
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class HeaderSection1 extends Sprite
	{
		
		private var _tlf:TLFTextField;
		private var _tlformat:TextLayoutFormat;
		
		
		private var _fontSize:Number;
		private var _fontColorCode:uint;// = SHELL_COLORS.CLR_WHITE;
		private var _backColorCode:uint;// = SHELL_COLORS.CLR_BLUE;
		private var _twidth:Number;
		private var _theight:Number;
		
		private var _tHasBack:Boolean;
		
		private var _txt:String;
		public function HeaderSection1()
		{
			super();

		}
		
		public function addHeader(str:String, fontcolor:String, fontsize:Number, tbacktrue:Boolean = false, backcolor:String ="white", twidth:Number = 755,theight:Number = 30):void
		{
			_txt = str;
			_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
			_fontSize = fontsize;
			_tHasBack = tbacktrue;
			_backColorCode = SHELL_COLORS.lookUpColor(backcolor);
			var backShape:Shape = new Shape();
			var backAlpha:int = (_tHasBack)?1:0;
			_twidth = twidth;
			_theight = theight;
			backShape.graphics.beginFill(_backColorCode,backAlpha);
			backShape.graphics.drawRect(0,0,_twidth,_theight);
			
			backShape.graphics.endFill();
			this.addChild(backShape);
		
			_tlf  = new TLFTextField();
			_tlf.embedFonts = true;
			_tlf.antiAliasType =  AntiAliasType.ADVANCED;
			
			//addChild(myTLFTextField); 
			_tlf.width =twidth;// 755;
			_tlf.height =theight;// 50;
			//_tlf.border = true;
			_tlf.verticalAlign = VerticalAlign.MIDDLE;
			
			_tlf.selectable = false;
		
			//_tlf.background = tbacktrue;
		//	_tlf.backgroundColor = _backColorCode;//0x15A5C9;
			_tlf.htmlText = str;
	
			
			// TEXTLAYOUT FORMAT
			_tlformat = new TextLayoutFormat();
			
			_tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlformat.renderingMode = RenderingMode.CFF;
			_tlformat.cffHinting = CFFHinting.NONE;
			
			_tlformat.fontSize = _fontSize;// 24;
			_tlformat.color = _fontColorCode;// 0xffffff;
			_tlformat.textAlign = TextAlign.LEFT;
			_tlformat.lineHeight = "100%";
			_tlformat.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
			
			//_tlformat.paddingLeft = 10;
			
			_tlformat.fontFamily =  SHELL_VARS.SHELL_FONT_FAMILY;
			
			if (_tHasBack) {
				_tlformat.backgroundColor = _backColorCode;//SHELL_COLORS.CLR_BLUE;// 0x15A5C9;
				_tlformat.backgroundAlpha = 1;
			}
			
			//TEXTFLOW
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.paddingTop = 2;
			myTextFlow.paddingLeft = 10;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
			myTextFlow.hostFormat =_tlformat ;
			myTextFlow.flowComposer.updateAllControllers();
			//_tlf.x = 10;
			this.addChild(_tlf);

		}
		
		public function changeHeader(newHeader:String):void
		{
			_txt = newHeader;
			_tlf.htmlText = newHeader;
			//TEXTFLOW
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.paddingTop = 2;
			myTextFlow.paddingLeft = 10;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
			myTextFlow.hostFormat =_tlformat ;
			myTextFlow.flowComposer.updateAllControllers();
			
		}
		
	}
}