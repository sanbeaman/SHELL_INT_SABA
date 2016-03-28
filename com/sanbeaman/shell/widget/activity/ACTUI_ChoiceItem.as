package com.sanbeaman.shell.widget.activity
{
	import com.greensock.TweenMax;
	import com.greensock.loading.LoaderMax;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.widget.activity.ACTUI_ChoiceBox;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class ACTUI_ChoiceItem extends MovieClip
	{
		
		private var _iconMC:ACTUI_Icon;
		private var _checkBox:ACTUI_ChoiceBox;
		
		
		
		private var _itemText:String;
		private var _itemTextBox:Sprite;
		
		public var answerTxt:String;
		
		
		private var _optionWidth:Number;
		private var _optionHeight:Number;
		
		private  var _textWidth:Number = 600;
		
		private var _textPadding:int = 4;
		private var _padLeft:int = 4;
		private var _padRight:int = 4;
		
		private var _selected:Boolean;
		private var _enabled:Boolean;
		
		public var tf_height:Number;
		
		
		private var _bid:String;
		private var _lbl:String;
		private var _isanswer:String;
		
		private var _currentState:String;
		private var _isChecked:Boolean;
		
		private var _back:Sprite;
		private var _hit:Sprite;
		
		private var _itemWidth:Number;
		private var _itemHeight:Number;
		
		
		private var _xPad:Number;
		private var _yPad:Number;
		
		
		private var _textAreaWidth:Number;
		
		private var _iconAreaWidth:Number;
		
		
		private var _uip:UIparams;
		
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		
		public function ACTUI_ChoiceItem()
		{
			super();
			_enabled = false;
			_isChecked= false;
			//this.mouseChildren = false;
		}
		
		public function buildItem(id:String, itemtxt:String, isanswr:String, uip:UIparams,cBox:Sprite, fontfamily:String = "Arial", langID:String = null):void
		{
			
			_bid = id;
			_isanswer = isanswr;
			_itemText = itemtxt;
			_uip  = new UIparams();
			_uip = uip;
			
			_itemWidth = _uip.uiWidth;
			_itemHeight = _uip.uiHeight;
			
			_xPad = _uip.uiPadX;
			_yPad = _uip.uiPadY;
			_hit  = new Sprite();
			_hit.name = id;
			_hit.graphics.lineStyle(1,0x000000,0);
			_hit.graphics.beginFill(0xffffff,.1);
			_hit.graphics.drawRect(0,0,_itemWidth,_itemHeight);
			
			
			_localeID = (langID != null)?langID:"en";
			
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			
			this.addChild(_hit);
			this.hitArea = _hit;
			
			//var iconNo_Loader:ImageLoader = LoaderMax.getLoader("Icon_No");
			//iconNo_Loader.load();
			var iconNO_bitmap:Bitmap = LoaderMax.getLoader("Icon_No").rawContent as Bitmap;
			var iconNO_bmpData:BitmapData = iconNO_bitmap.bitmapData;
			
			var iconYES_bitmap:Bitmap = LoaderMax.getLoader("Icon_Yes").rawContent as Bitmap;
			var iconYES_bmpData:BitmapData = iconYES_bitmap.bitmapData;
			
			_back = new Sprite();
			

			
			_iconMC = new ACTUI_Icon();
			_iconMC.build(iconYES_bmpData,iconNO_bmpData);
			_checkBox = cBox as ACTUI_ChoiceBox;
			
			var heightYadjust:Number;
			
			var checkBoxWidth:Number = _checkBox.iconwidth;
			var checkBoxHeight:Number = _checkBox.iconheight;
			
	
			if (_itemHeight > checkBoxHeight){//_checkBox.height){
				heightYadjust = (_itemHeight - checkBoxHeight) * .5;
				trace('heightYadjust==='+heightYadjust);
			} else {
				heightYadjust = 0;
				
			}
			
			var XiconX:Number;
			var XcbX:Number;
			var XtextboxX:Number;
			
			var _iconAreaWidth:Number = _iconMC.width + _checkBox.width + _xPad;
			var _textAreaWidth:Number = _itemWidth - _iconAreaWidth;
			
			if (_localeID == "ar"){
				XiconX = _itemWidth - _iconMC.width;
				XcbX = _itemWidth - _iconAreaWidth;
				XtextboxX = 0;
			} else {
				XiconX = 0;
				XcbX = _iconMC.width;
				XtextboxX = _iconAreaWidth;
			}
			
			_iconMC.x = XiconX;
			_iconMC.y = heightYadjust;
			_checkBox.y = heightYadjust;
			
			_checkBox.x =XcbX; //_iconMC.x + _iconMC.width;// + _xPad;
			
			_back.addChild(_iconMC);
			
			TweenMax.to(_checkBox, 0, {bevelFilter:{blurX:3, blurY:3,angle:90, strength:0.5, distance:2}});
			_back.addChild(_checkBox);
			
		//	_iconAreaWidth = _checkBox.x + checkBoxWidth + _xPad;
		//	_textAreaWidth = _itemWidth - _iconAreaWidth;
			_itemTextBox = _addLabel(_itemText, _textAreaWidth);
			_itemTextBox.x = XtextboxX;
			
			_back.addChild(_itemTextBox );
			
			//add back box for width measurement
		
			
			this.addChild(_back);
			//	_back.mouseEnabled = false;
			//	_back.mouseChildren = false;
		}
		
		private function _addLabel(str:String, txtfieldW:Number):Sprite
		{
			
			var txtSprite:Sprite = new Sprite();
			txtSprite.mouseChildren = false;
			txtSprite.mouseEnabled = false;
			
			var tlf:TLFTextField = new TLFTextField();
			tlf.embedFonts = true;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
			tlf.background = false;
			
		
			//	tlf.border = true;
			tlf.width = txtfieldW;
			tlf.height = _itemHeight;// 755;
			//	tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.wordWrap = true;
			tlf.verticalAlign = VerticalAlign.MIDDLE;
			tlf.selectable = false;
			tlf.htmlText = str;
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			
			format.fontSize =  _uip.uiFontSize;
			format.color = _uip.uiFontColorCode;
			
			
			
			if (_localeID == "ar"){
				format.textAlign = TextAlign.RIGHT;
				_padRight = 20;
				_padLeft = 4;
			} else {
				format.textAlign = TextAlign.LEFT;
				_padRight = 4;
				_padLeft = 4;
			}
			
			format.lineHeight = "110%";
		//	format.paddingLeft = _textPadding;
		//	format.paddingRight = padRight;
			
			
			format.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;//"Arial";
			
			
			
			
			/*
			format.paddingTop = 4;
			format.paddingBottom = 4;
			*/
			
			var myTextFlow:TextFlow = tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.hostFormat = format;
			myTextFlow.paddingLeft = _padLeft;
			myTextFlow.paddingRight = _padRight;
			myTextFlow.direction = _txtDirection;
			myTextFlow.flowComposer.updateAllControllers();
			
			
			txtSprite.addChild(tlf);
			_back.addChild(txtSprite);
			
			return txtSprite;
			
		}
		
		/**
		 * enabled
		 * Is the button enabled for use?
		 * @return	Boolean
		 */
		override public function get enabled():Boolean
		{
			
			return _enabled;
			
		}
		
		override public function set enabled( p_value:Boolean ):void
		{
			super.enabled = p_value;
			
			_enabled = p_value;
			
			if( !_enabled )
			{
				
				this.useHandCursor = false;
				this.buttonMode = false;
			
			}
			else
			{
			
				this.buttonMode = true;
			//	buttonMode = true;
				this.useHandCursor = true;
				
				
				
				//currentState = UP;
			}
			
		}
		
		
		public function set bid(p_value:String):void
		{
			_bid = p_value;
		}
		public function get bid():String
		{
			
			return _bid;
		}
		public function set isChecked(p_value:Boolean):void
		{
			_isChecked = p_value;
			selected = p_value;
		}
		public function get isChecked():Boolean
		{
			
			return _isChecked;
		}
		
		public function set isanswer(p_value:String):void
		{
			_isanswer= p_value;
		}
		public function get isanswer():String
		{
			
			return _isanswer;
			
		}
		/**
		 * currentState
		 * The current state of the button. The valid values are
		 * UP, OVER, DOWN, DISABLED, UP_SELECTED, OVER_SELECTED, 
		 * DOWN_SELECTED, and DISABLED_SELECTED.
		 * 
		 * @return	String
		 */  
		public function get currentState():String
		{
			
			return _currentState;
			
		}
		
		public function set currentState( p_value:String ):void
		{
			_currentState = p_value;
			switch (_currentState){
				case 'hover':
					_checkBox.hover(true);
					break;
				case 'normal':
					_checkBox.hover(false);
					break;
				case 'disabled':
					_checkBox.hover(false);
					break;
				
			}
		}
		
		
		
		
		public function resetOptions():void
		{
			this.selected = false;
			/*
			checkBox_no.visible = false;
			checkBox_yes.visible = false;
			checkBox_checked.visible = false;
			checkBox_arrow.visible = false;
			*/
		}
		private function _str2boolean(str:String):Boolean
		{
			
			switch(str) {
				case "1":
				case "true":
				case "yes":
					return true;
				case "0":
				case "false":
				case "no":
					return false;
				default:
					return Boolean(str);
			}
		}
		
		
		public function get selected():Boolean
		{
			return _selected;
		}
		public function set selected(pv:Boolean):void
		{
			_selected = pv;
			if (_selected) {
				
				_checkBox.isChecked = true;
			} else{
				
				_checkBox.isChecked = false;
			}
			
		}
		
		public function checkAnswer():Boolean
		{
			var answerCorrectly:Boolean;
			if (this.selected) {
				if (_str2boolean(this.isanswer) ){
					_iconMC.iconState = "yes";
					answerCorrectly = true;
				} else {
					_iconMC.iconState = "no";
					answerCorrectly = false;
				}
				
			} else {
				if (_str2boolean(this.isanswer) ){
					//_iconMC.iconState = "no";
					answerCorrectly = false;
				} else {
					
					answerCorrectly = true;
				}
			}
			this.enabled = false;
			return answerCorrectly;
			
		}
		
		
		
	}
}
