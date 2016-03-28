package com.sanbeaman.shell.widget.activity
{
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.ui.BTN_ShellMain;
	import com.sanbeaman.shell.ui.BitmapSprite;
	
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
	import flash.display.*;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	public class ACTUI_Btn extends MovieClip
	{
		[Embed (source="/masterShell/widget/act/BTN_TrgiggerOrange1.png")]
		private var _btnTriggerBack:Class
		public var btnTriggerBack:Bitmap = new _btnTriggerBack;
		
		private var _uip:UIparams;
		
		private var _btnBackSprite:BitmapSprite;
		private var _btnLabelBack:Sprite;
		
		public function ACTUI_Btn()
		{
			super();
			
		}
		
		public function buildBtn(lbl:String, uip:UIparams):void
		{
			_uip = new UIparams();
			_uip = uip;
			
			
			var _scaleRect:Rectangle = new Rectangle(20,8,120,18);
			_btnBackSprite = new BitmapSprite(btnTriggerBack.bitmapData,_scaleRect);
			
			var tlf:TLFTextField = new TLFTextField();
				//	tlf.border = true;
				
				tlf.height = _uip.uiHeight;
				tlf.autoSize = TextFieldAutoSize.LEFT;
				
				tlf.verticalAlign = VerticalAlign.MIDDLE;
				tlf.selectable = false;
				tlf.text = lbl;
				
				var format:TextLayoutFormat = new TextLayoutFormat();
				format.fontFamily = "Arial";
				format.fontSize = _uip.uiFontSize;// 14;
				format.color =_uip.uiFontColorCode;// 0x000000;
				
				format.paddingLeft = 4;
				format.paddingRight = 4;
				/*
				format.paddingTop = 4;
				format.paddingBottom = 4;
				*/
				format.textAlign = TextAlign.CENTER;
			
				var myTextFlow:TextFlow = tlf.textFlow;
				
				myTextFlow.hostFormat = format;
				myTextFlow.flowComposer.updateAllControllers();
				
				var txtWidth:Number = tlf.width;
				
				trace("txtwodth= " + txtWidth);
				tlf.mouseEnabled = false;
				tlf.mouseChildren = false;
				
				_btnBackSprite.width = txtWidth + 40;// txtWidth + 40;
				_btnBackSprite.height =  _uip.uiHeight;//40
				tlf.x=20;
				tlf.y= 4;
				
				_btnBackSprite.addChild(tlf);
				this.addChild(_btnBackSprite);
				
				
		}
	}
}