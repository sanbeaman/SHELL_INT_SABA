package com.sanbeaman.shell.widget.activity
{
	import fl.text.TLFTextField;
	
	import flash.display.*;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class Act_DragBtn extends MovieClip
	{
		
		private var _bid:String;
		private var _lbl:String;
		private var _isanswer:String;
		private var _enabled:Boolean;
		private var _currentState:String;
		private var _isChecked:Boolean;
		
		private var _dragback:Sprite;
		
		
		private var _btnWidth:Number;
		private var _btnHeight:Number;
		
		
		private var _fsize:Number = 14;
		private var _fcolorCode:uint = 0xffffff;
		
		public function Act_DragBtn()
		{
			super();
			_enabled = false;
			_isChecked= false;
			this.mouseChildren = false;
			//this.mouseEnabled = false;
			
			
		}
		public function buildBtn(id:String,isanswr:String, w:Number,h:Number):void
		{
			_bid = id;
			_isanswer = isanswr;
			
			_btnWidth = w;
			_btnHeight = h;
			//_dragback = new Sprite();
			this.graphics.lineStyle(1,0xcccccc,1);
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [SHELL_COLORS.CLR_LTBLUE,SHELL_COLORS.CLR_DKBLUE];
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
			this.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interop,0);//,"rgb",gradRotation);
			
			
	
			//_dragback.graphics.beginFill(SHELL_COLORS.CLR_TURQUOISE,1);
			this.graphics.drawRect(0,0,_btnWidth,_btnHeight);
		//	this.addChild(_dragback);
			
		}
		
		public function addLabel(str:String):void
		{
			
			
			var tlf:TLFTextField = new TLFTextField();
			
			tlf.embedFonts = true;
		//	tlf.autoSize =  TextFieldAutoSize.LEFT;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
			tlf.selectable = false;
			
			
			//	tlf.border = true;
			tlf.width = _btnWidth;
			tlf.height =_btnHeight;// 755;
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
			
			
			tlformat.fontSize = _fsize;
			tlformat.color = _fcolorCode;// 0x666666;
			
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
				useHandCursor = false;
				buttonMode = false;
				//currentState = 'ready';
			}
			else
			{
				buttonMode = true;
				useHandCursor = true;
				
				
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
			
			
			
			/*
			switch( p_value )
			{
			case UP:
			{
			_currentState = UP;
			break;
			}
			case OVER:
			{
			_currentState = OVER;
			break;
			}
			case DOWN:
			{
			_currentState = DOWN;
			break;
			}
			case DISABLED:
			{
			_currentState = DISABLED;
			break;
			}
			}
			
			this.gotoAndPlay( _currentState );*/
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
				//currentState = DOWN;
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