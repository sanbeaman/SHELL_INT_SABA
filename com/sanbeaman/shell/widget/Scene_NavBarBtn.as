package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.motion.AdjustColor;
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;


	
	public class Scene_NavBarBtn extends MovieClip
	{
		private var _enabled:Boolean;
		
		private var _btnIcon:Sprite;
		private var _btnLabel:Sprite;
		private var _btnTarget:String;
		
		private var _btnTracked:Boolean;
		
		
		private var _btnIconUrl:String;
		private var _btnLabelTxt:String;
		
	//	private var _btnLabelTLF:TLFTextField;
		
		private var _currentState:String;
		
		private var _iLoader:ImageLoader;
		
		private var _tformat:TextFormat;
		
		private var _color:AdjustColor;
		private var _colorMatrix:ColorMatrixFilter;
		private var _matrix:Array;
		private var _filterBW:Array;
		
		private var _filterGlow_blue:BitmapFilter;
		private var _filterGlow:Array;
	
		private var _iconWidth:Number;
		private var _iconHeight:Number;
		private var _btnWidth:Number;
		private var _btnHeight:Number;
		
		
		private var _tlf_buttonlabel:TLFTextField;
		private var _fontSize:Number;
		private var _fontColorCode:uint;
		private var _btnBack:Sprite;
		
		private var _pulseTL:TimelineMax;
		private var _pulseON:Boolean;
		private var _pulseColorCode:uint;// SHELL_COLORS.CLR_BLUE;
		private var _pulseAlpha:Number = .8;
		private var _pulseX:Number = 10;
		private var _pulseY:Number = 10;
		private var _pulseStrength:Number = 3;
		private var _pulseQuality:uint = 3;
		
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		
		public function Scene_NavBarBtn()
		{
			super();
			_enabled = true;
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
		}
		/**
		 * enabled
		 * Is the button enabled for use?
		 * @return	Boolean
		 */
		override public function get enabled():Boolean
		{
			
			return _enabled;
			
		}
		
		override public function set enabled( p_value:Boolean ):void
		{
			super.enabled = p_value;
			
			_enabled = p_value;
			
			if( !_enabled )
			{
				useHandCursor = false;
				buttonMode = false;
				//currentState = 'ready';
			}
			else
			{
				buttonMode = true;
				useHandCursor = true;
				
				
				//currentState = UP;
			}
			
		}
		public function buildBtn(imgpath:String,btnlabel:String, btnw:Number,btnh:Number,iconw:Number = 0,iconh:Number = 0, fontSize:Number = 14, fontColorCode:uint = 0x666666,pulseColorCode:uint = 0xfe9003, fontfamily:String = "Arial",langID:String= null):void
		{
			_btnIconUrl = imgpath;
			_btnLabelTxt = btnlabel;
			_btnWidth = btnw;
			_btnHeight = btnh;
			_iconWidth = iconw;
			_iconHeight = iconh;
			
			_fontSize = fontSize;
			_fontColorCode = fontColorCode;
			_pulseColorCode = pulseColorCode;
			//_loadImageIcon(_btnIconUrl);
			//_createTextFormat();
		//	_createFilters();
			_initListeners();
			_btnBack  = new Sprite();
			//_btnBack.graphics.lineStyle(1,0x000000);
			_btnBack.graphics.beginFill(0x777777,0);
			_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			_btnBack.graphics.endFill();
			
			this.addChild(_btnBack);
			
			
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_btnIcon = new Sprite();
			if (_iconWidth == 0) {
		  	 _iLoader = new ImageLoader(_btnIconUrl, {container:_btnIcon, centerRegistration:true, onComplete:_imgLoadComplete_handler});
			} else {
				_iLoader = new ImageLoader(_btnIconUrl, {container:_btnIcon, width:_iconWidth,height:_iconHeight,scaleMode:"proportionalInside", centerRegistration:true, onComplete:_imgLoadComplete_handler});
			}
			
			_iLoader.load();
		}
		
		private function _loadImageIcon(iconpath:String):void{
			
			_btnIcon = new Sprite();
			_iLoader = new ImageLoader(iconpath, {container:_btnIcon, centerRegistration:true, onComplete:_imgLoadComplete_handler});
			_iLoader.load();
		}
		
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
		
		
			//_iconWidth = _btnIcon.width;
		//	_iconHeight = _btnIcon.height;
			
			_btnIcon.x = _btnWidth * .5;
			_btnIcon.y = _btnIcon.width * .5;
			_btnBack.addChild(_btnIcon);
		//	_btnWidth = _iconWidth + (_iconWidth * .5);
		//	_btnHeight = _iconHeight + (_iconHeight * .5);
		//	trace("_btnWidth= "+ _btnWidth + " _iconWidth= "+ _iconWidth);
		//	trace("_btnHeight= "+ _btnHeight + "_iconHeight= "+ _iconHeight);
			//_addLabel();
			
			_pulseTL = new TimelineMax({paused:true,repeat:-1});
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
			
			_addLabel();
			_currentState = 'ready';
		}
		
		/**
		 * Initialize listeners for mouse events
		 * 
		 * @return	void
		 */
		private function _initListeners():void
		{
			this.addEventListener( MouseEvent.MOUSE_OVER, _onMouseOver, false, 0, true );
			//	this.addEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown, false, 0, true );
			//this.addEventListener( MouseEvent.MOUSE_UP, _onMouseOver, false, 0, true );
			//	this.addEventListener( MouseEvent.CLICK, _onMouseClick, false, 0, true );
			this.addEventListener( MouseEvent.MOUSE_OUT, _onMouseOut, false, 0, true );
			
		}
	
		private function _addLabel():void
		{
			_tlf_buttonlabel = new TLFTextField();
			_tlf_buttonlabel.embedFonts = true;
			_tlf_buttonlabel.antiAliasType =  AntiAliasType.ADVANCED;
			//addChild(myTLFTextField); 
			_tlf_buttonlabel.width = _btnWidth;// + 20;
			_tlf_buttonlabel.multiline = true;
			_tlf_buttonlabel.wordWrap = true;
			
			_tlf_buttonlabel.height = _btnHeight - _iconHeight;
			_tlf_buttonlabel.verticalAlign = VerticalAlign.MIDDLE;
			_tlf_buttonlabel.selectable = false;
		//	_tlf_buttonlabel.border = true;
		//	_tlf_buttonlabel.background = true;
		//	_tlf_buttonlabel.backgroundColor = tbackColor;//0x15A5C9;
			_tlf_buttonlabel.htmlText = _btnLabelTxt;
			
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			
			format.fontSize = _fontSize;//_uiParams.uiFontSize;
			format.color = _fontColorCode;//0x66666;// _uiParams.uiFontColorCode;
			
			
			//format.textAlign = _uiParams.uiFontHAlignCONST;
			format.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			
		
			format.textAlign = TextAlign.CENTER;
			format.verticalAlign = VerticalAlign.MIDDLE;
			format.lineHeight = "90%";
			
			var myTextFlow:TextFlow = _tlf_buttonlabel.textFlow;
			myTextFlow.invalidateAllFormats();
			
			myTextFlow.hostFormat = format;
		//	myTextFlow.paddingLeft = 10;//20;
			//myTextFlow.paddingRight = 10;//20;
			//myTextFlow.paddingTop = _padding;//10;
			//	myTextFlow.paddingBottom =_padding;// 10;
			//	myTextFlow.direction = Direction.RTL;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			
			
			trace("_iconHeight = "+ _iconHeight);
			_tlf_buttonlabel.y = _btnIcon.height;// * .5;
			_tlf_buttonlabel.x = 0;//((_iconWidth * .5)* -1);
			this.addChild(_tlf_buttonlabel);
			
		}
	
		
		public function set currentState(pv:String):void
		{
			if (_currentState != pv) {
				_currentState = pv;
				_changeState(_currentState);
			}
			
		}
		public function get currentState():String
		{
			var pv:String = _currentState;// = pv;
			return pv;
		}
		
		/*
		private function _createFilters():void
		{
			_filterGlow_blue = new GlowFilter(0x66CCFF,.7,15,15,4,BitmapFilterQuality.MEDIUM);
			_filterGlow = [_filterGlow_blue];
			_color = new AdjustColor();
			_color.brightness = 0;
			_color.contrast= 20;
			_color.hue = 0;
			_color.saturation = -100;
			
			_matrix = _color.CalculateFinalFlatArray();
			_colorMatrix = new ColorMatrixFilter(_matrix);
			_filterBW = [_colorMatrix];
			
		}
		*/
		/*
		private function _createBWFilters():Array
		{
		
			var adjcolor:AdjustColor; = new AdjustColor();
			adjcolor.brightness = 0;
			adjcolor.contrast= 20;
			adjcolor.hue = 0;
			adjcolor.saturation = -100;
			private var clrMatrixFilter:ColorMatrixFilter;
		
			var finalclr:Array = adjcolor.CalculateFinalFlatArray();
			var finalcolorMatrix:ColorMatrixFilter = new ColorMatrixFilter(finalclr);
			
			var filterarray = [finalcolorMatrix];
			
			return filterarray;
			
		}
		*/
		private function _changeState(cs:String):void
		{
			switch (cs) {
				case 'grey':
					trace('should be grey');
				
					TweenMax.to(_btnIcon, .3, {alpha:.7,colorMatrixFilter:{saturation:0}});
				//	_btnIcon.filters = _createBWFilters();
					break;
				case 'glow':
					_pulseTL.play();
					//_btnIcon.filters = _filterGlow;
					break;
				
				case 'ready':
					_pulseTL.gotoAndStop(0);
					break;
				
				case 'pulse':
					_pulseTL.play();
					break;
				
			}
		}
		
		
		/////////////////////////////////////////////
		//  HANDLERS
		/////////////////////////////////////////////
		/**
		 * Show over state on mouse over
		 * 
		 * @param	p_evt	(MouseEvent) mouse over event
		 * @return	void
		 */
		private function _onMouseOver( p_evt:MouseEvent ):void
		{
			if( _enabled )
			{
				_changeState('glow');
			}
		}
		
		
		/**
		 * Show up state on mouse out
		 * 
		 * @param	p_evt	(MouseEvent) mouse out event
		 * @return	void
		 */
		private function _onMouseOut( p_evt:MouseEvent ):void
		{
			if( _enabled )
			{
				_changeState('ready');
			}
		}

		public function get btnTarget():String
		{
			return _btnTarget;
		}

		public function set btnTarget(value:String):void
		{
			_btnTarget = value;
		}

		public function get btnTracked():Boolean
		{
			return _btnTracked;
		}

		public function set btnTracked(value:Boolean):void
		{
			
			if (value) {
				_changeState('grey');
			}
			_btnTracked = value;
		}


	}
}