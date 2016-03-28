package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.events.WidgetBtnEvent;
	import com.sanbeaman.shell.events.WidgetEvent;
	import com.sanbeaman.shell.ui.BTN_BMPScale9SimpleState;
	import com.sanbeaman.shell.widget.activity.C2R_CheckBox;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class C2R_Button extends MovieClip
	{
		/*
		[Embed (source="/masterShell/widgetui/clickbtn_normal.png")]
		private var _skin_normal:Class
		public var skin_normal:Bitmap = new _skin_normal;
		
		[Embed (source="/masterShell/widgetui/clickbtn_hover.png")]
		private var _skin_hover:Class
		public var skin_hover:Bitmap = new _skin_hover;
		
		
		[Embed (source="/masterShell/widgetui/clickbtn_down.png")]
		private var _skin_down:Class
		public var skin_down:Bitmap = new _skin_down;
		*/
		private var _enabled:Boolean = true;
		
		
		private var _btnID:String;
		private var _btnIndex:int;
		private var _btnFillType:String;
		
		private var _btnLabel:String;
		private var _tformat:TextFormat;
		private var _btnLabelField:TextField;
		
		private var _btnFontSize:int;
		private var _btnFontColor:uint;
		
		private var _btnWidth:Number;
		private var _btnHeight:Number;
		
		private var _hPadding:int;
		private var _vPadding:int;
		
		private var _btnLabelWidth:Number;
		private var _btnLabelHeight:Number;
		
		private var _btn:BTN_BMPScale9SimpleState;
		
		private var _pulseTL:TimelineMax;
		private var _glowTL:TimelineMax;
		private var _pulseON:Boolean;
		private var _pulseColor:String = "dkblue"
		private var _pulseColorCode:uint;// =  0x84D24E;  // CA_COLORS.CLR_GLOWORANGE;
		private var _pulseAlpha:Number = .8;
		private var _pulseX:Number = 10;
		private var _pulseY:Number = 10;
		private var _pulseStrength:Number = 3;
		private var _pulseQuality:uint = 3;
		
		private var _uip:UIparams;
		
		private var _lblSprite:Sprite;
		private var _back:Sprite;
		
		
		private var _checkBox:C2R_CheckBox;
		private var _selected:Boolean;
		
		private var _isTracked:Boolean;
		
		
		private var _xtraIcon:Sprite;
		
	
	
		private var _pointerIcon:Sprite;

		
		
		private var _fontFamily:String;
		private var _localeID:String;
		
		//	private var _txtboxback:StaticImage;
		//	private var _shell_dir:String;
		
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		private var _mediaPath:String;
		
		private var _hasIcon:Boolean = false;
		
		private var _c2rBTNLoaderMax:LoaderMax;
		
		private var _btn_normal:String = "c2r/c2r-btn_normal.png";
		private var _btn_hover:String = "c2r/c2r-btn_hover.png";
		private var _btn_down:String = "c2r/c2r-btn_down.png";
		
		private var _cbox_checked:String = "c2r/c2r-cbox_checked.png";
		private var _cbox_unchecked:String = "c2r/c2r-cbox_unchecked.png";
		
		private var _pointer_icon:String = "c2r/c2r-pointer.png";
		private var _img_icon:String;// = "c2r/c2r-pointer.png";
		
		private var _intialBtnState:Boolean;
		private var _intialTrackedState:Boolean;
		
	
		private var _uiFolder:String;
		
		public function C2R_Button()
		{
			super();
		}

		public function buildButtonStates(lbl:String,uip:UIparams,mediapath:String,uiassetfolder:String,isbtnEnabled:Boolean = false,isbtnTracked:Boolean = false,fontfamily:String = "Arial", langID:String = null,iconpath:String = null):void
		{
			_btnLabel = lbl;
			_back = new Sprite();
			
			
			_uip = new UIparams();
			_uip =  uip;
			
			_btnWidth = _uip.uiWidth;
			_btnHeight = _uip.uiHeight;
			
			//var scale9rect:Rectangle = new Rectangle(4,4,78,20);
			_mediaPath = mediapath;
			
			_uiFolder = uiassetfolder;
			_intialBtnState = isbtnEnabled;
			_intialTrackedState = isbtnTracked;
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			_btn_normal = _mediaPath + _uiFolder + "btn_normal.png";//"c2r/c2r-btn_normal.png";
			_btn_hover = _mediaPath + _uiFolder + "btn_hover.png";//"c2r/c2r-btn_hover.png";
			_btn_down = _mediaPath + _uiFolder + "btn_down.png";//"c2r/c2r-btn_down.png";
			
			_cbox_checked = _mediaPath + _uiFolder + "cbox_checked.png";// "c2r/c2r-cbox_checked.png";
			_cbox_unchecked  = _mediaPath + _uiFolder + "cbox_unchecked.png";//  "c2r/c2r-cbox_unchecked.png";
			
			 _pointer_icon =_mediaPath + _uiFolder + "pointer.png";// "c2r/c2r-pointer.png";
			
			
			_c2rBTNLoaderMax = new LoaderMax({name:"c2rLM", onComplete:_c2rloader_completeHandler, onError:_c2rloader_errorHandler});
			_c2rBTNLoaderMax.append( new ImageLoader(_btn_normal, {name:"btnnormal", estimatedBytes:2400}) );
			_c2rBTNLoaderMax.append( new ImageLoader(_btn_hover, {name:"btnhover", estimatedBytes:2400}) );
			_c2rBTNLoaderMax.append( new ImageLoader(_btn_down, {name:"btndown", estimatedBytes:2400}) );
			_c2rBTNLoaderMax.append( new ImageLoader(_cbox_unchecked, {name:"cboxunchecked", estimatedBytes:2400}) );
			_c2rBTNLoaderMax.append( new ImageLoader(_cbox_checked, {name:"cboxchecked", estimatedBytes:2400}) );
			
			
			
			if (iconpath != null) {
				_hasIcon = true;
				_img_icon =  _mediaPath + iconpath;
				//img_pointerpath = _mediaPath + pointerpath;
				
				_c2rBTNLoaderMax.append( new ImageLoader(_img_icon, {name:"btniconimg", estimatedBytes:2400}) );
				_c2rBTNLoaderMax.append( new ImageLoader(_pointer_icon, {name:"btnpointerimg", estimatedBytes:2400}) );
				
			}
			
			_c2rBTNLoaderMax.load();
		}
		
		private function _c2rloader_completeHandler(le:LoaderEvent):void {
			
		
			var scale9rect:Rectangle = new Rectangle(4,4,78,20);
			
			var skin_normal:Bitmap = _c2rBTNLoaderMax.getLoader("btnnormal").rawContent;
			var skin_hover:Bitmap = _c2rBTNLoaderMax.getLoader("btnhover").rawContent;// as Bitmap;
			var skin_down:Bitmap = _c2rBTNLoaderMax.getLoader("btndown").rawContent;// as Bitmap;
			/*
			var skin_normal:Bitmap = _c2rBTNLoaderMax.getContent("btnnormal") as Bitmap;
			var skin_hover:Bitmap = _c2rBTNLoaderMax.getContent("btnhiver") as Bitmap;
			var skin_down:Bitmap = _c2rBTNLoaderMax.getContent("btndown") as Bitmap;
			*/
			_btn =  new BTN_BMPScale9SimpleState();
		
			
			_btn.buildBtn(scale9rect,skin_normal.bitmapData,skin_hover.bitmapData,skin_down.bitmapData);
			_btn.width = _btnWidth;
			_btn.height = _btnHeight;
			
			_back.addChild(_btn);
			
			if (_hasIcon) {
				_pointerIcon = _c2rBTNLoaderMax.getContent("btnpointerimg") as Sprite;
				var imgicon:Sprite = _c2rBTNLoaderMax.getContent("btniconimg") as Sprite;
				imgicon.x = 12;
				imgicon.y = 10;
				
				
				_pointerIcon.addChild(imgicon);
				_pointerIcon.y = int( _pointerIcon.height) * -1;
				_pointerIcon.x = int(_btnWidth * .5) - int(_pointerIcon.width * .5);
				_back.addChild(_pointerIcon);
				
			}
			var chkbx0:Bitmap = _c2rBTNLoaderMax.getLoader("cboxunchecked").rawContent;// as Bitmap;
			var chkbx1:Bitmap = _c2rBTNLoaderMax.getLoader("cboxchecked").rawContent;// as Bitmap;
		//	_checkBox = new C2R_CheckBox();
			_checkBox = new C2R_CheckBox();
			_checkBox.init(chkbx0,chkbx1);
			_checkBox.x = 4;
			_checkBox.y = 5;
			
			_btn.addChild(_checkBox);
			var chkboxArea:Number = _checkBox.x + _checkBox.width;
			var twidth:Number = int(_btnWidth - chkboxArea);//_checkBox.width + 8);
			var theight:Number = _btnHeight;
			
			var lblbox:Sprite = _addLabelSprite(_btnLabel,twidth,theight);
			lblbox.x = chkboxArea;
			_btn.addChild(lblbox);
			this.addChild(_back);
			_buildPulseState();
			this.addEventListener(MouseEvent.CLICK,_btnclickhandler);
			if(_intialBtnState == true || _intialTrackedState ==true ){
				this.enabled = true;
			} else {
				this.enabled = false;
			}
			
			this.isTracked = _intialTrackedState;

			
		}
		private function _addLabelSprite(btnLabel:String,tw:Number,th:Number = 0):Sprite
		{
			_btnLabel = btnLabel;
			
			var spr:Sprite = new Sprite();
			
			var tlf:TLFTextField = new TLFTextField();
		//	tlf.border = true;
			//tlf.borderColor = 0xffffff;
			tlf.embedFonts = true;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			tlf.width = tw;// _uip.uiWidth - 20;
			if (th > 0) {
				tlf.height = th; //34
			}
		
			//	tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.wordWrap = true;
			tlf.multiline = true;
			tlf.verticalAlign = VerticalAlign.MIDDLE;
			tlf.selectable = false;
			tlf.htmlText = _btnLabel;
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			format.fontSize = _uip.uiFontSize;// 14;
			format.color = _uip.uiFontColorCode;// 0x000000;
			format.lineHeight = "90%";
			/*
			format.paddingTop = 4;
			format.paddingBottom = 4;
			*/
			format.textAlign = _uip.uiFontHAlignCONST;//TextAlign.CENTER;
			format.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;
			
			
			var myTextFlow:TextFlow = tlf.textFlow;
			
			myTextFlow.invalidateAllFormats();
			myTextFlow.direction = _txtDirection;
			
			myTextFlow.hostFormat = format;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;
			
			
			//myTextFlow.paddingLeft = 10;
			myTextFlow.paddingRight = 4;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			
			
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
			
			//tlf.x = 0;
			tlf.y = 1;
			spr.addChild(tlf);
			
			
			return spr;
		}
		private function _c2rloader_errorHandler(le:LoaderEvent):void {
			trace("error occured with " + le.target + ": " + le.text);
		}
		
		/*
			_uip = new UIparams();
			_uip =  uip;
			var scale9rect:Rectangle = new Rectangle(4,4,78,20);
			_btn =  new BTN_BMPScale9SimpleState();
			_btn.buildBtn(scale9rect,skin_normal.bitmapData,skin_hover.bitmapData,skin_down.bitmapData);
			_btn.addEventListener(WidgetBtnEvent.WIDGETBTN_CLICK,_btnclickhandler);
			
			_back = new Sprite();
			
			
			_lblSprite = _addLabelSprite(btnLabel);
			_lblSprite.mouseChildren = false;
			_lblSprite.mouseEnabled = false;
			this.addChild(_back);
			
			
			
			var btnWidth:Number = _uip.uiWidth;//int(_lblSprite.width);
			var btnHeight:Number = _uip.uiHeight;
			_btn.height =  btnHeight;//_uip.uiWidth;
			_btn.width =  btnWidth;//_uip.uiWidth;
			_back.addChild(_btn);
			
			
			
			if (addIcon != null){
				
				var xicon:C2R_Icon =  new C2R_Icon();
				xicon.addIcon(addIcon);
				xicon.x =  int(this.width * .5) - int(xicon.width * .5); 
				xicon.y = xicon.height * -1;
				this.addChild(xicon);
			}
			_checkBox = new C2R_CheckBox();
			_checkBox.x = 4;
			_checkBox.y = 5;
			
			_back.addChild(_checkBox);
			_lblSprite.x = 18;
			
			_back.addChild(_lblSprite);
			_buildPulseState();
			//this.enabled = true;
			
		}
		
		*/
		
		
		
	
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
			
			
			_enabled = p_value;
			
			if( !_enabled )
			{
				//this.alpha = .5;
				/*
				if (_pulseON) {
				_pulseON = false;
				}
				*/
				_btn.btnenabled = false;
				this.mouseEnabled = false;
				this.useHandCursor = false;
			}
			else
			{
				//this.alpha = 1;
				//this.alpha = 1;
				_btn.btnenabled = true;
				this.mouseEnabled = true;
				this.useHandCursor = true;
			}
			
			super.enabled = p_value;
			
		}
		
		public function get pulseON():Boolean
		{
			return _pulseON;
		}
		
		public function set pulseON(value:Boolean):void
		{
			if (value) {
				_pulseTL.play();
			} else  {
				_pulseTL.gotoAndStop(0);
				
			}
			_pulseON = value;
		}
		
		
		private function _buildPulseState():void
		{
			
			_pulseColorCode = SHELL_COLORS.lookUpColor(_pulseColor);
			
			_pulseTL = new TimelineMax({paused:true,repeat:-1});
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
			
		}
		
		
		public function glowBtn():void
		{
			_pulseColorCode = SHELL_COLORS.lookUpColor(_pulseColor);
			
			_glowTL = new TimelineMax();
			_glowTL.append(new TweenMax(this,3,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_glowTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
			
		}
		public function activateBtn(withPulse:Boolean=true):void
		{
			if (!_enabled) {
				this.enabled = true;
				_btn.btnenabled = true;
				this.pulseON = withPulse;
			}
		}
		private function _btnclickhandler(me:MouseEvent):void
		{
			trace("_btnwas clicked=" + _btnIndex);
			var we:WidgetEvent = new WidgetEvent(WidgetEvent.C2R_EVENT,"btnclicked",_btnIndex,_btnID);
			this.dispatchEvent(we);
		}
		public function get selected():Boolean
			
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
			
		{
			
			if(value) {
				_btn.selected = true;
				if (_pulseON){
					_pulseON = false;
				}
			} else {
				_btn.selected = false;
			}
			_selected = value;
		}
		
		public function get isTracked():Boolean
			
		{
			return _isTracked;
		}
		
		public function set isTracked(value:Boolean):void
			
		{
			if(value) {
				_checkBox.tracked = true;
			}
			_isTracked = value;
		}
		
		public function get btnIndex():int
			
		{
			return _btnIndex;
		}
		
		public function set btnIndex(value:int):void
			
		{
			_btnIndex = value;
		}
		
		public function get btnID():String
		{
			return _btnID;
		}
		
		public function set btnID(value:String):void
		{
			_btnID = value;
		}
		
	}
}