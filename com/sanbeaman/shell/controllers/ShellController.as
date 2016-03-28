package com.sanbeaman.shell.controllers
{
	import com.sanbeaman.shell.data.CourseObject;
	import com.sanbeaman.shell.data.SceneObject;
	import com.sanbeaman.shell.data.SectionObject;
	import com.sanbeaman.shell.data.SlideObject;
	import com.sanbeaman.shell.utils.SimpleUtils;
	
	
	public class ShellController
	{
		private var _isInit:Boolean;
		
		/**
		 * 
		 * Shell Variables
		 * 
		 * */
		
		private var _shellID:String;
		private var _shellXML:XML;
		
		
		//the path set via flash vars
		private var _shellDir:String;
		
		//the overall course object
		private var _courseObj:CourseObject;
		
		
		
		//the overall Section Object
		private var _sectionObj:SectionObject;
		private var _sectionID:String;
	
		//Array of all the Scenes in the Section
		private var _sceneList:Array;
		
		
		private var _totalScenes:int;
		private var _finalSceneIndex:int;
		
		/**
		 * 
		 * Current SCENE Variables
		 * 
		 * */
		
		//the Current SCene Object
		private var _currentSceneObject:SceneObject;
		//Array of the Current Scens Slides
		private var _currentSlideList:Array;
		
		
		// the current slide object
		private var _currentSlideObject:SlideObject;
		private var _currentSlideIndex:int;
		
		
		/**
		 * 
		 * Tracking Variables
		 * 
		 * */
		//If true than the Section has Already been completed so all child objects are complete as well
		private var _sectionComplete:Boolean;
		
		
		//Array Containing all the tracked SCene IDs
		private var _sceneIDListTracked:Array;
		
		private var _scormSuspendDataString:String;
		
		
		private var _suspendDataArray:Array;
		
		//Array Containing all the tracked Slide IDs
		private var _slideIDListTracked:Array;
	
		public function ShellController()
		{
			
			_isInit = false;
		}
		
		/**
		 * 
		 * Current SLIDE Variables
		 * 
		 * */
		public function get currentSlideObject():SlideObject
		{
			return _currentSlideObject;
		}

		public function get finalSceneIndex():int
		{
			return _finalSceneIndex;
		}

		public function get totalScenes():int
		{
			return _totalScenes;
		}

		public function get sectionID():String
		{
			return _sectionID;
		}

		public function get sceneIDListTracked():Array
		{
			return _sceneIDListTracked;
		}

		public function get currentSceneObject():SceneObject
		{
			return _currentSceneObject;
		}

		public function init(inXML:XML,secComplete:Boolean = false):void
		{
			_shellXML = inXML;
			
			_sectionComplete = secComplete;
			
			if (_sectionComplete){
				//then all slides and Scenes need to be accessible
				//clear tracked scene lisst and disregard listTrack since it will be repouplated when xml is parsed
				_sceneIDListTracked = new Array();	
			} else {
				//Section is not complete, so we need to check keep the listTracked data if any..
				
				if (_suspendDataArray != null){
					// if not null then must have soem tracked sceneIDs
					_sceneIDListTracked = _suspendDataArray;
				} else {
					//no previously tracked data so create new Array
					_sceneIDListTracked = new Array();
				}
			}
			
			//for trackign slides inside scenes
			_slideIDListTracked = new Array();	
			
			var courseXML:XMLList = _shellXML.course;
			
			_courseObj = new CourseObject();
			_courseObj.courseCode = courseXML.@code;
			_courseObj.courseTemplateCode = (courseXML.hasOwnProperty("@template"))?courseXML.@template:"";
			_courseObj.localeID = courseXML.@localeID;
			_courseObj.courseTitle = courseXML.title;
			var sdebug:String = (courseXML.hasOwnProperty("@debug"))?courseXML.@debug:"false";
			//_courseObj.showDebug = true;
			_courseObj.showDebug = SimpleUtils.convertString2Boolean(sdebug);
			//trace("showDEBUG++++> " + sdebug + "_courseObj.showDebug" +  _courseObj.showDebug);
			_sectionObj = new SectionObject();
			_sectionObj.sectionID = _shellXML.section.@id;
			_sectionID = _sectionObj.sectionID;
			
			_sectionObj.sectionHeader = _shellXML.section.header;
			_sectionObj.sectionID = _shellXML.section.@snumber;
			//_sectionObj.sectionType = (_shellXML.section.hasOwnProperty("@type"))?_shellXML.section.@type:"simple";
			//_sectionObj.sectionTemplate =  (_shellXML.hasOwnProperty("@template"))?_shellXML.@template:_courseObj.courseTemplate;
			//_sectionObj.sectionXML = _shellXML.section;
			
			
			_sectionObj.isTracked = _sectionComplete;
			
			var sceneXML:XMLList = _shellXML.section.scenes.*;
			var sceneIndex:int = 0;
			_sceneList = new Array();
			
			for each (var scene:XML in sceneXML) {
				var sceneObj:SceneObject = new SceneObject();
				
				
				var sceneid:String = scene.@sNumber;
				sceneObj.sID = scene.@sNumber;
				
				
				var thisSceneTracked:Boolean;
				
				if (_sectionComplete){
					// add SceneId to list of tracked SceneIDs, and set object to isTracked 
					_sceneIDListTracked.push(sceneid);
					
					thisSceneTracked = true;
				} else {
					//check if sceneID has been tracked by checkign it against the TrackedSceneID list.
					thisSceneTracked  = this.isSceneTracked(sceneid);
		
				}
				sceneObj.isTracked = thisSceneTracked;
				
				
				sceneObj.sectionHeader = _sectionObj.sectionHeader;
				
				sceneObj.sNumber = scene.@sNumber;
				sceneObj.sHeader = scene.header;
				//trace("sceneObj.sHeader=" + sceneObj.sHeader);
				sceneObj.langID = _courseObj.localeID;
				
				sceneObj.sType = String(scene.@sType).toLowerCase();
				//sceneObj.sType = scene.@sType;
				sceneObj.sContBtnType = String(scene.@continueBtnType).toLowerCase();
				sceneObj.shellDir = this.shellDir;
			//	sceneObj.sectionTemplate = _sectionObj.sectionTemplate;
				sceneObj.sceneItems = scene.sceneitems;
				sceneObj.slides = scene.slides;
				sceneObj.slideList = _parseSlideXMLtoSlideArray(scene.slides, thisSceneTracked);
				
				
			//	trace("sceneObj.sContent= "+ sceneObj.sContent.toString());
				sceneObj.sIndex = sceneIndex;
				sceneIndex++;
				//var sl:Array = sceneObj.slideList;
				//trace("_slideList " + sl.length); 
				_sceneList.push(sceneObj);
				
			
			}
			_sectionObj.scenesArray = _sceneList;
			_totalScenes = _sceneList.length;
			_finalSceneIndex = _totalScenes -1;
		//	_slideIDListTracked = new Array();		
		
			
			//return _sectionObj;
					
		}

		
		private function _parseSlideXMLtoSlideArray(sldsXML:XMLList, isSceneTracked:Boolean):Array
		{
			var _slidesXML:XMLList  = sldsXML.*;
			var slideIndex:int = 0;
			var sldarray:Array  = new Array();
			
			for each (var slide:XML in _slidesXML) {
				var slideObj:SlideObject = new SlideObject();
				if (slide.hasOwnProperty("@id")){
					slideObj.slideID = slide.@id;
				} else {
					slideObj.slideID = slide.@sNumber;
				}
				//slideObj.slideID = slide.@id;
				
				slideObj.slideNumber = slide.@sNumber;
				slideObj.slideType = String(slide.@type).toLowerCase();
				slideObj.slideAnimType = String((slide.hasOwnProperty("@animType"))?slide.@animType:"defaultsync").toLowerCase();
				slideObj.slideEndType = String((slide.hasOwnProperty("@endType"))?slide.@endType:"CONTINUE").toLowerCase();
				
				slideObj.slideContent = slide.*;
				
				var thisSlideTracked:Boolean;
				//set the tracking status of each slide
				if (_sectionComplete) {
					//section is complete so that means all slides are as well
					//slideObj.isTracked = true;
					thisSlideTracked = true;
					_slideIDListTracked.push(slideObj.slideID);
				} else {
					//the section isnot complete but if the SCene is comeplete then so are the slides
					thisSlideTracked = isSceneTracked;
					//slideObj.isTracked = false;
				}
				slideObj.isTracked = thisSlideTracked;
				
				slideObj.slideIndex = slideIndex;
				slideIndex++;
				
				sldarray.push(slideObj);
				
				
			}
			return sldarray;
			
			trace("Number of Slides = " + sldarray.length);
		}
		public function get shellDir():String
		{
			return _shellDir;
		}

		public function set shellDir(value:String):void
		{
			_shellDir = value;
		}

		public function get courseObj():CourseObject
		{
			return _courseObj;
		}

		public function set courseObj(value:CourseObject):void
		{
			_courseObj = value;
		}
		/***
		 * slideIDListTracked:Array
		 * A list of SLideIDs either from LMS or created as each slide is compelted
		 * 
		 * */
		public function get slideIDListTracked():Array
		{
			return _slideIDListTracked;
		}
		
		/***
		 * 
		 * A list of SLideIDs either from LMS or created as each slide is compelted
		 * 
		 * */
		
		public function set slideIDListTracked(value:Array):void
		{
			_slideIDListTracked = value;
		}
		public function get currentSlideList():Array
		{
			return _currentSlideList;
		}
		
		public function isSceneTracked(scneID:String):Boolean
		{
			var scenTracked:Boolean;
			if (_sceneIDListTracked.indexOf(scneID) >= 0){
				scenTracked = true;
			} else {
				scenTracked = false;
			}
			
			return scenTracked;
		}
		//Track the sceneID against _sceneIDListTracked array, if new sceneID then return true to initiate suspenddata save
		public function trackSceneID_FORBookmark(scnID:String):Boolean
		{
			var isNewID:Boolean;// = false;
			var thisIndex:int = _sceneIDListTracked.lastIndexOf(scnID);
			trace('trackSceneID_FORBookmark= '+ thisIndex + '_sceneIDListTracked '+ _sceneIDListTracked.toString());
			if (thisIndex == -1){
				_sceneIDListTracked.push(scnID);
				_currentSceneObject.isTracked = true;
				isNewID = true;
			} else {
				isNewID = false;
			}
			return isNewID;
			
		}
		public function isSlideTracked(sldID:String):Boolean
		{
			var slideTracked:Boolean;
			if (_slideIDListTracked.indexOf(sldID) >= 0){
				slideTracked = true;
			} else {
				slideTracked = false;
			}
			
			return slideTracked;
		}
		
		

		public function trackSceneID(scnID:String):void
		{
			var thisIndex:int = _sceneIDListTracked.lastIndexOf(scnID);
			if (thisIndex == -1){
				_sceneIDListTracked.push(scnID);
				
				_currentSceneObject.isTracked = true;
			}
		
		}
		
		
		public function trackSlideByID(sldID:String):void
		{
			var thisIndex:int = _slideIDListTracked.lastIndexOf(sldID);
		//	trace("trackSlideByTD -> " + sldID + " ---thisIndex= " + thisIndex);
			if (thisIndex == -1){
				_slideIDListTracked.push(sldID);
				
				var sldObj:SlideObject = getSlideObjectByID(sldID);
				trace('does sldObj.slideID '+ sldObj.slideID + '= sldID ' + sldID +'<<<<<<');
				_currentSlideObject.isTracked = true;
				trace('issldObj tracked?' + sldObj.isTracked);
				
				
			}
			
			//trace('_slideIDListTracked.length= ' + _slideIDListTracked.length);
			
			
		}
		private function getSlideObjectByID(sldID:String):SlideObject
		{
		
			var cSlideObj:SlideObject = new SlideObject();
			
			for (var sid:int = 0; sid < _currentSlideList.length; sid++) {
				var sldO:SlideObject = _currentSlideList[sid];
				if (sldID == sldO.slideID) {
					cSlideObj = sldO;
					break;
				}
			}
			
			
			return cSlideObj;
			
		}
		
		
		
		public function getAndSetCurrentSceneObjectBySceneIndex(scnIndex:int):SceneObject
		{
		//	trace("scnINdex = " + scnIndex ); 
			
			var scenObj:SceneObject = new SceneObject();
			var sindex:int = (scnIndex > _finalSceneIndex)?0:scnIndex;
			
			scenObj = _sceneList[sindex];
			scenObj.shellDir = _shellDir;
			
			_setCurrentSceneObjectAndCreateSlideList(scenObj);
			return scenObj;

		}
		
		public function getAndSetCurrentSceneObjectBySceneID(scnID:String):SceneObject
		{
			///	_currentSceneObject = _sectionObj.getSceneObjectBySceneID(scnID);
			
			var scenObj:SceneObject = new SceneObject();
			
			//var scenObj:SceneObject;
			for (var si:int = 0; si < _sceneList.length;si++) {
				var so:SceneObject = _sceneList[si];
				if (scnID == scenObj.sID) {
					scenObj = so;
					scenObj.shellDir = _shellDir;
					break;
				}
			}
			_setCurrentSceneObjectAndCreateSlideList(scenObj);
			return scenObj;
			
		}
		
		
		public function getAndSetCurrentSlideObjectBySlideID(sldID:String):SlideObject
		{
			var cSlideID:String = sldID;
			_currentSlideObject = new SlideObject();
			
			var cSlideObj:SlideObject = new SlideObject();
			
			//var scenObj:SceneObject;
			for (var sid:int = 0; sid < _currentSlideList.length; sid++) {
				var sldO:SlideObject = _currentSlideList[sid];
				if (cSlideID == sldO.slideID) {
					_currentSlideObject = sldO;
					break;
				}
			}
			
			
			return _currentSlideObject;
			
		}
		
		public function getAndSetCurrentSlideObjectByIndex(sldIndex:int):SlideObject
		{
			_currentSlideIndex = sldIndex;
			
			_currentSlideObject = new SlideObject();
			
			_currentSlideObject = _currentSlideList[_currentSlideIndex];
			
			return _currentSlideObject;
			
		}
		
		
		/**
		 * _setCurrentSceneObject & set create current Slide List for this Scene
		 * 
		 * 
		 * */
		
		
		private function _setCurrentSceneObjectAndCreateSlideList(value:SceneObject):void
		{
			_currentSlideList = new Array();
			
			_currentSceneObject = value;
			_currentSlideList = _currentSceneObject.slideList;
		}

		public function get suspendDataArray():Array
		{
			return _suspendDataArray;
		}

		public function set suspendDataArray(value:Array):void
		{
			_suspendDataArray = value;
		}

		public function get scormSuspendDataString():String
		{
			return _scormSuspendDataString;
		}

		public function set scormSuspendDataString(value:String):void
		{
			_scormSuspendDataString = value;
		}

		/**
		 * 
		 * Section Variables
		 * 
		 * */
		public function get sectionObj():SectionObject
		{
			return _sectionObj;
		}
		

	}
}


