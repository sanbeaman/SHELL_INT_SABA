package com.sanbeaman.shell.widget
{
	
	import com.sanbeaman.shell.widget.BodyUI;
	
	
	
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.text.engine.*;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.*;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class SceneNumberTXT extends BodyUI
	{
		
		private var _sNumber:String;
		private var _tlf:TLFTextField;
		public function SceneNumberTXT()
		{
			super();
		}
		
		public function init(scnum:String):void
		{
			_tlf= new TLFTextField();
			
			_tlf.width =200;//600;// 755;
			_tlf.height = 20;//600;// 755;
		//	_tlf.border = true;
			//	myTLFTextField.border = true;
			//myTLFTextField.background = tbacktrue;
			//myTLFTextField.backgroundColor = tbackColor;//0x15A5C9;
			_tlf.htmlText = scnum;
			
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			format.fontSize = 14;//18;
			format.color = 0xcccccc;// 0x666666;
			//	format.listStylePosition =  ListStylePosition.OUTSIDE;
			//format.listStyleType = ListStyleType.CIRCLE;
			
			
			format.textAlign = TextAlign.CENTER;
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.textAlign = TextAlign.RIGHT;
			myTextFlow.hostFormat = format;
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(_tlf);
		}

		public function get sNumber():String
		{
			return _sNumber;
		}

		public function set sNumber(value:String):void
		{
			_sNumber = value;
			_tlf.text = _sNumber;
			
			
		}

	}
}