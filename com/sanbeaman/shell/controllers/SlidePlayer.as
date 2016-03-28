package com.sanbeaman.shell.controllers
{
	import com.greensock.TimelineMax;
	import com.sanbeaman.shell.events.ShellEvent;
	import com.sanbeaman.shell.media.MediaSync;
	import com.sanbeaman.shell.ui.BTN_ShellMain;
	import com.sanbeaman.shell.utils.SlideTimeCode;
	
	import flash.display.Bitmap;
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	public class SlidePlayer extends Sprite
	{
		/*
		[Embed (source="/masterShell/btns/navwhiteBACK_normal.png")]
		private var _btnskinrestart_normal:Class
		public var btnskinrestart_normal:Bitmap = new _btnskinrestart_normal;
		
		[Embed (source="/masterShell/btns/navwhiteBACK_hover.png")]
		private var _btnskinrestart_hover:Class
		public var btnskinrestart_hover:Bitmap = new _btnskinrestart_hover;
		
		[Embed (source="/masterShell/btns/navwhiteBACK_down.png")]
		private var _btnskinrestart_down:Class
		public var btnskinrestart_down:Bitmap = new _btnskinrestart_down;
		
		
		//Next Graphics for buttons
		[Embed (source="/masterShell/btns/navwhiteNEXT_normal.png")]
		private var _btnskinresume_normal:Class
		public var btnskinresume_normal:Bitmap = new _btnskinresume_normal;
		
		
		[Embed (source="/masterShell/btns/navwhiteNEXT_hover.png")]
		private var _btnskinresume_hover:Class
		public var btnskinresume_hover:Bitmap = new _btnskinresume_hover;
		
		[Embed (source="/masterShell/btns/navwhiteNEXT_down.png")]
		private var _btnskinresume_down:Class
		public var btnskinresume_down:Bitmap = new _btnskinresume_down;
		
		//Pause Graphics for buttons
		
		[Embed (source="/masterShell/btns/navwhitePAUSE_normal.png")]
		private var _btnskinpause_normal:Class
		public var btnskinpause_normal:Bitmap = new _btnskinpause_normal;
		
		[Embed (source="/masterShell/btns/navwhitePAUSE_hover.png")]
		private var _btnskinpause_hover:Class
		public var btnskinpause_hover:Bitmap = new _btnskinpause_hover;
		
		[Embed (source="/masterShell/btns/navwhitePAUSE_down.png")]
		private var _btnskinpause_down:Class
		public var btnskinpause_down:Bitmap = new _btnskinpause_down;
		*/
		private var _backShape:Sprite;
	
		private var _btn_resumepause:Sprite;
		private var _btn_block:MovieClip;
		private var _btn_restart:BTN_ShellMain;
		private var _btn_resume:BTN_ShellMain;
		private var _btn_pause:BTN_ShellMain;
		
		private var _btnY:Number = 4;
		private var _btnwidth:Number = 24;
		private var _btnxpad:Number = 2;
		private var _btn_restartX:Number = 6;
		
		
		private var _pauseCover:Bitmap;
		
		
		private var _slideTL:TimelineMax;
		
	//	private var _slideVO:SlideAudioSync;
		
		
		private var _slideMedia:MediaSync;
		
		private var _slideTimer:Timer;
		/** 
		 * SCRUBBAR 
		 * 
		 *  */
		private var _scrubTrack:Sprite;
		private var _scrubTrackColor:String;
		
		private var _scrubHandle:Sprite;
		private var _scrubHandleColor:String;
		
		private var _scrubBar:Sprite;
		private var _scrubBarColor:String;
		
		
		private var _scrubShadowColor:String;
	
		protected var _trackWidth:Number = 250;
		protected var _trackHeight:Number = 5;
		protected var _trackY:Number = 10;
		protected var _handleWidth:Number = 6;
		protected var _handleHeight:Number = 18;
		protected var _handleYadjust:Number = -7;
		
		private var _scrubX:Number;
		private var _scrubY:Number;
		
		private var _max:Number;
		private var _min:Number;
		
		private var _isDragging:Boolean;
		private var _isPlaying:Boolean;
		private var _wasPaused:Boolean;
		
		private var _totalTimeInSec:Number;
		private var _scrubTo:Number;
		
		private var _currentSlideTime:Number;
		
		private var _percentComplete:Number;
		
		private var _hasSlideMedia:Boolean;// = false;
		private var _hasSlideAudio:Boolean;// = false;
	
		private var _pulseColor:String;
		
		private var _slidePlayerActivated:Boolean = false;
		
		private var _slideTimeCode:SlideTimeCode;
		
		
		
		
		public function SlidePlayer(btnRestart:BTN_ShellMain,btnResume:BTN_ShellMain,btnPause:BTN_ShellMain,handleColor:String = "white",barColor:String = "greycc", trackColor:String = "grey33", shadowColor:String = "black", blockclr:String = "black",pulseclr:String = "ltblue",blockalpha:Number = 1)
		{
			super();
			
			_btn_restart = btnRestart;
			_btn_resume = btnResume;
			_btn_pause = btnPause;
			
			_scrubHandleColor = handleColor;
			_scrubBarColor = barColor;
			_scrubTrackColor = trackColor;
			_scrubShadowColor = shadowColor;
			
			var scrubHandleColorCode:uint = SHELL_COLORS.lookUpColor(_scrubHandleColor);
			var scrubBarColorCode:uint = SHELL_COLORS.lookUpColor(_scrubBarColor);
			var scrubTrackColorCode:uint = SHELL_COLORS.lookUpColor(_scrubTrackColor);
			var scrubShadowColorCode:uint = SHELL_COLORS.lookUpColor(_scrubShadowColor);
			
			//_blockColor = blockclr;
			var blockColorCode:uint = SHELL_COLORS.lookUpColor(blockclr);
			_pulseColor= pulseclr;
			var blockAlpha:Number = blockalpha;
			
			
			_backShape = new Sprite();
			//_backShape.graphics.lineStyle(1,0x000000);
			_backShape.graphics.beginFill(blockColorCode,blockAlpha);
			_backShape.graphics.drawRect(0,0,350,24);
			_backShape.graphics.endFill();
			this.addChild(_backShape);
			
			_btn_restart.visible = false;
			_btn_resume.visible = false;
			_btn_pause.visible = false;
			
			_btn_restart.x = 0;
			_btn_restart.y = 0;
			
			_btn_resumepause =new Sprite();
			_btn_resumepause.x = 26;
			_btn_resumepause.y = 0;

			_btn_resume.x = 0;
			_btn_resume.y = 0;
			_btn_pause.x =  0;
			_btn_pause.y = 0;
			
			_btn_resumepause.addChild(_btn_pause);
			_btn_resumepause.addChild(_btn_resume);
			
			
			//_btn_resumepause.addChild(_btn_block);
			
			_scrubX = 52;
			_scrubY = _trackY;
			
			_scrubTrack = new Sprite();
			_scrubTrack.graphics.beginFill(scrubTrackColorCode,1);
			_scrubTrack.graphics.drawRect(0,0,_trackWidth,_trackHeight);
			_scrubTrack.graphics.endFill();
			
			_scrubTrack.x = _scrubX;
			_scrubTrack.y = _scrubY;
			
			_scrubBar = new Sprite();
			var sbshadow:Shape = new Shape();
			sbshadow.graphics.beginFill(scrubShadowColorCode,.3);
			sbshadow.graphics.drawRect(0,0,_trackWidth+2,_trackHeight+2);
			sbshadow.graphics.endFill();
			sbshadow.x = -1;
			_scrubBar.addChild(sbshadow);
			
			var sbar:Shape = new Shape();
			sbar.graphics.beginFill(scrubBarColorCode,1);
			sbar.graphics.drawRect(0,0,_trackWidth,_trackHeight);
			sbar.graphics.endFill();
			_scrubBar.addChild(sbar);
			_scrubBar.x = 0;
			_scrubBar.y = 0;
			
			this.addChild(_scrubTrack);
		
			//_scrubTrack.mouseChildren = false;
			
			_scrubHandle = new Sprite();
			var handleShadow:Shape = new Shape();
			handleShadow.graphics.beginFill(scrubShadowColorCode,.3);
			handleShadow.graphics.drawRect(0, 0, _handleWidth+2, _handleHeight+2);
			handleShadow.graphics.endFill();
			handleShadow.x = -1;
			_scrubHandle.addChild(handleShadow);
			var handle:Shape = new Shape();
			
			handle.graphics.beginFill(scrubHandleColorCode);
			handle.graphics.drawRect(0, 0, _handleWidth, _handleHeight);
			handle.graphics.endFill();
			_scrubHandle.addChild(handle);
			
			_scrubHandle.y = _handleYadjust;//-7;
			this.addChild(_btn_restart);
			this.addChild(_btn_resumepause);
			
			_btn_block = new MovieClip();
			_btn_block.graphics.beginFill(blockColorCode,1);
			_btn_block.graphics.drawRect(_btn_resumepause.x,_btn_resumepause.y,_btn_resumepause.width, _btn_resumepause.height);
		
		
			this.addChild(_btn_block);
			_btn_block.enabled = false;
			_slideTimeCode = new SlideTimeCode();
			_slideTimeCode.alpha = 0;
			_slideTimeCode.x = _scrubTrack.x + _scrubTrack.width + 10;
			_slideTimeCode.init("secs");
			this.addChild(_slideTimeCode);
			
		}
		
		public function setupSlideController(slideTL:TimelineMax,slideMedia:MediaSync = null,alreadyComplete:Boolean = false):void
		{
			_slideTL = new TimelineMax();
			
			_slideTL = slideTL
		//	_slideTL = slideTL;
			//var tlChildren:Array = _slideTL.getChildren();
			
			if (slideMedia != null) {
				_hasSlideMedia = true;
				_slideMedia = slideMedia;
			} else {
				_hasSlideMedia = false;
			}
			
			
			_min = 0;
		
			_totalTimeInSec = _slideTL.totalDuration();
			if (alreadyComplete) {
				_percentComplete = 1;
			} else {
				_percentComplete = 0;
				
			}
			
			_scrubBar.x = 0;
			_scrubBar.scaleX = _percentComplete;
		
			_scrubTrack.addChild(_scrubBar);
			_scrubHandle.x = 0;
			_scrubTrack.addChild(_scrubHandle);
			
			
			_slidePlayerActivated = false;
			
	
		}
		
		
		public function startSlideController():void
		{
			
			if(!_slidePlayerActivated){
				_playerActivate();
				
			}
			/*
			_addDragEventListener();
			_slideTimer  = new Timer(20, 0);
			_slideTimer.addEventListener(TimerEvent.TIMER, _timerTick);
			_slideTimer.start();
			_slideTL.play();
			if (_hasSlideMedia) {
				_slideMedia.playMedia();
			}
			
			_btn_restart.visible = true;
			_btn_restart.addEventListener(MouseEvent.CLICK, _restartbtn_handler);
			_btn_resumepause.addEventListener(MouseEvent.CLICK, _resumebtn_handler);
			_controllerStatus(false);
			*/
			
			
		}
		private function _playerActivate():void
		{
			//_addDragEventListener();
			//trace('_playerActivate');
			_scrubHandle.buttonMode = true;
			_scrubHandle.useHandCursor = true;
			_scrubHandle.addEventListener(MouseEvent.MOUSE_DOWN, _startDragging);
			_isDragging = false;
			
			_slideTimer  = new Timer(20, 0);
			_slideTimer.addEventListener(TimerEvent.TIMER, _timerTick);
			_slideTimer.start();
			_slideTL.play();
			
			if (_hasSlideMedia) {
				_slideMedia.playMedia();
			}
			
			_btn_restart.visible = true;
			_btn_restart.addEventListener(MouseEvent.CLICK, _restartbtn_handler);
			_btn_resumepause.visible = true;
			_btn_resumepause.alpha = 1;
			_btn_resumepause.mouseChildren = false;
			_btn_resumepause.buttonMode = true;
			_btn_resumepause.useHandCursor = true;
			_btn_resumepause.addEventListener(MouseEvent.CLICK, _resumebtn_handler);
			_btn_block.visible = false;
			_scrubBar.addEventListener(MouseEvent.CLICK, _scrubbar_skip);
			_slidePlayerActivated = true;
			_controllerStatus(false);
		}
	
		
		private function _scrubbar_skip(me:MouseEvent):void
		{
			_scrubHandle.x = _scrubTrack.mouseX;
		
			
			if(_scrubHandle.x <= 0){
				_scrubHandle.x = 0;
			}else if(_scrubHandle.x >= _scrubTrack.width - _scrubHandle.width){
				_scrubHandle.x = _scrubTrack.width - _scrubHandle.width;
			}else{
				
			}
			
			_scrubTo = _scrubHandle.x * _totalTimeInSec / (_scrubTrack.width - _scrubHandle.width);
			_slideTL.time(_scrubTo);
			if (_hasSlideMedia){
				trace('has slide media === _scrubTO>'+ _scrubTo + 'is _slideTL.paused' + _slideTL.paused() );
				
				_slideMedia.mediaTime = _scrubTo;
				//	_slideVO.currentTime = _scrubTo;
			}
			
		}
		private function _playerDeactivate():void
		{
			_scrubHandle.buttonMode = false;
			_scrubHandle.useHandCursor = false;
			_scrubHandle.removeEventListener(MouseEvent.MOUSE_DOWN, _startDragging);
			//_isDragging = false;
			
			
			_slideTimer.removeEventListener(TimerEvent.TIMER, _timerTick);
			_scrubHandle.removeEventListener(MouseEvent.MOUSE_DOWN, _startDragging);
			
			_scrubTrack.removeChild(_scrubBar);
			_scrubTrack.removeChild(_scrubHandle);
			
			_btn_restart.removeEventListener(MouseEvent.CLICK, _restartbtn_handler);
			
			_btn_resumepause.removeEventListener(MouseEvent.CLICK, _resumebtn_handler);
			
			if (_hasSlideMedia){
				
				_slideMedia.killMedia();
				_slideMedia = null;
				//	_slideVO.killAudio();
				//	_slideVO = null;
				//_slideVO.resumeAudio();
			}
			
			//_slideTimer.stop();
			_slideTimer.stop();
			_slideTimer = null;
			_slideTL.kill();
			_slideTL = null;
			_slidePlayerActivated = false;
			
		}
		
		public function checkStatus():void
		{
			
			if (_slidePlayerActivated){
				var isresumepauseActve:Boolean = (_slideTL.totalProgress() >= 1)?false:true;
				_toggle_btnblock(isresumepauseActve);
				// _toggle_resumePause(isresumepauseActve);
			}
				/*
				if (_slideTL.totalProgress() >= 1){
				_btn_resumepause.alpha = .3;
				_btn_resumepause.mouseChildren = false;
				_btn_resumepause.buttonMode = false;
				_btn_resumepause.useHandCursor = false;
			//	_btn_pause.enabled = false;
			} else {
				_btn_resumepause.mouseChildren = true;
				_btn_resumepause.buttonMode = true;
				_btn_resumepause.useHandCursor = true;
				_btn_resumepause.alpha = 1;
				//_btn_pause.enabled = true;
			}
			}
			*/
		}
		
		private function _toggle_btnblock(isactive:Boolean):void{
			if (!isactive){
				_btn_pause.visible = false;
				_btn_resume.visible = true;
				_btn_block.visible = true;
				_btn_block.alpha = .8;
				_slideTL.pause();
				
			} else {
				_btn_block.visible = false;
			}
		//	_btn_block.visible = (isactive)?false:true;
			/*
			var btnalpha:Number = (isactive)?1:0.3;
			_btn_resumepause.alpha = btnalpha;
			_btn_resumepause.mouseChildren = isactive;
			_btn_resumepause.buttonMode = isactive;
			_btn_resumepause.useHandCursor = isactive;
			_btn_pause.enabled = isactive;
			_btn_resume.enabled = isactive;
			*/
		}
		private function _toggle_resumePause(isactive:Boolean):void{
			_btn_block.visible = isactive;
			/*
			var btnalpha:Number = (isactive)?1:0.3;
			_btn_resumepause.alpha = btnalpha;
			_btn_resumepause.mouseChildren = isactive;
			_btn_resumepause.buttonMode = isactive;
			_btn_resumepause.useHandCursor = isactive;
			_btn_pause.enabled = isactive;
			_btn_resume.enabled = isactive;
			*/
		}
		private function _controllerStatus(setPauseStatus:Boolean):void
		{
			//if setPauseStatus is TRUE, then isPLAYING = FALSE
			//
			_isPlaying = (setPauseStatus)? false:true;
			if (_isPlaying) {
			//	_btn_pause.alpha = 1;
				//_btn_pause.enabled = true;
				_btn_pause.visible = true;
				//_btn_pause.addEventListener(MouseEvent.CLICK, _resumebtn_handler);
				_btn_resume.visible = false;
			} else {
				_btn_pause.visible = false;
				//_btn_pause.removeEventListener(MouseEvent.CLICK, _resumebtn_handler);
				_btn_resume.visible = true;
			//	_btn_resume.addEventListener(MouseEvent.CLICK, _resumebtn_handler);
			}
			this.checkStatus();
		}
		
		private function _restartbtn_handler(me:MouseEvent):void
		{
			
			_currentSlideTime= 0;
			_slideTL.gotoAndPlay(0);
			if (_hasSlideMedia){
				_slideMedia.gotoMediaTime(0,true);
			//	_slideVO.gotoAudioTime(0,true);
			}
		
			_scrubHandle.x = 0;
			_controllerStatus(false);
			
		}
		private function _resumebtn_handler(me:MouseEvent):void
		{
			var isPaused:Boolean = _slideTL.paused();
			
			if(!isPaused) {
				//the slide is PLAYING So PAUSE
				if (_hasSlideMedia){
					_slideMedia.pauseMedia();
				//_slideVO.pauseAudio();
				}
				_slideTL.pause();
				_controllerStatus(true);
			} else {
				//Sthe SLIDE is PAUSED so PLAY
				var ctime:Number = _slideTL.time();
				
				if (_hasSlideMedia){
				_slideMedia.mediaTime = ctime;
				_slideMedia.resumeMedia();
				
				//_slideVO.resumeAudio();
				}
				_slideTL.resume();
				_controllerStatus(false);
			}
			
			
			
		}	
			
			
		private function _timerTick(e:TimerEvent):void
		{
			//trace('_slideTL.currentTime = '+ _slideTL.currentTime);
			if(_isDragging){
				_scrubTo = _scrubHandle.x * _totalTimeInSec / (_scrubTrack.width - _scrubHandle.width);
				_slideTL.time(_scrubTo);
				if (_hasSlideMedia){
					_slideMedia.mediaTime = _scrubTo;
			//	_slideVO.currentTime = _scrubTo;
				}
				_syncSlideOnScrub(_slideTL);
			} else {
				var currentProgress:Number = _slideTL.progress();
				if (_percentComplete < currentProgress) {
					_scrubBar.scaleX = _percentComplete = currentProgress;
				}
				_scrubHandle.x = _slideTL.progress()  * (_scrubTrack.width - _scrubHandle.width);
			}
			_slideTimeCode.timecode_seconds = _slideTL.time();
		
		}
		private function _syncSlideOnScrub(tlMax:TimelineMax):void
			{
				try{
					tlMax.gotoAndStop(_scrubTo);
				}catch(e:Error){
					//trace("No TimelineMax instance available");
					_stopDragging(null);
				}
			}
		private function _addDragEventListener():void
		{
			_scrubHandle.buttonMode = true;
			_scrubHandle.useHandCursor = true;
			_scrubHandle.addEventListener(MouseEvent.MOUSE_DOWN, _startDragging);
			_isDragging = false;
			
		}
		
		private function _positionThumbonclick():void
		{
			_scrubHandle.x = _scrubTrack.mouseX - _handleWidth;
			
			if(_scrubHandle.x <= 0){
				_scrubHandle.x = 0;
			}else if(_scrubHandle.x >= _scrubTrack.width - _scrubHandle.width){
				_scrubHandle.x = _scrubTrack.width - _scrubHandle.width;
			}else{
				
			}
		}
		private function _startDragging(e:MouseEvent):void
		{
			//_scrubUpdateTimer.addEventListener(TimerEvent.TIMER, reportThumbPosition);
			//_scrubUpdateTimer.start();
			
			_wasPaused = _slideTL.paused();
			if (_hasSlideMedia){
				_slideMedia.startSrubbing();
			//_slideVO.pauseAudio();
			}
			_isDragging = true;
			var scrubRectWidth:Number = (_percentComplete *  (_scrubTrack.width - _scrubHandle.width));
			_scrubHandle.startDrag(false, new Rectangle(0, _handleYadjust,scrubRectWidth, 0));
			//_scrubHandle.startDrag(false, new Rectangle(0, _handleYadjust, _scrubTrack.width - _scrubHandle.width, 0));
			_positionThumbonclick();
			stage.addEventListener(MouseEvent.MOUSE_UP, _stopDragging);
		}
		
		
		private function _stopDragging(e:MouseEvent):void
		{
			//trace("Stop Dragging");
			//_scrubUpdateTimer.removeEventListener(TimerEvent.TIMER, reportThumbPosition);
			//_scrubUpdateTimer.stop();
			_isDragging = false;
			_scrubHandle.stopDrag();
			
			if (!_wasPaused) {
				if (_hasSlideMedia){
					_slideMedia.resumeMedia();
					
			//	_slideVO.resumeAudio();
				}
				_slideTL.resume();
			} else {
				_slideTL.pause();
				
			}
			stage.removeEventListener(MouseEvent.MOUSE_UP, _stopDragging);
			_controllerStatus(_slideTL.paused());
			
		}
		
		public function killALL():void
		{
			
			if(_slidePlayerActivated) {
				_playerDeactivate();
			}
			/*
			_slideTimer.removeEventListener(TimerEvent.TIMER, _timerTick);
			_scrubHandle.removeEventListener(MouseEvent.MOUSE_DOWN, _startDragging);
			
			_scrubTrack.removeChild(_scrubBar);
			_scrubTrack.removeChild(_scrubHandle);
			
			_btn_restart.removeEventListener(MouseEvent.CLICK, _restartbtn_handler);
			_btn_resumepause.removeEventListener(MouseEvent.CLICK, _resumebtn_handler);
		
			if (_hasSlideMedia){
				
				_slideMedia.killMedia();
				_slideMedia = null;
			//	_slideVO.killAudio();
			//	_slideVO = null;
				//_slideVO.resumeAudio();
			}
			
			//_slideTimer.stop();
			_slideTimer.reset();
			_slideTimer = null;
			_slideTL.kill();
			_slideTL = null;
			*/
		}
		
		
	}
}