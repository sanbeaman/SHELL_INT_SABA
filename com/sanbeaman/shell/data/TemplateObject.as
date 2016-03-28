package com.sanbeaman.shell.data
{
	public class TemplateObject
	{
		private var _templateCode:String;
		private var _templateName:String;
		
		private var _shellBlockColor:String;
		private var _shellBlockColorCode:uint;
		private var _shellBlockAlpha:Number;
		
		//Scene Holder Dimensions
		private var _holder_width:Number;
		private var _holder_height:Number;
		private var _holder_x:Number;
		private var _holder_y:Number;
		
		
		private var _content_width:Number;
		private var _content_height:Number;
		
		private var _content_x:Number;
		private var _content_y:Number;
		
		private var _contentBack_frameSize:Number;// = 1;
		private var _contentBack_frameColor:String;// = "black";
		//private var _contentBack_frameColorCode = SHELL_COLORS.lookUpColor(_contentBack_frameColor);
		private var _contentBack_frameAlpha:Number;// =  0;
		private var _contentBack_fillColor:String;// = "white";
	//	private var _contentBack_fillColorCode:uint;// = SHELL_COLORS.lookUpColor(_contentBack_fillColor);
		private var _contentBack_fillAlpha:Number;// = 1;
		
		
		private var _pulseColor:String;
		private var _pulseColorCode:uint;
		
		//Fonts
		private var _fontSize_main:Number;
		private var _fontColor_main:String;
		private var _fontFamily_main:String;
		
		
		private var _fontSize_footer:Number;
		
		private var _headerAreaInside:Boolean;
		private var _headerArea_x:Number;
		private var _headerArea_y:Number;
		
	
		private var _sectionHeaderObject:TextBoxObject;
		private var _sceneHeaderObject:TextBoxObject;
		private var _noteBoxObject:TextBoxObject;
		
		private var _noteBox_frameSize:Number;//= 4;
		private var _noteBox_frameColor:String;// = "ltgrey";
		private var _noteBox_frameColorCode:uint;//= SHELL_COLORS.lookUpColor(_noteBox_frameColor);
		private var _noteBox_frameAlpha:Number;// = 1;
		
		
		private var _default_xPad:Number;
		private var _default_yPad:Number;
		
		private var _templateXML:XML;
		
		public function TemplateObject()
		{	

		}

		public function get shellBlockColor():String
		{
			return _shellBlockColor;
		}

		public function set shellBlockColor(value:String):void
		{
			
			_shellBlockColorCode = SHELL_COLORS.lookUpColor(value);
			_shellBlockColor = value;
		}

		public function get pulseColor():String
		{
			return _pulseColor;
		}

		public function set pulseColor(value:String):void
		{
			
			_pulseColorCode = SHELL_COLORS.lookUpColor(value);
			_pulseColor = value;
		}

		public function get shellBlockColorCode():uint
		{
			return _shellBlockColorCode;
		}

		public function set shellBlockColorCode(value:uint):void
		{
			_shellBlockColorCode = value;
		}

		public function get pulseColorCode():uint
		{
			return _pulseColorCode;
		}

		public function set pulseColorCode(value:uint):void
		{
			_pulseColorCode = value;
		}

		public function get templateCode():String
		{
			return _templateCode;
		}

		public function set templateCode(value:String):void
		{
			_templateCode = value;
		}

		public function get shellBlockAlpha():Number
		{
			return _shellBlockAlpha;
		}

		public function set shellBlockAlpha(value:Number):void
		{
			_shellBlockAlpha = value;
		}


		public function get holder_width():Number
		{
			return _holder_width;
		}

		public function set holder_width(value:Number):void
		{
			_holder_width = value;
		}

		public function get holder_height():Number
		{
			return _holder_height;
		}

		public function set holder_height(value:Number):void
		{
			_holder_height = value;
		}

		public function get templateName():String
		{
			return _templateName;
		}

		public function set templateName(value:String):void
		{
			_templateName = value;
		}

		public function get content_width():Number
		{
			return _content_width;
		}

		public function set content_width(value:Number):void
		{
			_content_width = value;
		}

		public function get content_height():Number
		{
			return _content_height;
		}

		public function set content_height(value:Number):void
		{
			_content_height = value;
		}

		public function get content_x():Number
		{
			return _content_x;
		}

		public function set content_x(value:Number):void
		{
			_content_x = value;
		}

		public function get content_y():Number
		{
			return _content_y;
		}

		public function set content_y(value:Number):void
		{
			_content_y = value;
		}

		public function get holder_x():Number
		{
			return _holder_x;
		}

		public function set holder_x(value:Number):void
		{
			_holder_x = value;
		}

		public function get holder_y():Number
		{
			return _holder_y;
		}

		public function set holder_y(value:Number):void
		{
			_holder_y = value;
		}

		public function get fontSize_main():Number
		{
			return _fontSize_main;
		}

		public function set fontSize_main(value:Number):void
		{
			_fontSize_main = value;
		}

		public function get fontColor_main():String
		{
			return _fontColor_main;
		}

		public function set fontColor_main(value:String):void
		{
			_fontColor_main = value;
		}

		public function get fontFamily_main():String
		{
			return _fontFamily_main;
		}

		public function set fontFamily_main(value:String):void
		{
			_fontFamily_main = value;
		}

		public function get fontSize_footer():Number
		{
			return _fontSize_footer;
		}

		public function set fontSize_footer(value:Number):void
		{
			_fontSize_footer = value;
		}

		public function get contentBack_frameSize():Number
		{
			return _contentBack_frameSize;
		}

		public function set contentBack_frameSize(value:Number):void
		{
			_contentBack_frameSize = value;
		}

		public function get contentBack_frameColor():String
		{
			return _contentBack_frameColor;
		}

		public function set contentBack_frameColor(value:String):void
		{
			_contentBack_frameColor = value;
		}

		public function get contentBack_frameAlpha():Number
		{
			return _contentBack_frameAlpha;
		}

		public function set contentBack_frameAlpha(value:Number):void
		{
			_contentBack_frameAlpha = value;
		}

		public function get contentBack_fillColor():String
		{
			return _contentBack_fillColor;
		}

		public function set contentBack_fillColor(value:String):void
		{
			_contentBack_fillColor = value;
		}

		public function get contentBack_fillAlpha():Number
		{
			return _contentBack_fillAlpha;
		}

		public function set contentBack_fillAlpha(value:Number):void
		{
			_contentBack_fillAlpha = value;
		}

		
		public function get headerAreaInside():Boolean
		{
			return _headerAreaInside;
		}

		public function set headerAreaInside(value:Boolean):void
		{
			_headerAreaInside = value;
		}

		public function get headerArea_x():Number
		{
			return _headerArea_x;
		}

		public function set headerArea_x(value:Number):void
		{
			_headerArea_x = value;
		}

		public function get headerArea_y():Number
		{
			return _headerArea_y;
		}

		public function set headerArea_y(value:Number):void
		{
			_headerArea_y = value;
		}

		public function get default_yPad():Number
		{
			return _default_yPad;
		}

		public function set default_yPad(value:Number):void
		{
			_default_yPad = value;
		}

		public function get default_xPad():Number
		{
			return _default_xPad;
		}

		public function set default_xPad(value:Number):void
		{
			_default_xPad = value;
		}

		public function get sectionHeaderObject():TextBoxObject
		{
			return _sectionHeaderObject;
		}

		public function set sectionHeaderObject(value:TextBoxObject):void
		{
			_sectionHeaderObject = value;
		}

		public function get sceneHeaderObject():TextBoxObject
		{
			return _sceneHeaderObject;
		}

		public function set sceneHeaderObject(value:TextBoxObject):void
		{
			_sceneHeaderObject = value;
		}

		public function get noteBoxObject():TextBoxObject
		{
			return _noteBoxObject;
		}

		public function set noteBoxObject(value:TextBoxObject):void
		{
			_noteBoxObject = value;
		}

		public function get templateXML():XML
		{
			return _templateXML;
		}

		public function set templateXML(value:XML):void
		{
			_templateXML = value;
		}

		


	}
}