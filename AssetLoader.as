package
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
//	import com.sanbeaman.shell.utils.LoadShellFonts;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	public class AssetLoader extends EventDispatcher {
		
		public static const ASSET_LOAD_COMPLETE:String = "assetLoadComplete";
		public static const ASSET_LOAD_ERROR:String = "assetLoadError";
		public static const FIRST_ASSET_LOAD:String = "firstAssetLoad";
		
		private var _firstAsset:String = "shellback";
		//var _queLoader:LoaderMax;
		private var _assetArray:Array;
		private var _shelldir:String;
		private var _assetDic:Dictionary;
		
		public function AssetLoader()
		{
			
			_shelldir = SHELL_VARS.FOLDER_SHELL_IMGS + "assets.xml";
			_assetArray = new Array();
			_assetDic = new Dictionary();
			
			LoaderMax.activate([ImageLoader]); //only necessary once - allows XMLLoader to recognize ImageLoader nodes inside the XML
		
			var loader:XMLLoader = new XMLLoader(_shelldir, {onChildComplete:_childCompleteHandler,onComplete:_completeHandler, estimatedBytes:50000});
			
			
			loader.load();
		}
		public function getAssetBitmap(name:String):Bitmap
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
			/*
			if(_assetDic[name]==undefined){
				var bitmap:Bitmap= new Bitmap();
				_assetDic[name]= bitmap;
				trace('no bitmap');
			}
			return _assetDic[name];
			*/
		}
		
		private function _childCompleteHandler(event:LoaderEvent):void {
			var loaderName:String = event.target.name;
			
		//	trace('this loader is called: ' + loaderName);
			
			
			if (loaderName != 'imgque'){
				var bmp:Bitmap = LoaderMax.getLoader(loaderName).rawContent;
				_assetDic[bmp] = loaderName;
			}
			if (loaderName == _firstAsset){
				var evt:Event = new Event(AssetLoader.FIRST_ASSET_LOAD);
				this.dispatchEvent(evt);
			}
		}
		
		private function _completeHandler(event:LoaderEvent):void {
			//	trace('Asset LOading Complete.');
				/*
				for (var i:Object in _assetDic){ // Make sure you use object, or your key might not show up 
					trace (i + ' = ' + _assetDic[i]); // [Object MovieClip] = 'foo', then [Object MovieClip] = 'bar' 
				}
				*/
				var evt:Event = new Event(AssetLoader.ASSET_LOAD_COMPLETE);
				this.dispatchEvent(evt);
			
		}
		
		
			
		}
}