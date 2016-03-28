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
	
	
	
	public class BodySubBullet extends BodyUI
	{
		
		private  var _tHeight:Number;
		private var myTLFTextField:TLFTextField;
		
		private var _tWidth:Number;
		
		public function BodySubBullet()
		{
		super();
	}
	
	public function init(id:String, order:int, time:Number, str:String, textWidth:Number = 600):void
	{
		this.id = id;
		this.order = order;
		this.time = time;
		this.type = "bodysubbullet";
		_tWidth = textWidth;
		_addText(str,_tWidth);
		
	}
	
	
	private function _addText(str:String, twidth):void
	{
		myTLFTextField = new TLFTextField();

		myTLFTextField.embedFonts = true;
		myTLFTextField.antiAliasType = AntiAliasType.ADVANCED;
		//addChild(myTLFTextField); 
		myTLFTextField.width = twidth;//600;// 755;
		//	myTLFTextField.autoSize = 
		//myTLFTextField.height =theight;// 50;
		//myTLFTextField.verticalAlign = VerticalAlign.MIDDLE;
		myTLFTextField.selectable = false;
		//	myTLFTextField.border = true;
		//myTLFTextField.background = tbacktrue;
		//myTLFTextField.backgroundColor = tbackColor;//0x15A5C9;
		myTLFTextField.htmlText = str;
		
		
		var format:TextLayoutFormat = new TextLayoutFormat();
		format.fontLookup = FontLookup.EMBEDDED_CFF;
		format.renderingMode = RenderingMode.CFF;
		format.cffHinting = CFFHinting.NONE;
		
		format.fontFamily = "Arial";
		format.fontSize = 14;
		format.color = 0x666666;
		format.listAutoPadding = 80;
		format.listStylePosition =  ListStylePosition.OUTSIDE;
		format.listStyleType = ListStyleType.DISC;
		
		
		var myTextFlow:TextFlow = myTLFTextField.textFlow;
		myTextFlow.invalidateAllFormats();
		myTextFlow.hostFormat = format;
		myTextFlow.flowComposer.updateAllControllers();
		this.addChild(myTLFTextField);
		
		_tHeight =int( myTLFTextField.textHeight);
		
		trace("BodyBullet height= " + this.height);
		
		
	}
	
	public function get tHeight():Number
	{
		var th:Number = int(myTLFTextField.textHeight);
		return _tHeight;
	}
	
	
}
}