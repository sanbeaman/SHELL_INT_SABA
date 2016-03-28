package com.sanbeaman.shell.widget.activity
{
	import com.greensock.*;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.ui.*;
	import com.sanbeaman.shell.ui.BTN_BMPScale9SimpleState;
	import com.sanbeaman.shell.ui.BTN_ShellMain;
	import com.sanbeaman.shell.ui.BitmapSprite;
	
	import fl.text.TLFTextField;
	
	import flash.display.*;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class BTN_ACTMain extends MovieClip
	{
		[Embed (source="/masterShell/widget/act/mainbtn_normal.gif")]
		private var _btnback_skin_normal:Class
		public var skin_normal:Bitmap = new _btnback_skin_normal;
		
		[Embed (source="/masterShell/widget/act/mainbtn_hover.gif")]
		private var _btnback_skin_hover:Class
		public var skin_hover:Bitmap = new _btnback_skin_hover;
		
		[Embed (source="/masterShell/widget/act/mainbtn_down.gif")]
		private var _btnback_skin_down:Class
		public var skin_down:Bitmap = new _btnback_skin_down;
		
	
		private var _enabled:Boolean = true;
		
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
		private var _pulseColor:String = "orange"
		private var _pulseColorCode:uint;// =  0x84D24E;  // CA_COLORS.CLR_GLOWORANGE;
		private var _pulseAlpha:Number = .8;
		private var _pulseX:Number = 10;
		private var _pulseY:Number = 10;
		private var _pulseStrength:Number = 3;
		private var _pulseQuality:uint = 3;
		
		private var _uip:UIparams;
		
		private var _lblSprite:Sprite;
		private var _back:Sprite;
		public function BTN_ACTMain()
		{

			super();
			
			
		}
		
		public function buildButtonStates(btnLabel:String,uip:UIparams):void
		{
			
			
			_uip = new UIparams();
			_uip =  uip;
			var scale9rect:Rectangle = new Rectangle(20,10,80,14);
			_btn =  new BTN_BMPScale9SimpleState();
			_btn.buildBtn(scale9rect,skin_normal.bitmapData,skin_hover.bitmapData,skin_down.bitmapData);
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
			_back.addChild(_lblSprite);
			_buildPulseState();
			this.enabled = false;
			
		}

		
		private function _addLabelSprite(btnLabel):Sprite
		{
			_btnLabel = btnLabel;
			
			var spr:Sprite = new Sprite();
			
			var tlf:TLFTextField = new TLFTextField();
			//tlf.border = true;
			tlf.embedFonts = true;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			tlf.width = _uip.uiWidth;
			tlf.height = _uip.uiHeight; //34
		//	tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.wordWrap = false;
			tlf.multiline = false;
			tlf.verticalAlign = VerticalAlign.MIDDLE;
			tlf.selectable = false;
			tlf.htmlText = _btnLabel;
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			format.fontSize = _uip.uiFontSize;// 14;
			format.color = _uip.uiFontColorCode;// 0x000000;
			format.lineHeight = "100%";
			/*
			format.paddingTop = 4;
			format.paddingBottom = 4;
			*/
			format.textAlign = TextAlign.CENTER;
			format.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;
			
			
			var myTextFlow:TextFlow = tlf.textFlow;
			
			myTextFlow.invalidateAllFormats();
			myTextFlow.hostFormat = format;
			myTextFlow.verticalAlign = VerticalAlign.MIDDLE;
			
		
			//myTextFlow.paddingLeft = 10;
			//myTextFlow.paddingRight = 10;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			
			
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
			
			//tlf.x = 0;
			tlf.y = 2;
			spr.addChild(tlf);
			
			
			return spr;
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
			
			
			_enabled = p_value;
			
			if( !_enabled )
			{
				this.alpha = .5;
				
				_btn.btnenabled = false;
				
			}
			else
			{
				this.alpha = 1;
				//this.alpha = 1;
				_btn.btnenabled = true;
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
				_pulseTL.restart();
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
		
	}
}