package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.events.PageEvent;
	import com.sanbeaman.shell.utils.SimpleUtils;
	import com.sanbeaman.shell.widget.BodyButton;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.formats.Direction;
	
	public class BodyPages extends BodyUI
	{
		private var _localeID:String;
	
		private var _fontFamily:String;
		
		private var _fullTL:TimelineMax;
		private var _pgXML:XMLList;
		private var _pagesArray:Array;
		
		private var _pageX:Number;
		private var _pageY:Number;
		private var _groupX:String;
		private var _groupY:String;
		
		private var _syncType:String;
		
		private var _pageArea_width:Number;
		private var _pageArea_height:Number;
		
		private var _pagesTL:TimelineMax;
		private var _pageIndex:int;
		
		private var _cPageIndex:int;
		private var _cPage:BodyPage;
		
		private var _nextPage_btn:BodyButton;
		private var _prevPage_btn:BodyButton;
		
		private var _addedPrevBtn:Boolean = false;
		private var _finalPageIndex:int;
		
		private var _pagesComplete:Boolean = false;
		
		private var _layoutModifier:String;
		
		public function BodyPages()
		{
			super();
			
			
		}
		
		public function buildPages(pgsXML:XML, fontfamily:String = "Arial", langID:String = null):void
		{
			//_pagesTL = new TimelineMax({paused:true,onComplete:_pagesComplete});
			/*_nextArrow = new Sprite();
			_nextArrow.graphics.beginFill(0xff0000,1);
			_nextArrow.graphics.drawRect(0,0,30,30);
			_nextArrow.graphics.endFill();
			
			_prevArrow = new Sprite();
			_prevArrow.graphics.beginFill(0x00ff00,1);
			_prevArrow.graphics.drawRect(0,0,30,30);
			_prevArrow.graphics.endFill();
			*/
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_layoutModifier = (_localeID == "ar")?"flipx":"none";
			_groupX = (pgsXML.hasOwnProperty("@x"))?pgsXML.@x:"0";
			_groupY = (pgsXML.hasOwnProperty("@y"))?pgsXML.@y:"0";
			
			_syncType = (pgsXML.hasOwnProperty("@syncType"))?pgsXML.@syncType:"buildy";
			
			_pageArea_width = pgsXML.@width;
			_pageArea_height = pgsXML.@height;
		
			this.graphics.beginFill(0xffffff,.1);
			this.graphics.drawRect(0,0,_pageArea_width,_pageArea_height);
			this.graphics.endFill();
			
			_pgXML = pgsXML.*;
			_pagesArray = new Array();
			_pageIndex = 0;
			trace('_pgXML =' + _pgXML.toString());
			for each (var page:XML in _pgXML)
			{
				
				//var ypad:Number = page.@yPad;
				var pg:BodyPage = _buildPage(page);
				pg.id = page.@id;
				//pg.x = -900;
				this.addChild(pg);
				_pagesArray.push(pg);
				//_pageIndex++;
			}
			/*
			_prevArrow.x = 600;
			_prevArrow.y = 250;
			_nextArrow.x = 650;
			_nextArrow.y = 250;
			
			
			this.addChild(_prevArrow);
			this.addChild(_nextArrow);
			_prevArrow.visible = false;
			_nextArrow.visible = false;
			*/
			
			_finalPageIndex = _pagesArray.length -1;
			trace('_finalPageIndex= '+ _finalPageIndex + '_pageIndex='+ _pageIndex);
			
		}
		
		private function _buildPage(pXML:XML):BodyPage
		{
			
			
			var xholder:Number;
			var yholder:Number; 
			
			if (_syncType == "buildy"){
				yholder = 0;
			}
		
			
			var uypad:Number = pXML.@yPad;
			//var itemXML:XMLList = page.item;
			var padeItemIndex:int = 0;
			var bodyPg:BodyPage = new BodyPage();
			var itemarray:Array = new Array();
			
			
			var upulsecolor:String =(pXML.hasOwnProperty("@pulseColor"))?pXML.@pulseColor:"orange";
			
			for each (var item:XML in pXML.*) {
				
				var itype0:String = item.@type;
				var itype:String = itype0.toLowerCase();
				
				var itemid:String = item.@id;
				var iw:Number = item.@width;
				var ih:Number = (item.hasOwnProperty("@height"))? item.@height : 0;
				var iFsize:Number = item.@fontSize;
				var iFontColor:String = (item.hasOwnProperty("@fontColor"))? item.@fontColor : "default";
				var ipulsecolor:String;
				
				var iypad:Number = (item.hasOwnProperty("@yPad"))? item.@yPad : uypad;
				
				if (itype == 'bodybullet'){
					
					
					var bbull:BodyBullet = new BodyBullet();
					bbull.init(item,iw,"normal",iFsize,iFontColor,_fontFamily,_localeID);
					bbull.id = itemid;
					bbull.order = padeItemIndex;
					bbull.time = 1;
					
					padeItemIndex++;
					var relativeX:Number = (!isNaN(Number(_groupX)))?Number(_groupX):SimpleUtils.relativeLayoutConverter(_groupX,_pageArea_width,iw,0,_layoutModifier);
					//	bc.init(bcid,1,1,bb,500,"normal",bbfsize);
					bbull.x = relativeX;
					bbull.y = yholder + iypad;
					yholder = bbull.y + int(bbull.height) 
					//bodyPg.addChild(bbull);
				
					itemarray.push(bbull);
				} else if (itype == 'btnnextpage'){
					var nxtuip:UIparams = new UIparams();
					nxtuip.uiWidth = iw;
					nxtuip.uiHeight = ih;
					nxtuip.uiFontSize = iFsize;
					nxtuip.uiFontColor = iFontColor;
					
					ipulsecolor = (item.hasOwnProperty("@pulseColor"))?item.@pulseColor:upulsecolor;
				//	var bdyBTN:BodyButton = new BodyButton();
					//bdyBTN.init(item,uip,ipulsecolor);
					_nextPage_btn = new BodyButton();;
					_nextPage_btn.init(item,nxtuip,ipulsecolor);
					_nextPage_btn.x = _pageArea_width - nxtuip.uiWidth;
					_nextPage_btn.y = yholder + iypad;//_pageArea_height - int( ih + ypad);
					
					
					_nextPage_btn.isEnabled = true;
					_nextPage_btn.buttonMode = true;
					_nextPage_btn.useHandCursor = true;
					_nextPage_btn.mouseChildren = false;
					_nextPage_btn.addEventListener(MouseEvent.CLICK,_nextPage);
					itemarray.push(_nextPage_btn);
				//	_nextPage_btn.visible = false;
				//	this.addChild(_nextPage_btn);
					
					
					
				} else if (itype == 'btnprevpage'){
					var prvuip:UIparams = new UIparams();
					prvuip.uiWidth = iw;
					prvuip.uiHeight = ih;
					prvuip.uiFontSize = iFsize;
					prvuip.uiFontColor = iFontColor;
					ipulsecolor = (item.hasOwnProperty("@pulseColor"))?item.@pulseColor:upulsecolor;
					//var bdyBTN:BodyButton = new BodyButton();
					//_prevPage_btn = new BTN_ACTMain();
					//_prevPage_btn.buildButtonStates(item,prvuip);
					
					_prevPage_btn =  new BodyButton();
					_prevPage_btn.init(item,prvuip,ipulsecolor);
					_prevPage_btn.x = item.@x;
					_prevPage_btn.y =yholder + iypad;// _pageArea_height - int( ih + ypad);
					
					_prevPage_btn.isEnabled = true;
					_prevPage_btn.buttonMode = true;
					_prevPage_btn.useHandCursor = true;
					_prevPage_btn.mouseChildren = false;
					_prevPage_btn.addEventListener(MouseEvent.CLICK,_prevPage);
					
					//_prevPage_btn.visible = false;
				//	this.addChild(_prevPage_btn);
					itemarray.push(_prevPage_btn);
					_addedPrevBtn = true;
					
				}
			
				
			}
			bodyPg.buildBodyPage(itemarray,_localeID);
			return bodyPg;
			
		}
		public function startPages():void
		{
			var pgsevt:PageEvent = new PageEvent(PageEvent.PAGES_START);
			this.dispatchEvent(pgsevt);
			
			_openPage(0);
		}
		
		private function _openPage(pgindex:int):void
		{
			_cPageIndex = pgindex;
			
			_cPage = _pagesArray[_cPageIndex];
			_cPage.addEventListener(PageEvent.PAGE_OPEN,_pageOpen_handler);
			_cPage.animatePageStart();
			//_cPage.animatePageSTART();
		//	_cPage.animateIn();
			
		}
		private function _pageOpen_handler(evt:PageEvent):void
		{
			trace('_pageOpen_handler');
			_cPage.removeEventListener(PageEvent.PAGE_OPEN,_pageOpen_handler);
			_whichPageIndex(_cPageIndex);
			if (_cPageIndex >= _finalPageIndex) {
				_completePages();
			}
			/*
			if(!_nextPage_btn.visible){
				if(_cPageIndex < _finalPageIndex){
				_nextPage_btn.visible = true;
				_nextPage_btn.isEnabled = true;
				_nextPage_btn.addEventListener(MouseEvent.CLICK,_nextPage);
				}
				
			} 
			
			if (_addedPrevBtn){
				_prevBtnActivator();
			}
			*/
		
			
		}
		private function _completePages():void
		{
			if (!_pagesComplete) {
				trace("_completePages");
				var pgsevt:PageEvent = new PageEvent(PageEvent.PAGES_COMPLETE);
				this.dispatchEvent(pgsevt);
				_pagesComplete = true;
			}

		}
		/*
		private function _prevBtnActivator():void
		{
			if(!_prevPage_btn.visible){
				if (_cPageIndex > 0){
					_prevPage_btn.visible = true;
					_prevPage_btn.isEnabled = true;
					_prevPage_btn.addEventListener(MouseEvent.CLICK,_prevPage);
				}
				
			}
			
			
			
		}
		
		*/
		private function _prevPage(evt:MouseEvent):void
		{
			//_prevPage_btn.removeEventListener(MouseEvent.CLICK,_prevPage);
			//_prevPage_btn.visible = false;
			_cPage.addEventListener(PageEvent.PAGE_CLOSED,_pageClosedPREV_handler);
			_cPage.animatePageOUT()
		//	_cPage.animateOut();
			
			
		}
		private function _pageClosedPREV_handler(evt:PageEvent):void
		{
			//_cPage.removeEventListener(PageEvent.PAGE_CLOSED,_pageClosedPREV_handler);
			_cPageIndex = _cPageIndex - 1;
			if (_cPageIndex < 0){
				_cPageIndex = 0;
			}
			_whichPageIndex(_cPageIndex);
			_cPage = _pagesArray[_cPageIndex];
			_cPage.addEventListener(PageEvent.PAGE_OPEN,_pageOpen_handler);
			_cPage.animatePageIN();
			//_cPage.animateIn();
			
		}
		
		private function _whichPageIndex(pi:int):void
		{
			trace('currentpageIndex=' + pi);
		}
		private function _nextPage(evt:MouseEvent):void
		{
			//_nextPage_btn.removeEventListener(MouseEvent.CLICK,_nextPage);
		//	_nextPage_btn.visible = false;
			_cPage.addEventListener(PageEvent.PAGE_CLOSED,_pageClosedNEXT_handler);
			_cPage.animatePageOUT();
			//_cPage.animateOut();
			
			
		}
		private function _pageClosedNEXT_handler(evt:PageEvent):void
		{
		//	_cPage.removeEventListener(PageEvent.PAGE_CLOSED,_pageClosedNEXT_handler);
			_cPageIndex = _cPageIndex + 1;
			if (_cPageIndex >= _pagesArray.length){
				_cPageIndex =  _pagesArray.length -1;
			}
			_whichPageIndex(_cPageIndex);
			_cPage = _pagesArray[_cPageIndex];
			_cPage.addEventListener(PageEvent.PAGE_OPEN,_pageOpen_handler);
			_cPage.animatePageIN();
		//	_cPage.animateIn();
			
		}
		
		

	}
}