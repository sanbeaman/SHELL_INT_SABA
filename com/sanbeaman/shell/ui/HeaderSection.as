package com.sanbeaman.shell.ui
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.*;
	import flash.text.engine.*;

	
	public class HeaderSection extends Sprite
	{
		private var _headerBack:Shape;
		
		private var _fontColor:uint;
		private var _fontSize:Number;
		private var _backColor:uint;
		
		private var _backWidth:Number;
		private var _backHeight:Number;
		
		private var tb:TextBlock = new TextBlock(); 
		private var te:TextElement; 
		private var ef:ElementFormat; 
		private var fd:FontDescription = new FontDescription(); 
		private var str:String; 
		private var tl:TextLine; 
		
		public function HeaderSection(backClr:uint,fontClr:uint,fontSize:Number, backWidth:Number,backHeight:Number,str:String)
		{
			
			super();
			_backWidth = backWidth;
			_backHeight = backHeight;
			
			_backColor = backClr;
			_fontColor = fontClr;
			
			_headerBack = new Shape();
			_headerBack.graphics.beginFill(_backColor,0);
			_headerBack.graphics.drawRect(0,0,_backWidth,_backHeight);
			this.addChild(_headerBack);
			
			_addHeader(str,fontSize,fontClr);
			
		}
	
		private function _addHeader(str:String,fntsize:Number, fntclr:uint):void
		{
			
			// initialize the headline container and controller objects 
			var fd1:FontDescription = new FontDescription(); 
			fd1.fontName = "Arial, Helvetica, _sans"; 
			fd1.fontPosture = FontPosture.NORMAL; 
			fd1.fontWeight = FontWeight.BOLD;
			
			trace('string='+ str);
			//fd1.fontName = "Arial"; 
			ef = new ElementFormat(fd1); 
			ef.fontSize =fntsize;// 30; 
			ef.color =fntclr;// 0xffffff;; 
			//str = "This is flash text"; 
			te = new TextElement(str, ef); 
			tb.content = te; 
			tl = tb.createTextLine(null,600); 
			//tl.x = 20;
		//	tl.y = 36;
			this.addChild(tl); 
			
		}
	}
}

