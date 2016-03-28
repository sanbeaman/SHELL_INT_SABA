package com.sanbeaman.shell.ui
{
	import com.greensock.loading.LoaderMax;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class HeaderSectionMain extends Sprite
	{
		
				/*
				[Embed (source="/masterShell/imgs/headerBack.png")]
				private var _hBack:Class
				public var hBack:Bitmap = new _hBack;
				*/
				private var _headerBack:Sprite;
				private var _isBackBitmap:Boolean;
				private var _headerBackBitmap:String;
				
				private var _sectionHeader_txt:String;
				private var _sceneHeader_txt:String;
				private var _headerDivider:String;
				
				private var _format_sectionHeader:TextLayoutFormat;
				private var _format_sceneHeader:TextLayoutFormat;
				
				private var _txtformat_sec:TextFormat;
				private var _txtformat_scen:TextFormat;
				
				private var _tlf_sectionHeader:TLFTextField;
				
				private var _sectionHeader_tlf:TLFTextField;
				private var _sectionHeader_tlformat:TextLayoutFormat;
				
				private var _tlf_connectHeaders:TLFTextField;
				
				private var _tlf_sceneHeader:TLFTextField;
				private var _localeID:String;
				private var _txtDirection:String;
				private var _txtFieldASize:String;
				
				private var _fontFamily:String;
				
				private var _sectionTitle:String;
				
				private var _txtFlow:TextFlow;
				private var _padx:Number;
				private var _pady:Number;
				
				private var _hasFX:Boolean = false;
				private var _FXon:Boolean = false;
				private var _printView:Boolean = false;
				
				private var _fontFX:String;
				private var _fontStyle:String;
				private var _fontName:String;
				
				private var _sceneDivider:String;
				
				private var _sectionTitleLength:Number;
				
				public function HeaderSectionMain()
				{
					super();
					//this.addChild(hBack);
				}
				
				public function init(headerXML:XMLList, headerTxt:String, sceneheadXML:XMLList = null, langID:String = null):void
				{
					
					
					_sectionTitle = headerTxt;
					_sectionTitleLength = _sectionTitle.length;
				//	trace("_sectionTitleLength======"+_sectionTitle.length);
					
					/*
					<sectionHeader x="0" y="30" 
					width="755" height="32" 
					xPad="12" yPad="3" 
					fontName="Helvetica Neue Black Condensed" 
					fontSize="28" fontColor="white" fontStyle="bold" fontAlign="left" fontFX="dropShadow" 
					frameSize="1" frameColor="blue" frameAlpha="0" 
					fillColor="blue" fillAlpha="0" bitmap="headerback" />
					*/
					_localeID = (langID != null)?langID:"en";
					_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
					_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
					
					_headerBack = new Sprite();
					
					_isBackBitmap =  (headerXML.hasOwnProperty("@bitmap"))?true:false;
					if(_isBackBitmap) {
						_headerBackBitmap = headerXML.@bitmap;
						var gpsbmp:Bitmap = LoaderMax.getLoader(_headerBackBitmap).rawContent;
						_headerBack.addChild(gpsbmp);
						
					} else {
						var fillColorCode:uint = SHELL_COLORS.lookUpColor(headerXML.@fillColor);
						var fillAlpha:Number = (headerXML.hasOwnProperty("@fillAlpha"))?headerXML.@fillAlpha:0;
						
						var frameSize:Number = (headerXML.hasOwnProperty("@frameSize"))?headerXML.@frameSize:1;
						var frameColorCode:uint = SHELL_COLORS.lookUpColor(headerXML.@frameColor);
						var frameAlpha:Number =(headerXML.hasOwnProperty("@frameAlpha"))?headerXML.@frameAlpha:0;
						
						_headerBack.graphics.beginFill(fillColorCode,fillAlpha);
						_headerBack.graphics.lineStyle(frameSize,frameColorCode,frameAlpha,true);
						_headerBack.graphics.drawRect(0,0,headerXML.@width,headerXML.@height);
						_headerBack.graphics.endFill();
						
					}
					
					
					this.addChild(_headerBack);
					_fontName = (headerXML.hasOwnProperty("@fontName"))?headerXML.@fontName:"Arial";
					var _fontSize:Number = (headerXML.hasOwnProperty("@fontSize"))?headerXML.@fontSize:16;
					var _fontColorCode:uint = SHELL_COLORS.lookUpColor(headerXML.@fontColor);
					
					_sectionHeader_tlf = new TLFTextField();
					_sectionHeader_tlf.embedFonts = true;
					_sectionHeader_tlf.antiAliasType =  AntiAliasType.ADVANCED;
					_sectionHeader_tlf.width = headerXML.@width;
					trace('	_sectionHeader_tlf.width =' + 	_sectionHeader_tlf.width);
					_sectionHeader_tlf.height = headerXML.@height;
					_sectionHeader_tlf.verticalAlign =  VerticalAlign.MIDDLE;
					_sectionHeader_tlf.selectable = false;
					
					_sectionHeader_tlf.border = true;
					
					// TEXTLAYOUT FORMAT
					_format_sectionHeader = new TextLayoutFormat();
					
					_format_sectionHeader.fontLookup = FontLookup.EMBEDDED_CFF;
					_format_sectionHeader.renderingMode = RenderingMode.CFF;
					_format_sectionHeader.cffHinting = CFFHinting.NONE;
					
					if (_sectionTitleLength > 32 ) {
						_fontSize = _fontSize-4;
					}
					_format_sectionHeader.fontSize = _fontSize;// 24;
					_format_sectionHeader.color = _fontColorCode;// 0xffffff;
					//	_tlformat.textAlign = TextAlign.LEFT;
					_format_sectionHeader.lineHeight = "100%";
					_format_sectionHeader.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
					
					//_tlformat.paddingLeft = 10;
					
					_format_sectionHeader.fontFamily = _fontName;//  SHELL_VARS.SHELL_FONT_FAMILY;
					
					
					_txtformat_sec = _createTextFormat(headerXML);
					
					
					_sectionHeader_tlf.defaultTextFormat = _txtformat_sec;
					_sectionHeader_tlf.htmlText = _sectionTitle;
				//	_sceneDivider = headerXML.@divider;
					
					if (sceneheadXML != null) {
						_txtformat_scen = _createTextFormat(sceneheadXML);
						//_sceneDivider = headerXML.@divider;
						_sceneDivider = headerXML.@divider;
						trace("_sceneDivider="+ _sceneDivider + "<<");
					}
					
					_fontFX = (headerXML.hasOwnProperty("@fontFX"))?headerXML.@fontFX:"x";
					_padx= (headerXML.hasOwnProperty("@xPad"))?headerXML.@xPad:10;
					_pady = (headerXML.hasOwnProperty("@yPad"))?headerXML.@yPad:2;
					
					//TEXTFLOW
					_txtFlow = _sectionHeader_tlf.textFlow;
					_txtFlow.invalidateAllFormats();
					_txtFlow.paddingTop =_pady;
					_txtFlow.paddingLeft = _padx;
					
					_txtFlow.paddingRight = _checkPadRight();//_padx;
					_txtFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
					_txtFlow.direction = _txtDirection;
					_txtFlow.hostFormat =_format_sectionHeader ;
					
					
					_txtFlow.flowComposer.updateAllControllers();
					//_tlf.x = 10;
					this.addChild(_sectionHeader_tlf);
					
					
					if (_fontFX.toLowerCase() == 'dropshadow'){
						_hasFX = true;
						this.applyFX();
						//this.hasFilter = true;
					}

					//_sectionHeader_tlf.x = _xpad;
				//	_sectionHeader_tlf.y= _ypad;
					
					
					_headerBack.addChild(_sectionHeader_tlf);
					
					
					
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
					_sectionHeader_tlf.filters = myFilters;
				}
				
				
				private function _createTextFormat(inXML:XMLList):TextFormat
				{
					/*<sceneHeader style="breadcrumb" 
					x="0" y="0" xPad="0" yPad="0" width="755" height="30" 
					frameSize="1" frameColor="black" frameAlpha="0" fillColor="white" fillAlpha="0" 
					fontName="Century Gothic" fontSize="14" fontColor="0x999999" fontStyle="reg" 
					fontAlign="left" fontFX="x" inside="false" divider="/"/>
					*/
					
					var tf:TextFormat = new TextFormat();
					tf.font = inXML.@fontName;
					tf.size = inXML.@fontSize;
					var fcolorCode:uint = SHELL_COLORS.lookUpColor(inXML.@fontColor);
					tf.color = fcolorCode;
					
					return tf;
					//_txtformat_scen.font = SHELL_VARS.SHELL_FONT_FAMILY;
					//	_txtformat_scen.size = 14;
					//_txtformat_scen.bold = false;
					
					
					
				}
				
				public function switchSceneHeader(secStr:String,scenStr:String = null):void
				{
					var sectionString:String;
					var hasSceneHeader:Boolean = (scenStr != null)?true:false;
					
					var sceneTextStart:Number;
					var sceneTextEnd:Number;
					var completeString:String;
					
					if (hasSceneHeader) {
						sectionString = secStr + _sceneDivider;
						hasSceneHeader = true;
						sceneTextStart = sectionString.length;
						completeString = sectionString + scenStr;
						sceneTextEnd = completeString.length;
						_sectionHeader_tlf.htmlText = "";
						_sectionHeader_tlf.htmlText = completeString;
						_sectionHeader_tlf.setTextFormat(_txtformat_sec,-1,sceneTextStart -1);
						_sectionHeader_tlf.setTextFormat(_txtformat_scen,sceneTextStart,sceneTextEnd);
					} else {
						sectionString = secStr;
						completeString = secStr;
						_sectionHeader_tlf.htmlText = "";
						_sectionHeader_tlf.htmlText = completeString;
						_sectionHeader_tlf.setTextFormat(_txtformat_sec);
						//sceneTextStart = sectionString.length;
					}
					
					
					_txtFlow = _sectionHeader_tlf.textFlow;
					_txtFlow.invalidateAllFormats();
					_txtFlow.paddingTop =_pady;
					_txtFlow.paddingLeft = _padx;
					_txtFlow.paddingRight = _checkPadRight();//_padx;
					_txtFlow.verticalAlign = VerticalAlign.MIDDLE;;//VerticalAlign.TOP;
					_txtFlow.direction = _txtDirection;
					_txtFlow.hostFormat =_format_sectionHeader ;
					//newTxtFlow.hostFormat =_format_sectionHeader ;
					
					
					_txtFlow.flowComposer.updateAllControllers();
				
					
				}
				
				private function _checkPadRight():Number
				{
					var padRight:Number;
					if(_txtDirection == Direction.RTL){
						padRight = _padx;
					} else {
						padRight = 0;
					}
					
					return padRight;
				}
				public function addHeader(secStr:String,scenStr:String = "none"):void
				{
					var sectionString:String;
					var hasSceneHeader:Boolean;// = false;
					var sceneTextStart:Number;
					var sceneTextEnd:Number;
					var completeString:String;
					
					if (scenStr != "none") {
						sectionString = secStr + " / ";
						hasSceneHeader = true;
						sceneTextStart = sectionString.length;
						completeString = sectionString + scenStr;
						sceneTextEnd = completeString.length;
					} else {
						sectionString = secStr;
						hasSceneHeader = false;
						completeString = secStr;
						//sceneTextStart = sectionString.length;
					}
					_txtformat_sec = new TextFormat();
					
					//_txtformat_sec.fontLookup = FontLookup.EMBEDDED_CFF;
					//	_txtformat_sec.renderingMode = RenderingMode.CFF;
					//	_txtformat_sec.cffHinting = CFFHinting.NONE;
					_txtformat_sec.color = SHELL_COLORS.lookUpColor("dkgrey");
					_txtformat_sec.size = 18;
					_txtformat_sec.bold = true;
					
					
					_txtformat_sec.font = SHELL_VARS.SHELL_FONT_FAMILY;
					
					
					_txtformat_scen = new TextFormat();
					//_txtformat_scen.font = SHELL_VARS.SHELL_FONT_FAMILY;
					_txtformat_scen.size = 14;
					_txtformat_scen.bold = false;
					
					
					_tlf_sectionHeader = new TLFTextField();
					_tlf_sectionHeader.embedFonts = true;
					_tlf_sectionHeader.antiAliasType =  AntiAliasType.ADVANCED;
					_tlf_sectionHeader.defaultTextFormat = _txtformat_sec;
					
					//	_tlf_sectionHeader.autoSize =  TextFieldAutoSize.LEFT;
					_tlf_sectionHeader.width = 755;// 755;
					_tlf_sectionHeader.height = 24;// 50;
					//_tlf_sectionHeader.verticalAlign = VerticalAlign.BOTTOM;
					_tlf_sectionHeader.selectable = false;
					_tlf_sectionHeader.direction = Direction.LTR;
					_tlf_sectionHeader.wordWrap = false;
					_tlf_sectionHeader.htmlText = completeString;
					
					if (hasSceneHeader) {
						_tlf_sectionHeader.setTextFormat(_txtformat_sec,-1,sceneTextStart -1);
						_tlf_sectionHeader.setTextFormat(_txtformat_scen,sceneTextStart,sceneTextEnd);
					} else {
						_tlf_sectionHeader.setTextFormat(_txtformat_sec);
					}
					/*
					var myTextFlow:TextFlow = _tlf_sectionHeader.textFlow;
					myTextFlow.invalidateAllFormats();
					myTextFlow.paddingLeft = 20;
					//myTextFlow.paddingTop = 12;
					myTextFlow.hostFormat =_format_sectionHeader;
					myTextFlow.flowComposer.updateAllControllers();
					
					if (hasSceneHeader) {
					
					_tlf_sectionHeader.setTextFormat(_format_sceneHeader,sceneTextStart,sceneTextEnd);
					
					
					}
					
					*/
					_tlf_sectionHeader.y = 4;
					_tlf_sectionHeader.x = 50;
					this.addChild(_tlf_sectionHeader);
					
				}
				
				public function addHeaderTLF(secStr:String,scenStr:String = "none"):void
				{
					var sectionString:String;
					var hasSceneHeader:Boolean;// = false;
					var sceneTextStart:Number;
					var sceneTextEnd:Number;
					var completeString:String;
					if (scenStr != "none") {
						sectionString = secStr + " / ";
						hasSceneHeader = true;
						sceneTextStart = sectionString.length +1;
						completeString = sectionString + scenStr;
						sceneTextEnd = completeString.length;
					} else {
						sectionString = secStr;
						hasSceneHeader = false;
						completeString = secStr;
						//sceneTextStart = sectionString.length;
					}
					
					
					_format_sectionHeader = new TextLayoutFormat();
					_format_sectionHeader.fontLookup = FontLookup.EMBEDDED_CFF;
					_format_sectionHeader.renderingMode = RenderingMode.CFF;
					_format_sectionHeader.cffHinting = CFFHinting.NONE;
					_format_sectionHeader.color =0x15A5C9; 
					
					_format_sectionHeader.fontWeight = FontWeight.BOLD;
					//	_format_sectionHeader.backgroundAlpha = 1;
					
					_format_sectionHeader.fontSize = 18;
					//	_tlf_format.paddingLeft = 20;
					_format_sectionHeader.lineHeight = "100%";
					_format_sectionHeader.styleName = "sectionHeader";
					_format_sectionHeader.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
					
					_format_sceneHeader = new TextLayoutFormat();
					_format_sceneHeader.fontLookup = FontLookup.EMBEDDED_CFF;
					_format_sceneHeader.renderingMode = RenderingMode.CFF;
					_format_sceneHeader.cffHinting = CFFHinting.NONE;
					_format_sceneHeader.color =0x15A5C9; 
					
					_format_sceneHeader.fontWeight = FontWeight.NORMAL;
					
					
					_tlf_sectionHeader = new TLFTextField();
					_tlf_sectionHeader.embedFonts = true;
					_tlf_sectionHeader.antiAliasType =  AntiAliasType.ADVANCED;
					//	_tlf_sectionHeader.autoSize =  TextFieldAutoSize.LEFT;
					_tlf_sectionHeader.width = 400;// 755;
					_tlf_sectionHeader.height = 24;// 50;
					//_tlf_sectionHeader.verticalAlign = VerticalAlign.BOTTOM;
					_tlf_sectionHeader.selectable = false;
					_tlf_sectionHeader.direction = Direction.LTR;
					_tlf_sectionHeader.wordWrap = false;
					_tlf_sectionHeader.htmlText = sectionString;
					
					var myTextFlow:TextFlow = _tlf_sectionHeader.textFlow;
					myTextFlow.invalidateAllFormats();
					myTextFlow.paddingLeft = 20;
					myTextFlow.fontWeight = FontWeight.BOLD;
					//myTextFlow.paddingTop = 12;
					myTextFlow.hostFormat = _format_sectionHeader;
					myTextFlow.flowComposer.updateAllControllers();
					
					if (hasSceneHeader) {
						
						//	_tlf_sectionHeader.setTextFormat(_format_sceneHeader,sceneTextStart,sceneTextEnd);
						
						
					}
					//_tlf_sectionHeader.y = 4;
					this.addChild(_tlf_sectionHeader);
					
				}
				
				private function _addSceneHeader(str:String):void
				{
					
					_format_sceneHeader = new TextLayoutFormat();
					_format_sceneHeader.fontLookup = FontLookup.EMBEDDED_CFF;
					_format_sceneHeader.renderingMode = RenderingMode.CFF;
					_format_sceneHeader.cffHinting = CFFHinting.NONE;
					_format_sceneHeader.color =0x15A5C9; 
					
					_format_sceneHeader.fontWeight = FontWeight.NORMAL;
					//	_format_sectionHeader.backgroundAlpha = 1;
					_format_sceneHeader.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
					_format_sceneHeader.fontSize = 14;
					//	_tlf_format.paddingLeft = 20;
					_format_sceneHeader.lineHeight = "100%";
					_format_sceneHeader.styleName = "sceneHeader";
					
					_tlf_sceneHeader = new TLFTextField();
					_tlf_sceneHeader.embedFonts = true;
					_tlf_sceneHeader.antiAliasType =  AntiAliasType.ADVANCED;
					//_tlf_sceneHeader.autoSize =  TextFieldAutoSize.LEFT;
					_tlf_sceneHeader.width = 400;// 755;
					_tlf_sceneHeader.height = 24;// 50;
					//		_tlf_sceneHeader.verticalAlign = VerticalAlign.BOTTOM;
					_tlf_sceneHeader.selectable = false;
					_tlf_sceneHeader.direction = Direction.LTR;
					_tlf_sceneHeader.wordWrap = false;
					_tlf_sceneHeader.htmlText = str;
					
					var myTextFlow3:TextFlow = _tlf_sceneHeader.textFlow;
					myTextFlow3.invalidateAllFormats();
					myTextFlow3.paddingLeft = 0;
					myTextFlow3.fontWeight = FontWeight.NORMAL;
					
					//myTextFlow.paddingTop = 12;
					myTextFlow3.hostFormat =_format_sceneHeader;
					myTextFlow3.flowComposer.updateAllControllers();
					
					var newX:Number = _tlf_sectionHeader.textWidth + 10;
					_tlf_sceneHeader.y = 4;
					_tlf_sceneHeader.x = _tlf_sectionHeader.x + newX;
					
					this.addChild(_tlf_sceneHeader);
				}
				
				
				public function applyFX():void
				{
					if (!_FXon){
						var filter:BitmapFilter = getBitmapFilter();
						var myFilters:Array = new Array();
						myFilters.push(filter);
						_sectionHeader_tlf.filters = myFilters;
						
						_FXon = true;
					}
				}
				public function removeFX():void
				{
					if (_FXon){
						_sectionHeader_tlf.filters = null;
						_FXon = false;
					}
				}
				
				
			}
		}

