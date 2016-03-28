package com.sanbeaman.shell.widget.activity
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	public class C2R_CheckBox extends Sprite
	{
		/*
		[Embed (source="/masterShell/widgetui/hs_checkbox0.png")]
		private var _hs_checkbox00:Class
		private var _hs_checkbox0:Bitmap = new _hs_checkbox00;
		
		[Embed (source="/masterShell/widgetui/hs_checkbox1.png")]
		private var _hs_checkbox01:Class
		private var _hs_checkbox1:Bitmap = new _hs_checkbox01;
		*/
		
		private var _hs_checkbox0:Bitmap;
		private var _hs_checkbox1:Bitmap;
		private var _tracked:Boolean;
		
		public function C2R_CheckBox()
		{
			super();
		}
		public function init(cb0:Bitmap,cb1:Bitmap):void
		{
			_hs_checkbox0 = new Bitmap(cb0.bitmapData);
			_hs_checkbox1 = new Bitmap(cb1.bitmapData);
			this.addChild(_hs_checkbox0);
			this.addChild(_hs_checkbox1);
			_hs_checkbox1.visible = false;
			this.mouseEnabled = false;
			this.mouseChildren = false;
			_tracked = false;
		}

		public function get tracked():Boolean
		{
			return _tracked;
		}

		public function set tracked(value:Boolean):void
		{
			_hs_checkbox1.visible = value;
			_tracked = value;
		}

	}
}