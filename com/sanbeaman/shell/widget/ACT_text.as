package com.sanbeaman.shell.widget
{
	
	
	import com.sanbeaman.shell.data.UIparams;
	
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class ACTUI_BodyText extends BodyUI
	{
		
		private var _tlformat:TextLayoutFormat;
		private var _tlft:TLFTextField;
		
		private var _uip:UIparams;
		
		public function ACTUI_BodyText()
		{
			super();
		}
		
		
		//public function addHeader(str:String, tbacktrue:Boolean = false, tbackColor:uint =0xffffff, twidth:Number = 755,theight:Number = 50):void
		public function addHeader(str:String, uiparams:UIparams):void
		{
			_uip = uiparams;
			
			_tlformat = new TextLayoutFormat();
			_tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlformat.renderingMode = RenderingMode.CFF;
			_tlformat.cffHinting = CFFHinting.NONE;
			_tlformat.color = _uip.uiFontColorCode;//SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
			_tlformat.backgroundColor = _uip.uiFillColorCode; //SHELL_COLORS.CLR_WHITE;// 0xFFFFFF;
			_tlformat.backgroundAlpha = _uip.uiFillAlpha; //1;
			
			_tlformat.fontSize = _uip.uiFontSize;//   20;
			
			_tlformat.fontFamily = "Arial";
			trace("_uip.uiPadding= " + _uip.uiPadding);
			/*
			if(_uip.uiPadding != "") {
				_tlformat.paddingLeft = _uip.uiPadding;
			} else {
				_tlformat.paddingLeft = 20;//    2
			}
			*/
			_tlformat.paddingLeft = _uip.uiPadding;//    20;
			//_tlformat.styleName = "sceneHeader";
			
			_tlformat.textAlign = _uip.uiFontHAlignCONST;
			_tlft = new TLFTextField();
			_tlft.embedFonts = true;
			_tlft.antiAliasType =  AntiAliasType.ADVANCED;
			//addChild(myTLFTextField); 
			_tlft.width = _uip.uiWidth; //twidth;// 755;
			_tlft.height = _uip.uiHeight;// 50;
			
			
			_tlft.verticalAlign = _uip.uiFontVAlignCONST; // VerticalAlign.MIDDLE;
			
			_tlft.selectable = false;
			
			if (_uip.uiFillAlpha == 1) {
				_tlft.background = true; // tbacktrue;
				_tlft.backgroundColor = _uip.uiFillColorCode; //tbackColor;//0x15A5C9;
			} else {
				_tlft.background = false; 
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
		
		
		
	}
}

