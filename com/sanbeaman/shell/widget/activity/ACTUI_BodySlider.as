package com.sanbeaman.shell.widget.activity
{
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class ACTUI_BodySlider extends BodyUI
	{
		
		private var _minimum:Number = 0;
		private var _maximum:Number = 10;
		private var _value:Number = 0;
		private var _tickInterval:Number = 0;   
		private var _snapInterval:Number = 0;
		//private var tickContainer:Sprite;
		private var _thumb:ACTUI_ThumbSlider;
		
		private var _trackOver:Sprite;
		private var _track:Sprite;
		
		private var _trackWidth:Number;
		private var _trackHeight:Number;
		private var _snapIncrement:int;
		private var _snapOffSet:int;
		
		private var _scrubRect:Rectangle;
		private var _scrubbing:Boolean;
		
		private var _timerSlider:Timer;
		
		private var _thumbY:Number;
		
		private var _sliderHeight:Number = 32;
		
		private var _ticks:Sprite;
		
		
		private var _tickGraphic:Sprite;
		
		private var _bigTickLast:Boolean = true;
		
		
		private var _printView:Boolean = false;
		
		public function ACTUI_BodySlider()
		{
			super();
			//_init();
		}
		
		public  function init(trackBack:Sprite,trackOver:Sprite,thumbHandle:ACTUI_ThumbSlider, trackWidth:Number = 270,trackHeight:Number=10, snapIncrement:int = 30):void
		{
			_track = trackBack;
			_trackOver = trackOver;
			_thumb = new ACTUI_ThumbSlider();
			_thumb = thumbHandle;
			_trackWidth = trackWidth;
			_trackHeight = trackHeight;
			_snapIncrement = snapIncrement;
			
			var _trackY:Number = (_track.height * -.5);
			_track.y = _trackY;
			_trackOver.y = _trackY;
			_snapOffSet = (_thumb.width * .5);
			_trackOver.scaleX = 0;
		//	_trackOver.width = _snapOffSet;
			
			_ticks = new Sprite();
			var ix:Number =0;//10;//_snapOffSet;// 0;
			do {
				var tck:Sprite = _buildTick();
				tck.x = ix;
				_ticks.addChild(tck);
				if (ix == 0){
					tck.alpha = 0;
				}
				ix += _snapIncrement;
			} while (ix <= 270);
			_ticks.y = (_sliderHeight * -.5);
			_ticks.alpha = .8;
			_ticks.mouseChildren = false;
			_ticks.mouseEnabled = false;
			this.addChild(_ticks);
			this.addChild(_track);
			
			//	_trackOver.alpha =1;
			this.addChild(_trackOver);
			
			//_thumbY = (_snapOffSet * -1);
			//	_thumb.y = _thumbY;
			_thumb.x = _snapOffSet;
			this.addChild(_thumb);
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, _sbThumb_down);
			_timerSlider = new Timer(10);
			_timerSlider.addEventListener(TimerEvent.TIMER, _timerSCO_update);
			_timerSlider.start();
		}
		
		private function _sbThumb_down(me:MouseEvent):void
		{
			_scrubRect = new Rectangle(_snapOffSet, 0, _trackWidth, 0);
			_scrubbing = true;
			_thumb.startDrag(true, _scrubRect);
			_thumb.addEventListener(MouseEvent.MOUSE_UP, _handleMouseEvents);
			_thumb.addEventListener(MouseEvent.ROLL_OUT, _handleMouseEvents);	
		}
		
		private function _handleMouseEvents(evt:MouseEvent):void
		{
			_thumb.stopDrag();
			_scrubbing = false;
			_thumb.removeEventListener(MouseEvent.MOUSE_UP, _handleMouseEvents);
			_thumb.removeEventListener(MouseEvent.ROLL_OUT, _handleMouseEvents);
			var snapIncrement:Number = _snapIncrement;//snap to the closest 10 pixels
			var snapMod:Number = _thumb.x%snapIncrement;//devide the current position by 10 and take the remainder (% is the modulo operator that proforms the action)
			var newthumbX:Number = ((snapMod >= snapIncrement/2) ? _thumb.x +(snapIncrement - snapMod) : _thumb.x - snapMod);
			var thumbX10:Number = newthumbX;// + _snapOffSet;
			
			if (newthumbX < _snapOffSet ) {
				thumbX10 = _snapOffSet;
				
			} else if (newthumbX >= _trackWidth) {
				thumbX10 =_trackWidth;// + _snapOffSet;// 280;
			} else {
				thumbX10 = newthumbX;// + _snapOffSet;
			}
			_thumb.x = thumbX10;
			trace("adjusted thumb = " + thumbX10);
			_trackOver.scaleX  =  thumbX10 / _trackWidth;;//_thumb.x;
		//	_trackOver.width = thumbX10 ;//+ _snapOffSet; ;
			trace("adjusted thumb round = " + Math.round(thumbX10));
			/**
			 this statement checks to see if the current _x is closer to the next increment or previous increment and moves it accordingly
			 */
			
			
		}
		private function _buildTick():Sprite
		{
			var spr:Sprite = new Sprite();
			var tline:Shape = new Shape();
			
			var lineThick:int;
			var lineHeight:int;
			var lineX:Number;
			var lineY:Number;
			
			if (_bigTickLast){
				lineThick = 1;
				lineHeight = 28;
				lineX = 0;
				lineY = 2;
				_bigTickLast = false;
			} else {
				lineThick = 3;
				lineHeight = _sliderHeight + 6;
				lineX = -1;
				lineY = -6;
				_bigTickLast = true;
			}
			tline.graphics.lineStyle(lineThick,SHELL_COLORS.CLR_TICK,1,true,"none",CapsStyle.NONE);
			tline.graphics.lineTo(0,lineHeight);
			tline.y = lineY;
			tline.x = lineX;//-1;
			spr.addChild(tline);
			
			return spr;
		}
		
		private function _timerSCO_update(te:TimerEvent):void
		{
			//trace("_currentframe = " + _currentframe);
			
			var thumbX:Number = _thumb.x;//+ _snapOffSet;
			if (_scrubbing) {
				_trackOver.scaleX = thumbX / _trackWidth;
				//_trackOver.width = thumbX;// + _snapOffSet;
			} else {
				
			}
		}
		
		public function get printView():Boolean
		{
			return _printView;
		}
		
		public function set printView(value:Boolean):void
		{
			
			if (value){
				_thumb.printViewOff = false;
				//_thumb.thmb.visible = false;
			} else {
				_thumb.printViewOff = true;
				//_thumb.thmb.visible = true;
			}
			_printView = value;
		}
		
		
	}
}
