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
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	import flashx.textLayout.formats.*;
	
	public class BodyCopy extends BodyUI
	{
		public function BodyCopy()
		{
			super();
		}
		
		public function init(id:String, order:int, time:Number, str:String):void
		{
			this.id = id;
			this.order = order;
			this.time = time;
			this.type = "bodycopy";
			_addText(str);
			
		}
		
		
		private function _addText(str:String):void
		{
			var myTLFTextField:TLFTextField = new TLFTextField();
			//addChild(myTLFTextField); 
			myTLFTextField.width =600;// 755;
			//myTLFTextField.autoSize = 
				//myTLFTextField.height =theight;// 50;
				//myTLFTextField.verticalAlign = VerticalAlign.MIDDLE;
				myTLFTextField.selectable = false;
			//	myTLFTextField.border = true;
			//myTLFTextField.background = tbacktrue;
			//myTLFTextField.backgroundColor = tbackColor;//0x15A5C9;
			myTLFTextField.text = str;
			
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontFamily = "Arial";
			format.fontSize = 18;
			format.color = 0x666666;
		//	format.listStylePosition =  ListStylePosition.OUTSIDE;
			//format.listStyleType = ListStyleType.CIRCLE;
			
			
			var myTextFlow:TextFlow = myTLFTextField.textFlow;
			
			myTextFlow.hostFormat = format;
			myTextFlow.flowComposer.updateAllControllers();
			this.addChild(myTLFTextField);
			
		}
		
	}
}