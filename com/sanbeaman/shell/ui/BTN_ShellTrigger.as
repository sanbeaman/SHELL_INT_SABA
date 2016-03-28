package com.sanbeaman.ui
{
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.sanbeaman.widgets.ui.BitmapData_MainShell;
	import com.sanbeaman.widgets.ui.BitmapData_TriggerShell;
	import com.sanbeaman.widgets.ui.Icon_Pulse;
	
	import flash.display.*;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.geom.*;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import lt.uza.ui.Scale9SimpleStateButton;
	
	public class BTN_ShellTrigger extends MovieClip
	{
		
		//private var _btnFillType:String;
		
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
		
		private var _btn:Scale9SimpleStateButton;
		
		private var _pulseTL:TimelineMax;
		
		private var _pulseON:Boolean;
		private var _pulseColor:uint = CA_COLORS.CLR_GLOWORANGE;
		private var _pulseAlpha:Number = .8;
		private var _pulseX:Number = 10;
		private var _pulseY:Number = 10;
		private var _pulseStrength:Number = 3;
		private var _pulseQuality:uint = 3;
		
		
		
		private var _hasPulseIcon:Boolean;
		
		private var _pulseIcon:Icon_Pulse;
		
		
		private var _startX:Number;
		private var _startY:Number;
		private var _isTriggerActive:Boolean;
		private var _triggerType:String;
		
		
		private var _minHeight:Number;
		public function BTN_ShellTrigger()
		{
			super();
			_pulseON = false;
		}
		
		public function get triggerType():String
		{
			return _triggerType;
		}

		public function get startY():Number
		{
			return _startY;
		}

		public function set startY(value:Number):void
		{
			_startY = value;
		}

		public function get startX():Number
		{
			return _startX;
		}

		public function set startX(value:Number):void
		{
			_startX = value;
		}

		public function get isTriggerActive():Boolean
		{
			return _isTriggerActive;
		}

		public function set isTriggerActive(value:Boolean):void
		{
			_isTriggerActive = value;
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
		
		public function buildbtn(triggerType:String, btnLabel:String, btnFontSize:int,btnFontColor:uint,hPad:int=10,vPad:int=4,minHeight:Number = 32,hasIcon:Boolean = false):void
		{
			
			_minHeight = minHeight;
			_hasPulseIcon = hasIcon;
			
			_triggerType = triggerType.toLowerCase();
			
			_btnLabel = btnLabel.toUpperCase();
			
			_btnFontSize = btnFontSize;
			_btnFontColor = btnFontColor;
			
			_hPadding = hPad;
			_vPadding = vPad;
			
			_btnLabelField = new TextField();
			_btnLabelField.mouseEnabled = false;
			_btnLabelField.selectable = false;
			_btnLabelField.embedFonts = true;
			//_btnLabelField.border = true;
			//_btnLabelField.height = _btnHeight;
			//_btnLabelField.border = true;
			_btnLabelField.antiAliasType = AntiAliasType.ADVANCED;
			_btnLabelField.autoSize = TextFieldAutoSize.LEFT;
			_btnLabelField.gridFitType = flash.text.GridFitType.PIXEL;
			//_btnLabelField.
			
			_btnLabelField.text = _btnLabel;
			_btnLabelField.setTextFormat(_createTextFormat());
			
			
			_btnLabelWidth = int( _btnLabelField.width);// + 20;
			_btnLabelHeight = int(_btnLabelField.height);// + 12;
			
			trace("_btnLabelWidth=  " +_btnLabelWidth + " _btnLabelHeight= " + _btnLabelHeight);
			
			_btnWidth = _btnLabelWidth + (2 * _hPadding);
			_btnHeight = _btnLabelHeight + (2 *_vPadding);
			
			if (_btnHeight < _minHeight ) {
				_btnHeight = _minHeight;
			}
			
			_btn = _bitMapButton(_btnLabelWidth,_btnLabelHeight,_hPadding,_vPadding);
		
			
			
			trace("_btnWidth=  " +_btnWidth + " _btnHeight= " + _btnHeight);
			
			//	_btnLabelField.x = 10;
			//	_btnLabelField.y = 0;
			
			/*
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [CA_COLORS.CLR_FILL01, CA_COLORS.CLR_FILL02];
			var alphas:Array = [1, 1];
			var ratios:Array = [0, 255];
			
			this.graphics.lineStyle(1,CA_COLORS.CLR_FRAME01,1,true,LineScaleMode.NONE,CapsStyle.ROUND,JointStyle.ROUND);
			var gradRotation:Number = new Number(0);
			trace("_btnFillType= "+ _btnFillType);
			if (_btnFillType == "VERTICALGRAD") {
			gradRotation = (Math.PI / 180) * 90;  // This turns it 90 degrees clockwise
			}
			
			trace("gradRotation = "+ gradRotation);
			var matr:Matrix = new Matrix();
			var halfHeight:int = _btnHeight/2;
			matr.createGradientBox(_btnWidth,halfHeight,gradRotation,0,0);
			//matr.createGradientBox(20, 20, 0, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			var interop:String = InterpolationMethod.LINEAR_RGB;
			this.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interop,0);//,"rgb",gradRotation);
			
			this.graphics.drawRoundRect(0,0,_btnWidth,_btnHeight,6);
			//this.graphics.drawRect(0,0,btnWidth,btnHeight);
			*/
			var btnX:Number = (_btnWidth - _btnLabelWidth) * .5;
			var btnY:Number = (_btnHeight - _btnLabelHeight) * .5;
			trace ("btnX , btnY == " + btnX + " , " + btnY);
			_btnLabelField.x = int(btnX);
			
			_btnLabelField.y = btnY;//int(_vPadding * .75);// 0;//_vPadding;// - int(_vPadding * .5);
			
			if (_hasPulseIcon) {
				_btn.width = _btnWidth + 75;
			} else {
				_btn.width = _btnWidth;
			}
		
			_btn.height = _btnHeight;
			
			
			this.addChild(_btn);
			
			
			if (_hasPulseIcon) {
				_pulseIcon = new Icon_Pulse();
				_pulseIcon.mouseChildren = false;
				_pulseIcon.mouseEnabled = false;
			//	_pulseIcon.
				_pulseIcon.buildIcon("icon_phone.png");
				//var extraWidth:Number = 
				_pulseIcon.x = _btnLabelField.x +_btnLabelField.width + (34 );// - 46;
				_pulseIcon.y = 18;
				this.addChild(_pulseIcon);
			}
			this.addChild(_btnLabelField);
			_buildPulseState();
		}
		private function _buildPulseState():void
		{
			_pulseTL = new TimelineMax({paused:true,repeat:-1});
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColor, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:_pulseStrength},ease:Bounce.easeOut}));
			_pulseTL.append(new TweenMax(this,1,{glowFilter:{color:_pulseColor, alpha:_pulseAlpha,blurX:_pulseX,blurY:_pulseY,quality:_pulseQuality,strength:0}}));
			
			if (_hasPulseIcon) {
				var phoneTL:TimelineMax = new TimelineMax({repeat:4});
				phoneTL.append(new TweenMax(_pulseIcon, .1, {rotation:"-10"}));
				phoneTL.append(new TweenMax(_pulseIcon, .1, {rotation:"+20"}));
				phoneTL.append(new TweenMax(_pulseIcon, .1, {rotation:"-20"}));
				phoneTL.append(new TweenMax(_pulseIcon, .1, {rotation:"+20"}));
				phoneTL.append(new TweenMax(_pulseIcon, .1, {rotation:"-10"}));
		
				_pulseTL.insert(phoneTL,0);

			}
			
			
			
			//var pulseUP:Twee = new TweenMax(this,1, {glowFilter:{color:0x91e600, alpha:1, blurX:15, blurY:15},repeat:-1,paused:true});
			
			//	TweenMax.to(mc, 1, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30}});
			//some time later (maybe in by a ROLL_OUT event handler for a button), reverse the tween, causing it to go backwards to its beginning from wherever it is now.
			//	myTween.reverse();
			
			//pause the tween
			//	myTween.pause();
			
			//restart the tween
			//	myTween.restart();
			
			//make the tween jump to its halfway point
			//	myTween.currentProgress = 0.5;
			
			
			//	TweenMax.to(mc, 1, {glowFilter:{color:0x91e600, alpha:1, blurX:30, blurY:30}});
		//	this.pulseON = true;
		}
		private function _bitMapButton(blw:Number,blh:Number,hpad:int,vpad:int):Scale9SimpleStateButton
		{
			
			
			/*
			function onComplete (event:Event):void
			{
			bitmapData = Bitmap(LoaderInfo(event.target).content).bitmapData;
			}
			*/
			/*
			* Create a new rectangle defining Scale9 area of your bitmap
			*/
			var scale9rect:Rectangle; 
			
			
			var simpleScale9Btn:Scale9SimpleStateButton;
			
			//	var scale9_example:Rectangle = new Rectangle(hpad,vpad,blw,blh);
			if (_triggerType == 'done') {
				scale9rect = new Rectangle(15,6,20,20);
				var bmmain:BitmapData_MainShell = new BitmapData_MainShell();
				
				simpleScale9Btn = new Scale9SimpleStateButton(
					scale9rect,
					bmmain.getBitmapDataFor("up"),
					bmmain.getBitmapDataFor("over"),
					bmmain.getBitmapDataFor("down")
					);
			} else {
				scale9rect = new Rectangle(16,8,24,24);
				var bmtrigger:BitmapData_TriggerShell = new BitmapData_TriggerShell();
				
				simpleScale9Btn = new Scale9SimpleStateButton(
					scale9rect,
					bmtrigger.getBitmapDataFor("up"),
					bmtrigger.getBitmapDataFor("over"),
					bmtrigger.getBitmapDataFor("down")
				);
			}
		
			
			/*
			* Initialize the button with all 3 states (normal, hover, down) using 3 different bitmaps;
			*/
			/*
			var button_example_a:Scale9SimpleStateButton = new Scale9SimpleStateButton(
				scale9_example,
				button_skin_normal.bitmapData, 
				button_skin_hover.bitmapData, 
				button_skin_down.bitmapData
			);
			*/
			return simpleScale9Btn;
		}
		
		
		
		private function _createTextFormat():TextFormat
		{
			
			Font.registerFont(AgencyFBBold);
			var tfmt:TextFormat = new TextFormat();
			tfmt.font = "AgencyFB-Bold";
			tfmt.size = _btnFontSize;
			tfmt.bold = true;
			//tfmt.leftMargin = 4;
			//tfmt.rightMargin = 4;
			tfmt.letterSpacing = 1;
			tfmt.align =  TextFormatAlign.LEFT;
			//_disTFormat.bold = true;
			tfmt.color = _btnFontColor;
			
			return tfmt;
			
		}
		
		
		
	}
}