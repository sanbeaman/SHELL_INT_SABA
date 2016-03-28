package com.sanbeaman.shell.widget.activity
{
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.widget.BoxCopy;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	
	import flashx.textLayout.formats.Direction;
	
	public class ACTUI_PanelBox extends Sprite
	{
		private var _stxt:BoxCopy;
		private var _xpad:Number;
		private var _ypad:Number;
		private var _sID:String;
		private var _sIndex:int;
		private var _endX:Number;
		private var _endY:Number;
		
		private var _localeID:String;
		private var _fontFamily:String;
		
		public function ACTUI_PanelBox()
		{

		super();
		}
	
	public function init(str:String,uip:UIparams,fontfamily:String = "Arial", langID:String = null):void
	{
		//_pad = uip.uiPadding;
		_fontFamily = fontfamily;
		_localeID = (langID != null)?langID:"en";
		//_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
		//_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
	
		var txtwidth:Number = uip.uiWidth;
		var txtheight:Number = uip.uiHeight;
		
		var fsize:Number = uip.uiFontSize;
		var fcolorcode:uint = uip.uiFontColorCode;
		
		var xpad:Number = uip.uiPadX;
		var ypad:Number = uip.uiPadY;
		
		var fontalign:String = uip.uiFontHAlign;
		
		_stxt = new BoxCopy();
		_stxt.addText(str,txtwidth,fsize,fcolorcode,xpad,ypad,txtheight,fontalign,_fontFamily,_localeID);
		//_stxt.addText(str,w,uip.uiFontSize,uip.uiFontColorCode,uip.uiPadX,uip.uiPadY,0,_fontFamily,_localeID);
		
		
		var th:Number = _stxt.txtHeight;
		
		var txtRect:Rectangle = _stxt.getBounds(this);
		trace("feedback text height =  " + th);
		var frameSize:Number = uip.uiFrameSize;
	//	var frSize:int = uip.uiFrameSize;   // frameSize;
		var frameAlpha:Number = uip.uiFrameAlpha;
		
		if (frameSize <= 0) {
			frameAlpha = 0;
		} 
		
		this.graphics.lineStyle(frameSize,uip.uiFrameColorCode,frameAlpha);
		this.graphics.beginFill(uip.uiFillColorCode,uip.uiFillAlpha);
		this.graphics.drawRect(0,0,txtwidth, th);
	//	this.graphics.drawRect(txtRect.x,txtRect.y,txtRect.width, txtRect.height);
		
		trace("txtRect=> " + txtRect.x +" , "+ txtRect.y +" , "+ txtRect.width  +" , "+ txtRect.height);
		//this.graphics.drawRect(0,0,300,300);
		
		this.addChild(_stxt);
		
	}

		public function get sID():String
		{
			return _sID;
		}

		public function set sID(value:String):void
		{
			_sID = value;
		}

		public function get sIndex():int
		{
			return _sIndex;
		}

		public function set sIndex(value:int):void
		{
			_sIndex = value;
		}

		public function get endX():Number
		{
			return _endX;
		}

		public function set endX(value:Number):void
		{
			_endX = value;
		}

		public function get endY():Number
		{
			return _endY;
		}

		public function set endY(value:Number):void
		{
			_endY = value;
		}


}
}