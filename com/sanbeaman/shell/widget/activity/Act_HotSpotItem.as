package com.sanbeaman.shell.widget.activity
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.sanbeaman.shell.data.UIparams;
	
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	
	
	
	public class Act_HotSpotItem extends MovieClip
	{
		private static const _DEG2RAD:Number = Math.PI/180;
		private var _itemID:String;
		private var _sindex:int;
		
		private var _backShapeString:String;
		private var _textLabel:String;
		private var _uip:UIparams;
		
		
		private var _backItem:Sprite;
		private var _backShape:Sprite;
		
		private var _labelSprite:Sprite;
		
		private var _actCheck:Act_HotSpotCheckBox;
		
		private var _itemStatus:String;
		private var _isChecked:Boolean;
		private var _isActive:Boolean;
		
		
		private var _enabled:Boolean;
		
		
		private var _activeColorCode:uint;
		private var _fillColorCode:uint;
		
		public function Act_HotSpotItem()
		{
			super();
			this.mouseChildren = false;
			
		}
		
		public function init(txtLabel:String, shapeString:String, uiparams:UIparams,highlightcolor:String = "ltblue"):void
		{
			_backShapeString = shapeString;
			_textLabel = txtLabel;
			_uip = uiparams;
			
			_fillColorCode = _uip.uiFillColorCode;
			_activeColorCode =  SHELL_COLORS.lookUpColor(highlightcolor);
			/*
			
			var shapePointArray = new Array();
			shapePointArray = _backShapeString.split("|");
			*/
			
			_backItem = new Sprite();
			_backItem.x = _uip.uiX;
			_backItem.y = _uip.uiY;
			
			
			_backShape = new Sprite();
			_backShape.graphics.lineStyle(_uip.uiFrameSize,_uip.uiFrameColorCode);
			_backShape.graphics.beginFill(_uip.uiFillColorCode,_uip.uiFillAlpha);
			
			
			/*
			if (_uip.uiFrameShape == 'polygon') {
			
			var pnt0:Point = _buildShapePoints(shapePointArray[0]);
			_backShape.graphics.moveTo(pnt0.x,pnt0.y);
			var pnt1:Point = _buildShapePoints(shapePointArray[1]);
			_backShape.graphics.lineTo(pnt1.x,pnt1.y);
			var pnt2:Point = _buildShapePoints(shapePointArray[2]);
			_backShape.graphics.lineTo(pnt2.x,pnt2.y);
			var pnt3:Point = _buildShapePoints(shapePointArray[3]);
			_backShape.graphics.lineTo(pnt3.x,pnt3.y);
			
			_backShape.graphics.lineTo(pnt0.x,pnt0.y);
			_backShape.graphics.endFill();
			
			*/
			
			_backShape.graphics.drawRect(0,0,_uip.uiWidth,_uip.uiHeight);
			_backShape.graphics.endFill();
			
			
			_backShape.x = 0;//_uip.uiX;
			_backShape.y =0;// _uip.uiY;
			
			//_backShape.alpha = 0;
			
			_actCheck = new Act_HotSpotCheckBox();
		
			
		//	var dist:Number = Point.distance(pnt1,pnt2);
		//	trace("dist" + dist);
		//	var rightSideShapeHeight:Number = pnt2.y - pnt1.y;
		//	trace("rightSideShapeHeight" + rightSideShapeHeight);
			
			var cbHeightAdjust:Number = _actCheck.height/2;
			var halfrssh:Number = _backShape.height /2;
		//	var halfrssh:Number = dist /2;
			var chkY:Number = halfrssh - cbHeightAdjust;
			var chkYint:int = int(chkY);
			_actCheck.x =   _backShape.x + _backShape.width + 18;
			_actCheck.y = _backShape.y + chkYint;
			
			_backItem.addChild(_backShape);
			_backItem.addChild(_actCheck);
			
			var shapeWidth:Number = _backShape.width;
			var shapeHeight:Number  = _backShape.height;
			
			//_back.addChild(actCheck);
			var smallHeight:Number = shapeHeight;
			_labelSprite = _createLabel(_textLabel,shapeWidth,smallHeight,_uip.uiFontSize,_uip.uiFontColorCode);
		//	var rotAdjust:Number;
		//	var degreeRot:Number = _uip.uiRotation;
		//	if ( degreeRot < 0) {
		//		rotAdjust = degreeRot * -2;
		//	} else {
		//		rotAdjust = degreeRot * 2;
		//	} 
			_labelSprite.y = 2;
			_labelSprite.x = 2;
		_labelSprite.mouseEnabled = false;
		_labelSprite.mouseChildren = false;
		//	_labelSprite.rotation = degreeRot;
			//this.skew(_labelSprite,45,45);
			_backItem.addChild(_labelSprite);
			_backItem.mouseChildren = false;
			this.addEventListener(MouseEvent.ROLL_OVER , _rollover_handler);
			this.addEventListener(MouseEvent.ROLL_OUT , _rollout_handler);
			_itemStatus = "normal";
			this.enabled = false;
			_isChecked = false;
			this.addChild(_backItem);
		}
		
		
		private function _listenerManager():void
		{
			
			if (this.enabled) {
				this.addEventListener(MouseEvent.ROLL_OVER , _rollover_handler);
				this.addEventListener(MouseEvent.ROLL_OUT , _rollout_handler);
			} else {
				this.removeEventListener(MouseEvent.ROLL_OVER , _rollover_handler);
				this.removeEventListener(MouseEvent.ROLL_OUT , _rollout_handler);
			}
			//_backShape.addEventListener(MouseEvent.ROLL_OVER , _rollover_handler);
			//_backShape.addEventListener(MouseEvent.ROLL_OUT , _rollout_handler);
			
			
		}
		private function _rollover_handler(me:MouseEvent):void
		{
			_actCheck.currentState = "pulse";
			_backShape.alpha = .8;
			
			
		}
		
		private function _rollout_handler(me:MouseEvent):void
		{
			_actCheck.currentState = "normal";
			_backShape.alpha = 0;
			
		}
		private function _createLabel(str:String,lblw:Number,lblh:Number, fontsize:Number,fontcolor:uint):Sprite
		{
			
			var txtSprite:Sprite = new Sprite();
			//////////////////////////////////
			
			var tlf:TLFTextField = new TLFTextField();
			tlf.embedFonts = true;
			//tField.autoSize =  TextFieldAutoSize.LEFT;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			//	tlf.border = true;
			tlf.width = lblw;
			tlf.height =lblh;// 755;
			//	tlf.autoSize = TextFieldAutoSize.LEFT;
			tlf.wordWrap = true;
			tlf.verticalAlign = VerticalAlign.MIDDLE;
			tlf.selectable = false;
			tlf.htmlText = str;
			
			
			
			var tlformat:TextLayoutFormat = new TextLayoutFormat();
			tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
			tlformat.renderingMode = RenderingMode.CFF;
			tlformat.cffHinting = CFFHinting.NONE;
			
			tlformat.textAlign = TextAlign.CENTER;
			
			
			tlformat.fontSize = fontsize;
			tlformat.color = fontcolor;// 0x666666;
			
			tlformat.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
			
			var myTextFlow:TextFlow = tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			
			myTextFlow.paddingLeft = 4;
			myTextFlow.paddingRight = 4;
			
			myTextFlow.hostFormat = tlformat;
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(tlf);
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
		
			/////////////////////////////////
		
			txtSprite.addChild(tlf);
			return txtSprite;
		}
		private function _buildShapePoints(pointString:String):Point
		{
			var newPoint:Point = new Point();
			var pointArray:Array = pointString.split(",",2);
			newPoint.x = pointArray[0];
			newPoint.y = pointArray[1];
			
			return newPoint;
		}
		
		
		
		public  function skew(target:DisplayObject, skewXDegree:Number, skewYDegree:Number):void
		{
			var m:Matrix = target.transform.matrix.clone();
			m.b = Math.tan(skewYDegree*_DEG2RAD);
			m.c = Math.tan(skewXDegree*_DEG2RAD);
			target.transform.matrix = m;
		}   
		
		public  function skewY(target:DisplayObject, skewDegree:Number):void
		{
			var m:Matrix = target.transform.matrix.clone();
			m.b = Math.tan(skewDegree*_DEG2RAD);
			target.transform.matrix = m;
		}       
		
		public  function skewX(target:DisplayObject, skewDegree:Number):void
		{
			var m:Matrix = target.transform.matrix.clone();
			m.c = Math.tan(skewDegree*_DEG2RAD);
			target.transform.matrix = m;
		}   

		
		private function _activateBack():void
		{
			//TweenMax.to(_backShape, .5, {glowFilter:{color:_activeColorCode, alpha:1, blurX:30, blurY:30}});
			var TL1:TimelineMax = new TimelineMax();
			TL1.insert(TweenMax.to(_backShape, .5, {alpha:1}));
			TL1.insert(TweenMax.to(_backShape, .5, {glowFilter:{color:_activeColorCode, alpha:1, blurX:10, blurY:10, strength:3, quality:3}}));
		//	TweenMax.to(_backShape, .5, {colorMatrixFilter:{colorize:_activeColorCode, amount:1}});
		}
		private function _deActivateBack():void
		{
			
			var TL1:TimelineMax = new TimelineMax();
			TL1.insert(TweenMax.to(_backShape, .5, {alpha:0}));
			TL1.insert(TweenMax.to(_backShape, .5, {glowFilter:{color:_activeColorCode, alpha:1, blurX:10, blurY:10, strength:0, quality:3}}));
				
				
		//	TweenMax.to(_backShape, .5, {alpha:0});
		//	TweenMax.to(_backShape, 1, {glowFilter:{color:_activeColorCode, alpha:1, blurX:5, blurY:5, strength:0, quality:3}});
		//	TweenMax.to(_backShape, .5, {glowFilter:{color:_activeColorCode, alpha:0, blurX:30, blurY:30}});
			
		//	TweenMax.to(_backShape, .5, {colorMatrixFilter:{colorize:_fillColorCode, amount:1}});
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
			
			
			_enabled = p_value;
			
			if( !_enabled )
			{
			//	this.alpha = .5;
				this.mouseEnabled = false;
				this.buttonMode = false;
				this.useHandCursor = false;
				
			}
			else
			{
				this.alpha = 1;
				this.mouseEnabled = true;
				this.buttonMode = true;
				this.useHandCursor = true;
				
			}
			_listenerManager();
			super.enabled = p_value;
			
		}
		
		public function get sindex():int
		{
			return _sindex;
		}

		public function set sindex(value:int):void
		{
			_sindex = value;
		}

		public function get itemID():String
		{
			return _itemID;
		}

		public function set itemID(value:String):void
		{
			_itemID = value;
		}

		
		public function get itemStatus():String
		{
			return _itemStatus;
		}

		public function set itemStatus(value:String):void
		{
			
			if (_isActive == false && _isChecked == false) {
				_itemStatus = value;
				switch (value){
					case "normal":
						_actCheck.currentState = "normal";
						break;
					case "pulse":
						_actCheck.currentState = "pulse";
						break;
				
				}
			
			}
		}

		public function get isActive():Boolean
		{
			return _isActive;
		}

		public function set isActive(value:Boolean):void
		{
			
			if (value){
				_actCheck.currentState = "active";
				_activateBack();
				//_itemStatus = "active";
			} else {
				_deActivateBack();
			}
			_isActive = value;
		}
		
		public function get isChecked():Boolean
		{
			return _isChecked;
		}
		
		public function set isChecked(value:Boolean):void
		{
			
			if (value) {
			_actCheck.tracked = true;
			_itemStatus = "tracked";
			}
			_isChecked = value;
		}



	}
}