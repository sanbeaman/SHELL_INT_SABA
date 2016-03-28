package com.sanbeaman.shell.widget
{
	
	import com.greensock.*;
	import com.sanbeaman.shell.events.ShellEvent;
	
	import flash.display.*;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.*;
		
		public class GPSNavBar extends Sprite
		{
			private var _navBack:Sprite;
			private var _shellDir:String;
			
			private var _totalBtns:int;
			
			private var _btnArray:Array;
			private var _btnClickedArray:Array;
			
			public var gpsNavBarHeight:Number = 100;
			private var _showY:Number;
			private var _hideY:Number;
			
			private var _currentSlideTarget:String;
			
			public function GPSNavBar()
			{
				super();
				_navBack = new Sprite();
				var fillType:String = GradientType.LINEAR;
				var colors:Array = [0x858585, 0xFFFfff];
				var alphas:Array = [1, 1];
				var ratios:Array = [0x00, 0xFF];
				var matr:Matrix = new Matrix();
				matr.createGradientBox(SHELL_VARS.CONTENT_WIDTH,33,Math.PI/2,0,1);
				//matr.createGradientBox(20, 20, Math.PI/9, 0, 0);
				var spreadMethod:String = SpreadMethod.PAD;
				var interp:String = InterpolationMethod.LINEAR_RGB; 
				
				_navBack.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interp);       
				_navBack.graphics.drawRect(0,0,SHELL_VARS.CONTENT_WIDTH,gpsNavBarHeight);
				_navBack.graphics.lineStyle(3,0x00B5D7,1,true);
				_navBack.graphics.moveTo(0,0);
				_navBack.graphics.lineTo(SHELL_VARS.CONTENT_WIDTH,0);
				
				this.addChild(_navBack);
				
				_showY = _navBack.y;
				_hideY = _showY + _navBack.height;
				trace("_showY= " + _showY + "  _hideY= " + _hideY);
				_navBack.y = _hideY;
				
				
			}
			
			public function buildGPSNavBar(uinode:XML, shelldir:String):void
			{
				
				_shellDir = shelldir;
				_btnArray = new Array();
				_btnClickedArray = new Array();
				
				var btnW:Number = uinode.@width;
				var btnH:Number = uinode.@height;
				
				var gnbXML:XMLList = uinode.*;
				
				for each (var gpsButton:XML in gnbXML) 
				{ 
					var gpsbtn:GPSNavBarBtn = new GPSNavBarBtn();
					gpsbtn.x = gpsButton.@x;
					gpsbtn.y = gpsButton.@y;
					gpsbtn.name = gpsButton.@target;
					gpsbtn.btnTarget = gpsButton.@target;
					trace("gpsbtnname= " +  gpsbtn.name);
					var gpsbtnw:Number = gpsButton.@width;
					var gpsbtnh:Number = gpsButton.@height;
					var ipath:String = _shellDir + gpsButton.@sfile;
					var blbl:String = gpsButton;
					
					gpsbtn.buildBtn(ipath,blbl,btnW,btnH,gpsbtnw,gpsbtnh);
					gpsbtn.addEventListener(MouseEvent.CLICK,_gpsbtn_clickhandler);
					_btnArray.push(gpsbtn);
					_navBack.addChild(gpsbtn);
					
					
				}
				_totalBtns = _btnArray.length;
				
				
			}
			
			private function _gpsbtn_clickhandler(me:MouseEvent):void
			{
				
				//var clkObject:Object = me.currentTarget;
				//var btnName:String = clkObject.name;
				
				
				var gpsbtn:GPSNavBarBtn = me.currentTarget as GPSNavBarBtn;
				var btnName:String = gpsbtn.name;
				trace("btnName= " + btnName);
				var targetslide:String =  btnName;
				
				if (!gpsbtn.btnTracked) {
					 _checkNewBtns(targetslide);
					 targetslide = gpsbtn.btnTarget;
				} else {
					targetslide = gpsbtn.btnTarget;
					
				}
				trace("targetslide =" + targetslide);;
				_currentSlideTarget = targetslide;
				var slidevent:ShellEvent = new ShellEvent(ShellEvent.SLIDE_EVENT,"loadSlide",_currentSlideTarget);
				this.dispatchEvent(slidevent);
				gpsbtn.currentState = "ready";
				this.hideNavBar();
				
			}
			
			
			private function _checkNewBtns(btnName:String):void
			{
				var targetSlide:String = "none";
				
				for (var i:int = 0; i < _btnArray.length; i++) {
					var gpsbtn:GPSNavBarBtn = _btnArray[i];
					if (gpsbtn.name == btnName) {
						_btnArray.splice(i,1);
						_btnClickedArray.push(gpsbtn);
						targetSlide = gpsbtn.btnTarget;
						break;
					}
					
				}
				trace("_checkNewBtns----_btnClickedArray.length" + _btnClickedArray.length);
				//return targetSlide;
			}
			
			//you build these functions into your objects (classes, MovieClips, whatever):
			public function showNavBar():TimelineLite {
				var tl:TimelineLite = new TimelineLite();
				tl.append( TweenMax.to(_navBack, 0.5, {y:_showY,onComplete:_show_complete}) );
				return tl;
			}
			
			public function hideNavBar():TimelineLite {
				var tl:TimelineLite = new TimelineLite();
				tl.append( TweenMax.to(_navBack, 0.5, {y:_hideY, onComplete:_hide_complete}) );
				return tl;
			}
			
			private function _hide_complete():void
			{
				
				trace("hide complete");
				//this.killAll();
				//var sce:ShellControllerEvent = new ShellControllerEvent(ShellControllerEvent.SLIDE_EVENT,"slideOut",_slideId,true);
				//this.dispatchEvent(sce);
			}
			
			private function _show_complete():void
			{
				trace("show complete");
				_checkBtnStates();
				//trace("_animateIn_complete");
			//	this.startSlide();
				
				//this.addEventListener(MouseEvent.ROLL_OUT, _rollout_handler);
			}
			
			private function _checkBtnStates():void
			{
				
				var cGPSbtn:GPSNavBarBtn;
			
				
				if (_btnClickedArray.length < 1){
					cGPSbtn = _btnArray[0];
					cGPSbtn.currentState = 'pulse';
					//var se:ShellEvent = new ShellEvent(ShellEvent.SLIDE_EVENT,"slideDone","notDone");
				//	this.dispatchEvent(se);
				//	var sce:ShellControllerEvent = new ShellControllerEvent(ShellControllerEvent.SLIDE_EVENT,"slideOut",_slideId,true);
					//this.dispatchEvent(sce);
				} else {
					for (var i:int = 0; i < _btnClickedArray.length; i++) {
						cGPSbtn = _btnClickedArray[i];
						if (cGPSbtn.name == _currentSlideTarget){
							cGPSbtn.btnTracked = true;
							break;
						}
					}
		
					
					
				}
			
				_checkAllSlidesDone();
				
			}
			
			private function _checkAllSlidesDone():void
			{
				var se:ShellEvent;
				
				if (_btnArray.length <= 0){
					se = new ShellEvent(ShellEvent.SLIDE_EVENT,"slideDone","allDone");
				} else {
					se = new ShellEvent(ShellEvent.SLIDE_EVENT,"slideDone","notDone");
				}
				
				this.dispatchEvent(se);
			}

		}
}