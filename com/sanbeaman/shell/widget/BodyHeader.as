package com.sanbeaman.shell.widget
{
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
	
	public class BodyHeader extends BodyUI
	{
		
		private var _tlf_format:TextLayoutFormat;
		private var _txtbacktrue:Boolean;
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		public function BodyHeader()
		{
			super();
			_tlf_format = new TextLayoutFormat();
			_tlf_format.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlf_format.renderingMode = RenderingMode.CFF;
			_tlf_format.cffHinting = CFFHinting.NONE;
		}
		
			
		
		public function addHeader(str:String, fontname:String, fontsize:Number = 22, fontcolor:String ="black", padX:Number = 20,padY:Number = 12, fillcolor:String = "white", fillalpha:Number = 1, twidth:Number = 755,theight:Number = 50, langID:String = null):void
		{
			
			
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;

			_tlf_format.color = SHELL_COLORS.lookUpColor(fontcolor); //SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
			var _backColorCode:uint = SHELL_COLORS.lookUpColor(fillcolor);// 0xFFFFFF;
			_tlf_format.backgroundColor =_backColorCode;//SHELL_COLORS.lookUpColor(fillcolor);// 0xFFFFFF;
			//_tlf_sceneHeader.fontWeight = FontWeight.BOLD;
			_tlf_format.backgroundAlpha = fillalpha;// 1;
			
			_txtbacktrue = (fillalpha != 0)?true:false;
			
			_tlf_format.fontFamily = fontname;//SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			_tlf_format.fontSize =fontsize;// 22;
			//	_tlf_format.paddingLeft = 20;
			_tlf_format.lineHeight = "100%";
			_tlf_format.styleName = "sceneHeader";
			//_tlf_format.direction = txtDirection;
			var tField:TLFTextField = new TLFTextField();
			tField.embedFonts = true;
			tField.antiAliasType =  AntiAliasType.ADVANCED;
			tField.autoSize =  _txtFieldASize;// TextFieldAutoSize.LEFT;
			tField.width =twidth;// 755;
			tField.height =theight;// 50;
			//tField.border = true;
			tField.verticalAlign = VerticalAlign.BOTTOM;
			tField.selectable = false;
		//	tField.direction = Direction.LTR;
			tField.wordWrap = true;
			tField.background = _txtbacktrue;
			tField.backgroundColor = _backColorCode;//0x15A5C9;
			tField.htmlText = str;
			
			var myTextFlow:TextFlow = tField.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.paddingLeft = padX;//20;
			myTextFlow.paddingRight = padX;//20;
			myTextFlow.paddingTop =  padY;//12;
			myTextFlow.hostFormat =_tlf_format;
			myTextFlow.direction =_txtDirection;// (txtDirection == 'rtl')?Direction.RTL:Direction.LTR;
			
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(tField);
		}
	}
}