package com.sanbeaman.shell.data
{
	public class SceneObject
	{
		private var _sectionHeader:String;
		private var _sectionTemplate:String;
		private var _sID:String;
		private var _sIndex:int;
		private var _sType:String;
		private var _sHeader:String;
		private var _sNumber:String;
		private var _sContBtnType:String;
		private var _sceneItems:XMLList;
		
		private var _slides:XMLList;
		
		private var _shellDir:String;
		
		private var _slideList:Array;
		private var _totalSlides:int;
		private var _finalSlideIndex:int;
		
		private var _isTracked:Boolean;
		
		private var _trackedSlideArray:Array;
		
		private var _hasInternalMenu:Boolean;
		
		private var _langID:String;
		
		public function SceneObject()
		{
			
		}

		public function get sectionHeader():String
		{
			return _sectionHeader;
		}

		public function set sectionHeader(value:String):void
		{
			_sectionHeader = value;
		}

		public function get finalSlideIndex():int
		{
			return _finalSlideIndex;
		}

		
		public function get totalSlides():int
		{
			return _totalSlides;
		}

		
		public function get isTracked():Boolean
		{
			return _isTracked;
		}

		public function set isTracked(value:Boolean):void
		{
			_isTracked = value;
		}

		public function get sContBtnType():String
		{
			return _sContBtnType;
		}

		public function set sContBtnType(value:String):void
		{
			_sContBtnType = value;
		}

		public function get slides():XMLList
		{
			return _slides;
		}

		public function set slides(value:XMLList):void
		{
			_slides = value;
			/*
			var item:XML;
			_slideList = new Array();
			for each(item in _slides.slide) {
				trace("item: " + item.@sNumber);
				_slideList.push(item);
				
			}
			trace(">>>>>>>>>>>>>>Scene " + _sNumber + " has a total of " + _slideList.length + " slides");
			*/
		}

		public function get sNumber():String
		{
			return _sNumber;
		}

		public function set sNumber(value:String):void
		{
			_sNumber = value;
		}

		public function get sHeader():String
		{
			return _sHeader;
		}

		public function set sHeader(value:String):void
		{
			_sHeader = value;
		}

		public function get sType():String
		{
			return _sType;
		}

		public function set sType(value:String):void
		{
			_sType = value;
		}

		public function get sIndex():int
		{
			return _sIndex;
		}

		public function set sIndex(value:int):void
		{
			_sIndex = value;
		}

		public function get sID():String
		{
			return _sID;
		}

		public function set sID(value:String):void
		{
			_sID = value;
		}

		public function get shellDir():String
		{
			return _shellDir;
		}

		public function set shellDir(value:String):void
		{
			_shellDir = value;
		}

		public function get sceneItems():XMLList
		{
			return _sceneItems;
		}

		public function set sceneItems(value:XMLList):void
		{
			_sceneItems = value;
		}
		
		public function get slideList():Array
		{
			
			return _slideList;
		}

		public function set slideList(value:Array):void
		{
			
			_slideList = value;
			_totalSlides = _slideList.length;
			_finalSlideIndex = _totalSlides -1;
		}

		public function get trackedSlideArray():Array
		{
			return _trackedSlideArray;
		}

		public function set trackedSlideArray(value:Array):void
		{
			_trackedSlideArray = value;
		}

		public function get hasInternalMenu():Boolean
		{
			return _hasInternalMenu;
		}

		public function set hasInternalMenu(value:Boolean):void
		{
			_hasInternalMenu = value;
		}

		public function get sectionTemplate():String
		{
			return _sectionTemplate;
		}

		public function set sectionTemplate(value:String):void
		{
			_sectionTemplate = value;
		}

		public function get langID():String
		{
			return _langID;
		}

		public function set langID(value:String):void
		{
			_langID = value;
		}

	
		/*
		public function set slideList(value:Array):void
		{
			_slideList = value;
		}
*/

	}
}