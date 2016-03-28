package com.sanbeaman.shell.ui
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.sanbeaman.shell.ui.BTN_BMPSimpleState;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
//	import lt.uza.ui.Scale9SimpleStateButton;
	
	
	public class BTN_ShellMain extends MovieClip
	{
		
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
		
		private var _btn:BTN_BMPSimpleState;
		private var _btn_back:Bitmap;
		private var _pulseTL:TimelineMax;
		
		private var _pulseON:Boolean;
		private var _pulseColor:uint = 0x84D24E;  // CA_COLORS.CLR_GLOWORANGE;
		private var _pulseAlpha:Number = .8;
	
		private var _pulseX:Number = 3;//10;
		private var _pulseY:Number = 3;//10;
		private var _pulseStrength:Number = 2;
		private var _pulseQuality:uint = 3
		
		
		
		public function BTN_ShellMain()
		{
			super();
			//trace('BTN_SHELLMAIN');
			
		}
		
		public function buildButtonStates(btnLabel:String,skin_back:BitmapData,skin_normal:BitmapData,
			skin_hover:BitmapData,
			skin_down:BitmapData,scale9rect:Rectangle = null, pulsecolor:String = 'orange'
		):void
		{
			_btn_back = new Bitmap(skin_back);
			//_btn_back.visible = false;
			_btn_back.alpha = 0;
			this.addChild(_btn_back);
			_btn = new BTN_BMPSimpleState(btnLabel,skin_normal,skin_hover,skin_down,scale9rect);
			_pulseColor = SHELL_COLORS.lookUpColor(pulsecolor);
			
			//_btn = _bitMapButton();
			
			this.addChild(_btn);
			_buildPulseState();
			//	this.addChild(button_skin_normal);
			
			
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
				this.visible = false;
				_btn.btnenabled = false;
				
			}
			else
			{
				this.visible = true;
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
			//	_pulseTL.restart();
				_pulseTL.pause(0);
			}
			_pulseON = value;
		}
		private function _buildPulseState():void
		{
			_pulseTL = new TimelineMax({paused:true,repeat:-1});
			var backTL:TimelineMax = new TimelineMax();
			backTL.append(TweenMax.to(_btn_back, .3, {alpha:.8}));
			backTL.append(TweenMax.to(_btn_back, .3, {alpha:0}));
			
			var glowTL:TimelineMax = new TimelineMax();
			glowTL.append(new TweenMax(this,.3,{glowFilter:{color:_pulseColor, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			glowTL.append(new TweenMax(this,.3,{glowFilter:{color:_pulseColor, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
			
			_pulseTL.insert(backTL,0);
			_pulseTL.insert(glowTL,0);
		}
		/*
	
		private function _buildPulseState():void
		{
			_pulseTL = new TimelineMax({paused:true,repeat:-1});
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColor, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColor, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
	
		}
		*/

	}
}