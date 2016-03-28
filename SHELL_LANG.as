package 
{
	import fl.lang.Locale;
	import fl.text.TLFTextField;
	
	import flash.display.Sprite;
	import flash.globalization.*;
	import flash.globalization.LocaleID;
	import flash.text.Font;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	import flashx.textLayout.elements.*;
	import flashx.textLayout.formats.*;
	
	public class SHELL_LANG
	{
		//------------------
		// SETUP LOCALE OBJECT:
		
		private var _languages:Object = new Object();	// Stores flags for loaded languages
		private var _localeDefault:String = "en";		// Default language
		private var _locale:String;// = "en";				// Current language selected in combobox
		private var _locales:Array;// = "en";	
		
		
		private var _langInterval:Number;
		
		
		public function SHELL_LANG()
		{
			_locale = "en";
			Locale.addXMLPath("en", "en/SHELL_INT_UI_en.xml");
			Locale.addXMLPath("fr", "fr/SHELL_INT_UI_fr.xml");
			Locale.addXMLPath("ar", "ar/SHELL_INT_UI_ar.xml");
			//Locale.setLoadCallback(Delegate.create(this, languageLoaded));
			Locale.setLoadCallback(_localeLoadedHandler);
			Locale.loadLanguageXML("ar");
		
			// Get list of Locales from Strings panel
			//_locales = Locale.languageCodeArray.sort();	
		//	trace("locales length = "+ _locales.length);
			
			//Locale.setLoadCallback(localeCallback);
			//Locale.loadLanguageXML("en");
			// create interval to check if language XML file is loaded
			_langInterval = setInterval(_checkLocaleStatus, 10);
			
			
		}
		private function _checkLocaleStatus():void {
			if (Locale.checkXMLStatus()) {
				clearInterval(_langInterval);
				trace("clearing interval @ " + getTimer() + " ms");
			}
		}
		
		public function setNewLang(langCode:String):void
		{
			_locale = langCode;
			var len:uint = _locales.length;							
			var dp:Array = new Array();	
			trace("len= " + _locales.length);
			// Format combobox labels
			for(var n:uint=0; n<len; n++)
			{
				var lang:String = _locales[n];
				var newlang:String = "en";
				
				if (lang == _locale) {
					trace("lan= " + lang);
					newlang = _locale;
					break;
				}
				
				
			}
			_locale = newlang;
			Locale.loadLanguageXML(newlang);
		}
		// Event handler for Locale object
		private function _localeLoadedHandler(success:Boolean):void 
		{
			if( success )
			{
				// Mark language as loaded and show localized string
				_languages[_locale] = true;
				trace("Locale= "+  Locale.loadString("IDS_CURRENT_LANG"));
				//LocaleIDExample();
			}
		}  
	
		public static function  loadLocaleString(strConstant:String):String
		{
			
			var outStr:String;
			outStr =   Locale.loadString(strConstant);
			
			trace("loadLocaleString=== " + loadLocaleString);
			return outStr;
			
			
		}
		public function LocaleIDExample():void
			{
				var localeNames:Array = ["ar-SA", "EN_us", "en-US-POSIX", "zh-CH", "zh-TW", "zh-Hans", "zh-CH@collation=pinyin;calendar=chinese;currency=RMB"];
				
				for ( var i:int = 0; i < localeNames.length; i++ ) 
				{
					var locID:LocaleID = new LocaleID( localeNames[i] as String );
					/*
					trace( "Last Operation Status after new LocaleID: " + locID.lastOperationStatus);
					
					trace("name:     " + locID.name);
					trace("language: " + locID.getLanguage() + "; status: "  + locID.lastOperationStatus);
					trace("script:   " + locID.getScript()  +  "; status: "  + locID.lastOperationStatus);
					trace("region:   " + locID.getRegion()  +  "; status: "  + locID.lastOperationStatus);
					trace("variant:  " + locID.getVariant()  + "; status: "  + locID.lastOperationStatus);
					trace("isRightToLeft: ", locID.isRightToLeft(), "; status: "  + locID.lastOperationStatus);
					
					var keysAndValues:Object = locID.getKeysAndValues();
					var key:String;
					for (key in keysAndValues)
					{
						trace("key: ", key + " value: " + keysAndValues[ key ]);
					}
					trace( "Last Operation Status after getKeysAndValues(): " + locID.lastOperationStatus);
					*/
				}
			}	
	}
}


