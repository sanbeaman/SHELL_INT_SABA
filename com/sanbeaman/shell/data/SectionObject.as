package com.sanbeaman.shell.data
{
	public class SectionObject
	{
		private var _sectionID:String;
		private var _sectionIndex:int;
		private var _sectionType:String;
		private var _sectionHeader:String;
		private var _sectionNumber:String;
		private var _sectionTemplate:String;
		
		private var _sectionXML:XMLList;
		
		//private var _scenesXMLList:XMLList;
		
		private var _scenesArray:Array;
		private var _currentSceneObject:SceneObject;
		
		private var _isTracked:Boolean;
		
		public function SectionObject()
		{
			
			
		}
		
		public function get sectionXML():XMLList
		{
			return _sectionXML;
		}

		public function set sectionXML(value:XMLList):void
		{
			_sectionXML = value;
		}

		public function get isTracked():Boolean
		{
			return _isTracked;
		}

		public function set isTracked(value:Boolean):void
		{
			_isTracked = value;
		}

		public function get scenesArray():Array
		{
			return _scenesArray;
		}

		public function set scenesArray(value:Array):void
		{
			_scenesArray = value;
		}

		public function get sectionNumber():String
		{
			return _sectionNumber;
		}

		public function set sectionNumber(value:String):void
		{
			_sectionNumber = value;
		}

		public function get sectionHeader():String
		{
			return _sectionHeader;
		}

		public function set sectionHeader(value:String):void
		{
			_sectionHeader = value;
		}

		public function get sectionType():String
		{
			return _sectionType;
		}

		public function set sectionType(value:String):void
		{
			_sectionType = value;
		}

		public function get sectionIndex():int
		{
			return _sectionIndex;
		}

		public function set sectionIndex(value:int):void
		{
			_sectionIndex = value;
		}

		public function get sectionID():String
		{
			return _sectionID;
		}

		public function set sectionID(value:String):void
		{
			_sectionID = value;
		}
		public function getSceneObjectBySceneIndex(sindex:int):SceneObject
		{
			var scenObj:SceneObject = _scenesArray[sindex];
			
			return scenObj;
			
		}
		public function getSceneObjectBySceneNumber(snumber:String):SceneObject
		{
			var scenObj:SceneObject;
			for (var si:int = 0; si < _scenesArray.length;si++) {
				scenObj = _scenesArray[si];
				if (snumber == scenObj.sNumber) {
					
					break;
				}
			}
			
			return scenObj;
			
		}

		public function get sectionTemplate():String
		{
			return _sectionTemplate;
		}

		public function set sectionTemplate(value:String):void
		{
			_sectionTemplate = value;
		}


	}
}