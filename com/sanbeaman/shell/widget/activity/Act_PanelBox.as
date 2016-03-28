package com.sanbeaman.shell.widget.activity
{
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.widget.BoxCopy;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	public class Act_PanelBox extends Sprite
	{
		private var _stxt:BoxCopy;
		private var _pad:Number;
		private var _sID:String;
		private var _sIndex:int;
		private var _endX:Number;
		private var _endY:Number;
		
		public function Act_PanelBox()
		{

		super();
		}
	
	public function init(str:String,uip:UIparams):void
	{
		_pad = uip.uiPadding;
		_stxt = new BoxCopy();
		var w:Number = uip.uiWidth;
		
		_stxt.addText(str,w,uip.uiFontSize,uip.uiFontColorCode,_pad);
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
		this.graphics.drawRect(txtRect.x,txtRect.y,txtRect.width, txtRect.height);
		
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