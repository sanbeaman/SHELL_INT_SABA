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
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
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
	
	
	public class MapIcon extends BodyUI
	{
		/*
		[Embed (source="/masterShell/widgetui/clickbtn_normal.png")]
		private var _skin_normal:Class
		public var skin_normal:Bitmap = new _skin_normal;
		*/
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
		
		
		private var _txtbox:Sprite;
		
		private var _btnLabelWidth:Number;
		private var _btnLabelHeight:Number;
		
		//	private var _btn:BTN_BMPScale9SimpleState;
		
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
		private var _btn:Sprite;
		private var _pointerIcon:Sprite;
		private var _xtraIcon:Sprite;
		
		
		private var _fontFamily:String;
		private var _localeID:String;
		
	//	private var _txtboxback:StaticImage;
	//	private var _shell_dir:String;
		
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		private var _mediaPath:String;
		
		private var _hasIcon:Boolean = false;
		
		private var _iconLoaderMax:LoaderMax;
		
		//private var _normalbtnpath:String = "c2r/c2r_button.png";
		public function MapIcon()
		{
			super();
		}
		
		public function build(lbl:String,uip:UIparams,mediapath:String, btnpath:String, fontfamily:String = "Arial",langID:String = null,iconpath:String = null,pointerpath:String = null):void
		{
			
			_btnLabel = lbl;
			_back = new Sprite();
			
			_uip = new UIparams();
			_uip =  uip;
			//var scale9rect:Rectangle = new Rectangle(4,4,78,20);
			_mediaPath = mediapath;
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			var btnpath:String = _mediaPath + btnpath;
			
			_iconLoaderMax = new LoaderMax({name:"iconLM", onComplete:_img_completeHandler, onError:_img_errorHandler});
			_iconLoaderMax.append( new ImageLoader(btnpath, {name:"btnimg", width:_uip.uiWidth,height:_uip.uiHeight, estimatedBytes:2400}) );
			
			var img_iconpath:String;
			var img_pointerpath:String;// = _mediaPath + pointerpath;
			if (iconpath != null) {
				_hasIcon = true;
				img_iconpath =  _mediaPath + iconpath;
				img_pointerpath = _mediaPath + pointerpath;
				
				_iconLoaderMax.append( new ImageLoader(img_iconpath, {name:"iconimg", estimatedBytes:2400}) );
				_iconLoaderMax.append( new ImageLoader(img_pointerpath, {name:"pointerimg", estimatedBytes:2400}) );
				
			}
			
			//start loading
			_iconLoaderMax.load();
			
			
			
		}
		
		
		
		private function _img_completeHandler(le:LoaderEvent):void {
			
			_btn = new Sprite();
			_btn.addChild(_iconLoaderMax.getContent("btnimg"));
			var lblbox:Sprite = _addLabelSprite(_btnLabel);
			_btn.addChild(lblbox);
			_back.addChild(_btn);
			
			if (_hasIcon) {
				_pointerIcon = _iconLoaderMax.getContent("pointerimg") as Sprite;
				var imgicon:Sprite = _iconLoaderMax.getContent("iconimg") as Sprite;
				imgicon.x = 12;
				imgicon.y = 10;
				
				
				_pointerIcon.addChild(imgicon);
				_pointerIcon.y = int( _pointerIcon.height) * -1;
				_pointerIcon.x = (_uip.uiWidth - _pointerIcon.width) *.5;
				_back.addChild(_pointerIcon);
				
			}
			this.addChild(_back);
			_buildPulseState();
			

		}
		
		private function _img_errorHandler(le:LoaderEvent):void {
			trace("error occured with " + le.target + ": " + le.text);
		}
		
		/*
			_lblSprite = _addLabelSprite(lbl);
			
			this.addChild(_back);
			
			_back.addChild(_txtboxback);
			
			
			
			if (addIcon != null){
				
				var xicon:C2R_Icon =  new C2R_Icon();
				xicon.addIcon(addIcon);
				xicon.x =  int(this.width * .5) - int(xicon.width * .5); 
				xicon.y = xicon.height * -1;
				this.addChild(xicon);
			}
			
			
			
			//_lblSprite.x = 18;
			
			_back.addChild(_lblSprite);
			_buildPulseState();
			//this.enabled = true;
			
		}
		
		*/
		private function _addLabelSprite(btnLabel:String):Sprite
		{
			_btnLabel = btnLabel;
			
			var spr:Sprite = new Sprite();
			
			var tlf:TLFTextField = new TLFTextField();
			//tlf.border = true;
			tlf.embedFonts = true;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			tlf.width = _uip.uiWidth;// - 20;
			tlf.height = _uip.uiHeight; //34
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
			format.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;
			
			
			var myTextFlow:TextFlow = tlf.textFlow;
			
			myTextFlow.invalidateAllFormats();
			myTextFlow.direction = _txtDirection;
			myTextFlow.hostFormat = format;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;
			
			
			//myTextFlow.paddingLeft = 10;
			//myTextFlow.paddingRight = 10;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			
			
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
			
			//tlf.x = 0;
			tlf.y = 0;
			spr.addChild(tlf);
			
			
			return spr;
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
		
		
		public function glowIt(dur:Number = 1, reps:Number = 0):void
		{
			_pulseColorCode = SHELL_COLORS.lookUpColor(_pulseColor);
			
			_glowTL = new TimelineMax({yoyo:true,repeat:reps});
			_glowTL.append(new TweenMax(this,dur,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_glowTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColorCode, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
			
		}
		
	}
}