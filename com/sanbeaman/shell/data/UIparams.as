package com.sanbeaman.shell.data
{
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class UIparams
	{
		
		private var _uiId:String;
		
		//Layout Parameters
		private var _uiX:Number;
		private var _uiY:Number;
		
		private var _uiXloc:String;
		private var _uiYloc:String;
		
		private var _uiPadX:Number;
		private var _uiPadY:Number;
		private var _uiWidth:Number;
		private var _uiHeight:Number;
		private var _uiMargin:Number;
		private var _uiPadding:Number;
		private var _uiRotation:Number;
		//graphic parameters
		private var _uiFillColorType:String;
		private var _uiFillColorArray:Array;
		
		
		private var _uiFillColorGrad1:String;
		private var _uiFillColorGrad2:String;
		
		//For Label Boxes
		private var _uiFillColorLabel:String;
		private var _uiFillAlphaLabel:Number;
		
		private var _uiFrameColorLabel:String;
		private var _uiFrameAlphaLabel:Number;
		
		private var _uiFillColor:String;
		private var _uiFillColorCode:uint;
		private var _uiFillAlpha:Number; 
		
		private var _uiPulseColor:String;
		private var _uiPulseColorCode:uint;
		private var _uiPulseAlpha:Number; 
		
		private var _uiFrameSize:Number;
		private var _uiFrameShape:String;
		private var _uiFrameColor:String;
		private var _uiFrameColorCode:uint;
		
		private var _uiFrameAlpha:Number;
		
		
		//text parameters
		private var _uiFontSize:Number;
		private var _uiFontColor:String; 
		private var _uiFontColorCode:uint;
		private var _uiFontStyle:String;
		
		//if second font color is necessary
		private var _uiFontColor2:String; 
		private var _uiFontColorCode2:uint;
		
		private var _uiFontHAlign:String;
		private var _uiFontVAlign:String;
		
		private var _uiFontHAlignCONST:String;
		private var _uiFontVAlignCONST:String;
		
		
		private var _uiFormatType:String;
		private var _uiEffect:String;
		
		private var _uiTrans:String;
		private var _uiEase:String;
		
		private var _uiTime:Number;
		
		
		private var _uiContentPath:String;
		
		public function UIparams()
		{
		}

		public function set uiFontColor2(value:String):void
		{
			_uiFontColor2 = value;
		}
		public function get uiFontColorCode2():uint
		{
			_uiFontColorCode2 = SHELL_COLORS.lookUpColor(_uiFontColor2);
			return _uiFontColorCode2;
		}

		public function get uiFontHAlign():String
		{
			return _uiFontHAlign;
		}

		public function get uiEffect():String
		{
			return _uiEffect;
		}

		public function set uiEffect(value:String):void
		{
			_uiEffect = value;
		}

		public function get uiTime():Number
		{
			return _uiTime;
		}

		public function set uiTime(value:Number):void
		{
			_uiTime = value;
		}

		public function get uiEase():String
		{
			return _uiEase;
		}

		public function set uiEase(value:String):void
		{
			_uiEase = value;
		}

		public function get uiTrans():String
		{
			return _uiTrans;
		}

		public function set uiTrans(value:String):void
		{
			_uiTrans = value.toLowerCase();
		}

		public function get uiX():Number
		{
			return _uiX;
		}

		public function set uiX(value:Number):void
		{
			_uiX = value;
		}

		public function get uiY():Number
		{
			return _uiY;
		}

		public function set uiY(value:Number):void
		{
			_uiY = value;
		}

		public function get uiWidth():Number
		{
			return _uiWidth;
		}

		public function set uiWidth(value:Number):void
		{
			_uiWidth = value;
		}

		public function get uiHeight():Number
		{
			return _uiHeight;
		}

		public function set uiHeight(value:Number):void
		{
			_uiHeight = value;
		}

		public function get uiPadding():Number
		{
			return _uiPadding;
		}

		public function set uiPadding(value:Number):void
		{
			_uiPadding = value;
		}

		public function get uiFillColor():String
		{
			return _uiFillColor;
		}

		public function set uiFillColor(value:String):void
		{
			_uiFillColor = value;
			
		}

		public function get uiFillColorCode():uint
		{
			_uiFillColorCode = SHELL_COLORS.lookUpColor(_uiFillColor);
			return _uiFillColorCode;
		}

		/*
		public function set uiFillColorCode(value:uint):void
		{
			_uiFillColorCode = value;
		}
*/
		public function get uiFillAlpha():Number
		{
			return _uiFillAlpha;
		}

		public function set uiFillAlpha(value:Number):void
		{
			_uiFillAlpha = value;
		}

		public function get uiFrameSize():Number
		{
			return _uiFrameSize;
		}

		public function set uiFrameSize(value:Number):void
		{
			_uiFrameSize = value;
		}

		public function get uiFrameColor():String
		{
			return _uiFrameColor;
		}

		public function set uiFrameColor(value:String):void
		{
			_uiFrameColor = value;
			
		}

		public function get uiFrameColorCode():uint
		{
			_uiFrameColorCode = SHELL_COLORS.lookUpColor(_uiFrameColor);
			
			//_uiFillColorCode = SHELL_COLORS.lookUpColor(_uiFrameColor);
			return _uiFrameColorCode;
		}

		

		public function get uiFrameAlpha():Number
		{
			return _uiFrameAlpha;
		}

		public function set uiFrameAlpha(value:Number):void
		{
			_uiFrameAlpha = value;
		}

		public function get uiFontSize():Number
		{
			return _uiFontSize;
		}

		public function set uiFontSize(value:Number):void
		{
			_uiFontSize = value;
		}

		public function get uiFontColor():String
		{
			return _uiFontColor;
		}

		public function set uiFontColor(value:String):void
		{
			_uiFontColor = value;
		}

		public function get uiFontColorCode():uint
		{
			_uiFontColorCode = SHELL_COLORS.lookUpColor(_uiFontColor);
			return _uiFontColorCode;
		}

		public function get uiRotation():Number
		{
			return _uiRotation;
		}

		public function set uiRotation(value:Number):void
		{
			_uiRotation = value;
		}

		public function get uiId():String
		{
			return _uiId;
		}

		public function set uiId(value:String):void
		{
			_uiId = value;
		}

		public function get uiContentPath():String
		{
			return _uiContentPath;
		}

		public function set uiContentPath(value:String):void
		{
			_uiContentPath = value;
		}

		public function get uiFrameShape():String
		{
			
			return _uiFrameShape;
		}

		public function set uiFrameShape(value:String):void
		{
			_uiFrameShape = String(value).toLowerCase();
		}

		public function get uiFontStyle():String
		{
			return _uiFontStyle;
		}

		public function set uiFontStyle(value:String):void
		{
			_uiFontStyle = value;
		}

		public function get uiFontVAlignCONST():String
		{
			var conststr:String;
			var str:String = _uiFontVAlign;
			switch (str) {
					case 'middle':
						conststr = VerticalAlign.MIDDLE;
						break;
					case 'bottom':
						conststr = VerticalAlign.BOTTOM;
						break;
					case 'top':
						conststr = VerticalAlign.TOP;
						break;
					default:

				}
			
			return conststr;
		}

		public function set uiFontHAlign(value:String):void
		{
			_uiFontHAlign = value;
		}

		public function get uiFontHAlignCONST():String
		{
			var conststr:String;
			
			var str:String = _uiFontHAlign;
			
			switch (str) {
					case 'center':
						conststr = TextAlign.CENTER;
						break;
					case 'right':
						conststr = TextAlign.RIGHT;
						break;
					case 'left':
						conststr = TextAlign.LEFT;
						break;
					default:
						conststr = null;
				}
			
			
			return conststr;
		}

		public function set uiFontVAlign(value:String):void
		{
			_uiFontVAlign = value;
		}
		public function get uiFontVAlign():String
		{
			return _uiFontVAlign;// = value;
		}
		public function get uiPadX():Number
		{
			return _uiPadX;
		}

		public function set uiPadX(value:Number):void
		{
			_uiPadX = value;
		}

		public function get uiPadY():Number
		{
			return _uiPadY;
		}

		public function set uiPadY(value:Number):void
		{
			_uiPadY = value;
		}

		public function get uiPulseColor():String
		{
			return _uiPulseColor;
		}

		public function set uiPulseColor(value:String):void
		{
			_uiPulseColor = value;
		}

		public function get uiPulseColorCode():uint
		{
			_uiPulseColorCode = SHELL_COLORS.lookUpColor(_uiPulseColor);
			return _uiPulseColorCode;
		}

		public function get uiFillColorArray():Array
		{
			return _uiFillColorArray;
		}

		public function set uiFillColorArray(value:Array):void
		{
			_uiFillColorArray = value;
		}

		public function get uiFillColorType():String
		{
			return _uiFillColorType;
		}

		public function set uiFillColorType(value:String):void
		{
			_uiFillColorType = value;
		}

		public function get uiFillColorGrad1():String
		{
			return _uiFillColorGrad1;
		}

		public function set uiFillColorGrad1(value:String):void
		{
			_uiFillColorGrad1 = value;
		}

		public function get uiFillColorGrad2():String
		{
			return _uiFillColorGrad2;
		}

		public function set uiFillColorGrad2(value:String):void
		{
			_uiFillColorGrad2 = value;
		}

		public function get uiFillColorLabel():String
		{
			return _uiFillColorLabel;
		}

		public function set uiFillColorLabel(value:String):void
		{
			_uiFillColorLabel = value;
		}

		public function get uiFillAlphaLabel():Number
		{
			return _uiFillAlphaLabel;
		}

		public function set uiFillAlphaLabel(value:Number):void
		{
			_uiFillAlphaLabel = value;
		}

		public function get uiFrameColorLabel():String
		{
			return _uiFrameColorLabel;
		}

		public function set uiFrameColorLabel(value:String):void
		{
			_uiFrameColorLabel = value;
		}

		public function get uiFrameAlphaLabel():Number
		{
			return _uiFrameAlphaLabel;
		}

		public function set uiFrameAlphaLabel(value:Number):void
		{
			_uiFrameAlphaLabel = value;
		}

		public function get uiMargin():Number
		{
			return _uiMargin;
		}

		public function set uiMargin(value:Number):void
		{
			_uiMargin = value;
		}

		public function get uiFormatType():String
		{
			return _uiFormatType;
		}

		public function set uiFormatType(value:String):void
		{
			_uiFormatType = value;
		}

		public function get uiXloc():String
		{
			return _uiXloc;
		}

		public function set uiXloc(value:String):void
		{
			_uiXloc = value;
		}

		public function get uiYloc():String
		{
			return _uiYloc;
		}

		public function set uiYloc(value:String):void
		{
			_uiYloc = value;
		}

		


	}
}