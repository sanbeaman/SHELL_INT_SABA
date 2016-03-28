package com.sanbeaman.shell.widget
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
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class BoxCopy extends Sprite
	{
		
		private var _txtWidth:Number;
		private var _txtHeight:Number;
		private var _tlf:TLFTextField;
		
		private var _xpad:Number;
		private var _ypad:Number;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		private var _txtHAlign:String;
		
		private var _fontFamily:String;
		
		public function BoxCopy()
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		public function addText(str:String,tw:Number,tsize:Number,tcolor:uint = 0x666666,xpad:Number = 10,ypad:Number = 10, theight:Number = 0, fontalign:String = "center", fontfamily:String ="Arial", langID:String = null):void
		{
		//	_tlf_holder = new Sprite();
			//_tlf_holder.graphics.beginFill(0xff0000,.6);
		//	_tlf_holder.graphics.drawRect(5,5,200,200);
			
			_localeID = (langID != null)?langID:"en";
			
			
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			if (fontalign == "center") {
				//_txtFieldASize = TextFieldAutoSize.CENTER;
				_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
				_txtHAlign =  TextAlign.CENTER;
			} else {
				_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
				_txtHAlign = (_localeID == 'ar')?TextAlign.RIGHT:TextAlign.LEFT;
			}
			
			
			
			_fontFamily = fontfamily;
			
			_xpad = xpad;
			_ypad = ypad;
		//	_tlf_holder.width = tw;
		//	this.addChild(_tlf_holder);
			
			_tlf = new TLFTextField();
			_tlf.embedFonts = true;
			_tlf.antiAliasType =  AntiAliasType.ADVANCED;
			//_tlf.border = true;
			_tlf.multiline = true;
			_tlf.wordWrap = true;
			_tlf.width = tw;
			_tlf.autoSize = _txtFieldASize;
			
			/*
			if (theight == 0) {
				_tlf.autoSize = _txtFieldASize;// TextFieldAutoSize.LEFT;
			} else {
				_tlf.height = theight;
			}
		
		*/
			//_tlf.verticalAlign = VerticalAlign.MIDDLE;
			_tlf.selectable = false;
			
			//_tlf.direction = Direction.LTR;
			
			_tlf.htmlText = str;
			
		
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			format.fontSize = tsize;//18;
			format.color =tcolor;// 0x666666;
			format.textAlign = _txtHAlign;//TextAlign.CENTER;
		
			//format.paddingLeft = _xpad
			//format.paddingRight =_xpad;
			//format.paddingTop =_ypad;
			//format.paddingBottom =_ypad;
			
			format.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			
			//////		
			/////
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.direction = _txtDirection;
			
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;
			
			myTextFlow.paddingLeft = _xpad;//20;
			myTextFlow.paddingRight = _xpad;//20;
			myTextFlow.paddingTop = _ypad;//10;
			myTextFlow.paddingBottom =_ypad;// 10;
			myTextFlow.hostFormat = format;
		//	myTextFlow.direction = Direction.RTL;
		
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(_tlf);
			//this.addChild(_tlf_holder);
			//_tlf.mouseEnabled = false;
		//	_tlf.mouseChildren = false;
		}

		
		public function get txtHeight():Number
		{
			
			var tlfh0:int = int(_tlf.height);
			var tlfh:Number = Number( tlfh0);
			var tlfttth0:int = int(_tlf.textHeight);
			var tlfttth:Number = Number( tlfttth0);
			trace('_tlf.textHeight = ' + _tlf.textHeight);
			trace('_tlf.height = ' + _tlf.height);
			trace('_tlf.height int= ' + tlfh);
			
			
			_txtHeight = (tlfh >= tlfttth)?tlfh:tlfttth;
			//_tlf.height = _txtHeight;
			return _txtHeight;
		}

		
	}
}

