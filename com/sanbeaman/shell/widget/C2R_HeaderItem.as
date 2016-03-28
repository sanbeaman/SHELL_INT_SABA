package com.sanbeaman.shell.widget
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
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
	
	public class C2R_HeaderItem extends BodyUI
	{
		
		
		private var _fullImgPath:String;
		
		
		private var _iLoader:ImageLoader;
		private var _tlf_format:TextLayoutFormat;
	
		private var _back:Sprite;
		
		
		private var _uip:UIparams;
		private var _headerText:String;
		
		
		private var _textWidth:Number;
	
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		public function C2R_HeaderItem()
		{
			super();
			
		}
		
		
		
		public function init(txt:String,uiparams:UIparams,fontfamily:String = "Arial", langID:String = null):void
		{
			
			this.type = "C2RHeader";
			_uip = uiparams;
			
			_fontFamily = fontfamily;
			
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_headerText = txt;
			_back = new Sprite();
			
			var _transDirection:String = _uip.uiTrans;
			var p0:Point = new Point(0,0);
			var p1:Point = new Point(_uip.uiWidth,0);
			var p2:Point;
			var p3:Point;
			//var p4:Point;
			
			if (_transDirection == 'slideright'){
				var shortside:Number = _uip.uiWidth - _uip.uiHeight;
				trace('shortside='+shortside);
				p2 = new Point(shortside,_uip.uiHeight);
				p3 = new Point(0,_uip.uiHeight);
				
			} else if (_transDirection == 'slideleft') {
				p2 = new Point(_uip.uiWidth,_uip.uiHeight);
				p3 = new Point(_uip.uiHeight,_uip.uiHeight);
			} else {
				p2 = new Point(_uip.uiWidth,_uip.uiHeight);
				p3 = new Point(0,_uip.uiHeight);
			}
			var frameColorCode:uint = SHELL_COLORS.lookUpColor(_uip.uiFrameColor);
			
			var frameSize:Number = _uip.uiFrameSize;
			var frameAlpha:Number = _uip.uiFrameAlpha;
			
			var fillColorCode:uint = SHELL_COLORS.lookUpColor(_uip.uiFillColor);
			var fillAlpha:Number = _uip.uiFillAlpha;
			_back.graphics.lineStyle(frameSize,frameColorCode,frameAlpha,true);
			_back.graphics.beginFill(fillColorCode,fillAlpha);
			
			
			
			//_back.graphics.lineStyle(1,SHELL_COLORS.CLR_BLUE,1,true);
			
			//_back.graphics.beginFill(SHELL_COLORS.CLR_BLUE,1);
			
			_back.graphics.moveTo(p0.x,p0.y);
			_back.graphics.lineTo(p1.x,p1.y);
			_back.graphics.lineTo(p2.x,p2.y);
			_back.graphics.lineTo(p3.x,p3.y);
			_back.graphics.lineTo(p0.x,p0.y);
			_back.graphics.endFill();
			
			this.addChild(_back);
			/*
			_fullImgPath =imagePath;
			_iLoader = new ImageLoader(_fullImgPath, {container:_back, centerRegistration:false, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
			*/
			_addHeader(_headerText);
			
		}
		
		
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			trace('graphic loaded');
			
		}
		private  function _addHeader(str:String):void
		{
					
					_tlf_format = new TextLayoutFormat();
					_tlf_format.fontLookup = FontLookup.EMBEDDED_CFF;
					_tlf_format.renderingMode = RenderingMode.CFF;
					_tlf_format.cffHinting = CFFHinting.NONE;
					_tlf_format.color =_uip.uiFontColorCode;// SHELL_COLORS.CLR_BLUE;//0x15A5C9; 
					//_tlf_format.backgroundColor =SHELL_COLORS.CLR_WHITE;// 0xFFFFFF;
					//_tlf_sceneHeader.fontWeight = FontWeight.BOLD;
					//_tlf_format.backgroundAlpha = 1;
				
					_tlf_format.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
					_tlf_format.fontSize = _uip.uiFontSize;//_fontSize;
					//	_tlf_format.paddingLeft = 20;
					_tlf_format.lineHeight = "100%";
					//_tlf_format.styleName = "sceneHeader";
					
					var tField:TLFTextField = new TLFTextField();
					tField.embedFonts = true;
					tField.antiAliasType =  AntiAliasType.ADVANCED;
					//tField.autoSize = TextFieldAutoSize.LEFT;
					tField.width = _uip.uiWidth - _uip.uiHeight;//twidth;// 755;
					tField.height = _uip.uiHeight;//theight;// 50;
					tField.verticalAlign = VerticalAlign.MIDDLE;
					tField.selectable = false;
					//tField.direction = Direction.LTR;
					tField.wordWrap = true;
					//tField.background = tbacktrue;
				//	tField.backgroundColor = tbackColor;//0x15A5C9;
					tField.htmlText = str;
					
					var myTextFlow:TextFlow = tField.textFlow;
					myTextFlow.invalidateAllFormats();
					myTextFlow.direction = _txtDirection;
					myTextFlow.paddingLeft = _uip.uiPadX;
				//	myTextFlow.paddingTop = 12;
					myTextFlow.hostFormat = _tlf_format;
					myTextFlow.flowComposer.updateAllControllers();
					this.addChild(tField);
				}
	}
}
