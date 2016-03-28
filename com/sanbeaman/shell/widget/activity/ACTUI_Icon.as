package com.sanbeaman.shell.widget.activity
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class ACTUI_Icon extends Sprite
	{
		
		/*
		[Embed (source="/masterShell/widget/act/icon_no.gif")]
		private var _icon_no:Class
		public var icon_no:Bitmap = new _icon_no;
		
		[Embed (source="/masterShell/widget/act/icon_yes.gif")]
		private var _icon_yes:Class
		public var icon_yes:Bitmap = new _icon_yes;
		*/
	
		private var _icon_no:Bitmap;// = new _icon_no;
		
		
		private var _icon_yes:Bitmap;// = new _icon_yes;
		
		private var _back:Sprite;
	
		
		private var _iconState:String;
		
		
		public function ACTUI_Icon()
		{
			super();
			
		}
		
		public function build(yesIcon:BitmapData, noIcon:BitmapData):void
		{
			
			this.mouseEnabled = false;
			this.mouseChildren = false;
			_back = new Sprite();
			_icon_yes = new Bitmap(yesIcon);
			_icon_no = new Bitmap(noIcon);
			
			_back.addChild(_icon_no);
			_icon_no.visible = false;
			_back.addChild(_icon_yes);
			_icon_yes.visible = false;
			_back.x = 0;
			_back.y = 0;
			this.addChild(_back);
			
		}
		 

		public function get iconState():String
		{
			return _iconState;
		}

		public function set iconState(value:String):void
		{
			_iconState = value;
			switch (_iconState) {
				case 'yes':
					_icon_yes.visible = true;
					_icon_no.visible = false;
					break
				case 'no':
					_icon_yes.visible = false;
					_icon_no.visible = true;
					break;
				default:
					_icon_yes.visible = false;
					_icon_no.visible = false;
			}
		}

	}
}