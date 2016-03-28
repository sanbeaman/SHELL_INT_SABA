package com.sanbeaman.shell.widget
{
	//import com.sanbeaman.shell.widget.activity.ACTUI_ChoiceBox;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.sanbeaman.shell.data.TextBoxObject;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.events.ShellEvent;
	import com.sanbeaman.shell.utils.SimpleUtils;
	import com.sanbeaman.shell.widget.activity.ACTUI_Btn;
	import com.sanbeaman.shell.widget.activity.ACTUI_ChoiceBox;
	import com.sanbeaman.shell.widget.activity.ACTUI_ChoiceItem;
	import com.sanbeaman.shell.widget.activity.ACTUI_FeedBackBox;
	import com.sanbeaman.shell.widget.activity.ACTUI_ScreenText;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.formats.Direction;

	

	
	public class ACT_multipleChoice extends BodyUI
	{
		
		private var _actType:String;
		private var _actXML:XMLList;
		
		private var _actWidth:Number;
		private var _actHeight:Number;
		
		
		private var _dragMCarray:Array;
		private var _dropMCarray:Array;
		
		private var _startX:Number;
		private var _startY:Number;
		
	//	private var _feedbackBox:ACT_FeedBackBox;
		
		//public var ansCorrect:AnswerCorrect; 
		//public var ansWrong:AnswerWrong; 
		
		private var _shellDir:String;
		
		
		private var _itemArray:Array;
		
		private var _actItemsArray:Array;
		
		private var _print_btn:BodyButton;
		private var _submit_btn:BodyButton;
	//	private var _submit_btn:BTN_ACTMain;
		
		private var _feedbackArray:Array;
		
		private var _feedbackY:Number;
		
		private var _margin:Number;
		//private var _padding:Number;
		
		private var _itemType:String;
		
		
		private var _currentSelectedItem:ACTUI_ChoiceItem;
		
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		private var _txtObject:TextBoxObject;
		private var _localeID:String;
		private var _layoutModifier:String;
		
		public function ACT_multipleChoice()
		{
			super();
			this.contentReady = false;
			_startX = 0;
			_startY = 0;
		}
		
		
		public function buildActivity(actwidth:Number, actheight:Number, atype:String, actXML:XML, shellDir:String,txtObject:TextBoxObject = null, fontfamily:String = "Arial",langID:String = null):void
		{
	
			_actWidth = actwidth;
			_actHeight = actheight;
			_shellDir = shellDir;
			_actType = atype;
			//_actXML = actXML.*;
			//	trace("_actXML " + _actXML.toString);
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtObject = txtObject;
			//_localeID = txtObject.box_langid;
			_layoutModifier = (_localeID == "ar")?"flipx":"none";
			
			//_localeID = (langID != null)?langID:"en";
			
		
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			_buildACTContent(actXML);
		}
		
		private function _buildACTContent(scXML:XML):void
		{
			//_uiAnimObjects = new Dictionary();
			//_slideContent = new MovieClip();
			var contentType:String = scXML.@type;
			var endType:String = scXML.@endType;
			_margin = (scXML.hasOwnProperty("@margin"))?scXML.@margin:0;
			var uxpad:Number = (scXML.hasOwnProperty("@xPad"))?scXML.@xPad:0;
			var uypad:Number  = (scXML.hasOwnProperty("@yPad"))?scXML.@yPad:0;
			//_padding = scXML.@padding;
			_actItemsArray = new Array();
			var actXML:XMLList = scXML.*;
			for each (var ui:XML in actXML)
			{
				var ut:String = ui.@type;
				var uiType:String = ut.toLowerCase();
			//	trace("utype= " + uiType);
				switch (uiType){
					case 'screentext':
						_actItemsArray.push(_createScreenText(ui));
						break;
					case 'questiontext':
					//	_createACTtext(ui);
						break;
					case 'actheaders':
					//	_createACTheaders(ui);
						break;
					case 'cboxes':
						_actItemsArray.push(_createACTItems(ui));
						break;
					case 'actbtns':
						_actItemsArray.push(_createACTBtns(ui));
						break;
					case 'feedbacktext':
						_createACTfeedback(ui);
						break;
					
				}
				
			}
			var yHolder:Number;// = _startY;
			var xHolder:Number;// = _startX;
			
			//var ypad:Number =_padding;// 10;
			
			for (var i:int = 0; i < _actItemsArray.length; i++) {
				var actitem:Sprite = _actItemsArray[i];
				if (_localeID == "ar"){
					
					xHolder = _actWidth - actitem.width;
					trace('xHOLDER: '+ xHolder +' _actWidth=' + _actWidth + ' actitem.width='+ actitem.width)
				} else {
					trace('actitem.name: '+actitem.name);
					xHolder = _startX;
				}
				actitem.x = xHolder;
				actitem.y = yHolder;
				this.addChild(actitem);
				
				//if(actitem.name == 'submitbtn'){
				//	_feedbackY = yHolder;
			//	}
				yHolder =  actitem.y + actitem.height + uypad;
			}
			
			this.contentReady = true;
		}
	
		private function _createScreenText(ixml:XML):BodyUI
		{
			var bdyui:BodyUI = new BodyUI();
			bdyui.layout = 'relative';
			bdyui.name = "screentext";
			
			var uiAreaW:Number= (ixml.hasOwnProperty("@width"))?ixml.@width:_actWidth;
			var uiAreaH:Number= (ixml.hasOwnProperty("@height"))?ixml.@height:0;
			
			
			var groupX:String = (ixml.hasOwnProperty("@x"))?ixml.@x:"0";
			var groupY:String = (ixml.hasOwnProperty("@y"))?ixml.@y:"0";
			var uMargin:Number = (ixml.hasOwnProperty("@margin"))?ixml.@margin:0;
			
			var syncType:String = (ixml.hasOwnProperty("@syncType"))?ixml.@syncType:"buildy";
			
			var fontname:String = (ixml.hasOwnProperty("@fontName"))?ixml.@fontName:_fontFamily;
			
			var fontsize:Number = (ixml.hasOwnProperty("@fontSize"))?ixml.@fontSize:18;
			var fontcolor:String = (ixml.hasOwnProperty("@fontColor"))?ixml.@fontColor:_txtObject.box_fontColor;
			var fontstyle:String =(ixml.hasOwnProperty("@fontStyle"))?ixml.@fontStyle:_txtObject.box_fontStyle;//"reg";
			var fontalign:String =(ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:_txtObject.box_fontAlign;//"left";
			
			var uxpad:Number = (ixml.hasOwnProperty("@xPad"))?ixml.@xPad:0;
			var uypad:Number = (ixml.hasOwnProperty("@yPad"))?ixml.@yPad:0;
			
			
		//	var uX:Number = (ixml.hasOwnProperty("@x"))?ixml.@x:0;
		//	var uY:Number = (ixml.hasOwnProperty("@y"))?ixml.@y:0;
			
		//	var areaW:Number = _actWidth;
		//	var areaH:Number = _actHeight;
			
			//var uW:Number = (ixml.hasOwnProperty("@width"))?ixml.@width:_actWidth;
			//var uH:Number = (ixml.hasOwnProperty("@height"))?ixml.@height:_actHeight;
			
			//var holderX:Number = uX;
			//var holderY:Number = uY;
			
			
			//var holderX:Number = (!isNaN(Number(groupX)))?Number(groupX):SimpleUtils.relativeLayoutConverter(groupX,_actWidth,uW,uMargin);;
			//var holderY:Number = (!isNaN(Number(groupY)))?Number(groupY):SimpleUtils.relativeLayoutConverter(groupY,_actHeight,uH,uMargin);
			
			var holderX:Number = 0;//(!isNaN(Number(groupX)))?Number(groupX):SimpleUtils.relativeLayoutConverter(groupX,_actWidth,uW,uMargin);;
			var holderY:Number = 0;//(!isNaN(Number(groupY)))?Number(groupY):SimpleUtils.relativeLayoutConverter(groupY,_actHeight,uH,uMargin);
			
			for each (var child:XML in ixml.*) {
				
				var stxt:String = child;
				var xpad:Number = (child.hasOwnProperty("@xPad"))?child.@xPad:uxpad;
				var ypad:Number = (child.hasOwnProperty("@yPad"))?child.@yPad:uypad;
				var iX:String = (child.hasOwnProperty("@x"))?child.@x:"0";
				var iY:String = (child.hasOwnProperty("@y"))?child.@y:"0";
				
				var iW:Number = (child.hasOwnProperty("@width"))?child.@width:uiAreaW;
				var iH:Number = (child.hasOwnProperty("@height"))?child.@height:uiAreaH;
				var fsize:Number = (child.hasOwnProperty("@fontSize"))?child.@fontSize:fontsize;
				var fcolor:String = (child.hasOwnProperty("@fontColor"))?child.@fontColor:fontcolor;
				var fstyle:String =(child.hasOwnProperty("@fontStyle"))?child.@fontStyle:fontstyle;
				var falign:String =(child.hasOwnProperty("@fontAlign"))?child.@fontAlign:fontalign;
				
				var screenText:ACTUI_ScreenText = new ACTUI_ScreenText();
				screenText.addText(stxt,iW,fsize,fcolor,falign,fstyle,fontname,_localeID);
				
				var newX:Number;
				var newY:Number;
				
				var newW:Number = screenText.width; 
				var newH:Number = screenText.height; 
				if (syncType == 'buildy'){
					
					newX = (!isNaN(Number(iX)))?Number(iX):SimpleUtils.relativeLayoutConverter(iX,uiAreaW,newW,uMargin, _layoutModifier);
					newY = holderY + ypad;
					holderY = newY + screenText.txtHeight;
					uiAreaH = holderY;
				} else {
				//	var ix:String = (child.hasOwnProperty("@x")) ? child.@x : "0";
					//var iy:String = (child.hasOwnProperty("@y")) ? child.@y : groupY;
					
					//newX = (!isNaN(Number(ix)))?Number(groupX):SimpleUtils.relativeLayoutConverter(groupX,areaW,uPadding);;
					//newY  = (!isNaN(Number(groupY)))?Number(groupY):SimpleUtils.relativeLayoutConverter(groupY,areaH,uPadding);
					newX = (!isNaN(Number(iX)))?Number(iX):SimpleUtils.relativeLayoutConverter(iX,uiAreaW,newW,uMargin, _layoutModifier);
					newY = (!isNaN(Number(iY)))?Number(iY):SimpleUtils.relativeLayoutConverter(iY,uiAreaH,newH,uMargin);
				//	newX = (!isNaN(Number(ix)))?Number(ix):SimpleUtils.relativeLayoutConverter(ix,_actWidth,iW,uMargin);
				//	newY = (!isNaN(Number(iy)))?Number(iy):SimpleUtils.relativeLayoutConverter(iy,_actHeight,iH,uMargin);
					uiAreaH = newY + newH;
				}
				trace('screentext newX='+ newX + ' newY= ' + newY);
				
				screenText.x = newX;
				screenText.y = newY;
				//this.addChild(txt);
				screenText.mouseEnabled = false;
				screenText.mouseChildren = false;
				bdyui.addChild(screenText);
				
				//startY+= screenText.height + ypad;
				
			}
			
			
			bdyui.graphics.beginFill(0xffffff,0);
			bdyui.graphics.drawRect(0,0,uiAreaW,uiAreaH);
			bdyui.graphics.endFill();
			
			
			return bdyui;
			
			
		}
		private function _createACTtext(ixml:XML):void
		{
			var spr:Sprite = new Sprite();
			var w:Number;
			var fSize:Number;
			
			if (ixml.hasOwnProperty("@width")){
				w = ixml.@width;
			} else {
				w = 600;
			}
			if (ixml.hasOwnProperty("@fontSize")){
				fSize = ixml.@fontSize;
			} else {
				fSize = 18;
			}
			for each (var child:XML in ixml.*) {
				var txt:ScreenCopy = new ScreenCopy();
				var stxt:String = child;
				var sx:Number = child.@x;
				var sy:Number = child.@y;
				if (child.hasOwnProperty("@width")){
					w = child.@width;
				} 
				if (child.hasOwnProperty("@fontSize")){
					fSize = child.@fontSize;
				} 
				txt.addText(stxt,w,fSize);
				txt.x = sx;
				txt.y = sy;
				//this.addChild(txt);
				txt.mouseEnabled = false;
				txt.mouseChildren = false;
				spr.addChild(txt);
				
			}
			
			_actItemsArray.push(spr);
		
		}
		private function _createACTheaders(ixml:XML):void
		{
			
			var spr:Sprite = new Sprite();
			
			for each (var child:XML in ixml.*) {
				var txt:ScreenCopy = new ScreenCopy();
				var stxt:String = child;
				var sx:Number = child.@x;
				var sy:Number = child.@y;
				txt.addText(stxt,300,18);
				txt.x = sx;
				txt.y = sy;
				spr.addChild(txt);
				txt.mouseEnabled = false;
				txt.mouseChildren = false;
			}
			
			_actItemsArray.push(spr);
		}
		private function _createACTItems(ixml:XML):BodyUI
		{
			var bdyui:BodyUI = new BodyUI();
			_itemType = (ixml.hasOwnProperty("@itemType"))?ixml.@itemType:"cb";
			//trace('_itemType='+ _itemType);
			_itemArray = new Array();
			
			
			var uip:UIparams = new UIparams();
			uip.uiFillAlpha = ixml.@fillAlpha;
			uip.uiFillColor = ixml.@fillColor;
			
			//uip.uiFrameSize = ixml.@frameSize;
		//	uip.uiFrameAlpha = ixml.@frameAlpha;
		//	uip.uiFrameColor = ixml.@frameColor;
		//	uip.uiFrameShape = uinode.@frameShape;
			uip.uiFontSize = (ixml.hasOwnProperty("@fontSize"))?ixml.@fontSize:_txtObject.box_fontSize;
			uip.uiFontColor = (ixml.hasOwnProperty("@fontColor"))?ixml.@fontColor:_txtObject.box_fontColor;
			uip.uiFontStyle =(ixml.hasOwnProperty("@fontStyle"))?ixml.@fontStyle:_txtObject.box_fontStyle;//"reg";
			uip.uiFontHAlign =(ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:_txtObject.box_fontAlign;//"left";
			//uip.uiFontSize = ixml.@fontSize;
			//uip.uiFontColor = ixml.@fontColor;
			//uip.uiFontStyle = ixml.@fontStyle;
		
			uip.uiPadX = ixml.@xPad;
			uip.uiPadY = ixml.@yPad;
			
			var startX:Number = ixml.@x;
			var startY:Number = ixml.@y;
			
			var uW:Number =  ixml.@width;
			
			uip.uiHeight = ixml.@height;

			var itemYholder:Number = startY;
			var itemXholder:Number = startX;
			
			//Choice Box Variables
		
			
			/**
			 * iconType="bitmap" iconShape="circle"  
			 * iconWidth="34" iconHeight="34" 
			 * iconFrameSize="1" iconFrameColor="black" iconFrameAlpha="0" 
			 * iconCheck="icons/icon_check.png" iconUncheck="icons/icon_uncheck.png">
			 */
			var icontype:String = (ixml.hasOwnProperty("@iconType"))?ixml.@iconType:"vector";
			var iconshape:String = (ixml.hasOwnProperty("@iconShape"))?ixml.@iconShape:"circle";
			var iconwidth:Number = (ixml.hasOwnProperty("@iconWidth"))?ixml.@iconWidth:36;
			var iconheight:Number = (ixml.hasOwnProperty("@iconHeight"))?ixml.@iconHeight:36;
			var iconframesize:Number = (ixml.hasOwnProperty("@iconFrameSize"))?ixml.@iconFrameSize:4;
			var iconframecolor:String = (ixml.hasOwnProperty("@iconFrameColor"))?ixml.@iconFrameColor:"black";
			var iconframealpha:Number = (ixml.hasOwnProperty("@iconFrameAlpha"))?ixml.@iconFrameAlpha:1;
			var iconuncheck:String = (ixml.hasOwnProperty("@iconUncheck"))?ixml.@iconUncheck:"white";
			var iconcheck:String = (ixml.hasOwnProperty("@iconCheck"))?ixml.@iconCheck:"orange";
			
			for each (var child:XML in ixml.*) {
				
				var itemID:String = child.@id;
				var itemText:String = child;
				var itemISAnswer:String = child.@isanswer;
				
				var choiceItemBox:ACTUI_ChoiceBox = new ACTUI_ChoiceBox();
				choiceItemBox.build(icontype,iconshape,iconwidth,iconheight,iconframesize,iconframecolor,iconframealpha,iconuncheck,iconcheck,_shellDir);
				
				//choiceItemBox.build(icontype,ixml.@iconShape,ixml.@iconWidth,ixml.@iconHeight,ixml.@iconFrameAlpha,ixml.@iconFrameColor,ixml.@iconFrameAlpha,ixml.@iconUncheck,ixml.@iconCheck,_shellDir);
				
				uip.uiWidth = (child.hasOwnProperty("@width"))?child.@width:uW;
				trace('uip.uiWidth=' + uip.uiWidth);
				var choiceItem:ACTUI_ChoiceItem = new ACTUI_ChoiceItem();
				choiceItem.buildItem(itemID,itemText,itemISAnswer,uip,choiceItemBox,_fontFamily,_localeID);
			
				
			//	choiceItem.buildItem(itemID,itemText,itemISAnswer,uip);
				choiceItem.name = itemID;
			
				choiceItem.buttonMode = true;
				//choiceItem.mouseChildren = false;
				choiceItem.useHandCursor = true;
				
				
				choiceItem.addEventListener(MouseEvent.CLICK, _item_clickHandler);
				choiceItem.addEventListener(MouseEvent.ROLL_OVER, _item_RollOver);
				choiceItem.addEventListener(MouseEvent.ROLL_OUT, _item_RollOut);
			//	choiceItem.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				
				
				choiceItem.x = 	itemXholder;
				choiceItem.y = 	itemYholder;
				
				itemYholder = choiceItem.y + choiceItem.height + uip.uiPadY;
				
			
				bdyui.addChild(choiceItem);
				//this.addChild(choiceItem);
				_itemArray.push(choiceItem);
			}
			
			return bdyui;
			//_actItemsArray.push(spr);
			
		}
		private function _item_RollOver(me:MouseEvent):void
		{
			var actitem:ACTUI_ChoiceItem =  me.currentTarget as ACTUI_ChoiceItem;
			actitem.currentState = 'hover';
		//	trace('meTYPE='+ me.type + ' meTarget='+ me.target + 'meCurTar' + me.currentTarget);
			
		}
		private function _item_RollOut(me:MouseEvent):void
		{
			var actitem:ACTUI_ChoiceItem =  me.currentTarget as ACTUI_ChoiceItem;
			actitem.currentState = 'normal';
			//trace('meTYPE='+ me.type + ' meTarget='+ me.target + 'meCurTar' + me.currentTarget);
			
		}
		
		private function _createACTBtns(ixml:XML):BodyUI
		{
			var bdyui:BodyUI = new BodyUI();
			bdyui.name = 'actbtns';
			//trace('ixml= ' + ixml.toString());
			
			
			var uw:Number= (ixml.hasOwnProperty("@width"))?ixml.@width:200;
			var uh:Number= (ixml.hasOwnProperty("@height"))?ixml.@height:40;
			
			var groupx:String= (ixml.hasOwnProperty("@x"))?ixml.@x:"0";
			var groupy:String= (ixml.hasOwnProperty("@y"))?ixml.@y:"0";
			
			var groupmargin:Number= (ixml.hasOwnProperty("@margin"))?ixml.@margin:0;
			
			var ufontsize:Number = (ixml.hasOwnProperty("@fontSize"))?ixml.@fontSize:16;
			var ufontcolor:String = (ixml.hasOwnProperty("@fontColor"))?ixml.@fontColor:"black";
			var ufontstyle:String =(ixml.hasOwnProperty("@fontStyle"))?ixml.@fontStyle:"reg";
			var ufontalign:String =(ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:"center";
			
			var upulsecolor:String =(ixml.hasOwnProperty("@pulseColor"))?ixml.@pulseColor:"orange";
			
			var uiareaW:Number = _actWidth;
			var uiareaH:Number;// = uh;
			
			for each (var child:XML in ixml.*) {
				var btntype:String = child.@type;
				
				
				var iw:Number= ( child.hasOwnProperty("@width"))?child.@width:uw;
				var ih:Number =( child.hasOwnProperty("@height"))?child.@height:uh;
				
				var imargin:Number =( child.hasOwnProperty("@margin"))?child.@margin:groupmargin;
				
				uiareaH = ih;
				var fontsize:Number = (child.hasOwnProperty("@fontSize"))?child.@fontSize:ufontsize;
				var fontcolor:String = (child.hasOwnProperty("@fontColor"))?child.@fontColor:ufontcolor;
				var fontstyle:String =(child.hasOwnProperty("@fontStyle"))?child.@fontStyle:ufontstyle;
				var fontalign:String =(child.hasOwnProperty("@fontAlign"))?child.@fontAlign:ufontalign;
				
				var ipulsecolor:String = (child.hasOwnProperty("@pulseColor"))?ixml.@pulseColor:upulsecolor;
				
				var btnid:String = child.@id;
				var uip:UIparams = new UIparams();
				
				uip.uiHeight = ih;
				uip.uiWidth = iw;
				
				uip.uiFontSize = fontsize;
				uip.uiFontColor = fontcolor;
				uip.uiFontStyle =  fontstyle;
				uip.uiFontHAlign = fontalign;
				
				var btnlbl:String = child;
				
				var bdyBTN:BodyButton = new BodyButton();
				bdyBTN.init(btnlbl,uip,ipulsecolor);
				
				var ix:String = (child.hasOwnProperty("@x"))?child.@x:groupx;
				var iy:String = (child.hasOwnProperty("@y"))?child.@y:groupy;
				
				
				var newX:Number = (!isNaN(Number(ix)))?Number(ix):SimpleUtils.relativeLayoutConverter(ix,uiareaW,iw,imargin);
				var newY:Number = (!isNaN(Number(iy)))?Number(iy):SimpleUtils.relativeLayoutConverter(iy,uiareaH,ih,imargin);
				
				switch (btntype){
					case 'submit':
						_submit_btn = bdyBTN;
						_submit_btn.x = newX;
						_submit_btn.y = newY;
						_submit_btn.isEnabled = false;
						_submit_btn.alpha = .4;
						bdyui.addChild(_submit_btn);
						break;
					case 'print':
						_print_btn = bdyBTN;
						_print_btn.x = newX;
						_print_btn.y = newY;
						_print_btn.visible = false;
						_print_btn.isEnabled = false;
						bdyui.addChild(_print_btn);
						break;
				}
				
				
				
				
			}
			bdyui.graphics.beginFill(0xffffff,0);
			bdyui.graphics.drawRect(0,0,uiareaW,uiareaH);
			bdyui.graphics.endFill();
			
			/*
			var frameShape:Shape = new Shape();
			frameShape.graphics.lineStyle(1,0x000000);
			frameShape.graphics.drawRect(0,0,_actWidth,uiareaH);
			frameShape.graphics.endFill();
			bdyui.addChild(frameShape);
			*/
			return bdyui;
			//_actItemsArray.push(spr);
			
		}
		
		
		
		
		private function _createACTfeedback(ixml:XML):void
		{
			_feedbackArray = new Array();
			
			
			var afbX:Number = (ixml.hasOwnProperty("@x"))?ixml.@x:0;
			var afbY:Number = (ixml.hasOwnProperty("@y"))?ixml.@y:0;
			var afbW:Number = (ixml.hasOwnProperty("@width"))?ixml.@width:_actWidth;
			var afbH:Number = (ixml.hasOwnProperty("@height"))?ixml.@height:0;
			
			var ufontSize:Number = (ixml.hasOwnProperty("@fontSize"))?ixml.@fontSize:18;
			
			var ufontStyle:String =(ixml.hasOwnProperty("@fontStyle"))?ixml.@fontStyle:"reg";
			var ufontAlign:String =(ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:"center";
			
			var ufontColor:String = (ixml.hasOwnProperty("@fontColor"))?ixml.@fontColor:"black";
			
			var fbXpad:Number = (ixml.hasOwnProperty("@xPad"))?ixml.@xPad:12;
			var fbYpad:Number = (ixml.hasOwnProperty("@yPad"))?ixml.@yPad:12;

			var uframeSize:Number = (ixml.hasOwnProperty("@frameSize"))?ixml.@frameSize:2;
			var uframeColor:String = (ixml.hasOwnProperty("@frameColor"))?ixml.@frameColor:"black";
			var uframeAlpha:Number = (ixml.hasOwnProperty("@frameAlpha"))?ixml.@frameAlpha:1;
			
			var ufillColor:String = (ixml.hasOwnProperty("@fillColor"))?ixml.@fillColor:"paleblue";
			var ufillAlpha:Number = (ixml.hasOwnProperty("@fillAlpha"))?ixml.@fillAlpha:.9;
			
			var ufontColorCode:uint = SHELL_COLORS.lookUpColor(ufontColor);
			var uframeColorCode:uint = SHELL_COLORS.lookUpColor(uframeColor);
			var ufillColorCode:uint = SHELL_COLORS.lookUpColor(ufillColor);
			
			for each (var child:XML in ixml.*) {
				
				var _feedbackBox:ACTUI_FeedBackBox = new ACTUI_FeedBackBox();
	
				_feedbackBox.init(child,afbW,afbH,uframeSize,uframeColorCode,ufillColorCode,ufillAlpha,ufontSize,ufontColorCode,fbXpad,fbYpad,ufontAlign,_fontFamily,_localeID);
			
				//	2,0x000000,SHELL_COLORS.CLR_LTBLUE,0.9,18,0x000000,10);
				_feedbackBox.name = child.@type;
				//_feedbackBox.alpha = 0;
			//	_feedbackBox.x = afbX;
			//	_feedbackBox.y = afbY;
				_feedbackArray.push(_feedbackBox);
				//	_feedbackBox.visible = false;
				//	this.addChild(_feedbackBox);
				
			}

		}
		
		private function _item_clickHandler(me:MouseEvent):void
		{
			var item:ACTUI_ChoiceItem = me.currentTarget as ACTUI_ChoiceItem;
			
			if (_itemType == "rb") {
				var shouldActivateSubmit:Boolean;
				
				if (item.selected) {
					item.selected = false;
				//	isSelected = false;
					_currentSelectedItem = null;
					shouldActivateSubmit = false;
				} else {
					if (_currentSelectedItem != null){
						_currentSelectedItem.selected = false;
					}
					item.selected = true;
					//isSelected = true;
					_currentSelectedItem = item;
					shouldActivateSubmit = true;
				}
				_submit_activator(shouldActivateSubmit);
				
			} else {
				var isSelected:Boolean;
				if (item.selected) {
					item.selected = false;
					isSelected = false;
				} else {
					item.selected = true;
					isSelected = true;
				}	
				
				_check2activateSubmitBtn(isSelected);
			}
			
			
			
			
		}
		private function _toggleRadioButtons(isSel:Boolean):void
		{
			//var submitEnabled:Boolean = _submit_btn.enabled;
			var validSelection:Boolean;// = false;
			if (isSel == true) {
				validSelection = true;
			} else {
				validSelection = false;
				for (var j:int = 0; j < _itemArray.length; j++) {
					var itc:ACTUI_ChoiceItem = _itemArray[j];
					if (itc.selected == true) {
						validSelection = true;
						break;
					}
				}
				
				
			} 
			_submit_activator( validSelection);
			
		}
		
		private function _check2activateSubmitBtn(isSel:Boolean):void
		{
			//var submitEnabled:Boolean = _submit_btn.enabled;
			var validSelection:Boolean;// = false;
			if (isSel == true) {
				validSelection = true;
			} else {
				validSelection = false;
				for (var j:int = 0; j < _itemArray.length; j++) {
					var itc:ACTUI_ChoiceItem = _itemArray[j];
					if (itc.selected == true) {
						validSelection = true;
						break;
					}
				}
				
				
			} 
			_submit_activator( validSelection);
			
		}
		
		private function _submit_activator(shouldBeActive:Boolean):void
		{
			var submitEnabled:Boolean = _submit_btn.isEnabled;
			if (shouldBeActive) {
				if (submitEnabled == false) {
					_submit_btn.isEnabled = true;
					_submit_btn.addEventListener(MouseEvent.CLICK,_submitClick_handler);
					
				}
				
			} else {
				if (submitEnabled == true) {
					_submit_btn.isEnabled = false;
					_submit_btn.removeEventListener(MouseEvent.CLICK,_submitClick_handler);
					
				}
			}
		}
		
		private function _showFeedback(isPositive:Boolean):void
		{
			var whichFeedbackType:String;
			if (isPositive) {
				//play correct sound effect
				
				whichFeedbackType = "correct";
				
			} else{
				//play correct sound effect
				whichFeedbackType = "wrong";
			}
			
			_displayFeedback(whichFeedbackType);
			//_playSoundEff(whichFeedbackType);
		}
		
		private function _displayFeedback(whichFB:String):void
		{
			_playSoundEff(whichFB);
			for (var fb:int = 0; fb < _feedbackArray.length; fb++) {
				var fbox:Sprite = _feedbackArray[fb];
				if (fbox.name == whichFB) {
					fbox.x = 0;
					fbox.y = _feedbackY;
					this.addChild(fbox);
				}
			}
			
			_triggerActivtyComplete();
			
		}
		
		
		private function _submitClick_handler(me:MouseEvent):void
		{
			var btnClicked:Sprite = me.currentTarget as Sprite;
		var globalPoint:Point = btnClicked.localToGlobal(new Point(btnClicked.x, btnClicked.y));
			var containerPoint:Point = this.globalToLocal(globalPoint);
			/*
			obj.x = globalPoint.x;
			obj.y = globalPoint.y;
			// make the object transparent
			
			*/
			_feedbackY = containerPoint.y;
			
			//trace("_feedbackY" + btnClicked +" = > " + _feedbackY);
			btnClicked.visible = false;
			
			var questionCorrect:Boolean = _checkChoices();
			_showFeedback(questionCorrect);

		}
		/*
		private function _disableChoiceItems():void
		{
			for (var j:int = 0; j < _itemArray.length; j++) {
				var itc:ACT_MCchoiceItem = _itemArray[j];
				itc.buttonMode = false;
				itc.mouseChildren = false;
				itc.useHandCursor = false;
				itc.removeEventListener(MouseEvent.CLICK, _item_clickHandler);
			}
		}
		*/
		private function _checkChoices():Boolean
		{
			var qc:Boolean = true;
			for (var j:int = 0; j < _itemArray.length; j++) {
				var itc:ACTUI_ChoiceItem = _itemArray[j];
				itc.buttonMode = false;
				itc.mouseChildren = false;
				itc.useHandCursor = false;
				itc.removeEventListener(MouseEvent.CLICK, _item_clickHandler);
				itc.removeEventListener(MouseEvent.ROLL_OVER, _item_RollOver);
				itc.removeEventListener(MouseEvent.ROLL_OUT, _item_RollOut);
			
				if(!itc.checkAnswer()){
					qc = false;
				}
			}
			
			
			return qc;
		}
		
		private function _playSoundEff(sndType:String):void
		{
			var sndloader:MP3Loader = LoaderMax.getLoader(sndType);
			trace("sndloader.status " + sndloader.status);
			if (sndloader.playProgress >= 1) {
				sndloader.gotoSoundTime(0,true);
			} else {
				sndloader.playSound();		
			}
		}
		/*
		private function _playSoundEff(sndType:String):void
		{
			
			if (sndType == "correct") {
				var correct:Sound = new AnswerCorrect();
				correct.play();
			//	trace("sndTypeC=" + sndType);
			} else if (sndType == "wrong") {
				var wrong:Sound =  new AnswerWrong();
				wrong.play();
			//	trace("sndTypeW=" + sndType);
			}
			
		}
		*/
		private function _triggerActivtyComplete():void
		{
			var ae:ShellEvent = new ShellEvent(ShellEvent.ACT_EVENT, 'actDone');
			this.dispatchEvent(ae);
			
		}
	}
}