package com.sanbeaman.shell.widget
{
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.LoaderEvent;
	import com.greensock.events.TweenEvent;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.events.ShellEvent;
	
	import com.sanbeaman.shell.widget.activity.ACTUI_HotSpotCheckBox;
	import com.sanbeaman.shell.widget.activity.ACTUI_HotSpotItem;
	import com.sanbeaman.shell.widget.activity.ACTUI_PanelBox;
	import com.sanbeaman.shell.widget.activity.Act_HotSpotCheckBox;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Mouse;
	
	import flashx.textLayout.formats.Direction;
	
	public class ACT_click2reveal extends BodyUI
	{
		
		private var _actType:String;
		
		private var _fullImgPath:String;
		
		
		private var _iLoader:ImageLoader;
		
		private var _iArea:Sprite;
		
		
		private var _backImage:Sprite;
		private var _back:Sprite;
		
		private var _shellDir:String;
		
		private var _panelBoxArray:Array;
		
		private var _actItemArray:Array;
		
		
		private var _panelLayerIN:Sprite;
		private var _panelLayerOUT:Sprite;
		
		
		private var _currentItemIndex:int;
		
		private var _maxClicks:int;
		private var _userClicks:int = 0;
		
		
		private var _actItemsArray:Array;
		private var _actX:Number;
		private var _actY:Number;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function ACT_click2reveal()
		{
			super();
		}
		
		public function buildActivity(iwidth:Number, iheight:Number, atype:String, actXML:XML, shelldir:String,fontfamily:String = "Arial", langID:String = null):void
		{
			
			this.type = "actclick2reveal";
		//	trace("actXML= " + actXML.toString());
			_shellDir = shelldir;
			_actType = atype;
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			_panelLayerIN = new Sprite();
			_panelLayerOUT = new Sprite();
			_buildACTContent(actXML);
		}
		
		private function _buildACTContent(scXML:XML):void
		{
			_actX = scXML.@x;
			_actY = scXML.@y;
			//var dragBtnsXML:XML;
			//	var dropBtnsXML:XML;
			//	var subheadXML:XML = null;
			_actItemsArray = new Array();
			var actXML:XMLList = scXML.*;
			
			this.alpha = 0;
			_back = new Sprite();
		
			this.addChild(_back);
			
			
			
			var backXML:XML = null;
			var btnsXML:XML =  null;
			var txtXML:XML = null;
			
			for each (var ui:XML in actXML)
			{
				var ut:String = ui.@type;
				var uiType:String = ut.toLowerCase();
				trace("utype= " + uiType);
				switch (uiType){
					case 'backimage':
						backXML = ui;
					//	_createBackImage(ui);
						break;
					case 'clickbtns':
						btnsXML = ui;
					//	_createClickBtns(ui);
						break;
					case 'txtboxs':
						txtXML = ui;
					//	_createTxtBoxs(ui);
						break;
					
					
				}
				
				
			}
			_buildInteractiveArea(backXML,btnsXML,txtXML);
		
			//_displayTextPanel("item0");
			
		}
		/*
		private function _buildACTItems(axml:XML):void
		{
			_back = new Sprite();
	
			var actBack:XML = axml.activity_back[0];
			_back = _buildACTback(actBack);
			
			
			var actTxtBox:XML = axml.activity_txtboxs[0];
			_buildACTtxtbox(actTxtBox);
			
			var actClickBtnXML:XML  = axml.activity_clickbtns[0];
			_buildACTClickBtns(actClickBtnXML);
			
			
			
		}
	
	*/
		
		private function _buildInteractiveArea(bckXML:XML = null,clkbtnsXML:XML = null ,txtXML:XML = null):void
		{
			var backImgHolder:Sprite = new Sprite();
			
			if (bckXML != null) {
				backImgHolder = _createBackImage(bckXML);
			} 
			_back.addChild(backImgHolder);
			
			//_iArea = new Sprite();
			if (clkbtnsXML != null) {
				_iArea = _createClickBtns(clkbtnsXML);
				this.addChild(_iArea);
				
			}
			if (txtXML != null) {
				_createTxtBoxs(txtXML);
			}
			
			

		}
		
		private function _startActivity():void
		{
			_displayTextPanel("item0");
			
		}
		private function _createClickBtns(ixml:XML):Sprite
		{
		
			var iarea:Sprite = new Sprite();
			
			var uip:UIparams = new UIparams();
			uip.uiPadding = ixml.@padding;
	
			uip.uiFontSize = ixml.@fontSize;
			uip.uiFontColor = ixml.@fontColor;
			
			uip.uiFillColor= ixml.@fillColor;
			uip.uiFillAlpha = ixml.@fillAlpha;
			
			uip.uiFrameColor = ixml.@frameColor;
			uip.uiFrameAlpha = ixml.@frameAlpha;
			uip.uiFrameSize = ixml.@frameSize;
		 	
			/**
			iconType="bitmap"
			iconShape="square" 
			iconWidth="28" 
			iconHeight="26" 
			iconFrameSize="1" 
			iconFrameColor="black" 
			iconFrameAlpha="0" 
			iconReady="icons/hsicon_ready.png" 
			iconUncheck="icons/hsicon_unchecked.png" 
			iconCheck="icons/hsicon_checked.png"
				*** */
			
			
			var iconType:String = ixml.@iconType;
			var iconShape:String=ixml.@iconShape;
			var iconWidth:Number=ixml.@iconWidth;
			var iconHeight:Number=ixml.@iconHeight;
			var iconFrameSize:Number=ixml.@iconFrameSize;
			var iconFrameColor:String=ixml.@iconFrameColor;
			var iconFrameAlpha:Number=ixml.@iconFrameAlpha;
			var iconReady:String=ixml.@iconReady;
			var iconUncheck:String=ixml.@iconUncheck;
			var iconCheck:String=ixml.@iconCheck;
				
				
				
			var shapePoints:String;// = ixml.@shape;
			//var shapeBox:Sprite;
			var shapePointArray:Array;
			
			//Highlight Color for active State
			
			var HLcolor:String = ixml.@fillColor2;
		//	var actHSBtn:ACTUI_HotSpotItem;
			var actHSBtn:ACTUI_HotSpotItem;
			
			_actItemArray = new Array();
			
			var hsbindex:int = 0;
			_maxClicks = 0;
			var hscb:ACTUI_HotSpotCheckBox;
			
			for each (var child:XML in ixml.*) {
				var id:String = child.@id;
				var iX:Number = child.@x;
				var iY:Number = child.@y;
				var lbl:String = child;
				
				uip.uiWidth = child.@width;
				uip.uiHeight = child.@height;
				
				//uip.uiRotation = child.@rotation;
				trace("id-> " + id + "--" + iX + "--" + iY + "--" + lbl);
				//shapePoints = child.@shape;
				
				hscb = new ACTUI_HotSpotCheckBox();
				hscb.build(iconType,iconShape,
					iconWidth,iconHeight,
					iconFrameSize,iconFrameColor,iconFrameAlpha,
					iconReady,iconUncheck,iconCheck,_shellDir );
				
			
				actHSBtn = new ACTUI_HotSpotItem();
				actHSBtn.init(lbl,shapePoints,uip,hscb,HLcolor);
				actHSBtn.x = iX;// child.@x;
				actHSBtn.y = iY;//child.@y;
				iarea.addChild(actHSBtn);
				actHSBtn.sindex = hsbindex;
				actHSBtn.itemID = id;
				_actItemArray.push(actHSBtn);
				hsbindex++;
				_maxClicks++;
				
			}
			
			trace("_maxClicks= " + _maxClicks);
			return iarea;
			
		}
		
		
		private function _createTxtBoxs(ixml:XML):void
		{
			
			_iArea.addChild(_panelLayerOUT);
			_iArea.addChild(_panelLayerIN);
			var uip:UIparams = new UIparams();
			
			
			uip.uiFontSize = ixml.@fontSize;
			uip.uiFontColor = ixml.@fontColor;
			
			uip.uiFontHAlign = (ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:"center";
			
			uip.uiFillColor= ixml.@fillColor;
			uip.uiFillAlpha = ixml.@fillAlpha;
			
			uip.uiFrameColor = ixml.@frameColor;
			uip.uiFrameAlpha = ixml.@frameAlpha;
			uip.uiFrameSize = ixml.@frameSize;
			
			uip.uiX =  ixml.@x;
		
			uip.uiY = ixml.@y;
			uip.uiWidth = ixml.@width;
			uip.uiHeight= ixml.@height;
				
			uip.uiPadX = ixml.@xPad;
			uip.uiPadY = ixml.@yPad;
				
			_panelBoxArray = new Array();
			var pbindex:int = 0;
			for each (var child:XML in ixml.*) {
					
					var pbox:ACTUI_PanelBox = new ACTUI_PanelBox();
					
					pbox.init(child,uip,_fontFamily,_localeID);
					pbox.sID = child.@id;
					
				//	tb.init(child,afbW,afbH,aFrameSize,aFrameColorCode,aFillColorCode,aFillAlpha,aFontSize,aFontColorCode,aPadding);
				//	tb.init(child,afbW,afbH,4,0xffffff,0xffffff,0.5,18,SHELL_COLORS.CLR_DKGREY,10);
					
					pbox.endX = uip.uiX;
					pbox.endY = uip.uiY;
					
					//pbox.x = uip.uiX;
					//pbox.y = uip.uiY;
					pbox.sIndex = pbindex;
					
					_panelBoxArray.push(pbox);
					pbindex++;
					//	_feedbackBox.visible = false;
					//	this.addChild(_feedbackBox);
					
				}
			
				//this.addChild(_txtBoxArray[0]);
				
				
			
		}
		private function _createBackImage(ixml:XML):Sprite
		{
			
			_backImage = new Sprite();
			
			for each (var child:XML in ixml.*) {
				if (child.@type == 'image') {
					var imgpath:String = _shellDir + SHELL_VARS.FOLDER_MEDIA+child.@url;
					_iLoader = new ImageLoader(imgpath, {container:_backImage, onComplete:_imgLoadComplete_handler});
					_iLoader.load();
				} else {
					trace('no type= ' + child.@type);
				}
			}
			
			return _backImage;
		//	_back.addChild(_backImage);
		
			
		}
		
		private function _displayTextPanel(uID:String):void
		{
			//_currentItemIndex = hspIndex;
			var tl:TimelineMax = new TimelineMax({paused:true,onComplete:_panelTL_handler,onCompleteParams:[1,uID]});
			var inMC:ACTUI_PanelBox;
			for (var j:int = 0; j< _panelBoxArray.length; j++){
				var pbx:ACTUI_PanelBox = _panelBoxArray[j];
				if (pbx.sID == uID){
					inMC = pbx;
					break;
				}
			}
			
		//	inMC = _panelBoxArray[hspIndex];
			inMC.alpha = 0;
			var _xOffScreen:Number = inMC.endX + inMC.width + 10;
			inMC.x = _xOffScreen;
			inMC.y = inMC.endY;
			
			if (_panelLayerOUT.numChildren > 0) {
				
				_panelLayerOUT.removeChildAt(0);
			}
			if (_panelLayerIN.numChildren >0) {
				_panelLayerOUT.addChild(_panelLayerIN.getChildAt(0));
				_panelLayerIN.addChild(inMC);
				tl.append(TweenMax.to(_panelLayerOUT.getChildAt(0),0.5,{x:_xOffScreen,alpha:0}));
				tl.append(TweenMax.to(inMC,0.5,{x:inMC.endX,alpha:1,ease:Back.easeOut}));
			} else {
				_panelLayerIN.addChild(inMC);
				tl.append(TweenMax.to(inMC,1,{x:inMC.endX,alpha:1,ease:Back.easeOut}));
			}
			tl.play();
		}
		
		private function _panelTL_handler(param1:int,param2:String):void
		{
			var cindex:int = param1;
			var currentID:String = param2;
			//var clkBtn:ACTUI_HotSpotItem;
			for (var k:int = 0; k< _actItemArray.length; k++){
				var cb:ACTUI_HotSpotItem = _actItemArray[k];
				if (cb.itemID == currentID) {
					if (cb.isChecked == false) {
						cb.isChecked = true;
						_userClicks++;
					}
					
					break;
				}
				
			}
			_activateClickBtns("pulse",currentID);
			_checkClicks();
		}
		
		
		private function _checkClicks():void
		{
			if (_userClicks >= _maxClicks) {
				_triggerActivtyComplete();
			}
		}
		private function _activateClickBtns(iStatus:String, itemID:String = "none"):void
		{
			
			var clkBtn:ACTUI_HotSpotItem;
			for (var i:int = 0; i < _actItemArray.length; i++){
					clkBtn = _actItemArray[i] as ACTUI_HotSpotItem;
					
					if (iStatus == 'pulse') {
						clkBtn.enabled = true;
						clkBtn.addEventListener(MouseEvent.CLICK, _clkBtn_handler);
						if (clkBtn.itemID == itemID) {
							clkBtn.removeEventListener(MouseEvent.CLICK, _clkBtn_handler);
							clkBtn.enabled = false;
							clkBtn.isActive = true;
							clkBtn.itemStatus = "active";
						} else {
							clkBtn.isActive = false;
							clkBtn.itemStatus = "pulse";
						}
					} else if (iStatus == 'hold') {
						clkBtn.removeEventListener(MouseEvent.CLICK, _clkBtn_handler);
						clkBtn.enabled = false;
						if (clkBtn.itemID == itemID) {
							clkBtn.itemStatus = "active";
							clkBtn.isActive = false;
						} else {
							clkBtn.isActive = false;
							clkBtn.itemStatus = "hold";
						}
					} else {
						trace("what iStatus is this===" + iStatus);
					}

				}
		}
		
		private function _clkBtn_handler(me:MouseEvent):void
		{
			var clkBtn:ACTUI_HotSpotItem = me.currentTarget as ACTUI_HotSpotItem;
		
			
			var inx:int = clkBtn.sindex;
			var cid:String = clkBtn.itemID;
			_activateClickBtns("hold",cid);
			trace("itemId= " + cid + "  -- sindex= " + inx);
			//clkBtn.removeEventListener(MouseEvent.CLICK,_clkBtn_handler);
		//	clkBtn.itemStatus = "active";
			//_currentItemIndex = inx;
			_displayTextPanel(cid);
			
			
		}
		
		private function _triggerActivtyComplete():void
		{
			var ae:ShellEvent = new ShellEvent(ShellEvent.ACT_EVENT, 'actDone');
			this.dispatchEvent(ae);
			
		}
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			if (this.alpha == 0) {
			var tweenAct:TweenMax = TweenMax.to(this,0.5,{alpha:1,onComplete:_startActivity});
			} else {
				_startActivity();
			}
			trace("imageloadd");
			
		//	this.addChild(_back);
		}
	}
}