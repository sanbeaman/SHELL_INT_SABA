package com.sanbeaman.shell.widget
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	import flashx.textLayout.formats.TextAlign;
	
	
	
	
	public class DebugDisplay extends Sprite
	{
		
		private var _versionNumber:String;
		private var _sceneNumber:String;
		private var _slideNumber:String;
		private var _tlf_version:TLFTextField;
		private var _tlf_sceneNumber:TLFTextField;
		private var _tlf_slideNumber:TLFTextField;
	//	private var _tlf_1:TLFTextField;
		//private var _tlf_2:TLFTextField;
		
		public function DebugDisplay()
		{
			super();
		}
		
		
		
		public function init(version:String, scenenum:String = "", slidenumber:String = ""):void
		{
			_tlf_version= new TLFTextField();
			_tlf_version.border = false;
			_tlf_version.borderColor = 0x00ff00;
			_tlf_version.width = 50;// =200;//600;// 755;
			_tlf_version.height = 16;//600;// 755;

			_versionNumber = version;
			
			_tlf_version.htmlText = version;
			
			var format_ver:TextLayoutFormat = new TextLayoutFormat();
			format_ver.fontFamily =  SHELL_VARS.SHELL_FONT_FAMILY;//"Arial";
			format_ver.fontSize = 10;//18;
			format_ver.color = 0xcccccc;// 0x666666;
			
			
			
			var myTextFlow1:TextFlow = _tlf_version.textFlow;
			myTextFlow1.invalidateAllFormats();
			myTextFlow1.hostFormat = format_ver;
			myTextFlow1.verticalAlign =	VerticalAlign.BOTTOM;
			myTextFlow1.flowComposer.updateAllControllers();
			
			_tlf_version.x = 30;
			_tlf_version.y = 2;
			this.addChild(_tlf_version);
			
			
			_tlf_slideNumber= new TLFTextField();
			_tlf_slideNumber.wordWrap = false;
			_tlf_slideNumber.multiline = false;
			
			_tlf_slideNumber.border = true;
			_tlf_slideNumber.borderColor = 0x00ff00;
			_tlf_slideNumber.width= 70;// =200;//600;// 755;
			_tlf_slideNumber.height = 16;//600;// 755;
			_tlf_slideNumber.verticalAlign = VerticalAlign.MIDDLE; 
			_tlf_slideNumber.htmlText = slidenumber;

			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontFamily =  SHELL_VARS.SHELL_FONT_FAMILY;//"Arial";
			format.fontSize = 13;//18;
			format.color = 0x00ff00;// 0x666666;
			format.textAlign = TextAlign.CENTER;
			format.verticalAlign = VerticalAlign.MIDDLE;
			
			
			var myTextFlow3:TextFlow = _tlf_slideNumber.textFlow;
			myTextFlow3.invalidateAllFormats();
			myTextFlow3.hostFormat = format;
			//myTextFlow3.textAlign = TextAlign.CENTER;
		//	myTextFlow3.verticalAlign =	VerticalAlign.MIDDLE;
			myTextFlow3.paddingTop = 2;
			myTextFlow3.flowComposer.updateAllControllers();
			_tlf_slideNumber.x = _tlf_version.x + _tlf_version.width;//_tlf_sceneNumber.x + _tlf_sceneNumber.width + 4;
			_tlf_slideNumber.y = _tlf_version.y;// + _tlf_version.width; //_tlf_sceneNumber.y;
			this.addChild(_tlf_slideNumber);
			//trace('debugdisplay=' + _versionNumber);
		}
		public function get versionNumber():String
		{
			return _versionNumber;
		}
		
		public function set versionNumber(value:String):void
		{
			_versionNumber = value;
			_tlf_version.htmlText = _versionNumber;
		}
		
		public function get sceneNumber():String
		{
			return _sceneNumber;
		}
		
		public function set sceneNumber(value:String):void
		{
			_sceneNumber = value;
			//_tlf_sceneNumber.htmlText = 'sceneNum '+ _sceneNumber;
		}
		
		public function get slideNumber():String
		{
			return _slideNumber;
		}
		
		public function set slideNumber(value:String):void
		{
			
			_slideNumber = value;
			_tlf_slideNumber.htmlText =   _slideNumber;
		}
		
		
		
		
	}
}