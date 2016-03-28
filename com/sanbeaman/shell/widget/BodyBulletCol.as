package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.conversion.ITextImporter;
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.DivElement;
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.ListElement;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.elements.SpanElement;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.ListMarkerFormat;
	import flashx.textLayout.formats.ListStylePosition;
	import flashx.textLayout.formats.ListStyleType;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class BodyBulletCol extends BodyUI
	{
		private  var _tHeight:Number;
		private var _tlf:TLFTextField;
		
		private var _tWidth:Number;
		
		
		private var _fontColorCode:uint;
		private var _fontSize:Number;
		
		
		private var _textStyle:String;
		
		private var _textBorder:Boolean;// = false;
		
		private var _format:TextLayoutFormat;
		
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		private var _tflowStart:String ="<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'>";
		private var _tflowEnd:String ="</TextFlow>";
		
		//private var _tflowStart:String ="<TextFlow xmlns='http://ns.adobe.com/textLayout/2008'><list>";
		//private var _tflowEnd:String ="</list></TextFlow>";
		public function BodyBulletCol()
		{
			
		super();
	}
	
	public function init(item:String, textWidth:Number = 154,fontsize:Number = 12,fontcolor:String = "black", textstyle:String="bullets", textborder:Boolean = false, fontfamily:String = "Arial", langID:String = null):void
	{
		this.type = "bodybulletcol";
		_tWidth = textWidth;
		_textStyle = textstyle;
		_textBorder = textborder;
		_fontSize = fontsize;
		_fontColorCode = SHELL_COLORS.lookUpColor(fontcolor);
		
		_localeID = (langID != null)?langID:"en";		
		_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
		_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
		
		_fontFamily = fontfamily;
		
		var format:TextLayoutFormat = new TextLayoutFormat();
		format.fontLookup = FontLookup.EMBEDDED_CFF;
		format.renderingMode = RenderingMode.CFF;
		format.cffHinting = CFFHinting.NONE;
		format.listStyleType = ListStyleType.DISC;
		//format.listAutoPadding = 50;
		format.fontSize = _fontSize;//12;
		format.color = _fontColorCode;// SHELL_COLORS.lookUpColor("default");// 0x666666;
		format.lineHeight = "120%";
		format.paragraphSpaceAfter = 8;
		//format.listStylePosition =  ListStylePosition.OUTSIDE;
		//format.listStyleType = ListStyleType.DISC;
		//format.listAutoPadding = "12";
		format.fontFamily = _fontFamily;//SHELL_VARS.SHELL_FONT_FAMILY;// "Arial"; //Font.enumerateFonts(false)[0].fontName;
		
		//format.textAlign = TextAlign.LEFT; 
	
		_tlf  = new TLFTextField();
		//_tlf.defaultTextFormat = forma;
		_tlf.border = _textBorder;
		_tlf.wordWrap = true;
		_tlf.width = _tWidth;
		_tlf.autoSize = _txtFieldASize;// TextFieldAutoSize.LEFT;
		
		if (_textStyle == 'textflow'){
			var wrapintflow:String = _tflowStart + item + _tflowEnd;
			_tlf.tlfMarkup = wrapintflow;
		//	_tlf.condenseWhite = true;
		} else {
			_tlf.htmlText = item;
		}
		
		
		
		var myTextFlow:TextFlow = _tlf.textFlow;
		//myTextFlow.invalidateAllFormats();
		myTextFlow.direction = _txtDirection;
	myTextFlow.listAutoPadding = 12;
		myTextFlow.hostFormat = format;
		myTextFlow.flowComposer.updateAllControllers();
		addChild(_tlf);
	}
	
	private function _addText(str:String, twidth):void
	{
		
		_tlf  = new TLFTextField();
		_tlf.embedFonts = true;
		_tlf.antiAliasType =  AntiAliasType.ADVANCED;
		_tlf.border = _textBorder;
		//addChild(myTLFTextField); 
		_tlf.width = twidth;// 755;
		trace("bodybulletcol textwidth=" + twidth);
		_tlf.autoSize = TextFieldAutoSize.LEFT;
		_tlf.wordWrap = true;
		
			
	//	_tlf.autoSize = TextFieldAutoSize.LEFT;
		//_tlf.height =theight;// 50;
	//	_tlf.verticalAlign = VerticalAlign.MIDDLE;
		
		_tlf.selectable = false;
		
	//	_tlf.background = tbacktrue;
	//	_tlf.backgroundColor = _backColorCode;//0x15A5C9;
		_tlf.htmlText = str;
		

		
		
		var format:TextLayoutFormat = new TextLayoutFormat();
		format.fontLookup = FontLookup.EMBEDDED_CFF;
		format.renderingMode = RenderingMode.CFF;
		format.cffHinting = CFFHinting.NONE;
		
		format.fontSize = _fontSize;//12;
		format.color = _fontColorCode;// SHELL_COLORS.lookUpColor("default");// 0x666666;
		
		//format.listStylePosition =  ListStylePosition.OUTSIDE;
		//format.listStyleType = ListStyleType.DISC;
		//format.listAutoPadding = 0;
		format.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;// "Arial"; //Font.enumerateFonts(false)[0].fontName;
		
		format.textAlign = TextAlign.LEFT; 
		
		var myTextFlow:TextFlow = _tlf.textFlow;
		myTextFlow.invalidateAllFormats();
		
		
		if (_textStyle == "mixed"){
			
			myTextFlow.paddingLeft = -16;
			//myTextFlow.paragraphSpaceBefore = 16;
			myTextFlow.paragraphStartIndent = 16;
		} else if (_textStyle == "bullet"){
			myTextFlow.paddingLeft = 0;
			myTextFlow.paragraphStartIndent = 0;
			myTextFlow.listStylePosition = ListStylePosition.OUTSIDE;
			myTextFlow.listAutoPadding = 0;
			
		} else if (_textStyle == "none"){
			myTextFlow.paddingLeft = 0;
			//myTextFlow.paragraphSpaceBefore = 16;
			//myTextFlow.paragraphStartIndent = 16;
		} else {
			myTextFlow.paddingLeft = -16;
		}
		
		//myTextFlow.listAutoPadding = 0;
		myTextFlow.hostFormat = format;
		myTextFlow.flowComposer.updateAllControllers();
		this.addChild(_tlf);
		
		_tHeight =int( _tlf.textHeight);
	}
	
	public function get tHeight():Number
	{
		var th:Number = int(_tlf.textHeight);
		return _tHeight;
	}
	
	
}
}