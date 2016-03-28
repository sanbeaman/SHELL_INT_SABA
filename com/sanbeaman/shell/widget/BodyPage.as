package com.sanbeaman.shell.widget
{
	
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.sanbeaman.shell.events.PageEvent;
	
	import flash.text.TextFieldAutoSize;
	
	import fl.transitions.Tween;
	
	import flashx.textLayout.formats.Direction;
	
	public class BodyPage extends BodyUI
	{
		private var _originX:Number;
		private var _offscreenX:Number;
		
		private var _pageAnim_in:TimelineMax;
		private var _itemsArray:Array;
		private var _tweenArray:Array;
		
		private var _pageTL:TimelineMax;
		private var _localeID:String;
		
		public function BodyPage()
		{
			super();
			
		}


		public function buildBodyPage(itemarray:Array, langID:String = null):void
		{
			//_itemsArray = new Array();
			_itemsArray = itemarray;
			
			
			_localeID = (langID != null)?langID:"en";
			
			
		//	_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
		//	_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			_tweenArray = new Array();
			_pageTL = new TimelineMax({paused:true,onComplete:_pageOpen,onReverseComplete:_pageClosed});
			for (var i:int = 0; i < _itemsArray.length; i++) {
				
				var bdy:BodyUI = _itemsArray[i] as BodyUI;
			//	trace('bodyUI =' + bdy.id);
			//	bdy.alpha = 0;
			//	bdy.x = -900;
				this.addChild(bdy);
				var tw:TweenMax;
				if (_localeID == "ar"){
					tw = TweenMax.from(bdy,1,{x:"+300",autoAlpha:0});
				} else {
					tw = TweenMax.from(bdy,1,{x:"-300",autoAlpha:0});
				}
				_tweenArray.push(tw);
			//	_pageTL.add(tw,0);
				
			}
			_pageTL.add(_tweenArray,0,"start",0.5);
			//_pageTL.add(_tweenArray,0,"start",0);
			
			//_pageAnim_in = new TimelineMax({paused:true,onComplete:_pageOpen});
			//_pageAnim_in.appendMultiple(_itemsArray,.2);
		//	var twin:TweenLite = TweenLite.from(bbull,.4,{x:-900});
		}
		public function animatePageStart():void
		{
			//_pageOpen();
			trace('pageSTART');
			_pageTL.play();
			
		}
		public function animatePageIN():void
		{
			//_pageOpen();
			trace('pageIN');
			_pageTL.restart();
			
		}
		public function animatePageOUT():void
		{
			//_pageClosed();
			trace('pageOUT');
			_pageTL.reverse();
			
		}
		//you build these functions into your objects (classes, MovieClips, whatever):
		public function animateIn():TimelineLite {
			var tl:TimelineLite = new TimelineLite({onComplete:_pageOpen});
			tl.add(_tweenArray,0,"start",0);
			
			for (var i:int = 0; i< _itemsArray.length ; i++) {
				var bdy:BodyUI = _itemsArray[i] as BodyUI;
				tl.append(TweenMax.to(bdy,.5,{x:0,alpha:1}));
			}
			return tl;
		
		}
		//you build these functions into your objects (classes, MovieClips, whatever):
		public function animateOut():TimelineLite {
			var tl:TimelineLite = new TimelineLite({onComplete:_pageClosed});
			
			if (_localeID == "ar"){
				tl.appendMultiple(TweenMax.allTo(_itemsArray,.4,{x:900,alpha:0},.1));
			} else {
				tl.appendMultiple(TweenMax.allTo(_itemsArray,.4,{x:-900,alpha:0},.1));
			}
			
		
			
			//for (var i:int = 0; i< _itemsArray.length ; i++) {
			//	var bdy:BodyUI = _itemsArray[i] as BodyUI;
				//tl.append(TweenMax.to(bdy,.5,{x:-900,alpha:0}));
			//}
			return tl;
			
		}
		
		/*
		//you build these functions into your objects (classes, MovieClips, whatever):
		public function animateIn():void {
			_pageAnim_in.play();
			
		}
		
		public function animateOut():void {
			_pageAnim_in.reverse();
		
		}
		*/
		private function _pageOpen():void
		{
			var pgEvt:PageEvent = new PageEvent(PageEvent.PAGE_OPEN);
			
			this.dispatchEvent(pgEvt);
			
		}
		
		private function _pageClosed():void
		{
			trace('_pageClosed');
			var pgEvt:PageEvent = new PageEvent(PageEvent.PAGE_CLOSED);
			
			this.dispatchEvent(pgEvt);
		}

	}
}