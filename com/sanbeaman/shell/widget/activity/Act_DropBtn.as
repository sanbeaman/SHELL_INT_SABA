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
	
	public class Act_DropBtn extends MovieClip
	{
		
		private var _bid:String;
		private var _lbl:String;
		private var _isanswer:String;
		private var _enabled:Boolean;
		private var _currentState:String;
		private var _isChecked:Boolean;
		
		private var _back:Sprite;
		private var _hit:Sprite;
		
		private var _btnWidth:Number;
		private var _btnHeight:Number;
		
		public function Act_DropBtn()
		{
			super();
			_enabled = false;
			_isChecked= false;
			this.mouseChildren = false;
			
			
		}
		public function buildBtn(id:String,isanswr:String, w:Number,h:Number):void
		{
			_bid = id;
			_isanswer = isanswr;
			
			_btnWidth = w;
			_btnHeight = h;
			_hit  = new Sprite();
			_hit.name = id;
			_hit.graphics.lineStyle(1,0x000000,0);
			_hit.graphics.beginFill(0xffffff,.1);
			_hit.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			
			
			_back = new Sprite();
			_back.graphics.lineStyle(1,SHELL_COLORS.CLR_DKBLUE,1);
			
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [SHELL_COLORS.CLR_DKGREY,SHELL_COLORS.CLR_LTGREY];
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
			_back.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod,interop,0);//,"rgb",gradRotation);
			
			
	
			//_dragback.graphics.beginFill(SHELL_COLORS.CLR_TURQUOISE,1);
			_back.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			//this.addChild(_dragback);
			//_dragback.mouseEnabled = false;
			_back.mouseChildren = false;
			this.addChild(_back);
		//	_back.mouseEnabled = false;
		//	_back.mouseChildren = false;
		}
		
		public function addLabel(str:String):void
		{
			
			var txtSprite:Sprite = new Sprite();
			txtSprite.mouseChildren = false;
			txtSprite.mouseEnabled = false;
			
			var tlf:TLFTextField = new TLFTextField();
			tlf.mouseEnabled = false;
			tlf.mouseChildren = false;
			tlf.background = false;
			
			tlf.border = false;
			//	tlf.border = true;
			tlf.width = _btnWidth;
			tlf.height =_btnHeight;// 755;
		//	tlf.autoSize = TextFieldAutoSize.LEFT;
		
		
			
			tlf.wordWrap = true;
			tlf.verticalAlign = VerticalAlign.MIDDLE;
			tlf.selectable = false;
			tlf.text = str;
		//	tlf.mouseWheelEnabled = false;
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontFamily = "Arial";
			format.fontSize = 14;
			format.color = 0xffffff;
			
			format.textAlign = TextAlign.CENTER;
			
			format.paddingLeft = 4;
			format.paddingRight = 4;
			
			
			/*
			format.paddingTop = 4;
			format.paddingBottom = 4;
			*/
			
			
			
		
			
			var myTextFlow:TextFlow = tlf.textFlow;
			
			myTextFlow.hostFormat = format;
			myTextFlow.flowComposer.updateAllControllers();
		
			
			
			
			txtSprite.addChild(tlf);
			_back.addChild(txtSprite);
			this.addChild(_hit);
			
			
			
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
			_currentState = p_value;
		}
		
		
		
		
		
	}
}