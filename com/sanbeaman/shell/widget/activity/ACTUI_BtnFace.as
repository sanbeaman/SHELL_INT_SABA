package com.sanbeaman.shell.widget.activity
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	
	public class ACTUI_BtnFace extends Sprite
	{
		
		private var _colorsObject:Object;
		private var _btnW:Number;
		private var _btnH:Number;
		public function ACTUI_BtnFace()
		{
			super();
			
		}
		
		public function build(btnW:Number, btnH:Number, clrArray:Array, frameSize:Number, frameColorCode:uint):void
		{
			
			
			_btnW = btnW;
			_btnH = btnH;
			var colors:Array = clrArray;// _uiParams.uiFillColorArray;
			var color1:uint;
			var color2:uint;
			
			if (colors.length > 1) {
				color1 = colors[0];// = 0x04618d;
				color2 = colors[1];// = 0x379EE0;
		
			} else {
				color1 = colors[0];
				color2 = colors[0]
			}
			//define two colors that gradient will consist of
			
			_colorsObject = {left:color1, right:color2};
			//_colorsObject = {left:0xcc6633, right:0xff9933};
			
			var btnface:Sprite = new Sprite();
			btnface.name = 'btnface';
			
			//set an object sprite and add it to stage
			btnface.graphics.lineStyle(frameSize,frameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
			var m:Matrix = new Matrix();
			m.createGradientBox(_btnW, int(_btnH*.5), 1);
			//drawing a gradient box, set last value to 1 if you want vertical gradient or to 0 if you want horizontal gradient
			//m.createGradientBox(buttonWidth, buttonHeight, 1);
			btnface.graphics.beginGradientFill(GradientType.LINEAR, [_colorsObject.left, _colorsObject.right], [1, 1], [0x00, 0xFF], m, SpreadMethod.REFLECT);
			btnface.graphics.drawRect(0,0,_btnW,_btnH);
			btnface.graphics.endFill();
			
		
			
			var filter:BitmapFilter = getBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			var shadowFrameShadow:Sprite = new Sprite();
			shadowFrameShadow.name = "shadowFrameShadow";
			shadowFrameShadow.graphics.lineStyle(1,0xffffff,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
			shadowFrameShadow.graphics.beginFill(0xffffff,1);
			shadowFrameShadow.graphics.drawRect(0,0,_btnW,_btnH);
			shadowFrameShadow.graphics.endFill();
			shadowFrameShadow.filters = myFilters;
			
			var shadowFrame:Sprite = new Sprite();
			shadowFrame.name = "shadowFrame";
			
			shadowFrame.graphics.lineStyle(1,0xffffff,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
			shadowFrame.graphics.beginFill(0xffffff,0);
			shadowFrame.graphics.drawRect(0,0,_btnW,_btnH);
			shadowFrame.graphics.endFill();
			
			btnface.addChild(shadowFrameShadow);
			
			shadowFrameShadow.mouseChildren = false;
			shadowFrameShadow.buttonMode = false;
			shadowFrameShadow.mouseEnabled = false;
			btnface.addChild(shadowFrame);
			
			shadowFrame.mouseChildren = false;
			shadowFrame.buttonMode = false;
			shadowFrame.mouseEnabled = false;
		
			//btnface.filters = myFilters;
			this.addChild(btnface);
			btnface.mouseChildren = false;
			btnface.mouseEnabled = false;
			btnface.buttonMode = false;
		
			this.mouseChildren = false;
			//this.mouseEnabled = false;
			//this.mouseChildren = false;
			
		}
		//function that will draw a gradient
		/*
		private function _drawGradient():void {
			var m:Matrix = new Matrix();
			m.createGradientBox(_btnWidth, int(_btnHeight*.5), 1);
			//drawing a gradient box, set last value to 1 if you want vertical gradient or to 0 if you want horizontal gradient
			//m.createGradientBox(buttonWidth, buttonHeight, 1);
			_btnFace.graphics.beginGradientFill(GradientType.LINEAR, [_colorsObject.left, _colorsObject.right], [1, 1], [0x00, 0xFF], m, SpreadMethod.PAD);
			_btnFace.graphics.drawRect(0,0,_btnWidth,_btnHeight);
		}
		*/
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var angle:Number = 45;
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
		
		
	}
}