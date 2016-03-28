package com.sanbeaman.shell.widget
{
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.ui.BTN_BMPScale9SimpleState;
	import com.sanbeaman.shell.ui.BTN_ShellMain;
	import com.sanbeaman.shell.ui.BitmapSprite;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
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
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class BodyButton extends BodyUI
	{
		/*
		//[Embed (source="/masterShell/imgs/mainbtn_normal.gif")]
		[Embed (source="/masterShell/btns/mainbtn1_normal.png")]
		private var _btnback_skin_normal:Class
		public var skin_normal:Bitmap = new _btnback_skin_normal;
		
		
		//[Embed (source="/masterShell/imgs/mainbtn_hover.gif")]
		[Embed (source="/masterShell/btns/mainbtn1_hover.png")]
		private var _btnback_skin_hover:Class
		public var skin_hover:Bitmap = new _btnback_skin_hover;
		
	//	[Embed (source="/masterShell/imgs/mainbtn_down.gif")]
		[Embed (source="/masterShell/btns/mainbtn1_down.png")]
		private var _btnback_skin_down:Class
		public var skin_down:Bitmap = new _btnback_skin_down;
		*/
		
		private var _btn_normal:Bitmap;
		private var _btn_hover:Bitmap;
		private var _btn_down:Bitmap;
		
		
		private var _isEnabled:Boolean = true;
		
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
		
		private var _pulseON:Boolean;
		private var _pulseColorCode:uint;
		private var _pulseColor:String;// = "orange";//= 0x84D24E;  // CA_COLORS.CLR_GLOWORANGE;
		private var _pulseAlpha:Number = .8;
		private var _pulseX:Number = 10;
		private var _pulseY:Number = 10;
		private var _pulseStrength:Number = 3;
		private var _pulseQuality:uint = 3;
		
		private var _uip:UIparams;
		
		private var _lblSprite:Sprite;
		private var _back:Sprite;
		private var _btnType:String;
		
		private var _clickLink:String;
		
		private var _startEnabled:Boolean;
		
		private var _btnQueue:LoaderMax;
		private var _scale9rect:Rectangle;
		
		private var _fontFamily:String;
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		public function BodyButton()
		{
			
			super();
		//	this.id = id;
		//	this.order = order;
		//	this.time = time;
		//	this.type = "bodybutton";
			
		//	trace('bodybutton');
			
		}
		
		public function init(btnLabel:String,uip:UIparams, pulseColor:String = "orange", startEnabled:Boolean = false, fontfamily:String = "Arial", langID:String = null):void
		{
			_startEnabled = startEnabled;
			_btnLabel = btnLabel;
			
			_pulseColorCode = SHELL_COLORS.lookUpColor(pulseColor);
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_uip = new UIparams();
			_uip =  uip;
			_btnWidth = _uip.uiWidth;
			_btnHeight = _uip.uiHeight;
			
			_scale9rect = new Rectangle(14,8,94,20);
			_btn =  new BTN_BMPScale9SimpleState();
			_getButtonStates();
			//_loadButtonStates();
		}
		private function _getButtonStates():void
		{
			
			var bnloader:ImageLoader = LoaderMax.getLoader("BodyButton_normal") as ImageLoader;
			var bhloader:ImageLoader = LoaderMax.getLoader("BodyButton_hover") as ImageLoader;
			var bdloader:ImageLoader = LoaderMax.getLoader("BodyButton_down") as ImageLoader;
			_btn_normal =  bnloader.rawContent as Bitmap;
			_btn_hover =  bhloader.rawContent as Bitmap;
			_btn_down =  bdloader.rawContent as Bitmap;
		//	_btn_normal = LoaderMax.getContent("BodyButton_normal") as Bitmap;
		//	_btn_hover = LoaderMax.getContent("BodyButton_hover") as Bitmap;
		//	_btn_down = LoaderMax.getContent("BodyButton_down") as Bitmap;
			_buildButtonStates();
		}
		
		private function _loadButtonStates():void
		{
			//create an ImageLoader:
			var loadBtnState_normal:ImageLoader = new ImageLoader(SHELL_VARS.FOLDER_SHELL_IMGS+"BodyButton_normal.png", {name:"btn_normal", onComplete:_onImgLoad});
			var loadBtnState_hover:ImageLoader = new ImageLoader(SHELL_VARS.FOLDER_SHELL_IMGS+"BodyButton_hover.png", {name:"btn_hover", onComplete:_onImgLoad});
			var loadBtnState_down:ImageLoader = new ImageLoader(SHELL_VARS.FOLDER_SHELL_IMGS+"BodyButton_down.png", {name:"btn_down", onComplete:_onImgLoad});
			
			
			//Or you could put the ImageLoader into a LoaderMax. Create one first...
			_btnQueue = new LoaderMax({name:"btnQueue", onProgress:_queue_progressHandler, onComplete:_queue_completeHandler, onError:_queue_errorHandler});
			
			//append the ImageLoader and several other loaders
			_btnQueue.append( loadBtnState_normal );
			_btnQueue.append( loadBtnState_hover );
			_btnQueue.append( loadBtnState_down );
			
			//start loading
			_btnQueue.load();
			
			
			
		}
		//when the image loads, fade it in from alpha:0 using TweenLite
		private function _onImgLoad(event:LoaderEvent):void {
			var loaderName:String = event.target.name;
			trace('loaderName===='+loaderName);
			switch (loaderName){
				case 'btn_normal':
					_btn_normal = event.target.rawContent as Bitmap;
					break;
				case 'btn_hover':
					_btn_hover = event.target.rawContent  as Bitmap;;
					break;
				case 'btn_down':
					_btn_down = event.target.rawContent  as Bitmap;;
					break;
				default:
					trace('huh-'+ event.target);
					
			}
		}
		private function  _queue_progressHandler(event:LoaderEvent):void {
			trace("progress: " + _btnQueue.progress);
		}
		
		
		private function _queue_errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		private function _queue_completeHandler(event:LoaderEvent):void {
			trace(event.target + " is complete!");
			_buildButtonStates();
		}
		
		
		private function _buildButtonStates():void
		{
			
		
			
			_btn.buildBtn(_scale9rect,_btn_normal.bitmapData,_btn_hover.bitmapData,_btn_down.bitmapData);
			
			//	_btn.buildBtn(skin_normal,skin_hover,skin_down,scale9rect);
			_back = new Sprite();
			
			_lblSprite = _addLabelSprite(_btnLabel);
			_lblSprite.mouseChildren = false;
			_lblSprite.mouseEnabled = false;
			
			this.addChild(_back);
			
			
			var txtWidth:Number = _lblSprite.width;
			var txtHeight:Number = _lblSprite.height;
			
			trace("txtwodth= " + txtWidth) ;
			_btn.height =  txtHeight;
			_btn.width =  txtWidth;//_uip.uiWidth;
			//	_btnBackSprite.width = txtWidth + 8;// txtWidth + 40;
			//	_btnBackSprite.height =  _uip.uiHeight;//40
			
			
			_back.addChild(_btn);
			_back.addChild(_lblSprite);
			
			//_btn = _bitMapButton();
			
			//this.addChild(_back);
			_buildPulseState();
			this.isEnabled = _startEnabled;// _startEnabled;//false;
			//	this.addChild(button_skin_normal);
			
			/*	_lblSprite = new Sprite();
			_lblSprite.x= 0;
			_lblSprite.y = 0;
			_lblSprite.mouseChildren = false;
			_lblSprite.mouseEnabled = false;
			*/
		}
		private function _addLabelSprite(btnLabel:String):Sprite
		{
			_btnLabel = btnLabel;
		
			var spr:Sprite = new Sprite();
			
			var tlf:TLFTextField = new TLFTextField();
		//	tlf.border = true;
		//	tlf.borderColor = 0x000000;
			tlf.embedFonts = true;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			tlf.width = _uip.uiWidth;
			tlf.height = _uip.uiHeight; //34
		//	tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.wordWrap = false;
			
			tlf.verticalAlign = VerticalAlign.MIDDLE;
			tlf.selectable = false;
			tlf.htmlText = _btnLabel;
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			
			format.fontSize = _uip.uiFontSize;// 14;
			format.color = _uip.uiFontColorCode;// 0x000000;
			
		
			/*
			format.paddingTop = 4;
			format.paddingBottom = 4;
			*/
			format.textAlign = TextAlign.CENTER;
			format.fontFamily = _fontFamily;
			
			
			var myTextFlow:TextFlow = tlf.textFlow;
		
			myTextFlow.invalidateAllFormats();
			myTextFlow.hostFormat = format;
			myTextFlow.paddingLeft = 10;
			myTextFlow.paddingRight = 10;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;
			myTextFlow.flowComposer.updateAllControllers();
			
			
			
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
			
			//tlf.x = 0;
			//tlf.y = 8;
			spr.addChild(tlf);
			
	
			return spr;
		}
		
			
		/**
		 * isEnabled
		 * Is the button enabled for use?
		 * @return	Boolean
		 */
		public function get isEnabled():Boolean
		{
			
			return _isEnabled;
			
		}
		
		public function set isEnabled( p_value:Boolean ):void
		{
			
			
			_isEnabled = p_value;
			
			if( !_isEnabled )
			{
				this.alpha = .2;
				_btn.buttonMode = false;
				_btn.useHandCursor = false;
				_btn.btnenabled = false;
				
			}
			else
			{
				this.alpha = 1;
				//this.alpha = 1;
				_btn.btnenabled = true;
				_btn.buttonMode = true;
				_btn.useHandCursor = true;
			}
			
			//super.enabled = p_value;
			
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
				_pulseTL.restart();
			}
			_pulseON = value;
		}
		public function get btnType():String
			
		{
			return _btnType;
		}
		
		public function set btnType(value:String):void
			
		{
			_btnType = value;
		}
		
		public function get clickLink():String
			
		{
			return _clickLink;
		}
		
		public function set clickLink(value:String):void
			
		{
			_clickLink = value;
		}
		
		private function _buildPulseState():void
		{
			
			//_pulseColorCode = SHELL_COLORS.lookUpColor(_pulseColor);
			
			_pulseTL = new TimelineMax({paused:true,repeat:-1});
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
		
		}

		public function get btnWidth():Number
		{
			return _btnWidth;
		}

		public function set btnWidth(value:Number):void
		{
			_btnWidth = value;
		}

		public function get btnHeight():Number
		{
			return _btnHeight;
		}

		public function set btnHeight(value:Number):void
		{
			_btnHeight = value;
		}

		
	}
}