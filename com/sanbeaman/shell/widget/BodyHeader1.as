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
	
	public class BodyHeader1 extends BodyUI
	{
		
		private var _tlformat:TextLayoutFormat;
		private var _tlft:TLFTextField;
		
		private var _txtHeight:Number;
		
		private var _uip:UIparams;
		private var _txtbacktrue:Boolean;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function BodyHeader1()
		{
			super();
		}
		
		
		
		//public function addHeader(str:String, tbacktrue:Boolean = false, tbackColor:uint =0xffffff, twidth:Number = 755,theight:Number = 50):void
		public function addHeader(str:String, uiparams:UIparams , fontfamily:String ="Arial", langID:String = null):void
		{
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			
			
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			_uip = uiparams;
			_addhead(str,_uip.uiFontSize,_uip.uiFontColor,_uip.uiPadX,_uip.uiPadY,_uip.uiFillColor,_uip.uiFillAlpha, _uip.uiWidth, _uip.uiHeight);
			
			
		}
		
		private function _addhead(str:String, fontsize:Number = 22, fontcolor:String ="black", padX:Number = 20,padY:Number = 12, fillcolor:String = "white", fillalpha:Number = 1, twidth:Number = 755,theight:Number = 50):void
		{
			_tlformat = new TextLayoutFormat();
			_tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlformat.renderingMode = RenderingMode.CFF;
			_tlformat.cffHinting = CFFHinting.NONE;
			//_tlformat.color = _uip.uiFontColorCode;//SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
			_tlformat.color = SHELL_COLORS.lookUpColor(fontcolor); //SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
			var _backColorCode:uint = SHELL_COLORS.lookUpColor(fillcolor);// 0xFFFFFF;
			_tlformat.backgroundColor =_backColorCode;//SHELL_COLORS.lookUpColor(fillcolor);// 0xFFFFFF;
			//_tlf_sceneHeader.fontWeight = FontWeight.BOLD;
			_tlformat.backgroundAlpha = fillalpha;// 1;
			
			_txtbacktrue = (fillalpha != 0)?true:false;
			
			_tlformat.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			_tlformat.fontSize =fontsize;// 22;
			//	_tlf_format.paddingLeft = 20;
			_tlformat.lineHeight = "100%";
			_tlformat.styleName = "slideHeader";
			
			var tField:TLFTextField = new TLFTextField();
			tField.embedFonts = true;
			tField.antiAliasType =  AntiAliasType.ADVANCED;
			tField.autoSize = _txtFieldASize;// TextFieldAutoSize.LEFT;
			tField.width =twidth;// 755;
			tField.height =theight;// 50;
			tField.verticalAlign = VerticalAlign.TOP;
			tField.selectable = false;
		
		//	tField.border= true;
			tField.wordWrap = true;
			tField.background = _txtbacktrue;
			tField.backgroundColor = _backColorCode;//0x15A5C9;
			tField.htmlText = str;
			
			var myTextFlow:TextFlow = tField.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.paddingLeft = padX;//20;
			myTextFlow.paddingTop =  padY;//12;
			myTextFlow.hostFormat =_tlformat;
			myTextFlow.locale = _localeID;
			myTextFlow.direction = _txtDirection;
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(tField);
		}
		/*
			_tlformat = new TextLayoutFormat();
			_tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlformat.renderingMode = RenderingMode.CFF;
			_tlformat.cffHinting = CFFHinting.NONE;
			_tlformat.color = _uip.uiFontColorCode;//SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
			_tlformat.backgroundColor = _uip.uiFillColorCode; //SHELL_COLORS.CLR_WHITE;// 0xFFFFFF;
			_tlformat.backgroundAlpha = _uip.uiFillAlpha; //1;
			
			_tlformat.fontSize = _uip.uiFontSize;//   20;
			
			_tlformat.fontFamily = "Arial";
			
			_tlformat.paddingLeft = _uip.uiPadding;//    20;
			//_tlformat.styleName = "sceneHeader";
			
			_tlformat.textAlign = _uip.uiFontHAlignCONST;
			_tlft = new TLFTextField();
			_tlft.embedFonts = true;
			_tlft.antiAliasType =  AntiAliasType.ADVANCED;
			_tlft.border = true;
			//addChild(myTLFTextField); 
			_tlft.width = _uip.uiWidth; //twidth;// 755;
			
			if (_uip.uiHeight > 0){
				_tlft.height = _uip.uiHeight;// 50;
			}
		
			
			
			_tlft.verticalAlign = _uip.uiFontVAlignCONST; // VerticalAlign.MIDDLE;
			
			_tlft.selectable = false;
			
			if (_uip.uiFillAlpha == 0) {
				_tlft.background = false; 
			} else {
				_tlft.background = true; // tbacktrue;
				_tlft.backgroundColor = _uip.uiFillColorCode; //tbackColor;//0x15A5C9;
				_tlft.backgroundAlpha = _uip.uiFillAlpha; //tbackColor;//0x15A5C9;
			} 
			
			
			//	myTLFTextField.border = true;
		//	_tlft.background = tbacktrue;
		//	_tlft.backgroundColor = tbackColor;//0x15A5C9;
			_tlft.htmlText = str;
			
			var myTextFlow:TextFlow = _tlft.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.hostFormat =_tlformat ;
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(_tlft);
		}
		*/
		public function get txtHeight():Number
		{
			
			var tlfh:Number = (_tlft.textHeight > _uip.uiHeight)?_tlft.textHeight:_uip.uiHeight;
			
			//trace('tlfTXTh = ' + _tlft.textHeight);
		//	trace('tlfh = ' + _tlft.height);
			_txtHeight = tlfh;
			return _txtHeight;
		}
		
	}
	
}

