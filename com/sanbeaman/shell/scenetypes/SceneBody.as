package com.sanbeaman.shell.scenetypes
{
	import com.sanbeaman.shell.data.TemplateObject;
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
	
	import com.sanbeaman.shell.utils.SimpleUtils;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class SceneBody extends MovieClip
	{
		private var _back:Sprite;
		
		private var _contentBack:Sprite;
		
		//private var _contentWidth:Number;
		//private var _contentHeight:Number;
		
		private var _contentBack_frameSize:int;
		private var _contentBack_frameColor:String;
		private var _contentBack_frameColorCode:uint;
		private var _contentBack_frameAlpha:Number;
		
		private var _contentBack_fillColor:String;
		private var _contentBack_fillColorCode:uint;
		private var _contentBack_fillAlpha:Number;
		
		
		private var _contentX:Number;
		private var _contentY:Number;
		
		private var _contentBack_x:Number;
		private var _contentBack_y:Number;
		
		public var headerArea:Sprite;
		private var _headerAreaInside:Boolean = true;
		private var _headerArea_x:Number;
		private var _headerArea_y:Number;
		
		private var _noteBox_frameSize:int;
		private var _noteBox_frameColor:String;
		private var _noteBox_frameColorCode:uint;
		private var _noteBox_frameAlpha:Number;
		private var _noteBox_yPad:Number;
		
	
		public  var contentWindow:Sprite;
		public  var noteWindow:Sprite;
		private var _contentMask:Sprite;
		
		private var _noteBox:Sprite;
		private var _noteBoxText:TLFTextField;
		private var _noteBoxTextFormat:TextLayoutFormat;
		//public var navBar:GPSNavBar;
		
		private var _contentWidth:Number;//= SHELL_VARS.GPS_CONTENT_WIDTH; //700;
		private var _contentHeight:Number;// =SHELL_VARS.GPS_CONTENT_HEIGHT;// 450;
		
		
		public var playerHolder:Sprite;
		private var _playerHolder_x:Number;
		private var _playerHolder_y:Number;
		
		private var _courseTemplate:String;
	//	private var _hasHeaderWindow:Boolean;
		
		
		private var _to:TemplateObject;
		
		public function SceneBody()
		{
			super();
			/*
			var gps:GPSWindow = new GPSWindow();
			gps.buildGPSWindow(745,525);
			gps.x = 0;
			gps.y = 0;
			
			this.addChild(gps);
			*/
		}
		public function init(templateXML:XMLList):void
		{
			
			var sceneBdyXML:XMLList = templateXML.sceneBody;
			
			//_to = templateobject;
		//	_courseTemplate = template;
			_contentWidth = sceneBdyXML.@width;// contentW;
			_contentHeight =  sceneBdyXML.@height;//contentH;
			_contentX =sceneBdyXML.@x;// contentX;
			_contentY = sceneBdyXML.@y;//contentY;
			_contentBack_x = contentX;
			_contentBack_y = contentY;
	
			_contentBack_frameSize = sceneBdyXML.@frameSize;   //1;
			_contentBack_frameColor = sceneBdyXML.@frameColor;// "black";
			_contentBack_frameColorCode = SHELL_COLORS.lookUpColor(_contentBack_frameColor);
			_contentBack_frameAlpha = sceneBdyXML.@frameAlpha;// 0;
			_contentBack_fillColor = sceneBdyXML..@fillColor;// "white";
			_contentBack_fillColorCode = SHELL_COLORS.lookUpColor(_contentBack_fillColor);
			_contentBack_fillAlpha = sceneBdyXML.@fillAlpha;// 1;
			
			var sceneHeadXML:XMLList = templateXML.sceneHeader;
			var sceneHeaderInside:String = (sceneHeadXML.hasOwnProperty("@inside"))?sceneHeadXML.@inside:'false';
			
			_headerAreaInside = SimpleUtils.convertString2Boolean(sceneHeaderInside);
		//	trace('sceneHeaderInside= ' +sceneHeaderInside +'  -  '+_headerAreaInside);
			_headerArea_x = sceneHeadXML.@x;
			_headerArea_y= sceneHeadXML.@y;
			
			headerArea = new Sprite();
			headerArea.x = _headerArea_x;// = 0
			headerArea.y = _headerArea_y;//= 0;
			
		
			
			_back = new Sprite();
			/*
			_back.graphics.lineStyle(2,0xff0000,1);
			_back.graphics.beginFill(0xcccccc,.2);
			_back.graphics.drawRect(0,0,_contentWidth,_contentHeight);
			_back.graphics.endFill();
			*/
			
		//	gps.buildGPSWindow(745,525);
			_back.x = 0;
			_back.y = 0;
			
			this.addChild(_back);
			_contentBack = new Sprite();
		
			_contentBack.graphics.lineStyle(_contentBack_frameSize,
				_contentBack_frameColorCode,_contentBack_frameAlpha,true,
				LineScaleMode.NONE, CapsStyle.SQUARE,JointStyle.MITER);
			
			_contentBack.graphics.beginFill(_contentBack_fillColorCode,_contentBack_fillAlpha);
			
		//	_contentBack.graphics.beginFill(_contentBack_fillColorCode,_contentBack_fillAlpha);
			_contentBack.graphics.drawRect(0,0,_contentWidth,_contentHeight);
			_contentBack.graphics.endFill();
			
			_contentBack.x = _contentBack_x;//SHELL_VARS.GPS_WINDOW_X;// 23;
			_contentBack.y = _contentBack_y;// SHELL_VARS.GPS_WINDOW_Y; //20;
			
			_back.addChild(_contentBack);
			
			
			contentWindow = new Sprite();
			contentWindow.graphics.lineStyle(_contentBack_frameSize,
				_contentBack_frameColorCode,
				0,
				true,
				LineScaleMode.NONE, CapsStyle.SQUARE,JointStyle.MITER);
			
			contentWindow.graphics.beginFill(_contentBack_fillColorCode,_contentBack_fillAlpha);
			contentWindow.graphics.drawRect(0,0,_contentWidth,_contentHeight);
			contentWindow.graphics.endFill();
		//	contentWindow.graphics.beginFill(0xffffff,1);
			//contentWindow.graphics.drawRect(0,0,_windowWidth,_windowHeight);
		//	contentWindow.graphics.endFill();
			
			//contentWindow.x = 23;
		//	contentWindow.y = 20;
			
			if (_headerAreaInside){
				contentWindow.addChild(headerArea);
			} else {
				
				_back.addChild(headerArea);
				trace('_back>  y=' + _back.y +' headerArea>  y=' + headerArea.y + ' x= ' +headerArea.x);
			}
			_contentBack.addChild(contentWindow);
			
			/*
			navBar = new GPSNavBar();
			navBar.x = 0;
			navBar.y = 400;
			
			_contentBack.addChild(navBar);
			*/
			
			_contentMask = new Sprite();
			_contentMask.graphics.beginFill(0x000000,1);
			_contentMask.graphics.drawRect(0,0,_contentWidth,_contentHeight);
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
			var noteBlockXML:XMLList = templateXML.noteBlock;
			/***
			 * width="700" height="30"
			 *  x="0" y="row" 
			 * margin="10" xPad="10" yPad="6" 
			 * frameSize="4" frameColor="ltgrey" frameAlpha="1" 
			 * fillColor="black" fillAlpha="0"
			 *  fontName="Arial" fontSize="14" fontColor="white" fontStyle="reg" fontAlign="center" fontFX="x"
			 * 
			 *  */
			var noteBox_x:String  = noteBlockXML.@x;;
			var noteBox_y:String  = noteBlockXML.@y;
			var noteBox_margin:Number = (noteBlockXML.hasOwnProperty("@margin"))?noteBlockXML.@margin:0;
			var noteBox_xpad:Number = (noteBlockXML.hasOwnProperty("@xPad"))?noteBlockXML.@xPad:0;
			var noteBox_ypad:Number = (noteBlockXML.hasOwnProperty("@yPad"))?noteBlockXML.@yPad:0;
			
			_noteBox_frameSize = noteBlockXML.@frameSize;// 4;
			_noteBox_frameColor = noteBlockXML.@frameColor;// "ltgrey";
			_noteBox_frameColorCode = SHELL_COLORS.lookUpColor(_noteBox_frameColor);
			_noteBox_frameAlpha = noteBlockXML.@frameAlpha;// 1;
			
			var newNoteBoxX:Number;
			var newNoteBoxY:Number;
			 if (noteBox_x == 'row'){
				 newNoteBoxX = _contentBack.x;
			 } else {
				 newNoteBoxX = noteBox_x as Number;
			 }
			 
			 if (noteBox_y == 'row'){
				 newNoteBoxY =  _contentBack.y + _contentBack.height + noteBox_ypad;
			 } else {
				 newNoteBoxX = noteBox_x as Number;
			 }
		
			_noteBox = new Sprite();
			_noteBox.graphics.lineStyle(_noteBox_frameSize,_noteBox_frameColorCode,_noteBox_frameAlpha,true,LineScaleMode.NONE, CapsStyle.NONE );
			_noteBox.graphics.moveTo(0,0);
			_noteBox.graphics.lineTo(_contentWidth,0);
			
			_noteBox.x = newNoteBoxX;//_contentBack.x;
			_noteBox.y =  newNoteBoxY;//_contentBack.y + _contentBack.height + _noteBox_yPad;
			
			noteWindow = new Sprite();
			noteWindow.y = _noteBox_frameSize;//4;
			
			_noteBox.addChild(noteWindow);
			
			_back.addChild(_noteBox);
			
			if (_contentBack_frameAlpha >  0){
				var frameShape:Shape = new Shape();
				
				frameShape.graphics.lineStyle(_contentBack_frameSize,
				_contentBack_frameColorCode,
				_contentBack_frameAlpha,
				true,
				LineScaleMode.NONE, CapsStyle.SQUARE,JointStyle.MITER);
			
			
				frameShape.graphics.drawRect(0,0,_contentWidth,_contentHeight);
		
			
			frameShape.x = _contentBack_x;//SHELL_VARS.GPS_WINDOW_X;// 23;
			frameShape.y = _contentBack_y;// SHELL_VARS.GPS_WINDOW_Y; //20;
			
			_back.addChild(frameShape);
			}
			
			/*
			playerHolder = new Sprite();
			playerHolder.x = 350;
			playerHolder.y = 558;
			
			this.addChild(playerHolder);
			*/
		//	private var _playerHolder_x:Number;
			//private var _playerHolder_y:Number;
			
		}

		public function get contentWidth():Number
		{
			return _contentWidth;
		}

		

		public function get contentHeight():Number
		{
			return _contentHeight;
		}
		
		public function get contentX():Number
		{
			return _contentX;
		}
		
		
		
		public function get contentY():Number
		{
			return _contentY;
		}

		

		
	}
}