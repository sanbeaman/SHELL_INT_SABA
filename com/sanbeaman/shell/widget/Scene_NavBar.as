package com.sanbeaman.shell.widget
{
	
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import com.sanbeaman.shell.events.ShellEvent;
	import com.sanbeaman.shell.widget.Scene_NavBarBtn;
	
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
		
		public class Scene_NavBar extends Sprite
		{
			private var _navBack:Sprite;
			private var _shellDir:String;
			
			private var _totalBtns:int;
			
			private var _btnArray:Array;
			private var _btnClickedArray:Array;
			
			public var navBar_height:Number = 100;
			private var _showY:Number;
			private var _hideY:Number;
			
			private var _currentSlideTarget:String;
			
			
			private var _contentWidth:Number;
			
			private var _fontFamily:String;
			private var _localeID:String;
			
			public function Scene_NavBar()
			{
				super();
				_navBack = new Sprite();
				
				
			}
			
			public function build(uinode:XML, shelldir:String, contentWidth:Number = 755, fontfamily:String = "Arial", langID:String = null):void
			{
				
				_contentWidth = contentWidth;
				_fontFamily = fontfamily;
				
				_localeID = (langID != null)?langID:"en";
				//var colors:Array = [0x858585, 0xFFFfff];
				//_navBack.graphics.lineStyle(3,0x00B5D7,1,true);
				var fillColor1:String = (uinode.hasOwnProperty("@fillColor1"))?uinode.@fillColor1:"grey85";
				var fillColor2:String = (uinode.hasOwnProperty("@fillColor2"))?uinode.@fillColor2:"white";
				var frameColor:String = (uinode.hasOwnProperty("@frameColor"))?uinode.@frameColor:"ltblue";
				var fillColor1Code:uint = SHELL_COLORS.lookUpColor(fillColor1);
				var fillColor2Code:uint = SHELL_COLORS.lookUpColor(fillColor2);
				var frameColorCode:uint = SHELL_COLORS.lookUpColor(frameColor);
				
				var fontColor:String = (uinode.hasOwnProperty("@fontColor"))?uinode.@fontColor:"0x666666";
				var fontSize:Number = (uinode.hasOwnProperty("@fontSize"))?uinode.@fontSize:14;
				var pulseColor:String = (uinode.hasOwnProperty("@pulseColor"))?uinode.@pulseColor:"orange";
				
				var fontColorCode:uint = SHELL_COLORS.lookUpColor(fontColor);
			
				var pulseColorCode:uint = SHELL_COLORS.lookUpColor(pulseColor);
				
				var fillType:String = GradientType.LINEAR;
				var colors:Array = [fillColor1Code, fillColor2Code];
				var alphas:Array = [1, 1];
				var ratios:Array = [0x00, 0xFF];
				var matr:Matrix = new Matrix();
				matr.createGradientBox(_contentWidth,33,Math.PI/2,0,1);
				//matr.createGradientBox(20, 20, Math.PI/9, 0, 0);
				var spreadMethod:String = SpreadMethod.PAD;
				var interp:String = InterpolationMethod.LINEAR_RGB; 
				
				_navBack.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interp);       
				_navBack.graphics.drawRect(0,0,_contentWidth,navBar_height);
				_navBack.graphics.lineStyle(3,frameColorCode,1,true);
				_navBack.graphics.moveTo(0,0);
				_navBack.graphics.lineTo(_contentWidth,0);
				
				this.addChild(_navBack);
				
				_showY = _navBack.y;
				_hideY = _showY + _navBack.height;
				//trace("_showY= " + _showY + "  _hideY= " + _hideY);
				_navBack.y = _hideY;
				
				_shellDir = shelldir;
				_btnArray = new Array();
				_btnClickedArray = new Array();
				
				var btnW:Number = uinode.@width;
				var btnH:Number = uinode.@height;
				
				var navbXML:XMLList = uinode.*;
				
				for each (var item:XML in navbXML) 
				{ 
					var navbarbtn:Scene_NavBarBtn= new Scene_NavBarBtn();
					navbarbtn.x = item.@x;
					navbarbtn.y = item.@y;
					navbarbtn.name = item.@target;
					navbarbtn.btnTarget = item.@target;
					var nb_btnw:Number = item.@width;
					var nb_btnh:Number = item.@height;
					var ipath:String = _shellDir + SHELL_VARS.FOLDER_MEDIA+ item.@url;
					var blbl:String = item;
					navbarbtn.buildBtn(ipath,blbl,btnW,btnH,nb_btnw,nb_btnh,fontSize,fontColorCode,pulseColorCode,_fontFamily,_localeID);
					navbarbtn.addEventListener(MouseEvent.CLICK,_gpsbtn_clickhandler);
					_btnArray.push(navbarbtn);
					_navBack.addChild(navbarbtn);
					
					
				}
				_totalBtns = _btnArray.length;
				
				
			}
			
			private function _gpsbtn_clickhandler(me:MouseEvent):void
			{
				
				//var clkObject:Object = me.currentTarget;
				//var btnName:String = clkObject.name;
				
				
				var nvbtn:Scene_NavBarBtn = me.currentTarget as Scene_NavBarBtn;
				var btnName:String = nvbtn.name;
				//trace("btnName= " + btnName);
				var targetslide:String =  btnName;
				
				if (!nvbtn.btnTracked) {
					 _checkNewBtns(targetslide);
					 targetslide = nvbtn.btnTarget;
				} else {
					targetslide = nvbtn.btnTarget;
					
				}
			//	trace("targetslide =" + targetslide);;
				_currentSlideTarget = targetslide;
				var slidevent:ShellEvent = new ShellEvent(ShellEvent.SLIDE_EVENT,"loadSlide",_currentSlideTarget);
				this.dispatchEvent(slidevent);
				nvbtn.currentState = "ready";
				this.hideNavBar();
				
			}
			
			
			private function _checkNewBtns(btnName:String):void
			{
				var targetSlide:String = "none";
				
				for (var i:int = 0; i < _btnArray.length; i++) {
					var navbtn:Scene_NavBarBtn = _btnArray[i];
					if (navbtn.name == btnName) {
						_btnArray.splice(i,1);
						_btnClickedArray.push(navbtn);
						targetSlide = navbtn.btnTarget;
						break;
					}
					
				}
			//	trace("_checkNewBtns----_btnClickedArray.length" + _btnClickedArray.length);
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
				
				var cNavBtn:Scene_NavBarBtn;
			
				
				if (_btnClickedArray.length < 1){
					cNavBtn = _btnArray[0];
					cNavBtn.currentState = 'pulse';
					//var se:ShellEvent = new ShellEvent(ShellEvent.SLIDE_EVENT,"slideDone","notDone");
				//	this.dispatchEvent(se);
				//	var sce:ShellControllerEvent = new ShellControllerEvent(ShellControllerEvent.SLIDE_EVENT,"slideOut",_slideId,true);
					//this.dispatchEvent(sce);
				} else {
					for (var i:int = 0; i < _btnClickedArray.length; i++) {
						cNavBtn = _btnClickedArray[i];
						if (cNavBtn.name == _currentSlideTarget){
							cNavBtn.btnTracked = true;
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