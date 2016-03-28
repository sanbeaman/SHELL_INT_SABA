package com.sanbeaman.shell.widget
{
	//import com.sanbeaman.shell.widget.activity.ACTUI_ChoiceBox;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.events.ShellEvent;
	import com.sanbeaman.shell.utils.SimpleUtils;
	import com.sanbeaman.shell.widget.activity.ACTUI_Btn;
	import com.sanbeaman.shell.widget.activity.ACTUI_ScreenText;
	import com.sanbeaman.shell.widget.activity.ACT_MCchoiceItem;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.ListStyleType;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.WhiteSpaceCollapse;
	import flashx.undo.UndoManager;

	public class ACT_textAreaInput extends BodyUI
	{
		
		private var _actType:String;
		private var _actXML:XMLList;
		
		private var _actWidth:Number;
		private var _actHeight:Number;
		
		private var _startX:Number;
		private var _startY:Number;

		
		private var _shellDir:String;
		
		
		private var _itemArray:Array;
		
		private var _actItemsArray:Array;
		
		
		private var _submit_btn:BodyButton;
	
		private var _print_btn:BodyButton;
		private var _feedbackArray:Array;
		
		private var _feedbackY:Number;

		
		private var _margin:Number;
		
		private var _itemType:String;
		
		
		private var _txtbox_input:TLFTextField;
		private var _txtbox_display:TLFTextField;
		
		
		private var _tlformat_input:TextLayoutFormat;
		private var _tlformat_display:TextLayoutFormat;
		
		private var _fontFamily:String;

		private var _tflowStart:String ="<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'>";
		private var _tflowEnd:String ="</TextFlow>";
		private var _txtFlow_input:TextFlow;
		
		private var _txtFlow_display:TextFlow;
		
		
		private var _currentSelectedItem:ACT_MCchoiceItem;
		public var hasEnteredText:Boolean; 
		public var hasClickedTextBox:Boolean;
		
		
		private var em:EditManager;
		private var um:UndoManager;
	
		private var _back:Sprite;// = new Sprite();
		private var _printView:Boolean;
		
		
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		
		private var _layoutModifier:String;
		private var _txtresult_display:Sprite;
		private var _txtinput_display:Sprite;
		private var _innerPadding:Number = 6;
		
		public function ACT_textAreaInput()
		{
			super();
			this.name ='ACT_TAI';
			_startX = 0;
			_startY = 0;
		}
		
		
		public function buildActivity(atype:String, actXML:XML, shellDir:String, actwidth:Number = 700, actheight:Number = 400, fontfamily:String = "Arial",langID:String = null):void
		{
			_actType = atype;
			_shellDir = shellDir;
			_actWidth = actwidth;
			_actHeight = actheight;
			_fontFamily = fontfamily;
			
			_localeID = (langID != null)?langID:"en";
			//_layoutModifier ="none";
			_layoutModifier = (_localeID == "ar")?"flipx":"none";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_buildACTContent(actXML);
		}
		
		private function _buildACTContent(scXML:XML):void
		{
			var endType:String = scXML.@endType;
			_margin = (scXML.hasOwnProperty("@margin"))?scXML.@margin:0;
			var uxpad:Number = (scXML.hasOwnProperty("@xPad"))?scXML.@xPad:0;
			var uypad:Number  = (scXML.hasOwnProperty("@yPad"))?scXML.@yPad:0;
		
			_actItemsArray = new Array();
			
			var actXML:XMLList = scXML.*;
			
			for each (var ui:XML in actXML)
			{
				var ut:String = ui.@type;
				var uiType:String = ut.toLowerCase();
				//trace("utype= " + uiType);
				switch (uiType){
					case 'screentext':
						_actItemsArray.push(_createScreenText(ui));
					//	_createScreenText(ui);
						break;
					case 'actheaders':
					//	_createACTheaders(ui);
						break;
					case 'cboxes':
					//	_createACTItems(ui);
						break;
					case 'actui':
						_actItemsArray.push(_createACT_ui(ui));
						break;
					case 'actbtns':
						_actItemsArray.push(_createACTBtns(ui));
						//_createACTBtns(ui);
						break;
					case 'feedbacktext':
					//	_createACTfeedback(ui);
						break;
					
				}
				
			}
			var yHolder:Number = _startY;
			var xHolder:Number = _startX;
			
			
			
			for (var i:int = 0; i < _actItemsArray.length; i++) {
				var actitem:BodyUI = _actItemsArray[i];
				actitem.x = xHolder;
				actitem.y = yHolder;
				this.addChild(actitem);
				
				//if(actitem.name == 'submitbtn'){
				//	_feedbackY = yHolder;
			//	}
				yHolder =  actitem.y + actitem.height + uypad;
			}
		}
		
		private function _createScreenText(ixml:XML):BodyUI
		{
			var bdyui:BodyUI = new BodyUI();
			bdyui.layout = 'relative';
			bdyui.name = "screentext";
			var fontname:String = (ixml.hasOwnProperty("@fontName"))?ixml.@fontName:_fontFamily;
			
			var fontsize:Number = (ixml.hasOwnProperty("@fontSize"))?ixml.@fontSize:18;
			var fontcolor:String = (ixml.hasOwnProperty("@fontColor"))?ixml.@fontColor:"black";
			var fontstyle:String =(ixml.hasOwnProperty("@fontStyle"))?ixml.@fontStyle:"reg";
			var fontalign:String =(ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:"left";
			
			var xpad:Number = (ixml.hasOwnProperty("@xPad"))?ixml.@xPad:0;
			var ypad:Number = (ixml.hasOwnProperty("@yPad"))?ixml.@yPad:0;
			
			var startX:Number = (ixml.hasOwnProperty("@x"))?ixml.@x:0;
			var startY:Number = (ixml.hasOwnProperty("@y"))?ixml.@y:0;
			
			var uW:Number = (ixml.hasOwnProperty("@width"))?ixml.@width:_actWidth;
			var uH:Number = (ixml.hasOwnProperty("@height"))?ixml.@height:_actHeight;
			
			for each (var child:XML in ixml.*) {
				
				var stxt:String = child;
				var sx:Number = (child.hasOwnProperty("@x"))?child.@x:startX;
				var sy:Number = (child.hasOwnProperty("@y"))?child.@y:startY;
				
				var itemW:Number = (child.hasOwnProperty("@width"))?child.@width:uW;
				var fsize:Number = (child.hasOwnProperty("@fontSize"))?child.@fontSize:fontsize;
				var fcolor:String = (child.hasOwnProperty("@fontColor"))?child.@fontColor:fontcolor;
				var fstyle:String =(child.hasOwnProperty("@fontStyle"))?child.@fontStyle:fontstyle;
				var falign:String =(child.hasOwnProperty("@fontAlign"))?child.@fontAlign:fontalign;
				
				var screenText:ACTUI_ScreenText = new ACTUI_ScreenText();
				screenText.name = 'myscreentext';
				screenText.addText(stxt,itemW,fsize,fcolor,falign,fstyle,_fontFamily,_localeID);
				
				//screenText.addText(stxt,itemW,fsize,fcolor,falign,fstyle,_fontFamily,_localeID);
				//screenText.addText(stxt,itemW,fsize,fontname,fcolor,falign);
				
				screenText.x = sx;
				screenText.y = sy;
				//this.addChild(txt);
				screenText.mouseEnabled = false;
				screenText.mouseChildren = false;
				bdyui.addChild(screenText);
				
				var stHeight:Number  = int(screenText.txtHeight);
				startY+= stHeight + ypad;
				
			}
			
			return bdyui;
			
			
		}
		private function _createACTBtns(ixml:XML):BodyUI
		{
			var bdyui:BodyUI = new BodyUI();
			bdyui.name = 'actbtns';
			//trace('ixml= ' + ixml.toString());
			var uw:Number= (ixml.hasOwnProperty("@width"))?ixml.@width:200;
			var uh:Number= (ixml.hasOwnProperty("@height"))?ixml.@height:40;
			var ufontsize:Number = (ixml.hasOwnProperty("@fontSize"))?ixml.@fontSize:16;
			var ufontcolor:String = (ixml.hasOwnProperty("@fontColor"))?ixml.@fontColor:"black";
			var ufontstyle:String =(ixml.hasOwnProperty("@fontStyle"))?ixml.@fontStyle:"reg";
			var ufontalign:String =(ixml.hasOwnProperty("@fontAlign"))?ixml.@fontAlign:"center";
			
			var upulsecolor:String =(ixml.hasOwnProperty("@pulseColor"))?ixml.@pulseColor:"orange";
			
			
			var uiareaH:Number;// = uh;
			
			for each (var child:XML in ixml.*) {
				var btntype:String = child.@type;
				
				
				var iw:Number= ( child.hasOwnProperty("@width"))?child.@width:uw;
				var ih:Number =( child.hasOwnProperty("@height"))?child.@height:uh;
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
				//bdyBTN.name = 'mybutton';
				bdyBTN.init(btnlbl,uip,ipulsecolor,false);
				
				var ix:String = (child.hasOwnProperty("@x"))?child.@x:"0";
				var iy:String = (child.hasOwnProperty("@y"))?child.@y:"0";
				
				
				var newX:Number = (!isNaN(Number(ix)))?Number(ix):SimpleUtils.relativeLayoutConverter(ix,_actWidth,iw,0,_layoutModifier);
				var newY:Number = (!isNaN(Number(iy)))?Number(iy):SimpleUtils.relativeLayoutConverter(iy,_actHeight,ih,0);
				
				var btnArea:Sprite = new Sprite();
				
				switch (btntype){
					case 'submit':
					
						btnArea.graphics.beginFill(0xffffff,0);
						btnArea.graphics.drawRect(0,0,_txtinput_display.width, uh);
						btnArea.x = _txtinput_display.x;
						btnArea.y = newY;
						bdyui.addChild(btnArea);
						
						_submit_btn = bdyBTN;
						_submit_btn.name ='submitbtn';
						_submit_btn.x = (!isNaN(Number(ix)))?Number(ix):SimpleUtils.relativeLayoutConverter(ix,_txtinput_display.width,iw,0,_layoutModifier);
						_submit_btn.y =0;// (!isNaN(Number(iy)))?Number(iy):SimpleUtils.relativeLayoutConverter(iy,uh,ih,0);
						btnArea.addChild(_submit_btn);
						_submit_btn.isEnabled = false;
						_submit_btn.alpha = .2;
						
						break;
					case 'print':
					//	btnArea = new Sprite();
						btnArea.graphics.beginFill(0xffffff,0);
						btnArea.graphics.drawRect(0,0,_txtresult_display.width, uh);
						btnArea.x = _txtresult_display.x;
						btnArea.y = newY;
						bdyui.addChild(btnArea);
						_print_btn = bdyBTN;
						_print_btn.name = 'printbtn';
						
						_print_btn.x = (!isNaN(Number(ix)))?Number(ix):SimpleUtils.relativeLayoutConverter(ix,_txtresult_display.width,iw,0,_layoutModifier);
						_print_btn.y =0;// (!isNaN(Number(iy)))?Number(iy):SimpleUtils.relativeLayoutConverter(iy,uh,ih,0);
						
						btnArea.addChild(_print_btn);
						_print_btn.visible = false;
						_print_btn.isEnabled = false;
						
						break;
				}
			
			

				
			}
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
		
		
		private function _createACT_ui(ixml:XML):BodyUI
		{
			var bdyui:BodyUI = new BodyUI();
		
			_txtbox_input = new TLFTextField();
			_txtbox_input.name = '_txtbox_input';
			_txtbox_display = new TLFTextField();
			_txtbox_display.name = '_txtbox_display';
			
		
			var uwidth:Number = (ixml.hasOwnProperty("@width"))?ixml.@width:_actWidth;
			var uheight:Number = (ixml.hasOwnProperty("@height"))?ixml.@height:240;
			var ux:Number = (ixml.hasOwnProperty("@"))?ixml.@x:0;
			var uy:Number = (ixml.hasOwnProperty("@y"))?ixml.@y:0;
			var umargin:Number = (ixml.hasOwnProperty("@margin"))?ixml.@margin:0;
			var xpad:Number = (ixml.hasOwnProperty("@xPad"))?ixml.@xPad:0;
			var ypad:Number = (ixml.hasOwnProperty("@yPad"))?ixml.@yPad:0;
			
		//	_layoutModifier = (ixml.hasOwnProperty("@layoutModifier"))?ixml.@layoutModifier:"none";
			
			//var textinput_width:Number = (ixml.hasOwnProperty("@width"))?ixml.@width:680;;// - _margin; //20
			//var textinput_height:Number = (ixml.hasOwnProperty("@height"))?ixml.@height:240;// - _margin; //20;
			
			
			_back = new Sprite();
			_back.name = 'back';
		//	_back.graphics.lineStyle(1,0xff0000,1);
		//	_back.graphics.beginFill(0x00ff00,.5);
		//	_back.graphics.drawRect(0,0,uwidth,uheight);
			_back.x = ux;
			_back.y = uy;
		
			bdyui.addChild(_back);
			
			
			for each (var child:XML in ixml.*) {
				
				//var groupX:String = (uinode.hasOwnProperty("@x"))?uinode.@x:"0";
				//var groupY:String = (uinode.hasOwnProperty("@y"))?uinode.@y:"0";
				
				//var margin:Number = (uinode.hasOwnProperty("@margin"))?uinode.@margin:20;
				
				var groupx:String = (child.hasOwnProperty("@x"))?child.@x:"0";//child.@x;
				var groupy:String =  (child.hasOwnProperty("@y"))?child.@y:"0";//child.@x;child.@y;
			
			//	var iwidth:Number = (child.hasOwnProperty("@width"))?child.@width:uwidth;
			//	var iheight:Number = (child.hasOwnProperty("@height"))?child.@height:uheight;
			
				var iw:Number = (child.hasOwnProperty("@width"))?child.@width:uwidth * .5;
				var ih:Number = (child.hasOwnProperty("@height"))?child.@height:uheight;
				var ix:Number = (!isNaN(Number(groupx)))?Number(groupx):SimpleUtils.relativeLayoutConverter(groupx,uwidth,iw,umargin,_layoutModifier);
				var iy:Number = (!isNaN(Number(groupy)))?Number(groupy):SimpleUtils.relativeLayoutConverter(groupy,uheight,ih,umargin);
				
			//	var iwidth:Number= child.@width;//="246" 
				//var iheight:Number = child.@height;//="280" 
				
			
				
				var itemID:String = child.@id;
				
				
				var textStyle:String = (child.hasOwnProperty("@textStyle"))?child.@textStyle:"none";
				
				var itype:String = child.@type;// ="txtstart" 
				var itemText:String = child;
			
				var fillColorCode:uint = SHELL_COLORS.lookUpColor(child.@fillColor);//="ltgrey" 
				var fillAlpha:Number = child.@fillAlpha;//=".5" 
				var frameColorCode:uint = SHELL_COLORS.lookUpColor(child.@frameColor);//="black" 
				var frameSize:Number = child.@frameSize;//="2" 
				var frameAlpha:Number = child.@frameAlpha;//="1">
				
				var fontColorCode:uint = SHELL_COLORS.lookUpColor(child.@fontColor);//="black" 
				var fontSize:Number = child.@fontSize;//="18" 
				var fontStyle:String = child.@fontStyle;;//="reg" 
				var fontAlign:String = child.@fontAlign;//="left" 
				
				trace('itype='+ itype + ' width=' + iw+ ' height=' + ih + ' x= ' + ix + " y="+ iy);
				if (itype == 'txtinput'){
					var txtinput:Shape = new Shape();
					
					txtinput.graphics.lineStyle(frameSize,frameColorCode,frameAlpha);
					txtinput.graphics.beginFill(fillColorCode,fillAlpha);
					txtinput.graphics.drawRect(0,0,iw,ih);
					txtinput.graphics.endFill();
					txtinput.x=ix;
					txtinput.y=iy;
					bdyui.addChild(txtinput);
					
					_txtinput_display = new Sprite();
					_txtinput_display.name = '_txtinput_display';
					_txtinput_display.x = ix;//xHolder;// ix + 10;
					_txtinput_display.y = iy;//yHolder;//iy + 10;
					//_txtinput_display.graphics.lineStyle(frameSize,frameColorCode,frameAlpha);
					_txtinput_display.graphics.beginFill(fillColorCode,fillAlpha);
					
					_txtinput_display.graphics.drawRect(0,0,iw,ih);
					
					//_txtinput_display.graphics.drawRect(0,0,iwidth-10,iheight-10);
					_txtinput_display.graphics.endFill();
					bdyui.addChild(_txtinput_display);
				
					
					_tlformat_input = new TextLayoutFormat();
					_tlformat_input.fontLookup = FontLookup.EMBEDDED_CFF;
					_tlformat_input.renderingMode = RenderingMode.CFF;
					_tlformat_input.cffHinting = CFFHinting.NONE;
					
					_tlformat_input.fontSize = fontSize;
					_tlformat_input.color = fontColorCode;// 0x666666;
					if (fontAlign == 'center'){
						_tlformat_input.textAlign = TextAlign.CENTER;
					} 
					
					_tlformat_input.fontFamily =_fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
					
					
					
					
					_txtFlow_input = new TextFlow();
					_txtFlow_input.invalidateAllFormats();
					
					//sample text
					var p:ParagraphElement = new ParagraphElement();
					var s:SpanElement = new SpanElement();
					s.locale = _localeID;
					s.direction = _txtDirection;
					s.whiteSpaceCollapse = WhiteSpaceCollapse.COLLAPSE;
					s.id = "span1";
					s.text = itemText;
					//add to flow
					p.addChild(s);
					_txtFlow_input.addChild(p);
					
					
					var tfController:ContainerController = new ContainerController(_txtinput_display,iw,ih);
					//tfController.y = 10;
				//	tfController.x = 10;
					
			
					_txtFlow_input.flowComposer.addController(tfController);
					
					
					_txtFlow_input.hostFormat = _tlformat_input;
					_txtFlow_input.paddingTop = ypad;
					_txtFlow_input.paddingLeft = xpad;
					_txtFlow_input.paddingRight = xpad;
					_txtFlow_input.paddingBottom = ypad;
					_txtFlow_input.locale = _localeID;
					_txtFlow_input.direction = _txtDirection;
					_txtFlow_input.flowComposer.updateAllControllers();
					
					//define TextFlow Manger
					um = new UndoManager();
					em = new EditManager(um);
					
					_txtFlow_input.interactionManager = null;
					
					//_txtFlow_input.addEventListener(FocusEvent.FOCUS_IN, _focusInHandler)
					_txtinput_display.addEventListener(MouseEvent.CLICK,_txtbox_clickHandler);
			
					//inputTLFTextField.addEventListener(Event.CHANGE, changeHandler);
				} else {

					_txtresult_display = new Sprite();
					
					_txtresult_display.graphics.lineStyle(frameSize,frameColorCode,frameAlpha);
					_txtresult_display.graphics.beginFill(fillColorCode,fillAlpha);
					_txtresult_display.graphics.drawRect(0,0,iw,ih);
					_txtresult_display.graphics.endFill();
					_txtresult_display.x=ix;
					_txtresult_display.y=iy;
					_txtresult_display.visible = false;
					
					bdyui.addChild(_txtresult_display);
					
					_tlformat_display = new TextLayoutFormat();
					_tlformat_display.fontLookup = FontLookup.EMBEDDED_CFF;
					_tlformat_display.renderingMode = RenderingMode.CFF;
					_tlformat_display.cffHinting = CFFHinting.NONE;
						
					_tlformat_display.listStyleType = ListStyleType.DISC;
					_tlformat_display.listAutoPadding = 10;
					
					_tlformat_display.lineHeight = "120%";
						//		tlformat.direction =  (_fontDirection == 'right')?Direction.RTL:Direction.LTR;
					_tlformat_display.fontSize = fontSize;
					_tlformat_display.color = fontColorCode;// 0x666666;
						 if (fontAlign == 'center'){
							_tlformat_display.textAlign = TextAlign.CENTER;
						} 
						_tlformat_display.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
						
					//	_txtbox_display.border = true;
						_txtbox_display.embedFonts = true;
						//	tf.autoSize =  TextFieldAutoSize.LEFT;
						_txtbox_display.antiAliasType =  AntiAliasType.ADVANCED;
						
						
						if (textStyle == 'textFlow'){
							var wrapintflow:String = _tflowStart + itemText + _tflowEnd;
							_txtbox_display.tlfMarkup = wrapintflow;
						} else {
							_txtbox_display.htmlText = itemText;
						}
						
						_txtbox_display.width =  iw - (2*xpad);
						_txtbox_display.height =  ih - (2*ypad);
						
						_txtbox_display.wordWrap = true;
						_txtbox_display.selectable = false;
					
						
						var myTextFlow:TextFlow = _txtbox_display.textFlow;
						myTextFlow.direction = _txtDirection;
						myTextFlow.hostFormat = _tlformat_display;
						myTextFlow.paddingLeft = xpad;
						myTextFlow.paddingRight = xpad;
						myTextFlow.paddingTop= ypad;
						myTextFlow.paddingBottom = ypad;
						myTextFlow.flowComposer.updateAllControllers();
						myTextFlow.whiteSpaceCollapse = WhiteSpaceCollapse.COLLAPSE;
					//	_txtbox_display.visible = false;
						//_txtbox_display.x = xpad;
					//	_txtbox_display.y = ypad;
						_txtresult_display.addChild(_txtbox_display);
						//_txtbox_input.addEventListener(MouseEvent.CLICK,_txtbox_clickHandler);
							
						
				
				}

			}
			return bdyui;
		//	_actItemsArray.push(spr);
			
		}

		private function _txtbox_clickHandler(evt:MouseEvent):void
		{
			if (!hasClickedTextBox) {
				_txtinput_display.removeEventListener(MouseEvent.CLICK, _txtbox_clickHandler);
				hasClickedTextBox = true;
				//var s1:SpanElement = _txtFlow_input.getElementByID("span1") as SpanElement;
				//s1.text = "";
				
				
				_txtFlow_input.interactionManager = em;
				em.selectAll();
			em.deleteText();
			em.setFocus();
			hasEnteredText  = false;
			_submit_btn.isEnabled = true;
			_submit_btn.alpha = 1;
			_submit_btn.addEventListener(MouseEvent.CLICK,_btnSubmit_clickHandler);
			//_txtFlow_input.addEventListener(TextEvent.TEXT_INPUT, _txtbox_typeHandler);
			
		
			
			
			
			}
		}
				
		private function _focusTLF(tlf:TLFTextField):Boolean
		{
			
			trace('focus='+ tlf.stage.focus.name);
			//tlf.stage.focusRect = true;
			if (tlf.stage.focus != tlf) {
				tlf.stage.focus = tlf;
			}
			return ( (tlf.stage.focus) ) as Boolean;
		}
		
		public function _txtbox_typeHandler(event:TextEvent):void
		{
			if (!hasEnteredText) {
				trace("text has entered activate submit");
				
				_txtbox_input.removeEventListener(TextEvent.TEXT_INPUT, _txtbox_typeHandler);
				hasEnteredText = true;
				
				
				_submit_btn.isEnabled = true;
				_submit_btn.alpha = 1;
				_submit_btn.addEventListener(MouseEvent.CLICK,_btnSubmit_clickHandler);
			
			}
			
		}
		private function _btnSubmit_clickHandler(evt:MouseEvent):void
		{
			_txtbox_input.selectable = false;
			_submit_btn.removeEventListener(MouseEvent.CLICK,_btnSubmit_clickHandler);
			_submit_btn.visible = false;
			_txtresult_display.visible = true;
			//_txtbox_display.visible = true;
			_print_btn.visible = true;
			_print_btn.alpha = 1;
			_print_btn.isEnabled = true;
			_print_btn.addEventListener(MouseEvent.CLICK, _btnPrint_clickHandler);
			//	btn_submit.alpha = .7;
			_triggerActivtyComplete();
			
		}
		private function _btnPrint_clickHandler(evt:MouseEvent):void
		{
			var ae:ShellEvent = new ShellEvent(ShellEvent.ACT_EVENT, 'printActivity');
			this.dispatchEvent(ae);
		//	trace("_btnPrint_clickHandler");
		}
		private function _triggerActivtyComplete():void
		{
			var ae:ShellEvent = new ShellEvent(ShellEvent.ACT_EVENT, 'actDone');
			this.dispatchEvent(ae);
			
		}
		
		public function get printView():Boolean
		{
			return _printView;
		}
		
		public function set printView(value:Boolean):void
		{
			_printView = value;
			if (_printView){
				_print_btn.visible = false;
			//	_setUIprintView(true);
			} else {
				_print_btn.visible = true;
			//	_setUIprintView(false);
			}
		}
	}
}