package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.events.*;
	import com.sanbeaman.shell.widget.activity.C2R_Button;
	import flash.events.*;
	
	public class SceneMenu_C2R extends BodyUI
	{
		private var _btnArray:Array;
		private var _shellDIR:String;
		
		private var _BTN_WIDTH:Number; 
		private var _BTN_HEIGHT:Number;
		
		private var _BTN_padding:Number =0;
		
		private var _layout:String;
		
		private var _fontSize:Number;
		private var _fontColor:String;
		private var _fontColor2:String;
		
		private var _currentBtn:C2R_Button;
		private var _currentBtnIndex:int;
		
		private var _fullpath:String;
		private var _userChoice:Boolean;
		
		private var _finalBtnIndex:int;
		
		private var _isWidgetTracked:Boolean;// = false;
		
		private var _BtnSelectStart:Boolean;
		
		private var _previousBTN:C2R_Button;
		
		public function SceneMenu_C2R()
		{
			super();
		}

		
		public function init(uinode:XML, shellpath:String = "", userchoice:Boolean = true, iswidgettracked:Boolean = false):void
		{
			_BtnSelectStart = false;
			_fullpath = shellpath + SHELL_VARS.FOLDER_ICONS;//'icons/';
			_userChoice = userchoice;
			_isWidgetTracked = iswidgettracked;
			_btnArray  = new Array();
			
			_BTN_WIDTH = uinode.@width;
			_BTN_HEIGHT = uinode.@height;
			_BTN_padding = uinode.@padding;
			_layout = uinode.@layout;
			
			var uip:UIparams = new UIparams();
			uip.uiWidth =_BTN_WIDTH
			uip.uiHeight =_BTN_HEIGHT;
			uip.uiFontColor = uinode.@fontColor;
			uip.uiFontSize = uinode.@fontSize;
			uip.uiFontColor2 = uinode.@fontColor2;
			uip.uiFontHAlign = (uinode.hasOwnProperty("@fontAlign"))?uinode.@fontAlign: "center";
			var xHolder:Number = 0;
			var yHolder:Number = 0;
			
			var bIndex:int = 0;
			
			var btnList:XMLList = uinode.*; 
			for each (var btn:XML in btnList) {
				var c2rbtn:C2R_Button = new C2R_Button();
				var bicon:String = (btn.hasOwnProperty("@icon"))? btn.@icon:"no";
				var hasIcon:Boolean = (bicon == "no")? false:true;
				var btnlbl:String = btn.label;
				if (hasIcon) {
					var xiconPath:String = _fullpath + btn.@icon;
					c2rbtn.buildButtonStates(btnlbl,uip,xiconPath);
				} else {
					c2rbtn.buildButtonStates(btnlbl,uip);
				}
				
				c2rbtn.btnID = btn.@id;
				c2rbtn.btnIndex = bIndex;
				bIndex++;
				
				if (_layout == '1row'){
					c2rbtn.x = xHolder;
					c2rbtn.y = yHolder;
					xHolder = c2rbtn.x + c2rbtn.width + _BTN_padding;
					
				} else {
					c2rbtn.x = btn.@x;
					c2rbtn.y = btn.@y;
				}
				c2rbtn.addEventListener(WidgetEvent.C2R_EVENT, _btnClick_handler);
				
				if(_userChoice == true || _isWidgetTracked ==true ){
					c2rbtn.enabled = true;
				} else {
					c2rbtn.enabled = false;
				}
				c2rbtn.isTracked = _isWidgetTracked;
				
				this.addChild(c2rbtn);
				_btnArray.push(c2rbtn);
			}
			_finalBtnIndex = _btnArray.length - 1;
			_loadIntroSlide();
		}
		
		private function _loadIntroSlide():void
		{
			
			trace('loadintro');
			var we:WidgetEvent = new WidgetEvent(WidgetEvent.C2R_EVENT, 'loadIntro', -1,"intro");
			this.dispatchEvent(we);
		}
		
		
		private function _btnClick_handler(we:WidgetEvent):void
		{
			
			//btnclicked
			trace('_btnClick_handler=' + we.eventAction + 'weInfo=' + we.eventInfo + 'we.eventIndex='+ we.eventIndex);
			var eindex:int = we.eventIndex;
			var weAction:String = we.eventAction;
			var weInfo:String = we.eventInfo;
			var weIndex:int = we.eventIndex;
			
			if (weAction == 'btnclicked'){
				if (!_BtnSelectStart) {
					_BtnSelectStart = true;
					_currentBtn = new C2R_Button();
					_currentBtn = _btnArray[weIndex] as C2R_Button;
					_previousBTN = new C2R_Button();
					
				} else {
					_previousBTN = _currentBtn;
					_previousBTN.selected = false;
					_previousBTN.enabled = true;
					_currentBtn = _btnArray[weIndex] as C2R_Button;
					
				}
				
				
				var btnindex:int =_currentBtn.btnIndex;
				trace("weIndex= " + weIndex + "should equal btnindex= "+ btnindex);
				var btnid:String = _currentBtn.btnID;
				_currentBtnIndex = btnindex;
				_currentBtn.pulseON = false;
				_currentBtn.selected = true;
				var we:WidgetEvent = new WidgetEvent(WidgetEvent.C2R_EVENT, 'loadSlide', btnindex,btnid);
				this.dispatchEvent(we);
			}
		}
		
		public function animateBtn(animateType:String,btnid:String):void
		{
			for (var i:int = 0;i < _btnArray.length; i++){
				
				var btn:C2R_Button = _btnArray[i];
				//	trace('animateType' + animateType + 'btnid' + btnid + 'btn.btnID'+btn.btnID);
				if (btn.btnID == btnid && animateType == 'glow'){
					btn.glowBtn();
					
					//btn.glowBtn();
				}
			}
			
		}
		public function trackBtn(btnid:String):void
		{
			var nxtBtn:int;
			
			if (_currentBtn != null){
				_currentBtn.isTracked = true;
				nxtBtn = _currentBtnIndex+ 1;
			} else {
				nxtBtn = 0;
			}
			
			if(!_userChoice){
				_activateBtn(nxtBtn)
			}
			
		}
		public function _activateBtn(bindex:int):void
		{
			if (bindex <= _finalBtnIndex){
				var nbtn:C2R_Button = _btnArray[bindex];
				//check if they have completed the widget before
				if (_isWidgetTracked){
					//if they have been here before then all buttons should be active in which case just pulse the next 
					nbtn.pulseON = true;
				} else {
					//they haven't been here before, so we need to activate and pulse next button
					if (nbtn.isTracked == false){
						//if the next button isn't active then activate it (and glow)
						nbtn.activateBtn(true);
					} else {
						//if the next btn has already been tracked because they went back over an earlier btn, 
						//then look for next non=tracked btn and activate it
						for (var j:int = 0; j < _btnArray.length; j++) {
							var xbtn:C2R_Button = _btnArray[j];
							if (xbtn.isTracked == false) {
								xbtn.activateBtn(true);
								//	xbtn.pulseON = true;
								break;
							}
						}
						
					}
				}
				
			} else {
				trace('should not have btnindex higher then final btnindex');
			}
		}
	}
}