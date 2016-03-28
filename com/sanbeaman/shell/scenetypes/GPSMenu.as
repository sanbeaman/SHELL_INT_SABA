package com.sanbeaman.shell.scenetypes
{
	import com.sanbeaman.shell.ui.GPSWindow;
	import com.sanbeaman.shell.widget.GPSNavBar;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class GPSMenu extends MovieClip
	{
		
		private var _contentBack:Sprite;
		public  var contentWindow:Sprite;
		public  var noteWindow:Sprite;
		private var _contentMask:Sprite;
		
		private var _gpsNoteBox:Sprite;
		private var _gpsNoteText:TLFTextField;
		private var _gpsNoteTextFormat:TextLayoutFormat;
		//public var navBar:GPSNavBar;
		
		private var _windowWidth:Number=700;// SHELL_VARS.GPS_CONTENT_WIDTH; //700;
		private var _windowHeight:Number = 450;//SHELL_VARS.GPS_CONTENT_HEIGHT;// 450;
		
		
		private var _holderWidth:Number = 745;
		private var _holderHeight:Number = 525;
		
		private var _holderX:Number = 23;
		private var _holderY:Number = 20;
		
		public function GPSMenu()
		{
			super();
			/*
			var gps:GPSWindow = new GPSWindow();
			gps.buildGPSWindow(745,525);
			gps.x = 0;
			gps.y = 0;
			
			this.addChild(gps);
			*/
		
			var gps:Sprite = new Sprite();
		//	gps.buildGPSWindow(745,525);
			gps.x = 0;
			gps.y = 0;
			
			this.addChild(gps);
			
			_contentBack = new Sprite();
			_contentBack.graphics.beginFill(0xffffff,1);
			_contentBack.graphics.drawRect(0,0,_windowWidth,_windowHeight);
			_contentBack.graphics.endFill();
			
			_contentBack.x = _holderX;//23;//SHELL_VARS.GPS_WINDOW_X;// 23;
			_contentBack.y =_holderY;// 20;// SHELL_VARS.GPS_WINDOW_Y; //20;
			
			gps.addChild(_contentBack);
			
			
			contentWindow = new Sprite();
			contentWindow.graphics.beginFill(0xffffff,1);
			contentWindow.graphics.drawRect(0,0,_windowWidth,_windowHeight);
			contentWindow.graphics.endFill();
			
			//contentWindow.x = 23;
		//	contentWindow.y = 20;
			
			_contentBack.addChild(contentWindow);
			
			/*
			navBar = new GPSNavBar();
			navBar.x = 0;
			navBar.y = 400;
			
			_contentBack.addChild(navBar);
			*/
			
			_contentMask = new Sprite();
			_contentMask.graphics.beginFill(0xffffff,1);
			_contentMask.graphics.drawRect(0,0,_windowWidth,_windowHeight);
			_contentMask.graphics.endFill();
			
			//_contentMask.x = 24;
			//_contentMask.y = 24;
			
			_contentBack.addChild(_contentMask);
			_contentBack.mask = _contentMask;
			/*
			var bk:Sprite = new Sprite();
			bk.graphics.lineStyle(1,0xff0000);
			bk.graphics.beginFill(0xffffff,0);
			bk.graphics.drawRect(0,0,_windowWidth,_windowHeight);
			bk.graphics.endFill();
			
			bk.x = SHELL_VARS.GPS_WINDOW_X;// 23;
			bk.y =  SHELL_VARS.GPS_WINDOW_Y; //20;
			
			this.addChild(bk);
			
			*/
			noteWindow = new Sprite();
			noteWindow.y = 4;
			
			_gpsNoteBox = new Sprite();
			_gpsNoteBox.graphics.lineStyle(4,SHELL_COLORS.CLR_LTGREY,1,true,LineScaleMode.NONE, CapsStyle.NONE );
			_gpsNoteBox.graphics.moveTo(0,0);
			//_gpsNoteBox.graphics.lineTo(SHELL_VARS.GPS_CONTENT_WIDTH,0);
			_gpsNoteBox.graphics.lineTo(_windowWidth,0);
			
			_gpsNoteBox.x = _contentBack.x;
			_gpsNoteBox.y = _contentBack.y + _contentBack.height + 10;
			
			_gpsNoteBox.addChild(noteWindow);
			
			gps.addChild(_gpsNoteBox);
			
			
			
		}
		
	}
}