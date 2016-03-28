package com.sanbeaman.shell.widget.activity
{
	import com.greensock.*;
	import com.greensock.TimelineMax;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Act_HotSpotCheckBox extends MovieClip
	{
		[Embed (source="/masterShell/widget/act/hs_checkBox0.png")]
		private var _hs_checkbox00:Class
		private var _hs_checkbox0:Bitmap = new _hs_checkbox00;
		
		[Embed (source="/masterShell/widget/act/hs_checkBox1.png")]
		private var _hs_checkbox01:Class
		private var _hs_checkbox1:Bitmap = new _hs_checkbox01;
		
		[Embed (source="/masterShell/widget/act/hs_checkBox1chkd.png")]
		private var _hs_checkbox01chkd:Class
		private var _hs_checkbox1chkd:Bitmap = new _hs_checkbox01chkd;
		
		
		private var _checkBack:Sprite;
		private var _normalState:Sprite;
		private var _activeState:Sprite;
		private var _pulseState:MovieClip;
		private var _checkedState:Sprite;
		
		private var _currentState:String;
		
		private var _pulseStateTL:TimelineMax;
		
		private var _tracked:Boolean;
		
		public function Act_HotSpotCheckBox()
		{
			super();
			_checkBack = new Sprite();
			_normalState = new Sprite();
			_normalState.addChild(_hs_checkbox0);
			_checkBack.addChild(_normalState);
			_pulseStateTL = new TimelineMax({paused:true,repeat:-1,yoyo:true,delay:1});
			//_pulse_tl.append( new TweenMax(_btnEmblem,.5, {alpha:1}));
			_pulseStateTL.append( TweenMax.to(_normalState, 0.5,{scaleX:1.1, scaleY:1.1, alpha:0.4}));
			
			_activeState = new Sprite();
			_activeState.addChild(_hs_checkbox1);
			//_addRemoveCheckedState(true);
			
			
			_checkedState = new Sprite();
			_checkedState.addChild(_hs_checkbox1chkd);
			//_addRemoveCheckedState(true);
			
			this.addChild(_checkBack);
			this.tracked = false;

		}
		
		private function _addRemoveCheckedState(addit:Boolean):void
		{
			if (addit){
				_checkBack.addChild(_checkedState);
			} else {
				_checkBack.removeChild(_checkedState);
			}
		}
		
		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			_currentState = value;
			
			switch (_currentState){
				case "normal":
					if (!_tracked) {
						//_pulseStateTL.pause();
						_pulseStateTL.gotoAndStop(0);
						
					}
					break;
				case "pulse":
					if (!_tracked) {
						//_pulseStateTL.pause();
						_pulseStateTL.play();
						
					}
					
					break;
				case "active":
					if (!_tracked) {
						//_pulseStateTL.pause();
						_pulseStateTL.stop();
						_checkBack.removeChildAt(0);
						_checkBack.addChild(_activeState);
						
					}
					break;
		
			}
		}

		public function get tracked():Boolean
		{
			return _tracked;
		}

		public function set tracked(value:Boolean):void
		{
			_tracked = value;
			if (_tracked){
				_checkBack.removeChildAt(0);
				_checkBack.addChild(_checkedState);
			}
			//_addRemoveCheckedState(_tracked);
			
		}


	}
}