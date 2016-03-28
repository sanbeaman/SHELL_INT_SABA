package com.sanbeaman.shell.controllers
{
	import com.sanbeaman.shell.events.ShellEvent;
	import com.sanbeaman.shell.ui.BTN_ShellMain;
	
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
	
	import fl.lang.Locale;
	
	public class NavPlayer extends Sprite
	{
		private var _backShape:Shape;
		
		private var _btn_back:BTN_ShellMain;
		private var _btn_next:BTN_ShellMain;
		private var _btn_done:BTN_ShellMain;
		private var _btnY:Number = 3;
		
		
		private var _btn_backX:Number = 6;
		private var _btn_nextX:Number = 726;
		
		
		private var _backBtnActive:Boolean = false;
		private var _nextBtnActive:Boolean = false;
		private var _doneBtnActive:Boolean = false;
		
		
		private var _blockColor:String;
		private var _blockColorCode:uint;
		private var _blockAlpha:Number;
		private var _pulseColor:String;
		
		public function NavPlayer(btnBack:BTN_ShellMain,btnNext:BTN_ShellMain,btnDone:BTN_ShellMain,blockclr:String = "black",pulseclr:String = "ltblue",blockalpha:Number = 1)
		{
			super();
			
			
			_btn_back = btnBack;
			_btn_next = btnNext;
			_btn_done = btnDone;
			
				
			_blockColor = blockclr;
			_blockColorCode = SHELL_COLORS.lookUpColor(_blockColor);
			_blockAlpha = blockalpha;
			_pulseColor= pulseclr;
			
			_backShape = new Shape();
			
			
			_backShape.graphics.beginFill(_blockColorCode,_blockAlpha);
			//_backShape.graphics.beginFill(0x000000,1);
			_backShape.graphics.drawRect(0,0,SHELL_VARS.SHELL_WIDTH,30);
			_backShape.graphics.endFill();
			this.addChild(_backShape);
			
			/*
			var _gpsLine:Shape = new Shape();
			//	_gpsLine = new Shape();
			_gpsLine.graphics.lineStyle(4,0x4b4b4b,1,true,"normal",CapsStyle.NONE);
			_gpsLine.graphics.moveTo(0,0);
			_gpsLine.graphics.lineTo(687,0);
			_gpsLine.x = 0;
			_gpsLine.y =  8;
			
			this.addChild(_gpsLine);
			*/
			/*
			_btn_back = new BTN_ShellMain();
			var btnbackLBL:String =  Locale.loadString("IDS_BACK");
			
			trace("btnbackLBL = "+  btnbackLBL);
			_btn_back.buildButtonStates(btnbackLBL,btnback_skin_pulse.bitmapData,btnback_skin_normal.bitmapData,btnback_skin_hover.bitmapData,btnback_skin_down.bitmapData,null,_pulseColor);
			*/
			_btn_back.x = _btn_backX;
			_btn_back.y = _btnY;//12;
			_btn_back.visible = false;
			this.addChild(_btn_back);
			
			
			/*
			//_btn_back.visible = false;
			_btn_next = new BTN_ShellMain();
			
			var btnnextLBL:String = Locale.loadString("IDS_NEXT");
			_btn_next.buildButtonStates(btnnextLBL,btnback_skin_pulse.bitmapData,btnnext_skin_normal.bitmapData,btnnext_skin_hover.bitmapData,btnnext_skin_down.bitmapData,null,_pulseColor);
			*/
			_btn_next.x = _btn_nextX;;//this.width - _btn_next.width;
			_btn_next.y = _btnY;
			
			_btn_next.visible = false;
			this.addChild(_btn_next);
			
			/*
			_btn_done = new BTN_ShellMain();
			
			var btndoneLBL:String = Locale.loadString("IDS_DONE");
			_btn_done.buildButtonStates(btndoneLBL,btnback_skin_pulse.bitmapData,btndone_skin_normal.bitmapData,btndone_skin_hover.bitmapData,btndone_skin_down.bitmapData,null,_pulseColor);
			*/
			_btn_done.x = _btn_nextX;//this.width - _btn_next.width;
			_btn_done.y = _btnY;
			
			_btn_done.visible = false;
			this.addChild(_btn_done);
			//_btn_next.enabled = false;
		}
		
		public function activateBackBtn():void
		{
			//_btn_next.enabled = true;
			_btn_back.visible = true;
			_btn_back.addEventListener(MouseEvent.CLICK,_backBtn_clicker);
			_backBtnActive = true;
			//_btn_back.pulseON = true;
		}
		private  function _deActivateBackBtn():void
		{
			//_btn_next.enabled = false;
			_btn_back.visible = false;
			_btn_back.removeEventListener(MouseEvent.CLICK,_backBtn_clicker);
			_backBtnActive = false;
		}
		public function activateNextBtn(withPulse:Boolean = true):void
		{
		//	trace('navPlayer activateNextBtn withPulse?' + withPulse);
			_btn_next.visible = true;
			_btn_next.addEventListener(MouseEvent.CLICK,_nextBtn_clicker);
			_btn_next.pulseON = withPulse;
			_nextBtnActive = true;
		}
		
		public function activateDoneBtn(withPulse:Boolean =true):void
		{
		//	trace('navPlayer activateDoneBtn withPulse?' + withPulse);
			if (_nextBtnActive) {
				_deActivateNextBtn();
			}
			_btn_done.visible = true;
			_btn_done.addEventListener(MouseEvent.CLICK,_doneBtn_clicker);
			_btn_done.pulseON = withPulse;
			_doneBtnActive = true;
		}
		private  function _deActivateNextBtn():void
		{
			//_btn_next.enabled = false;
			_btn_next.visible = false;
			_btn_next.removeEventListener(MouseEvent.CLICK,_nextBtn_clicker);
			_nextBtnActive = false;
		}
		private  function _deActivateDoneBtn():void
		{
			//_btn_next.enabled = false;
			_btn_done.visible = false;
			_btn_done.removeEventListener(MouseEvent.CLICK,_doneBtn_clicker);
			_doneBtnActive = false;
		}
		private function _doneBtn_clicker(me:MouseEvent):void
		{
			_resetNavController();
			var scevt:ShellEvent = new ShellEvent(ShellEvent.SCENE_EVENT,"clickedDone");
			this.dispatchEvent(scevt);
			
		}
		private function _backBtn_clicker(me:MouseEvent):void
		{
			_resetNavController();
			var scevt:ShellEvent = new ShellEvent(ShellEvent.SCENE_EVENT,"clickedBack");
			this.dispatchEvent(scevt);
			
		}
		private function _nextBtn_clicker(me:MouseEvent):void
		{
			_resetNavController();
			var scevt:ShellEvent = new ShellEvent(ShellEvent.SCENE_EVENT,"clickedNext");
			this.dispatchEvent(scevt);
			
		}
		private function _resetNavController():void
		{
			if (_doneBtnActive) {
				_deActivateDoneBtn();
			}
			if (_nextBtnActive) {
				_deActivateNextBtn();
			}
			if (_backBtnActive) {
				_deActivateBackBtn();
			}
		}
	}
}