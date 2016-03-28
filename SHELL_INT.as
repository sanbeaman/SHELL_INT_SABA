package
{
	import com.greensock.TimelineLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TransformMatrixPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.sanbeaman.shell.controllers.NavController;
	import com.sanbeaman.shell.controllers.NavPlayer;
	import com.sanbeaman.shell.controllers.ShellController;
	import com.sanbeaman.shell.controllers.SlidePlayer;
	import com.sanbeaman.shell.data.CourseObject;
	import com.sanbeaman.shell.data.SceneObject;
	import com.sanbeaman.shell.data.SectionObject;
	import com.sanbeaman.shell.data.SlideObject;
	import com.sanbeaman.shell.data.TemplateObject;
	import com.sanbeaman.shell.events.ShellEvent;
	import com.sanbeaman.shell.loading.display.ProgressCircleMax;
	import com.sanbeaman.shell.scenetypes.SceneBase;
	import com.sanbeaman.shell.ui.BTN_ShellMain;
	import com.sanbeaman.shell.ui.GPSWindow;
	import com.sanbeaman.shell.ui.HeaderSectionScene;
	
	import com.sanbeaman.shell.ui.HeaderSectionMain;
	
	import com.sanbeaman.shell.ui.MainShellHeader;
	import com.sanbeaman.shell.ui.SectionHeader;
	import com.sanbeaman.shell.ui.ShellBack;
	import com.sanbeaman.shell.ui.ShellBlock;
	import com.sanbeaman.shell.ui.TextFlowTextLineFactory_example;
	import com.sanbeaman.shell.utils.TextFormatter;
	import com.sanbeaman.shell.widget.DebugDisplay;
	import com.sanbeaman.shell.widget.GPSNavBarBtn;
	import com.sfc.nav.SCORM;
	import com.wbtmodules.ca.as3.Debugger;
	import com.wbtmodules.ca.as3.MYSCORM;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.printing.PrintJobOrientation;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	import fl.lang.Locale;
	import fl.text.TLFTextField;
	
	import flashx.textLayout.TextLayoutVersion;


	public class SHELL_INT extends MovieClip
	{
		
		LoaderMax.activate([ImageLoader, SWFLoader, MP3Loader]);
		TweenPlugin.activate([ShortRotationPlugin, TransformAroundCenterPlugin, TransformAroundPointPlugin,TransformMatrixPlugin]);
		
		private var _mainLoaderMax:LoaderMax;
		
		//[Embed (source="/assets/imgs/ShellBack.jpg")]
		//private var _shellBack:Class
		//public var shellBack:Bitmap = new _shellBack;
		
		private var _shellBack:ShellBack;// = new ShellBack();
		
		private var _backgroundContentLoaded:Boolean;
		
		private var _msh:MainShellHeader;
		
		
	
		private var _shellFooter:ShellBlock;
		
		//area reserved for the Module / section title
		private var _sectionHeader:SectionHeader;
		private var _sectionSceneHeader:HeaderSectionMain;
		
	//	private var _sectionSceneHeader:HeaderSectionScene;
		//area that will contain any addional graphic elements and the content of the course
		private var _sectionBody:Sprite;
		
		private var _navPlayer:NavPlayer;
		
		
		private var _debugLayer:Sprite;
		
	//	public var shell_lang:SHELL_LANG;
		
		public var tformatter:TextFormatter;
		
		//------------------
		// SETUP LOCALE OBJECT:
		
		private var _languages:Object = new Object();	// Stores flags for loaded languages
		private var _localeDefault:String;// = "es";		// Default language
		private var _locale:String;// = "en";				// Current language selected in combobox
		private var _locales:Array;// = "en";	
		
		private var _localeLangID:String;
		
		private var _langInterval:Number;

		private var _contentLoadInterval:Number;
		/***********
		 * 
		 * SCORM & TEST VARIBALES
		 * 
		 * **/
		private var _scormCompleteStatus:String;
		private var _localTest:Boolean;// = false;
		//private var _testSCO:String;// = "_scos/4000/";
		private var _sectionNumber:Number;
		private var _sectionNumberFolder:String;
		private var _shelldir:String;
		private var _isLMSinit:Boolean;
		private var _inDebug:Boolean;
		
		private var _sectionComplete:Boolean;
		 
		
		private var suspend_langid:String=null;
		private var suspend_marked:Array;
		private var suspend_startmodule:Number;
		private var suspend_startscene:String;
		private var suspend_location:String;
		
		private var _suspendDataArray:Array;
		private var _suspendDataString:String;
		
		private var _completion_status:String;
		private var _success_status:String;
		
		
		private var _demoIsSectionComplete:String;
		private var _demoLocationString:String;
		
		private var _firstTime:Boolean = true;
		public var inDemoMode:Boolean = true;
		
		public static const CAFONT_NAME:String = "Arial";
		/***********
		 * 
		 * SHELL OBJECTS
		 * 
		 * **/
		
		private var _SHELLXML:String;// = 'shell400.xml';
		
		private var _shellURL:URLRequest;
	//	private var _shellXML_loader:URLLoader;
		private var _shellXML:XML;
		private var _shellXMLList:XMLList;
		
		/***********
		 * 
		 * SHELL DATA OBJECTS
		 * 
		 * **/
		
		private var _shellController:ShellController;
		private var _courseObj:CourseObject;
		private var _templateObject:TemplateObject;
		
		private var _sectionObj:SectionObject;
		
		private var _sectionStyle:String;
		
		
		private var _currentSceneIndex:int;
		private var _currentSceneObject:SceneObject;
		private var _currentSceneID:String;
		private var _currentSceneType:String;
		private var _currentSceneTrackedComplete:Boolean;
		
		private var _sceneStage:MovieClip;
		private var _currentSceneBase:SceneBase;// = new SceneBase();
		
		private var _sceneDone:Boolean;
		
		
		private var _currentSlideList:Array;
		private var _currentSlideIndex:int;
		
		private var _currentSlideObject:SlideObject;
	//	private var _ploader:PLoaderMiniAnim;
				
	//	public var loadshellfont:LoadShellFonts;
	
		private var _debugdisplay:DebugDisplay;
	
		
		private var _sectionStage:Sprite;
		private var _ALoader:AssetLoader;
		private var _templateLoader:TemplateLoader;
		
		private var _backHolder:Sprite;
		
		private var _templateID:String;
		private var _langID:String;
		
		private var _mainShell_path:String;
		private var _assets_path:String;
		private var _module_path:String;
		//private var _assetsPath:String;// = "../asce/en/assets/";//template.xml"
		private var _shellIMG_path:String;// = _assetsPath + "imgs/";
		private var _shellFonts_path:String;// = _assetsPath + "fonts/";
		private var _slidePlayer:SlidePlayer;
		
		private var _debugTemplateID:String;// = 1000;
		private var _debugSectionNumber:Number;// = 1000;
		private var _debugLangID:String;
		
		private var _xmlProgress:ProgressCircleMax;
		//private var _xmlProgress2:ProgressCircleMax;
		//private var _preloadObject:Object = {thickness:74, radius:76, color:0x003366, trackColor:0xcccccc, trackAlpha:0.8, hideText:false, textColor:0xFFFFFF};
		
		//private var _preloadObject:Object = {thickness:74, radius:76, color:0x666666, trackColor:0xcccccc, trackAlpha:0.5, hideText:false, textColor:0xFFFFFF};
		private var _preloadObject:Object = {thickness:74, radius:76, color:0xffffff, trackColor:0x000000, trackAlpha:0.2, hideText:false, textColor:0xFFFFFF};
		
		private var _shellXML_loader:XMLLoader;
		
		private var _modulePrefix:String = "zmod"; //zmod for testing but mod for production
		private var _shellVersion:String = "[v10.62]";
		/**
		 * v10.61 fixed an issue with bodyAnim sequencing and timeiming
		 *  v10.61 added some code to better work on  review server and show both end slides
		 * v10.60 merging MYSCORM.as from SCF's branch and edits to the SHELL for launch in SABA
		 * v10.52 made cahnges so the done button & Start button would advance to next SCO in ReviewShell, use cashell.html NOT cashell_lms.html
		 *  v10.51  minor layout tweeks added a SectionTitle text length to accomodate huge russian titles in ASCE
		 * v10.50  minor layout tweeks for long lang and SABA (Still need to work on SectionHEader)
		 * 	 v10.49 switched sectionHeader change event to target.... _sectionHeader:SectionHeader NOT _sectionSceneHeader:HeaderSectionScene, need to combine so Welcome 2chrysler dont break
		 * v10.48 started ASCE Arabic, added _layoutModifier to SceneBase and BodyUI, to hopefully allow RTL layouts to flip 'slideRight' to 'slideLeft' and vice versa 
		 * as opposed to hardcoding the change in the CML which is what I had to do for RPSS arabic
		 * v10.47 removed assets from Flash Library and added answerCorrect.mp3 and answerWrong.mp3 to the template.xml, and simplified how bitmaps are loaded in the template loader.
		 * 			changed the _mainLoaderMax.replaceURLText("{imgdir}",mpath,true); to onINit and use the loaderarray instead of looking for specific loaders
		 *   !!!!!!!!!!!!! make sure audio folder is added to assets folder and template.xml and manifest are changed to reflect new assets
		 * v10.46 fixed xml loader so it won't error when it doesn't find speical loaders, added default bodyImage paramters to template xml, also removed bodyIcon just have to add style="none"
		 * v10.45 saba versions of Wecome to chrysler
		 * v10.44 added a prelaoder for timeline coverflow
		 * v10.44 some adjustments to c2r for saba
		 * v10.43 added _sectionComplete pass thru to SceneBase in order to disable Start Button if user returns (needed to simplify manifest between saba and lat
		 * v10.42 modified preloader, fixed issue with hasSceneMenu and navbarmenu scene types
		 * v10.41 clean up minor issues during export for production steps
		 * v10.40 extras for text direction and starting media sync
		 * v10.30 added landID and textDirection and tightened up margins
		 * v10.23 in Sandbox for second review
		 * v10.22 created a more flexible rateSlider Thumb class, and fixed trackOver scaling
		 * v10.21 fixed the Printview on the TextArea Dragrate SlideType
		 * v10.20 more optimization and external asset laoding
		 * v10.16 comnined shell loading into new TemplateLoader Class, so 1 shell can open a course and langugae based on flashvars and xml
		 * 			-also added non embedded image preloader
		 * v10.16 fixed bodyButtons, changed shellcontroller to sID to sNUmbernot id
		 * v10.15 added splash and review shell to load new sections even if outside LMS
		 * v10.13 rewrote layout so it'smore consistent margin , xPad, yPad...
		 * v10.01 added lots.... most still in Dev
		 * 			animType to slide node: timesync = timeIn and timeOut (like shell_ca) animsync =  appends tweens in sequence.
		 * 			trimming down 'UI types' BodyImage, BodyBUllet, BodyBulletCol.... 
		 * 			removed xLoc and yLoc, need to check if x = string, use relative layout, else use number
		 * 			incorporated SlidePlayer 
		 * 			Added Resource Class to dynamically change Button assets based on template CODe
		 * 			XML has templte code to set overall style of course
		 * 			 
		 * v9.2 added two types of sync animations, to accomdate items that animate at same time  added unfinished textarea input
		 * v9.1 added SceneHolder to differentiat between GPS interface and new ones
		 *  v9.0 Major changes to allow Shell to work with different courses, changes to XML Section .
		 *  v8.7 added a box for the Done and next pulse state along withglow.
		 *
		 * v8.6 changed the COmplete And EXit Button to continue instead of exit ALL and see if postRule Action will complete course
		 * v8.3 changed it so MarkAllComplete happens independent of exitAll
		 * v8.1 changed MYSCORM to have special completeAndExit SCORM call
		 * 
		 * 
		 */
		public function SHELL_INT()
		{
			/*
			_debugTemplateID = "paps";
			_debugLangID = "ar";//flashvars.langid;
			_debugSectionNumber = 4000;
		*/
			_debugTemplateID ="spwc";//"paps";//  "spwc";// "asce";//
			_debugLangID = "fr_ca";//flashvars.langid;
			_debugSectionNumber = 3000;
			_demoIsSectionComplete =  "completed";//'incomplete';////
			//*/
			//startCourseClicked
			//_localeDefault = 'pt';
			_backHolder = new Sprite();
			this.addChild(_backHolder);
			_templateLoader = new TemplateLoader();
			_mainShell_path = _getMainShellPath();
			_assets_path = _mainShell_path + "assets/";
			_shellIMG_path = _assets_path+ "imgs/";
			_shellFonts_path = _assets_path + "fonts/";
			_module_path = _mainShell_path + _sectionNumberFolder;
			var template_path:String  = _assets_path + "template.xml";
			var shellstring:String = _module_path + 'sco.xml';
			var media_path:String = _module_path + "media/";
			
			var fullshellpath:String =shellstring; // _shelldir + shellstring;
			
			
			//var templateXML:String = _getShellTemplatePath();
		
			
			
			_xmlProgress = new ProgressCircleMax(_preloadObject);
			this.addChild(_xmlProgress);
			//link the XMLLoader to the circular progress display
			//var fullshellpath:String =shellstring; // _shelldir + shellstring;
			
			
			var loadercore:LoaderCore = _buildMainLoader(template_path,fullshellpath);
			//_shellXML_loader =new XMLLoader(fullshellpath, {name:"shellxml",skipFailed:false,onFail:_xmlFailHandler,onIOError:_xmlErrorHandler,onError:_xmlErrorHandler,onComplete:_shellXML_handler});
		//	_shellXML_loader.load();
			_xmlProgress.addLoader(loadercore);
			_templateLoader.addEventListener(TemplateLoader.TEMPLATE_LOAD_COMPLETE,_assetLoadComplete_handler);
			_templateLoader.addEventListener(TemplateLoader.TEMPLATE_LOAD_ERROR,_assetLoadError_handler);
			_templateLoader.addEventListener(TemplateLoader.FIRST_ASSET_LOAD,_firstAssetLoadComplete_handler);
			
			
		}
		private  function _buildMainLoader(tempatePath:String,scopath:String):LoaderCore
		{
			
			_mainLoaderMax = new LoaderMax({name:"mainLoader", autoLoad:true,onComplete:_mainLoader_completeHandler,onError:_mainLoader_errorHandler});
		
			_mainLoaderMax.append(_templateLoader.startLoader(tempatePath));
			
			_shellXML_loader = new XMLLoader(scopath, {name:"shellxml",skipFailed:false,onInit:_xml_initHandler, onComplete:_xml_completeHandler,onFail:_xmlFailHandler,onIOError:_xmlErrorHandler,onError:_xmlErrorHandler});
			
			_shellXML_loader.load();
			_mainLoaderMax.append(_shellXML_loader);
		
			_mainLoaderMax.load();
			return _mainLoaderMax;
		}
		
		private function _xml_initHandler(e:LoaderEvent):void
		{
			var allloaders:Array = _shellXML_loader.getChildren();
			//trace("allloaders" + allloaders);
			var mpath:String = _module_path + "/media/";
			_mainLoaderMax.replaceURLText("{imgdir}",mpath,true);
			for (var i:int = 0; i < allloaders.length; i++){
				_mainLoaderMax.append(allloaders[i]);
				allloaders[i].load();
			}
			
		}
		private function _xml_completeHandler(le:LoaderEvent):void
		{
			//trace("_xml_completeHandler");
			/*
			var mpath:String = _module_path + "/media/";
			_mainLoaderMax.replaceURLText("{imgdir}",mpath,true);
			
			var lmax1:LoaderMax = LoaderMax.getLoader("cfarrowmax");
			if (lmax1){
			lmax1.replaceURLText("{imgdir}",mpath,true);
			_mainLoaderMax.append(lmax1);
			lmax1.load();
			}
			
			var lmax2:LoaderMax = LoaderMax.getLoader("cfimagemax");
			if (lmax2){
			lmax2.replaceURLText("{imgdir}",mpath,true);
			_mainLoaderMax.append(lmax2);
			lmax2.load();
			}
		//	_mainLoaderMax.append(LoaderMax.getLoader("cfarrowmax"));
			//_mainLoaderMax.append(LoaderMax.getLoader("cfimagemax"));
			
			*/
		}
		private function _getMainShellPath():String
		{
			var mainshellpath:String;
			
			var hasExternalInterface:Boolean = ExternalInterface.available;
			if(hasExternalInterface){ 
				var flashvars:Object = LoaderInfo(this.loaderInfo).parameters;
				
				_templateID = flashvars.templateid;
				_langID = String(flashvars.langid).toLowerCase();
				_sectionNumber = flashvars.section;
			} else {
				_templateID = _debugTemplateID;//"asce";
				_langID = String(_debugLangID).toLowerCase();// "en";//flashvars.langid;
				_sectionNumber = _debugSectionNumber;//  _testSecNumber;
				//_shelldir =  _testSCO;// "_scos/sco5300/";;
				//	shelldir = _testSCO;
				//sectionNumber = 'sco';	
			}
			_sectionNumberFolder = _modulePrefix + _sectionNumber + "/";
			mainshellpath = "../"+_templateID+ "/"+_langID+"/";
			
			return mainshellpath;
		}
		private function _getShellTemplatePath():String
		{
			var templatepath:String;
			
			var hasExternalInterface:Boolean = ExternalInterface.available;
			if(hasExternalInterface){ 
				var flashvars:Object = LoaderInfo(this.loaderInfo).parameters;
				_templateID = flashvars.templateid;
				_langID = String(flashvars.langid).toLowerCase();
				_sectionNumber = flashvars.section;
			} else {
				_templateID = _debugTemplateID;//"asce";
				_langID = String(_debugLangID).toLowerCase();// "en";//flashvars.langid;
				_sectionNumber = _debugSectionNumber;//  _testSecNumber;
				//_shelldir =  _testSCO;// "_scos/sco5300/";;
				//	shelldir = _testSCO;
				//sectionNumber = 'sco';	
			}
			_sectionNumberFolder = _modulePrefix + _sectionNumber + "/";
			_mainShell_path = "../"+_templateID+ "/"+_langID+"/";
			_assets_path = _mainShell_path + "assets/";
			
			_shellIMG_path = _assets_path+ "imgs/";
			_shellFonts_path = _assets_path + "fonts/";
			
			_module_path = _mainShell_path + _sectionNumberFolder;
			
			
			//_shelldir = _assetsPath+ _sectionNumberFolder
			templatepath = _assets_path + "template.xml";
			
			return templatepath;
		}
		
		private function _assetLoadError_handler(evt:Event):void
		{
		//	trace('AssetLoadError = ' + evt.type);
		}
		
		private function _firstAssetLoadComplete_handler(evt:Event):void
		{
			var bmp:Bitmap = _templateLoader.getAssetBitmap("shellback");
			_backHolder.addChild(bmp);
		}
		private function _assetLoadComplete_handler(evt:Event):void
		{
			
			//_testSCO = "../zmod3000/";
			//_testSCO = "../asce/en/zmod500/";
			TRACK_VARS.inDemoMode = true;
			TRACK_VARS.sfcSCORM = false;
			//_demoIsSectionComplete = 'incomplete';////"completed";//
			//_demoLocationString ="4100|4200|4300|4400";//"5100|5200";//"3000|3100|3200|3300|3400";
			_localTest = TRACK_VARS.inDemoMode;
			
			//_checkSCORM_init();
		}
		
		/*
		private function _loadSHELL_xml(shellstring:String):void
		{
			
			trace("shellstring="+ shellstring);
			//Load the xml file with the menu settings
			var fullshellpath:String =shellstring; // _shelldir + shellstring;
		
			_shellXML_loader =new XMLLoader(fullshellpath, {name:"shellxml",skipFailed:false,onFail:_xmlFailHandler,onIOError:_xmlErrorHandler,onError:_xmlErrorHandler,onComplete:_shellXML_handler});
			_shellXML_loader.load();
	
		}
		*/
	
		private function _mainLoader_errorHandler(event:LoaderEvent):void {
			trace("mainLoader error occured with " + event.target + ": " + event.text);
		}
		
		private function _mainLoader_progressHandler(event:LoaderEvent):void {
			
			//trace("mainLoader proresss handler ");
		}
		private function _xmlErrorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
		
		private function _xmlFailHandler(event:LoaderEvent):void {
			
			trace("xml fail error occured with " + event.target + ": " + event.text);
		}
	//	private function _shellXML_handler(evt:LoaderEvent):void
	//	{
			
		private function _mainLoader_completeHandler(evt:LoaderEvent):void
			{
			//trace("xmlcomplete");
			
			_checkSCORM_initFresh();
		}
		private function _checkSCORM_initFresh():void
		{
			var shellstring:String;
			//var flashvars = LoaderInfo(this.loaderInfo).parameters;
			
			var scorm_arr:Array;
			var scorm_loc:String;// = "first";
			
			_completion_status = "incomplete";
			_success_status = "unknown";
			if (MYSCORM.InitLMS(true)) {
				_isLMSinit =true;
				var isFirstTime:Boolean = MYSCORM.isFirstTimeEntry;
				if (isFirstTime){
					//very first attempt on sco
					//set exit status to suspend 
					//maybe set suspend to unique character? to check against later?
					MYSCORM.exitStatus ='suspend';
				} else {
					//not first time , so check completion/success status
					_completion_status = MYSCORM.completionStatus;
					_success_status = MYSCORM.successStatus;
					_suspendDataString = MYSCORM.suspendData;
				}
			} else {
				_isLMSinit = false;
				_completion_status = _demoIsSectionComplete;
				_suspendDataString = _demoLocationString;//"";//"3000,3100,3110,3200,3300,3405,3410";// "2100,2200,2220,2300";;//"";//
				//_suspendDataArray = _suspendDataString.split("|");
			}
			
			// is there any bookmark data yet?
			if (_suspendDataString && _suspendDataString != "") {
				_suspendDataArray = _suspendDataString.split("|");
			}else {
				// default marked scenes to none
				_suspendDataArray=[];
			}
			/*
			// if the section has been previously completed, set to mark all scenes by default
			if (_completion_status == 'completed' ) {
				//	TRACK_VARS.allTracked = true;
				_sectionComplete = true;
			} else {
				_sectionComplete = false;
			}
			*/
			// if the section has been previously completed and/or passed, set to mark all scenes by default
			_sectionComplete = (_completion_status == 'completed') || (_success_status == 'passed');
			
			
			//_shelldir  =  _checkFlashVars();
			shellstring = _module_path + 'sco.xml';
			//	trace("modulepath="+ shellstring);
			_debugdisplay = new DebugDisplay();
			_init_shellController();
			
		}
		private function _init_shellController():void
		{
			
			//_displayDebug("_isLMSinit " + _isLMSinit);
			_shellXML= _shellXML_loader.content as XML;
			
			_shellController = new ShellController();
			_shellController.shellDir = _module_path;
			_shellController.suspendDataArray = _suspendDataArray;
			_shellController.scormSuspendDataString = _suspendDataString;
			_shellController.init(_shellXML,_sectionComplete);
			
		//	_sectionObj = _shellController.init(_shellXML,_sectionComplete);
			_courseObj = _shellController.courseObj;
			_sectionObj = _shellController.sectionObj;
			//_templateObject = _courseObj.courseTemplateObject;
			
			_localeLangID = _courseObj.localeID;
			_inDebug = _courseObj.showDebug;
			
			
			_courseObj.courseTemplateXML = _templateLoader.templateXML;
			
			_checkContentLoad();
			/*
			var temppath:String = "assets/template.xml";
			var loader:XMLLoader = new XMLLoader(temppath, {name:"template", onComplete:_tempXMLLoader_handler});
			loader.load();
			*/
		}
		private function _tempXMLLoader_handler(le:LoaderEvent):void
		{
			
			var templateXML:XML = XML(le.currentTarget.content);
		    var txml:XMLList = templateXML.template.(@code == _courseObj.courseTemplateCode)
			_courseObj.courseTemplateXML = txml;

		//	_loadTextBasedElements();
		}

		private function _checkContentLoad():void
		{
			_buildShell();
		}
		private function _buildShell():void
		{
			
			//SHELL PLAYER INFO
			var shellPlayerXML:XMLList = _courseObj.getTemplateBlockXML('shellPlayer');
			var shellPlayer_x:Number = shellPlayerXML.@x;
			var shellPlayer_y:Number = shellPlayerXML.@y;
			
			var blockcolor:String =  shellPlayerXML.@fillColor;
			var pulsecolor:String = shellPlayerXML.@pulseColor;// _templateObject.pulseColor;
			var blockalpha:Number = shellPlayerXML.@fillAlpha;// _templateObject.shellBlockAlpha;
			var handleclr:String = shellPlayerXML.@handleColor;//; 'white';
			var barclr:String = shellPlayerXML.@barColor;//'greycc';
			var trackclr:String =shellPlayerXML.@trackColor;//; 'grey33';
			var shadowclr:String = shellPlayerXML.@shadowColor;//'black';
			
			//SECTION STAGE INFO
			_sectionStage = new Sprite();
			
			//COURSE HEADER INFO
			var ctitle:String = _courseObj.courseTitle;
			_msh = new MainShellHeader(ctitle,blockcolor,blockalpha);
			_sectionStage.addChild(_msh);
			
			
			
			var sectionBodyXML:XMLList= _courseObj.getTemplateBlockXML('sectionBody');
			var sectionHeaderXML:XMLList= _courseObj.getTemplateBlockXML('sectionHeader');
			var sceneHeaderXML:XMLList =  _courseObj.getTemplateBlockXML('sceneHeader');
			
			_sectionStyle = sectionBodyXML.@style;
			
			_sectionBody = new Sprite();
			_sectionBody.x = sectionBodyXML.@x;//0;
			_sectionBody.y = sectionBodyXML.@y;//30;
			
			//trace('_sectionStyle =' + _sectionStyle);
			_sectionSceneHeader = new HeaderSectionMain();
			switch (_sectionStyle) {
				case 'gps':
					//_sectionSceneHeader = new HeaderSectionScene();
					//_sectionSceneHeader = new HeaderSectionScene();
					_sectionSceneHeader.init(sectionHeaderXML,_sectionObj.sectionHeader,null,_localeLangID);
					_sectionSceneHeader.x = sectionHeaderXML.@x;
					_sectionSceneHeader.y =sectionHeaderXML.@y;
					//	_sectionSceneHeader.addEventListener(ShellEvent.SCENE_EVENT,_sceneHeaderChange);
					_sectionStage.addChild(_sectionSceneHeader);
					/*
					_sectionHeader = new SectionHeader();
					_sectionHeader.init(sectionHeaderXML,_sectionObj.sectionHeader,_localeLangID);
					_sectionHeader.x = sectionHeaderXML.@x;
					_sectionHeader.y =sectionHeaderXML.@y;
					_sectionStage.addChild(_sectionHeader);
					*/
					var gps:GPSWindow = new GPSWindow();
					var gpspath:String =  sectionBodyXML.@bitmap;
					gps.buildGPSWindow(gpspath,sectionBodyXML.@width,sectionBodyXML.@height,700,450,"white",1);
					_sectionBody.addChild(gps);
					break;
				case 'breadcrumb':
				//	_sectionSceneHeader = new HeaderSectionScene();
					_sectionSceneHeader.init(sectionHeaderXML,_sectionObj.sectionHeader,sceneHeaderXML,_localeLangID);
					_sectionSceneHeader.x = sectionHeaderXML.@x;
					_sectionSceneHeader.y =sectionHeaderXML.@y;
				//	_sectionSceneHeader.addEventListener(ShellEvent.SCENE_EVENT,_sceneHeaderChange);
					_sectionStage.addChild(_sectionSceneHeader);
					break;
				
				default:
				
					_sectionSceneHeader.init(sectionHeaderXML,_sectionObj.sectionHeader,null,_localeLangID);
					//	_sectionHeader = new SectionHeader();
					//_sectionSceneHeader.init(sectionHeaderXML,_sectionObj.sectionHeader,null,_localeLangID);
					_sectionSceneHeader.x = sectionHeaderXML.@x;
					_sectionSceneHeader.y =sectionHeaderXML.@y;
					//	_sectionSceneHeader.addEventListener(ShellEvent.SCENE_EVENT,_sceneHeaderChange);
					_sectionStage.addChild(_sectionSceneHeader);
					
					//_sectionHeader.init(sectionHeaderXML,_sectionObj.sectionHeader,_localeLangID);
					//_sectionHeader.x = sectionHeaderXML.@x;
					//_sectionHeader.y =sectionHeaderXML.@y;
					
					//_sectionStage.addChild(_sectionHeader);
			}
			
			/*
			var sectionHeaderText:String = _sectionObj.sectionHeader;
		//	trace('sectionHedaertext= '+sectionHeaderText);
			var txtDir:String = (_localeLangID == "ar")?"rtl":"ltr";
			
			_sectionHeader = new SectionHeader();
			var sectionHeaderXML:XMLList = _courseObj.getTemplateBlockXML('sectionHeader');
			_sectionHeader.init(sectionHeaderXML,sectionHeaderText,txtDir);
			_sectionHeader.x = sectionHeaderXML.@x;
			_sectionHeader.y =sectionHeaderXML.@y;
			
			_sectionStage.addChild(_sectionHeader);
			
			var secBdyXML:XMLList = _courseObj.getTemplateBlockXML('sectionBody');
			var secBdyStyle:String = secBdyXML.@style;
			
			_sectionBody = new Sprite();
			_sectionBody.x = secBdyXML.@x;//0;
			_sectionBody.y = secBdyXML.@y;//30;
			
			switch (secBdyStyle) {
				case 'gps':
					var gps:GPSWindow = new GPSWindow();
					var gpspath:String =  secBdyXML.@bitmap;
					gps.buildGPSWindow(gpspath,secBdyXML.@width,secBdyXML.@height,700,450,"white",1);
					_sectionBody.addChild(gps);
					break;
				case 'breadcrumb':
					
					break;
				
				default:
					
			}
			
			*/
			
			/*
			switch (_courseObj.courseTemplateCode){
				case 'PAPS':
					var gps:GPSWindow = new GPSWindow();
					var gpsbmp:Bitmap = _ALoader.getAssetBitmap("gpsback");
					gps.buildGPSWindow(gpsbmp,_templateObject.holder_width,_templateObject.holder_height,_templateObject.content_x,_templateObject.content_y,"white",1);
					
				//	gps.buildGPSWindow(745,525,700,450,'white',1);
					gps.x = _templateObject.holder_x;//   .5;//SHELL_VARS.GPS_CHROME_X;//5;
					gps.y =_templateObject.holder_y;//30;// SHELL_VARS.GPS_CHROME_Y;//55;
					
					_sectionBody.addChild(gps);
					break;
				default:
					
					
			}
			*/
			//var _navPlayer:NavPlayer = new NavPlayer();
			
			var pulseback:Bitmap =  _templateLoader.getAssetBitmap("btn_pulse");;
		//	var pulseback:Bitmap =  _ALoader.getAssetBitmap("btn_pulse");;
			var btnNext:BTN_ShellMain = _buildShellBtn('btnNEXT',pulsecolor,pulseback);
			var btnBack:BTN_ShellMain = _buildShellBtn('btnBACK',pulsecolor,pulseback);
			var btnDone:BTN_ShellMain = _buildShellBtn('btnDONE',pulsecolor,pulseback);
			
			
			
			_navPlayer =  new NavPlayer(btnBack,btnNext,btnDone,blockcolor,pulsecolor,blockalpha);//blockalpha);
			_navPlayer.x = SHELL_VARS.FOOTER_X;
			_navPlayer.y = SHELL_VARS.FOOTER_Y;
			_navPlayer.addEventListener(ShellEvent.SCENE_EVENT, _navEvent_handler);
			
			this.addChild(_navPlayer);
			
			_sectionStage.addChild(_sectionBody);
			this.addChild(_sectionStage);
			var btnResume:BTN_ShellMain = _buildShellBtn('btnNEXT',pulsecolor,pulseback);
			var btnRestart:BTN_ShellMain = _buildShellBtn('btnBACK',pulsecolor,pulseback);
			var btnPause:BTN_ShellMain = _buildShellBtn('btnPAUSE',pulsecolor,pulseback);
			
		
			_slidePlayer =  new SlidePlayer(btnRestart,btnResume,btnPause,handleclr,barclr,trackclr,shadowclr,blockcolor,pulsecolor,blockalpha);
				
			_slidePlayer.x = shellPlayer_x;//280;
			_slidePlayer.y =shellPlayer_y;// 532;//562;// 558;
				//btnBack,btnNext,btnDone,blockcolor,pulsecolor,blockalpha);
			
			
			
			
			/*
			_navController = new NavController(blockcolor,pulsecolor,blockalpha);
			_navController.x = SHELL_VARS.FOOTER_X;
			_navController.y = SHELL_VARS.FOOTER_Y;
			_navController.addEventListener(ShellEvent.SCENE_EVENT, _navEvent_handler);
			
			this.addChild(_navController);
			*/
			
			_debugLayer = new Sprite();
			this.addChild(_debugLayer);
			
			//if (TRACK_VARS.inDemoMode) {
			if(_inDebug){
				_debugdisplay.x =30;
				_debugdisplay.y = 6;
				_navPlayer.addChild(_debugdisplay);
				_debugdisplay.init(_shellVersion);
				
			}
			
			
			//if section partially complete jump 2 last completed scene
			var jump2scene:int;
			
			if (!_sectionComplete){
				//if section isNOT complete then get index of last completed scene.(should not use index, but......)
				var newSceneIDListArray:Array = _shellController.sceneIDListTracked;
				//jumping to newSceneIDListArraay.length puts user after last completed scene
				jump2scene = (newSceneIDListArray.length<1)?0:(newSceneIDListArray.length);
				//trace('jup2scene int='+ jump2scene);
			} else {
				//if section is complete then ignore any bookmark and start at begininng
				jump2scene = 0;
			}
		
			//this.removeChild(_ploader);
			_loadScene(jump2scene);
		}
		
		
		private function _sceneHeaderChange(se:ShellEvent):void
		{
			var scene_title:String = se.eventInfo;
		//	trace('scene_title==== ' + scene_title);	
		}
		private function _buildShellBtn(btnname:String,pulsecolor:String,pulseback:Bitmap):BTN_ShellMain
		{
			var btn:BTN_ShellMain = new BTN_ShellMain();
			
			var skin_normal:String = btnname + "_normal";
			var skin_hover:String = btnname + "_hover";
			var skin_down:String = btnname + "_down";
			var bmpd_pulse:BitmapData = pulseback.bitmapData;
			
			
			var bmpd_normal:BitmapData = _templateLoader.getAssetBitmap(skin_normal).bitmapData;
			var bmpd_hover:BitmapData = _templateLoader.getAssetBitmap(skin_hover).bitmapData;
			var bmpd_down:BitmapData = _templateLoader.getAssetBitmap(skin_down).bitmapData;
		//	var bmpd_normal:BitmapData = _ALoader.getAssetBitmap(skin_normal).bitmapData;
		//	var bmpd_hover:BitmapData = _ALoader.getAssetBitmap(skin_hover).bitmapData;
		//	var bmpd_down:BitmapData = _ALoader.getAssetBitmap(skin_down).bitmapData;
			
			
			btn.buildButtonStates(btnname,bmpd_pulse,bmpd_normal,bmpd_hover,bmpd_down,null,pulsecolor);
			
			return btn;
		}
	
		private function _loadScene(sceneIndex:int = 0, forward:Boolean = true, byIndex:Boolean = true, sceneNumber:String = null ):void
		{
			var si:int = sceneIndex;
			var useSI:Boolean = byIndex;
			var sn:String = sceneNumber;
			
			
			_currentSceneIndex = sceneIndex;
			
			
			var so:SceneObject;
			if (!byIndex) {
				//trace('useSi= ' + useSI +' sceneNumber= ' + sn);
				so = _shellController.getAndSetCurrentSceneObjectBySceneID(sn);
			} else {
			//	trace('useSi= ' + useSI +' sceneIndex= ' + si);
				so = _shellController.getAndSetCurrentSceneObjectBySceneIndex(si);
			}
			
			
			//var scenType0:String = so.sType;
			var scentype:String = String(so.sType).toLowerCase(); 
			_currentSceneID = so.sID;
		//	trace('_currentSceneID= ' + _currentSceneID);
			//If going backwards load last slide instead of first slide
			var loadSlideIndex:int = (!forward) ? so.finalSlideIndex : 0;
			
			// do any required processing based on the new scene type
			switch (scentype) { 
				
				// if the scene is the course completion screen, we need to decide which slide to display based on the completion status
				case "completeexit":
					var courseComplete:Boolean;
					
					if (_isLMSinit != false) {
					// look at the read-only objectives to determine if they are all complete (all have success_status == 'passed')
					courseComplete = MYSCORM.objectivesPassed(0);
					// if in debug mode, add the scorm debugger window
					if (_inDebug) {
						var scormDebugger:Debugger = new Debugger();
						scormDebugger.x = 500;
						scormDebugger.y = 510;
						_debugLayer.addChild(scormDebugger);
						var newstring:String = MYSCORM.getTheObjectiveInfo();
						scormDebugger.displayText(newstring);
						var courseInfo:String = MYSCORM.getTheCourseInfo();
						scormDebugger.displayText(courseInfo);
						scormDebugger.alpha = 0.5;
					}
					} else {
						courseComplete = false;
					}
					
					// the course completion scene should have 2 slides, the first being the "not completed" and the second being the "completed" slide
					if (courseComplete) {
						loadSlideIndex = 1;
						//MYSCORM.setScoComplete();
						//MYSCORM.Commit();
					} else {
						loadSlideIndex = 0;
					}
					//trace("SHELL_CA._loadScene scenetype=coursecomplete complete="+courseComplete+" loadSlideIndex="+loadSlideIndex);
					break;
			}
			
			_currentSlideIndex = loadSlideIndex;
			if (_currentSlideIndex >= _shellController.currentSlideList.length) {
				_currentSlideIndex = _shellController.currentSlideList.length - 1;
				//trace("start slide forced to " + _currentSlideIndex);
			}
			_currentSlideObject = _shellController.getAndSetCurrentSlideObjectByIndex(_currentSlideIndex);
			
			//_sceneDone is true only when the user has finished viewing all slides contained in the current scene.
			_sceneDone = false;
			
			
			
			// if in debug mode, update the debug scene/slide number display
			if (_inDebug) {
				_debugdisplay.slideNumber = _currentSlideObject.slideNumber;
				//_debugdisplay.setSlideInfo(_currentSceneIndex+1,_currentSceneNumber,_currentSlideIndex+1,_currentSlideNumber);
			}
			
			//	_currentSceneTrackedComplete = _shellController.isSceneTracked(_currentSceneID);
			if (_inDebug && scentype =="splash") {
				//	_debugdisplay.sceneNumber = _currentSceneID;
				_sectionComplete = false;
			}
			//	_currentSceneObject = so;
			//_currentSceneObject.shellDir = _shelldir;
			_currentSceneBase = new SceneBase();
			
			_currentSceneBase.addEventListener(ShellEvent.SCENE_EVENT,_sceneEvent_listener);
			_currentSceneBase.buildScene(so,loadSlideIndex,_courseObj.courseTemplateXML,_slidePlayer,_sectionComplete);
			//	_currentSceneBase.buildScene(so,loadSlideIndex,_templateObject,_slidePlayer);
			
			
			_sectionBody.addChild(_currentSceneBase);
			
			
			/*
			
			if (scentype == "completeexit") {
				//MYSCORM.setCompletionStatus();
				//var globalObjStatus:String = MYSCORM.GetObjectiveStatusByID("gObj_RPSS00XX_primary");
				if (_inDebug){
					var scormDebugger:Debugger = new Debugger();
					scormDebugger.x = 500;
					scormDebugger.y = 510;
					_debugLayer.addChild(scormDebugger);
					var newstring:String = MYSCORM.getTheObjectiveInfo();
					scormDebugger.displayText(newstring);
					scormDebugger.alpha = 0;
					
				}
				var ccomplete:Boolean = MYSCORM.CheckGlobalObjectiveSuccessStatus();
				//ccomplete = true;
				//var ccomplete:Boolean = MYSCORM.CheckGlobalObjectiveCompletionStatus();
			//	areAllGlobalsComplete = true;
				
				var courseInfo:String;
				
				if (ccomplete){
					loadSlideIndex = 1;
				//	_sectionHeader.changeHeader("COURSE COMPLETE");
					var ccc:* = MYSCORM.MarkAllCompleteAndCommit();
					courseInfo = MYSCORM.getTheCourseInfo();
					
				} else {
					loadSlideIndex = 0;
				//	_sectionHeader.changeHeader("COURSE INCOMPLETE");
					courseInfo = MYSCORM.getTheCourseInfo();
					
				}
				if (_inDebug){
				scormDebugger.displayText(courseInfo);
				}
				//TRACK_VARS.courseComplete = true;
				 //	TRACK_VARS.globalObjectiveStatus
			}
			*/
			
		

		}
	
		private function _sceneEvent_listener(se:ShellEvent):void
		{
			var eventAction:String = se.eventAction;
			var eventInfo:String = se.eventInfo;
			var cSceneObj:SceneObject  = _shellController.currentSceneObject;
			
			switch (eventAction){
				case 'sceneDone':
				//	trace('cSceneObj = ' + cSceneObj.sID);
					var cSlideObj:SlideObject = _shellController.currentSlideObject;
					//var cSldID:String = cSlideObj.slideID;
				//	_shellController.trackSlideByID(cSldID);
					_sceneDone = true;
				//	trace("Scene-" + eventInfo + " is Complete");
					_checkSectionDone(cSceneObj);
					//_shellController.activateNextBtn();
					break;
				case 'courseDone':
					_delay_SCORMcall();
					_completeAndEndCourse();
					break;
				case 'slideDone':
					_slideContentComplete(eventInfo);
					
					break;
				case 'slideReady':
					_slideContentReady(eventInfo);
					
					break;
				case 'switchSceneHeader':
				//	trace('switchSceneHeader====' + eventInfo);
					_sectionSceneHeader.switchSceneHeader(_sectionObj.sectionHeader,eventInfo);
					break;
				case 'switchSectionHeader':
					_sectionSceneHeader.switchSceneHeader(eventInfo);
					break;
				case 'printScene':
					_printScene_handler();
					
					break;
				case 'startCourse':
					//cSceneObj = _shellController.currentSceneObject;
					_checkSectionDone(cSceneObj);
					break;
			}

			
		}
		private function _slideContentReady(slideID:String):void
		{
			
			var cSceneObj:SceneObject = _shellController.currentSceneObject;
			var cSceneIndex:int = cSceneObj.sIndex;
			var cSceneID:String = cSceneObj.sID;
			var cSceneType:String = cSceneObj.sType;
			
		//	var cSceneTypeLC:String = cSceneType.toLowerCase();
			var cSceneTracked:Boolean =  _shellController.isSceneTracked(cSceneID);
		//	trace("cSceneTracked = > " + cSceneTracked);
			var cSlideObj:SlideObject = _currentSceneBase.currentSlideObject;
		
			
		//	if (TRACK_VARS.inDemoMode){
			if (_inDebug){
			//	trace('for debug='+ cSlideObj.slideID);
			_debugdisplay.slideNumber = cSlideObj.slideID;
			}
	//	 trace("is slideId = " + cSlideObj.slideID + " tracked :" + _shellController.isSlideTracked(cSlideObj.slideID));
			var cSlideTracked:Boolean =  _shellController.isSlideTracked(cSlideObj.slideID);
			var cSlideIndex:int = cSlideObj.slideIndex;
			
		
			var firstSlide:Boolean  = (cSlideIndex <= 0)?true:false;
			var lastSlide:Boolean = (cSlideIndex >= cSceneObj.finalSlideIndex)?true:false;
			
			
			var firstScene:Boolean = (cSceneIndex <= 0)?true:false;
			var lastScene:Boolean = (cSceneIndex >=  _shellController.finalSceneIndex )?true: false;
			
			//Exception Because of GPSMENU SCENE TYPE
			//var isGPSMenu:Boolean = false;
			var hasSceneMenu:Boolean = _currentSceneBase.hasSceneMenu;
			if (hasSceneMenu){
				firstSlide = true;
				lastSlide = true;
			}
			//if (cSceneObj.sType == "navbarmenu"){
				//isGPSMenu = true;
				//firstSlide = true;
				//lastSlide = true;
			//}
			var showBackBtn:Boolean = false;
			var showNextBtn:Boolean = false;
			var showDoneBtn:Boolean = false;
			
			if (firstSlide == true && firstScene == true) {
				showBackBtn = false;
			} else {
				showBackBtn = true;
			}
			
			if (!cSceneTracked) {
					if (cSlideTracked && !hasSceneMenu) {
							if (lastSlide == true && lastScene == true){
								showDoneBtn = true;
								showNextBtn = false;
							} else {
								showDoneBtn = false
								showNextBtn = true;
							}
						} else {
							showDoneBtn = false;
							showNextBtn = false;
						}
			} else {
				//The CurrentSCene is tracked which mean all Slides are tracked 
				if (lastSlide == true && lastScene == true){
					showDoneBtn = true;
					showNextBtn = false;
				} else {
					showDoneBtn = false
					showNextBtn = true;
				}
			}
			var ssready:String = "Slide ready: ";
			//trace('cSceneType='+cSceneType + 'slidetype' + cSlideObj.slideType +"showNextBtn = "+showNextBtn );
			if (cSceneType == 'completeexit'){
				//trace(ssready+ 'completeexit');
				
			} else if (cSceneType == 'splash') {
				//trace(ssready+ 'splash');
				
			} else {
				
				if (showBackBtn) {
					_navPlayer.activateBackBtn();
				}
				if (showNextBtn) {
					_navPlayer.activateNextBtn(false);
				}
					
				if (showDoneBtn){
					_navPlayer.activateDoneBtn(false);
				}
			}
			
		}
		
		private function _slideContentComplete(slideID:String):void
		{
			
			var cSceneObj:SceneObject = _shellController.currentSceneObject;
			var cSceneIndex:int = cSceneObj.sIndex;
			var cSceneID:String = cSceneObj.sID;
			var cSceneType:String = cSceneObj.sType;
			
			//var cSceneIsTracked:Boolean =  _shellController.isSceneTracked(cSceneID);
			
			var cSlideObj:SlideObject = _shellController.currentSlideObject;
			
			//trace("SlideID-" + slideID + "= " + cSlideObj.slideID);
			
		
		//	var hasSceneMenu:Boolean = false;
			/*
			if (cSceneType == 'navbarmenu' || cSceneType == "c2r") {
				hasSceneMenu = true;
			}
			*/
			var cSlideIsTracked:Boolean =  _shellController.isSlideTracked(cSlideObj.slideID);
			var hasSceneMenu:Boolean = _currentSceneBase.hasSceneMenu;
			var continueBtnType:String = cSceneObj.sContBtnType;
		//	trace('continueBtnType= ' + continueBtnType);
			switch (continueBtnType) {
				case 'exit':
					if(!_isLMSinit){
						_navPlayer.activateNextBtn(true);
					}
					break;
				case 'start':
					//	trace("don't shownav");
					break;
				default:
					if (!hasSceneMenu) {
						//var withPulse:Boolean = (cSlideIsTracked == true)?true:false;
						_navPlayer.activateNextBtn(true);
					}
					
			}
		
			_shellController.trackSlideByID(cSlideObj.slideID);
	
		}
		
		
		private function _trackSceneAndSaveBookmark(scnID:String):void
		{
			var shouldISendData:Boolean = _shellController.trackSceneID_FORBookmark(scnID);
			if (shouldISendData){
				
				var newSceneIDListArray:Array = _shellController.sceneIDListTracked;
				var newSuspendDataString:String =  (newSceneIDListArray.length >1)?newSceneIDListArray.join("|"):newSceneIDListArray.toString();
				
				//var newSuspendDataString:String = newSceneIDListArray.join("|");
			//	trace("tracking data string>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>="+newSuspendDataString );
				
				MYSCORM.suspendData = newSuspendDataString;
				
			} else {
				//trace("tracking data has not changed - do not send");
			}
		}

		private function _checkSectionDone(scenObj:SceneObject):void
		{
			var so:SceneObject =  scenObj;
			var sceneID:String = so.sID;
		
			var continueBtnType:String = so.sContBtnType;
		//	trace('continueBtnType= '+ continueBtnType);
			
			if ( continueBtnType == 'done'){
					//MYSCORM.setCompletionStatus();
					//ADD SECTION COMPLETE SCORM CODE HERE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					_navPlayer.activateDoneBtn();
					_delay_SCORMcall();
					//MYSCORM.setCompletionStatus();
				} else if ( continueBtnType == 'start'){
					_delay_SCORMcall('nextsco')
					//MYSCORM.setCompletionStatus();
					//_nextSCO();
				} else if ( continueBtnType == 'exit'){
	
					//trace('This should only happen when scene is 99000');
				} else {
					//ADD SCENE COMPLETE BOOKMAKR CODE HERE!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					if (so.isTracked) {
						_navPlayer.activateNextBtn();
					} else {
						so.isTracked = true;
						//_shellController.trackSceneID(sceneID);
					//	_scorm_bookmark(sceneID);
						_navPlayer.activateNextBtn();
						_trackSceneAndSaveBookmark(sceneID);
					}
					
				}
			
		}
		
		private function _delay_SCORMcall(whatnext:String = ''):void
		{
			//MYSCORM.setCompletionStatus();
			MYSCORM.setScoComplete();
			if (whatnext == 'nextsco'){
				MYSCORM.Commit();
				_nextSCO();
			}
		}
		//is slideId
		private function _navEvent_handler(se:ShellEvent):void
		{
			var eventAction:String = se.eventAction;
				var eventInfo:String = se.eventInfo;
				
				var cSceneObj:SceneObject = _shellController.currentSceneObject;
				var cSceneIndex:int = cSceneObj.sIndex;
				var cSlideObj:SlideObject = _shellController.currentSlideObject;
				var cSlideIndex:int = cSlideObj.slideIndex;
				var cSceneType:String = cSceneObj.sType;
				
				
				var hasSceneMenu:Boolean = _currentSceneBase.hasSceneMenu;
				/*
				var hasSceneMenu:Boolean = false;
				if (cSceneType == 'navbarmenu' || cSceneType == 'c2r') {
					hasSceneMenu = true;
				}
				*/
				var newSceneIndex:int;
				var newSlideIndex:int;
				switch (eventAction){
					case 'clickedNext':
						newSlideIndex = cSlideIndex + 1;
						if (newSlideIndex > cSceneObj.finalSlideIndex || hasSceneMenu == true){
							newSceneIndex = cSceneIndex + 1;
							_clearAndLoadScene(cSceneIndex,newSceneIndex);
						} else {
							
							_clearAndLoadSlide(cSlideIndex,newSlideIndex);
						}
						break;
					case 'clickedBack':
						if(cSlideIndex == 0 || hasSceneMenu == true) {
							newSceneIndex = cSceneIndex -1;
							_clearAndLoadScene(cSceneIndex,newSceneIndex,false);
						} else {
							newSlideIndex = cSlideIndex - 1;
							_clearAndLoadSlide(cSlideIndex,newSlideIndex);
						
						}
						break;
					case 'clickedDone':
						_nextSCO();
						break;
				}
			
		}
		
		private function _clearAndLoadSlide(curSlideIndex:int, newSldIndex:int):void
		{
		//	_currentSceneBase.killCurrentSlideTL();
			_currentSceneIndex = curSlideIndex;
			_currentSlideObject = _shellController.getAndSetCurrentSlideObjectByIndex(newSldIndex);
			_currentSceneBase.loadSlideByIndex(newSldIndex);
			_currentSlideIndex = newSldIndex;
			
		}
		private function _clearAndLoadScene(curSceneIndex:int, newSceneIndex:int, forward:Boolean = true):void
		{
			_currentSceneBase.killCurrentSlideTL();
			var sceneTransTL:TimelineLite = new TimelineLite({onComplete:_onSceneOutTween, onCompleteParams:[curSceneIndex,newSceneIndex,forward]});
			sceneTransTL.append(TweenMax.to(_currentSceneBase,1,{alpha:0}));
			/*
			sceneTransTL.append(TweenMax.to(_currentSceneBase,1,{blurFilter:{blurX:20, blurY:29, quality:3},ease:Quart.easeOut}));
			sceneTransTL.insert(TweenMax.to(_currentSceneBase, 1, {transformAroundCenter:{scaleY:0}, ease:Elastic.easeOut}),.6);
			*/
			//sceneTransTL.insert(TweenMax.to(_currentSceneBase,.5,{scaleY:0,ease:Quart.easeOut}),.7);
			
			
		}
		
		private function _onSceneOutTween(cSi:int,nSi:int,fwd:Boolean):void {
			//trace("The tween has finished! param1 = " + cSi + ", and param2 = " + nSi + "going forward: " + fwd);
			/*
			while (_sceneStage.numChildren > 0) {
				_sceneStage.removeChildAt(0);
			}
			*/
			_sectionBody.removeChild(_currentSceneBase);
			
			_loadScene(nSi,fwd);
		}
		/**
		 * PRINT STUFF
		 */
		
		
		private function _printScene_handler():void
		{
			var pj:PrintJob = new PrintJob();
			var options:PrintJobOptions = new PrintJobOptions();
			options.printAsBitmap = true;
			trace("print called!");
			if (pj.start()) {
				try {
					
					var printSprite:Sprite = new Sprite();
					_sectionHeader.printView = true;
					_currentSceneBase.printView = true;
					var bitmapData:BitmapData = new BitmapData(stage.stageWidth,stage.stageHeight);
					//_currentSceneBase.printView = true;
					bitmapData.draw(_sectionStage);
					var screenShot:Bitmap = new Bitmap(bitmapData);
					printSprite.addChild(screenShot);
					_sectionHeader.printView = false;
					_currentSceneBase.printView = false;
					//========== printjob bug fix – prevent blank pages: ==========
					printSprite.x = 2000; //keep it hidden to the side of the stage
					stage.addChild(printSprite); //add to stage – prevents blank pages
					//=============================================================
				//	trace("before printSprite width: " + printSprite.width + " printJob.pageWidth: " + pj.pageWidth);
					//scale it to fill the page (portrait orientation):
					var myScale:Number;
					myScale = Math.min(pj.pageWidth/printSprite.width, pj.pageHeight/printSprite.height);
					printSprite.scaleX = printSprite.scaleY = myScale;
					var printArea:Rectangle = new Rectangle(0, 0, pj.pageWidth/myScale, pj.pageHeight/myScale);
				//	trace("after printSprite width: "+ printSprite.width + " printJob.pageWidth: " + pj.pageWidth);
					pj.addPage(printSprite,printArea,options);
					pj.send();
					stage.removeChild(printSprite);
					//_sectionHeader.printView = false;
				//	_currentSceneBase.printView = false;
					printSprite = null;
				}
				
				catch(e:Error) {
					// handle error 
				}
				pj.send();
			}
			
		}
		
		/**
		 * SCORM STUFF
		 */
		
		private function _markScoComplete():void
		{
			
			//MYSCORM.MarkScoComplete();
			//MYSCORM.Commit();
		}
		private function _completeAndEndCourse():void
		{
			//trace("ALL DONE");
			//	flash.media.SoundMixer.stopAll();
			//MYSCORM.setScoComplete(); // complete current SCO (exit SCO also completes the course)
			MYSCORM.ExitCourse();     // and physically exit/terminate the course
				//MYSCORM.setCompletionStatusExitAll();
		}
		private function _nextSCO(arg1:String = null):void
		{
			//trace("_nextSCO");
			if(!_isLMSinit){
				var nextsection:Number;// =  1000;
				if (_sectionNumber < 1000) {
				nextsection =  1000;
				} else if (_sectionNumber == 7000){
					nextsection =  88000;
				} else if (_sectionNumber  > 7000){
					nextsection =  + 99000;
				} else {
					nextsection = _sectionNumber + 1000;
				}
				var hasExternalInterface:Boolean = ExternalInterface.available;
				if (hasExternalInterface){
					ExternalInterface.call("nextsco",nextsection,_templateID,_langID);
				}
			
				
			//var returnvalue:int = ExternalInterface.call("js_function", "argument_for_js_function","another_argument");
			} else {
				if (arg1 != null) {
					MYSCORM.GoTo(arg1);
				} else {
					MYSCORM.Continue();
				}
				
			}

			
		}
		
		
	}
}