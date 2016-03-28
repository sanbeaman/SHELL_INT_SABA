package com.sanbeaman.shell.data
{
	public class CourseObject
	{
		
		private var _courseCode:String;
		private var _courseTemplateCode:String;
		private var _localeID:String;
		private var _courseTitle:String; 
		private var _showDebug:Boolean;
		private var _courseTemplateXML:XMLList;
		private var _courseTemplateObject:TemplateObject;
		
		public function CourseObject()
		{
		}

		public function get courseCode():String
		{
			return _courseCode;
		}

		public function set courseCode(value:String):void
		{
			_courseCode = value;
		}

		public function get localeID():String
		{
			return _localeID;
		}

		public function set localeID(value:String):void
		{
			_localeID = value;
		}

		public function get courseTitle():String
		{
			return _courseTitle;
		}

		public function set courseTitle(value:String):void
		{
			_courseTitle = value;
		}

		public function get showDebug():Boolean
		{
			return _showDebug;
		}

		public function set showDebug(value:Boolean):void
		{
			_showDebug = value;
		}

		public function get courseTemplateCode():String
		{
			
			var value:String = (_courseTemplateCode != "BLANK" || _courseTemplateCode != null)?_courseTemplateCode:"";
			
			return value;
		}

		public function set courseTemplateCode(value:String):void
		{
			_courseTemplateCode = value.toUpperCase();
		//	_courseTemplateObject = _setupTemplateObject(_courseTemplate);
		
		}

		public function get courseTemplateXML():XMLList
		{
			return _courseTemplateXML;
		}

		public function set courseTemplateXML(value:XMLList):void
		{
			_courseTemplateXML = value;
			//trace('_courseTemplateXML===> '+ _courseTemplateXML.toString());
		}
		
		public function getTemplateBlockXML(whichBlock:String):XMLList
		{
			var returnXML:XMLList = _courseTemplateXML.child(whichBlock);
			return returnXML;
			
		}

/*
		public function get courseTemplateObject():TemplateObject
		{
			return _courseTemplateObject;
		}
		*/

/*
		private function _setupTemplateObject(tcode:String):TemplateObject
		{
			var to:TemplateObject = new TemplateObject();
			to.templateCode = tcode;
			switch (tcode) {
				case 'ASCE':
					to.shellBlockColor = "black";
					to.shellBlockAlpha = 1;
					
					to.holder_width = 755;
					to.holder_height= 588;
					to.holder_x = 0;
					to.holder_y = 0;
					
					to.content_width = 731;
					to.content_height = 460;
					to.content_x = 12;
					to.content_y = 70;
					
					
					to.contentBack_frameSize = 4;
					to.contentBack_frameColor = "dkgrey";
					to.contentBack_frameAlpha = 1;
					
					to.contentBack_fillColor = "white";
					to.contentBack_fillAlpha = .8;
					
					to.headerAreaInside = false;
					to.headerArea_x = 14;
					to.headerArea_y = 40;
					var sectionBox:TextBoxObject = new TextBoxObject();
					sectionBox.box_fillAlpha =
					to.noteBox_frameAlpha = 0;
					to.noteBox_frameColor = "ltgrey";
					to.noteBox_frameSize = 4;
					
					
					
					to.fontFamily_main = "Arial";
					to.fontSize_main = 16;
					to.fontColor_main = "black";
				
					to.fontSize_footer = 14;
					
					to.sectionHeader_x = 0;
					to.sectionHeader_y = 0;
					to.sectionHeader_xpad = 12;
					to.sectionHeader_ypad = 2;
					to.sectionHeader_width = 755;
					to.sectionHeader_height =  32;
					to.sectionHeader_fillColor = "blue";
					to.sectionHeader_fillAlpha = 0;
					to.sectionHeader_frameSize = 0;
					to.sectionHeader_frameColor = "white";
					to.sectionHeader_frameAlpha = 0;
					
					to.sectionHeader_fontColor = "white";
					to.sectionHeader_fontName = "Helvetica Neue Black Condensed";
					to.sectionHeader_fontSize = 28;
					to.sectionHeader_fontStyle = "bold";
					to.sectionHeader_fontFX = "dropShadow";
					
					to.sceneHeader_fontColor = "black";
					to.sceneHeader_fontName = "Arial";
					to.sceneHeader_fontSize = 22;
					to.sceneHeader_fontStyle = "";
					//to.templateCode = tcode;
					to.pulseColor = "blue";
					
					to.default_xPad = 10;
					to.default_yPad = 10;
					
					break;
				case 'PAPS':
					
					to.shellBlockColor = "black";
					to.shellBlockAlpha = 1;
					
					to.holder_width = 745;
					to.holder_height= 525;
					to.holder_x = 5;
					to.holder_y = 30;
					
					to.content_width = 700;
					to.content_height = 450;
					to.content_x = 23;
					to.content_y = 20;
				
					to.contentBack_frameSize = 1;
					to.contentBack_frameColor = "black";
					to.contentBack_frameAlpha = 0;
					
					to.contentBack_fillColor = "white";
					to.contentBack_fillAlpha = 1;
					
					
					to.headerAreaInside = true;
					to.headerArea_x = 0;
					to.headerArea_y = 0;
					
					to.noteBox_frameAlpha = 1;
					to.noteBox_frameColor = "ltgrey";
					to.noteBox_frameSize = 4;
					
					to.fontFamily_main = "Arial";
					to.fontSize_main = 16;
					to.fontColor_main = "blue";
					to.fontSize_footer = 14;
					
					
					to.pulseColor = "orange";
					
					
					to.default_xPad = 10;
					to.default_yPad = 10;
					break;
				default:
					to.shellBlockColor = "black";
					to.shellBlockAlpha = 1;
					
					to.holder_width = 755;
					to.holder_height= 588;
					to.holder_x = 0;
					to.holder_y = 0;
					
					to.content_width = 731;
					to.content_height = 460;
					to.content_x = 12;
					to.content_y = 70;
					
					
					to.contentBack_frameSize = 4;
					to.contentBack_frameColor = "dkgrey";
					to.contentBack_frameAlpha = 1;
					
					to.contentBack_fillColor = "white";
					to.contentBack_fillAlpha = .8;
					
					to.noteBox_frameAlpha = 0;
					to.noteBox_frameColor = "ltgrey";
					to.noteBox_frameSize = 4;
					
					to.fontFamily_main = "Arial";
					to.fontSize_main = 16;
					to.fontColor_main = "blue";
					to.fontSize_footer = 14;
					
					
					to.fontFamily_main = "Arial";
					to.fontSize_main = 16;
					to.fontColor_main = "black";
					
					to.fontSize_footer = 14;
					
					//to.templateCode = tcode;
					to.pulseColor = "orange";
					
					
					to.default_xPad = 10;
					to.default_yPad = 10;
					
			}
			
			return to;
		}
*/
	}
}