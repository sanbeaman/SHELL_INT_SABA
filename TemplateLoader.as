package
{
	
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.core.LoaderCore;
	import com.sanbeaman.shell.utils.LoadShellFonts;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	public class TemplateLoader extends EventDispatcher
	{
		public static const TEMPLATE_LOAD_COMPLETE:String = "templateLoadComplete";
		public static const TEMPLATE_LOAD_ERROR:String = "templateLoadError";
		public static const FIRST_ASSET_LOAD:String = "firstAssetLoad";
		
		private var _firstAsset:String = "shellback";
		//var _queLoader:LoaderMax;
		private var _assetArray:Array;
		private var _shelldir:String;
		private var _assetDic:Dictionary;
		
		private var _targetPath:String;
		
	//	public static const COMPLETE:String = "complete";
	//	public static const ERROR:String = "error loading font";
		//private var loader:Loader = new Loader();
		//private var _fontsDomain:ApplicationDomain;
		private var _fontNames:Array;
		
		private var _xmlLoader:XMLLoader;
		
		private var _assetLoader:LoaderMax;
		private var _fontLoader:SWFLoader;
		private var _templateXML:XMLList;
		
		public function TemplateLoader()
		{
			
			_assetArray = new Array();
			_assetDic = new Dictionary();
			LoaderMax.activate([ImageLoader, SWFLoader, MP3Loader]);
			
		}
		public function startLoader(targetpath:String):LoaderCore
		{
			_targetPath = targetpath;
			//	_shelldir = SHELL_VARS.FOLDER_SHELL_IMGS + "assets.xml";
			//LoaderMax.activate([ImageLoader]); //only necessary once - allows XMLLoader to recognize ImageLoader nodes inside the XML
			_xmlLoader = new XMLLoader(_targetPath, {name:"templatexml",onInit:_initHandler,onComplete:_completeHandler,onIOError:_onIO_Error,onError:_onXML_Error,estimatedBytes:50000});
			//_xmlLoader = new XMLLoader(_targetPath, {name:"templatexml",onComplete:_completeHandler,onChildComplete:_childCompleteHandler,onIOError:_onIO_Error,onError:_onXML_Error,estimatedBytes:50000});
			
			_xmlLoader.load();
			return _xmlLoader;
		}
		
		private function _initHandler(le:LoaderEvent):void {
			var loadersarray:Array = _xmlLoader.getChildren();
			for (var i:int = 0; i < loadersarray.length; i++) {
				
				var loadname:String = loadersarray[i].name;
				switch (loadname){
					case 'imgque':
						var firstloader:LoaderCore = loadersarray[i].getLoader(_firstAsset);
						firstloader.addEventListener(LoaderEvent.COMPLETE, _firstAssetLoaded);
						
						//addEventListener(LoaderEvent.CHILD_COMPLETE, _img_childCompleteHandler);
						break;
					case 'fontque':
						loadersarray[i].addEventListener(LoaderEvent.COMPLETE, _font_completeHandler);
						break;
					default:
				}
						
			}

		}
		private function _firstAssetLoaded(le:LoaderEvent):void {
			var evt:Event = new Event(TemplateLoader.FIRST_ASSET_LOAD);
			this.dispatchEvent(evt);
		}
		private function _img_childCompleteHandler(le:LoaderEvent):void {
			var loaderName:String = le.target.name;
			trace('this loader is called: ' + loaderName);
			
			//var bmp:Bitmap = LoaderMax.getLoader(loaderName).rawContent;
			//_assetDic[bmp] = loaderName;
			
			if (loaderName == _firstAsset){
				var evt:Event = new Event(TemplateLoader.FIRST_ASSET_LOAD);
				this.dispatchEvent(evt);
				
			}
		}
		
		private function _font_completeHandler(le:LoaderEvent):void {
			_fontLoader = LoaderMax.getLoader('fontpack');
			var fontstring:String = _fontLoader.vars.fontArray;
			_fontNames = fontstring.split(",",19);
			trace('_fontNames='+ _fontNames.length + '  toString' + _fontNames);
			registerFonts(_fontNames);
		}
		/*
		public function init(targetpath:String):void
		{
			_targetPath = targetpath;
		//	_shelldir = SHELL_VARS.FOLDER_SHELL_IMGS + "assets.xml";
			//LoaderMax.activate([ImageLoader]); //only necessary once - allows XMLLoader to recognize ImageLoader nodes inside the XML
			_xmlLoader = new XMLLoader(_targetPath, {name:"templatexml",onComplete:_completeHandler,onChildComplete:_childCompleteHandler, estimatedBytes:50000});
			_xmlLoader.load();
		}
		*/
		private function _childCompleteHandler(event:LoaderEvent):void {
			var loaderName:String = event.target.name;
				trace('this loader is called: ' + loaderName);
			switch (loaderName){
				case 'imgque':
					
					break;
				case 'audio':
					
					break;
				case 'fontque':
					
					break;
				case 'fontpack':
					_fontLoader = LoaderMax.getLoader('fontpack');
					var fontstring:String = _fontLoader.vars.fontArray;
					_fontNames = fontstring.split(",",19);
					trace('_fontNames='+ _fontNames.length + '  toString' + _fontNames);
					registerFonts(_fontNames);
					break;
				default:
					var bmp:Bitmap = LoaderMax.getLoader(loaderName).rawContent;
					_assetDic[bmp] = loaderName;
					if (loaderName == _firstAsset){
						var evt:Event = new Event(TemplateLoader.FIRST_ASSET_LOAD);
						this.dispatchEvent(evt);
					}
					
			}
	
		}
		
		private function _completeHandler(event:LoaderEvent):void {
			
			//trace('Template Loading Complete.');
			/*
			for (var i:Object in _assetDic){ // Make sure you use object, or your key might not show up 
			trace (i + ' = ' + _assetDic[i]); // [Object MovieClip] = 'foo', then [Object MovieClip] = 'bar' 
			}
			*/
			_templateXML = LoaderMax.getContent('templatexml').template;
			
			//_assetLoader = LoaderMax.getLoader("imgque") as LoaderMax;
		//	_fontLoader = LoaderMax.getLoader("fontque") as LoaderMax;
			
			var evt:Event = new Event(TemplateLoader.TEMPLATE_LOAD_COMPLETE);
			this.dispatchEvent(evt);
			
		}
		public  function getAssetBitmap(name:String):Bitmap
		{
			var retrnBMP:Bitmap  = LoaderMax.getLoader(name).rawContent;
			return retrnBMP;
			
		}
		/*
		public  function getAssetBitmap(name:String):Bitmap
		{
			var retrnBMP:Bitmap;
			var count:int = 0;
			for (var obj:Object in _assetDic) {
				//trace('asset ' + count);
				if(_assetDic[obj]==name){
					//	trace('obj= '+ _assetDic[obj]);
					retrnBMP =  obj as Bitmap;
					break;
				}
				count++;
			}
			return retrnBMP;
			
		}
		*/
		/*
		public function LoadShellFonts(url:String,fontName:Array):void {
			_fontName = fontName;
			trace("loading");
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, font_ioErrorHandler);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,finished);
			loadAsset(url);
		}
		private function loadAsset(url:String):void {
			var request:URLRequest = new URLRequest(url);
			loader.load(request);
		}
		private function finished(evt:Event):void {
			_fontsDomain = loader.contentLoaderInfo.applicationDomain;
			registerFonts(_fontName);
			dispatchEvent(new Event(LoadShellFonts.COMPLETE));
		}
		*/
		
		private function _enumerateAllFonts():void
		{
			
			var fontArray:Array=Font.enumerateFonts(false);
			for (var i:int=0;i<fontArray.length;i++){
				trace('FontName= '+ fontArray[i].fontName + ' type= ' + fontArray[i].fontType);
				
			}//if
			
			
		}
	
	
		private function _showEmbeddedFonts():void 
		{
			var fonts:Array = Font.enumerateFonts();
			fonts.sortOn("fontName",Array.CASEINSENSITIVE);
			for (var i:int=0;i<fonts.length;i++){
				trace("Embedded fonts = " + fonts[i].fontName + ", " + fonts[i].fontStyle);
			}
			
		}
	
	/*
		private function font_ioErrorHandler(evt:Event):void {
			dispatchEvent(new Event(LoadShellFonts.ERROR));
		}
		*/
		public function registerFonts(fontList:Array):void {
		/*
			for (var i:uint = 0; i < fontList.length; i++) {
				
				Font.registerFont(getFontClass(fontList[i]));
			}
			*/
			_enumerateAllFonts();
		}
		
	
		public function getFontClass(id:String):Class {
			
			
			return	ApplicationDomain.currentDomain.getDefinition(id) as Class;
			
			//return _fontsDomain.getDefinition(id)  as  Class;
		}
		public function getFont(id:String):Font {
			var fontClass:Class = getFontClass(id);
			return new fontClass    as  Font;
		}
		
	
		public function getRealFontName(fname:String):String
		{
			var realFontName:String = new String();
			var fontArray:Array=Font.enumerateFonts(true);
			for (var item in fontArray) {
				if (fontArray[item].fontName==fname) {
					realFontName=fontArray[item].fontName;
					break;
				}//if
			}//for
			
			return realFontName;
		}

		public function get templateXML():XMLList
		{
			return _templateXML;
		}
		private function _onXML_Error(le:LoaderEvent):void {
			trace("error occured with " + le.target + ": " + le.text);
		}
		
		
		private function _onIO_Error(le:LoaderEvent):void
		{
			trace("error occured with " + le.target + ": " + le.text);
		}
		
	}
}

