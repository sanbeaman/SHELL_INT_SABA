package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.data.UIparams;
	
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
	
	public class BodySubHeader extends BodyUI
	{
		
		private var _tlformat:TextLayoutFormat;
		private var _tlft:TLFTextField;
		
		private var _uip:UIparams;
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function BodySubHeader()
		{
			super();
		}
		
		
		//public function addHeader(str:String, tbacktrue:Boolean = false, tbackColor:uint =0xffffff, twidth:Number = 755,theight:Number = 50):void
		public function addHeader(str:String, uiparams:UIparams, fontFamily:String = "Arial", langID:String = null):void
		{
			
			_uip = uiparams;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			_fontFamily = fontFamily;
			_tlft = new TLFTextField();
			_tlft.embedFonts = true;
			//_tlft.autoSize =  TextFieldAutoSize.LEFT;
			_tlft.antiAliasType =  AntiAliasType.ADVANCED;
			_tlft.selectable = false;
			_tlft.direction = _txtDirection;//Direction.LTR;
			_tlft.wordWrap = false;
			_tlft.width = _uip.uiWidth;
			_tlft.height = _uip.uiHeight;// 50;
	//	_tlft.border = true;
			_tlft.verticalAlign = _uip.uiFontVAlignCONST; 
			_tlft.borderAlpha = 1;
			if (_uip.uiFillAlpha == 1) {
				_tlft.background = true; // tbacktrue;
				_tlft.backgroundColor = _uip.uiFillColorCode; //tbackColor;//0x15A5C9;
			} else {
				_tlft.background = false; 
			}
			//tField.width = twidth;
			//tField.x = (stage.stageWidth - tField.width)/2;
			//	tField.y = 100;
			_tlft.htmlText = str;//"أغنية لشعبولا عن مقتل معمر القذافي";
			
			_tlformat = new TextLayoutFormat();
			_tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlformat.renderingMode = RenderingMode.CFF;
			_tlformat.cffHinting = CFFHinting.NONE;
			//if (_uip.uiFontHAlign == 'center'){
				_tlformat.textAlign = _uip.uiFontHAlignCONST;
		//	} 
			
			_tlformat.fontSize = _uip.uiFontSize;//   20;
			_tlformat.color = _uip.uiFontColorCode;//SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
			_tlformat.backgroundColor = _uip.uiFillColorCode; //SHELL_COLORS.CLR_WHITE;// 0xFFFFFF;
			_tlformat.backgroundAlpha = 1;//_uip.uiFillAlpha; //1;
			_tlformat.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;// "Arial, _sans";
			
			var myTextFlow:TextFlow = _tlft.textFlow;
			myTextFlow.invalidateAllFormats();
			
			myTextFlow.hostFormat =_tlformat ;
			myTextFlow.paddingLeft = _uip.uiPadX;
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(_tlft);
		}
		
		
		
	}
}