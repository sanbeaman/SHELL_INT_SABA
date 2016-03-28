package com.sanbeaman.shell.widget.activity
{
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import com.sanbeaman.shell.data.UIparams;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class ACTUI_BtnItem extends MovieClip
	{
		private var _bid:String;
		private var _lbl:String;
		private var _isanswer:String;
		private var _enabled:Boolean;
		private var _currentState:String;
		private var _isChecked:Boolean;
		private var _image:Sprite;
	
		private var _backFull:Sprite;
		
		private var _btnBack:Sprite;
		private var _btnFace:Sprite;
		private var _btnBackActive:Sprite;
		private var _btnEmblem:Sprite;
		
		private var _id:String;
		private var _zindex:int;
		
		private var _btnLabel:String;
		private var _btnType:String;
		private var _btnFillType:String;
		
		private var _backColorCode:uint;
		
		
		private var _tfield:TextField;
		private var _tformat:TextLayoutFormat;
		
		
		private var _tfieldWidth:Number = 110;
		private var _tfieldBack:Sprite;
		private var _btnWidth:Number;
		private var _btnHeight:Number; //use height for circle radius
		
		
		
		private var _tracked:Boolean;
	
		
		private var _tlf:TLFTextField = new TLFTextField();
		
		private var _uiParams:UIparams;
		
		
		private var _originX:Number;
		private var _originY:Number;
		
		public var lineBall:Sprite;
		
		private var _activeFrame:Sprite;
		
		private var _activeFrameSize:Number;
		
		private var  _colorsObject:Object;
		private var _color1grad:uint;// = colors[0];// = 0x04618d;
		private var _color2grad:uint;// = colors[1];// = 0x379EE0;
		private var _tl:TimelineMax;
	
	
		public function ACTUI_BtnItem()
		{
			super();
			_enabled = false;
			_isChecked = false;
		}
		
		public function buildBtn(btype:String,blabel:String,bwidth:Number,bheight:Number,bfilltype:String, bcolorcode:uint,uiParams:UIparams = null):void
		{
		//	trace('setup matchbtn');
			_btnType = btype;
			_btnLabel = blabel;
			_btnWidth = bwidth;
			_tfieldWidth = bwidth;
			_btnHeight = bheight;
			_backColorCode = bcolorcode;
			_uiParams = uiParams;
	
			_btnFillType = bfilltype;
			_btnFace = new Sprite();
			_btnBack = new Sprite();
			
		
			
			//this.addChild(_btnBack);
			switch (_btnFillType){
				case 'bitmap':
					/*
					var fullpath:String = SHELL_VARS.FOLDER_SHELL_IMGS + 'dragRate_dragItem.png';
					var loader:ImageLoader = new ImageLoader(fullpath, {container:_btnBack,width:_btnWidth,height:_btnHeight});
					loader.load();
					*/
					break;
				case 'gradient':
					
					_btnBack.graphics.beginFill(_backColorCode,1);
					_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnBack.graphics.endFill();
					
					var colors:Array = _uiParams.uiFillColorArray;
					_color1grad = colors[0];// = 0x04618d;
					_color2grad = colors[1];// = 0x379EE0;
					//define two colors that gradient will consist of
					_colorsObject = {left:_color1grad, right:_color2grad};
					//set an object sprite and add it to stage
					_btnFace.graphics.lineStyle(_uiParams.uiFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
					_drawGradient();
					/*
					var fillType:String;
					var alphas:Array = [1, 1];
					var ratios:Array = [0x00, 0xFF];
					
					var gradRotation:Number = new Number(0);
					gradRotation = (Math.PI / 180) * 90;  // This turns it 90 degrees clockwise
					
					//	var halfHeight:Number = _btnHeight * 0.5;
					var matr:Matrix = new Matrix();
					var halfHeight:int = _btnHeight/2;
					matr.createGradientBox(_btnWidth,_btnHeight,gradRotation,0,0);
					//matr.createGradientBox(20, 20, 0, 0, 0);
					var spreadMethod:String = SpreadMethod.REFLECT;
					var interop:String = InterpolationMethod.RGB;
					
					fillType = GradientType.LINEAR;
					colors = _uiParams.uiFillColorArray;// [SHELL_COLORS.CLR_LTBLUE,SHELL_COLORS.CLR_BLUE];
					
					_btnFace.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interop,0);//,"rgb",gradRotation);
					_btnFace.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnFace.graphics.endFill();
					*/
					break;
				default:
					_btnBack.graphics.beginFill(_backColorCode,1);
					_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnBack.graphics.endFill();
					_btnFace.graphics.lineStyle(_uiParams.uiFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
					_btnFace.graphics.beginFill(_backColorCode,1);	
					_btnFace.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnFace.graphics.endFill();
				}
			
			
				var filter:BitmapFilter = getBitmapFilter();
				var myFilters:Array = new Array();
				myFilters.push(filter);
				var shadowFrameShadow:Sprite = new Sprite();
				shadowFrameShadow.graphics.lineStyle(1,0xffffff,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
				shadowFrameShadow.graphics.beginFill(0xffffff,1);
				shadowFrameShadow.graphics.drawRect(0,0,_btnWidth,_btnHeight);
				shadowFrameShadow.graphics.endFill();
				shadowFrameShadow.filters = myFilters;
				shadowFrameShadow.mouseEnabled = false;
				var shadowFrame:Sprite = new Sprite();
				shadowFrame.graphics.lineStyle(1,0xffffff,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
				shadowFrame.graphics.beginFill(0xffffff,0);
				shadowFrame.graphics.drawRect(0,0,_btnWidth,_btnHeight);
				shadowFrame.graphics.endFill();
				shadowFrame.mouseEnabled = false;
				//_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			//	_btnBack.graphics.endFill();
				_activeFrameSize = _uiParams.uiFrameSize +2;
				_activeFrame = new Sprite();
				_activeFrame.graphics.lineStyle(_activeFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
				_activeFrame.graphics.beginFill(0xffffff,0);
				_activeFrame.graphics.drawRect(0,0,_btnWidth,_btnHeight);
				_activeFrame.graphics.endFill();
				_activeFrame.mouseEnabled = false;
				_activeFrame.visible = false;
				//_btnFace.filters = myFilters;
				this.addChild(_btnBack);
				this.addChild(_btnFace);
				this.addChild(shadowFrameShadow);
				this.addChild(shadowFrame);
				this.addChild(_activeFrame);
				if (_uiParams == null) {
					_uiParams = new UIparams();
					_uiParams.uiFontColor = "white";
					_uiParams.uiFontHAlign = "center";
					_uiParams.uiFontVAlign = "middle";
					_uiParams.uiFontSize = 16;
					_uiParams.uiFontStyle = "bold";
					
					
				}
				///////////////////////////////////////
				
				//_padding = padding;
				
				_tlf = new TLFTextField();
				_tlf.embedFonts = true;
				_tlf.antiAliasType =  AntiAliasType.ADVANCED;
				
				_tlf.height = bheight;
				_tlf.width = _tfieldWidth;//600;// 755;
				_tlf.wordWrap = true;
				//_tlf.autoSize = TextFieldAutoSize.LEFT;
				
				
				_tlf.verticalAlign = VerticalAlign.MIDDLE;
				_tlf.selectable = false;
				
				
				_tlf.htmlText = _btnLabel;
				
				
				var format:TextLayoutFormat = new TextLayoutFormat();
				format.fontLookup = FontLookup.EMBEDDED_CFF;
				format.renderingMode = RenderingMode.CFF;
				format.cffHinting = CFFHinting.NONE;
				
				
				
				if (_uiParams.uiFontStyle == "bold"){
					format.fontWeight = FontWeight.BOLD;
				} else {
					format.fontWeight = FontWeight.NORMAL;
				}
				format.fontSize = _uiParams.uiFontSize;
				format.color = _uiParams.uiFontColorCode;
				
				
				format.textAlign = _uiParams.uiFontHAlignCONST;
				format.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
				format.verticalAlign = _uiParams.uiFontVAlignCONST;
				
				var myTextFlow:TextFlow = _tlf.textFlow;
				myTextFlow.invalidateAllFormats();
				
				myTextFlow.hostFormat = format;
				myTextFlow.paddingLeft = 4;//20;
				myTextFlow.paddingRight = 2;//20;
				myTextFlow.paddingTop = 2;//20;
				myTextFlow.lineHeight = "100%";
			//	myTextFlow.verticalAlign = _uiParams.uiFontVAlignCONST;
				//myTextFlow.paddingTop = _padding;//10;
				//	myTextFlow.paddingBottom =_padding;// 10;
				//	myTextFlow.direction = Direction.RTL;
				
				myTextFlow.flowComposer.updateAllControllers();
				
				
				
				_tlf.mouseEnabled = false;
				_tlf.mouseChildren = false;
				
				this.addChild(_tlf);
				//	this.addChild(_itemContentBox);
				
				//this.addChild(_btnBack);
				
				lineBall = new Sprite();
				lineBall.graphics.beginFill(0xffffff,0);
				lineBall.graphics.drawCircle(0,0,1);
				lineBall.graphics.endFill();
				
				var lbx:Number;
				var lby:Number = int(_btnHeight * .5);
				if (_btnType == 'matchbtn'){
					lbx = _btnWidth;
					
				} else {
					lbx = 0;
				}
				lineBall.x = lbx;
				lineBall.y= lby;
				_btnBack.addChild(lineBall);
				_tracked = false;
				//set it to act like a button
				this.buttonMode = true;//making a hand cursor over images
				this.useHandCursor = true;
				this.mouseChildren = false;
				import com.greensock.*; 
				import com.greensock.easing.*;
				
				TweenMax.to(_btnBack, 0, {dropShadowFilter:{color:0x000000, alpha:0.6, blurX:2, blurY:2, strength:1, angle:45, distance:1}});
				//TweenMax.to(_btnFace, 0, {bevelFilter:{blurX:3, blurY:3,angle:90, strength:0.5, distance:2}});
			//	_tl = new TimelineMax({paused:true,yoyo:true,repeat:-1});
			//	_tl.add(TweenMax.to(_colorsObject, 0.3, {hexColors:{left:_color1grad, right:_color2grad},easing:Linear.easeNone, onUpdate:_drawGradient}));
					
		}
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var angle:Number = 90;
			var alpha:Number = 0.6;
			var blurX:Number = 4;
			var blurY:Number = 4;
			var distance:Number = 2;
			var strength:Number = 1;
			var inner:Boolean = true;
			var knockout:Boolean = true;
			var hideobj:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			return new DropShadowFilter(distance,
				angle,
				color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout, hideobj);
		}
		//function that will draw a gradient
		private function _drawGradient():void {
			var m:Matrix = new Matrix();
		//	m.createGradientBox(_btnWidth, _btnHeight,1);
			m.createGradientBox(_btnWidth, int(_btnHeight*.5),1);
			//drawing a gradient box, set last value to 1 if you want vertical gradient or to 0 if you want horizontal gradient
			//m.createGradientBox(buttonWidth, buttonHeight, 1);
			_btnFace.graphics.beginGradientFill(GradientType.LINEAR, [_colorsObject.left, _colorsObject.right], [1, 1], [0x00, 0xFF], m, SpreadMethod.REFLECT);
			_btnFace.graphics.drawRect(0,0,_btnWidth,_btnHeight);
		}
		/*
		//this function draws a gradient for mouse over effect
		private function _startAnimatingGradient(e:MouseEvent){
			TweenMax.to(colorsObject, 0.75, {hexColors:{left:color2Blue, right:color1Blue},easing:Linear.easeNone, onUpdate:drawGradient});
		}
		//this function draws a gradient for mouse out effect
		private function _resetAnimatingGradient(e:MouseEvent){
			TweenMax.to(colorsObject, 0.75, {hexColors:{left:color1Blue, right:color2Blue},easing:Linear.easeNone, onUpdate:drawGradient});
		}
*/
		
		
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
				buttonMode = false;
				useHandCursor = false;
				if (isChecked) {
					currentState = 'checked';
				} else {
					currentState = 'ready';
				}
			}
			else 
			{
				if (isChecked) {
					useHandCursor = false;
					buttonMode = false;
					currentState = 'checked';
					
				} else {
					buttonMode = true;
					useHandCursor = true;
					currentState = 'ready';
				}
				
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
		}
		public function get isChecked():Boolean
		{
			
			return _isChecked;
		}
		public function set lbl(p_value:String):void
		{
			_lbl = p_value;
		}
		public function get lbl():String
		{
			
			return _lbl;
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
			
			if (isChecked) {
				_currentState = 'checked';
			}
			
			_setBtnState( _currentState );
		}
		
		private function _setBtnState(bstate:String):void
		{
			switch (bstate){
				case 'checked':
					_activeFrame.visible = true;
				//	_tl.pause();
					_btnFace.alpha = .8;
				//	this.alpha = 1;
					
					break;
				case 'active':
					_activeFrame.visible = true;
					_btnFace.alpha = 1;
				//	_tl.play();
					break;
				case 'ready':
					_activeFrame.visible = false;
					_btnFace.alpha = 1;
				//	_tl.pause();
					//TweenMax.to(_colorsObject, 0.75, {hexColors:{left:_color2grad, right:_color1grad},easing:Linear.easeNone, onUpdate:_drawGradient});
				//	_tl.seek(0);
					//this.alpha = .6;
					break;
				default:
					
			}
		}
		/*public function get anchor():String
		{
		return _anchor;
		}
		
		public function set anchor(value:String):void
		{
		_anchor = value;
		}*/
		
		
		/////////////////////////////////////////////
		//  HANDLERS
		/////////////////////////////////////////////
		/**
		 * Show over state on mouse over
		 * 
		 * @param	p_evt	(MouseEvent) mouse over event
		 * @return	void
		 */
		private function _onMouseOver( p_evt:MouseEvent ):void
		{
			if( _enabled )
			{
				//TweenMax.to(_colorsObject, 0.75, {hexColors:{left:_color2grad, right:_color1grad},easing:Linear.easeNone, onUpdate:_drawGradient});
				//currentState = OVER;
			}
		}
		
		/**
		 * Show down state on mouse down
		 * 
		 * @param	p_evt	(MouseEvent) mouse down event
		 * @return	void
		 */
		private function _onMouseDown( p_evt:MouseEvent ):void
		{
			if( _enabled )
			{
				
			}
		}
		
		/**
		 * Show up state on mouse out
		 * 
		 * @param	p_evt	(MouseEvent) mouse out event
		 * @return	void
		 */
		private function _onMouseOut( p_evt:MouseEvent ):void
		{
			if( _enabled )
			{
				//TweenMax.to(_colorsObject, 0.75, {hexColors:{left:_color1grad, right:_color2grad},easing:Linear.easeNone, onUpdate:_drawGradient});
			
				//currentState = UP;
			}
		}
		
		
		/**
		 * Toggle the selected state of the button (if toggle is enabled), and
		 * show the over state. Also dispatches a ToggleButtonEvent.TOGGLE_BUTTON_CLICK
		 * event.
		 * 
		 * @see		ToggleButtonEvent
		 * @param	p_evt	(MouseEvent) mouse over event
		 * @return	void
		 */
		private function _onMouseClick( p_evt:MouseEvent ):void
		{
			if( _enabled )
			{
				//_currentState = OVER;
				
			}
			
			//this.dispatchEvent( new ShellButtonEvent( ShellButtonEvent.SHELL_BUTTON_CLICK ) );
		}
	}
}