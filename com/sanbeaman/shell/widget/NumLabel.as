package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;

	public class NumLabel extends BodyUI
	{
		private var _tField:TLFTextField;
		
		public function NumLabel()
		{
			super();
		}
		
		
		public function init(str:String,fsize:Number = 8, fcolor:String = "black", fwidth:Number=10,fheight:Number = 10,falign:String = 'center',fvalign:String ='middle'):void
		{
			var HAlign:String;
			if (falign == 'right'){
				HAlign = TextFormatAlign.RIGHT;
			} else if (falign == 'center'){
				HAlign =  TextFormatAlign.CENTER;
			} else {
				HAlign = TextFormatAlign.LEFT;
			}
			var VAlign:String;
			if (fvalign == 'bottom'){
				VAlign= VerticalAlign.BOTTOM;
			} else if (fvalign == 'top'){
				VAlign = VerticalAlign.TOP;
			} else {
				VAlign = VerticalAlign.MIDDLE;
			}
			
		_tField = new TLFTextField();
		_tField.embedFonts = true;
		//_tField.autoSize =  TextFieldAutoSize.LEFT;
		_tField.antiAliasType =  AntiAliasType.ADVANCED;
		_tField.selectable = false;
		//_tField.border = true;
		_tField.direction = Direction.LTR;
		_tField.wordWrap = false;
	
		_tField.width =  fwidth;
		_tField.height = fheight;
		
		_tField.verticalAlign = VerticalAlign.BOTTOM;
		
		_tField.htmlText = str;//"أغنية لشعبولا عن مقتل معمر القذافي";
		
		var tlformat:TextLayoutFormat = new TextLayoutFormat();
		tlformat.fontLookup = FontLookup.EMBEDDED_CFF;
		tlformat.renderingMode = RenderingMode.CFF;
		tlformat.cffHinting = CFFHinting.NONE;
	//	tlformat.lineHeight = "100%";
		tlformat.textAlign = HAlign;
		//tlformat.verticalAlign = VerticalAlign.BOTTOM;
		
		tlformat.fontSize = fsize;
		
		tlformat.color = SHELL_COLORS.lookUpColor(fcolor);// 0x666666;
		
		tlformat.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;//"Arial"; //applyFont.fontName;
		
		var myTextFlow:TextFlow = _tField.textFlow;
		myTextFlow.invalidateAllFormats();
		myTextFlow.hostFormat = tlformat;
	//	myTextFlow.verticalAlign = VerticalAlign.BOTTOM;;
		myTextFlow.flowComposer.updateAllControllers();
		
		trace('_tField.height =  ' + _tField.height);
		this.addChild(_tField)
		_tField.mouseEnabled = false;
		_tField.mouseChildren = false;
		}
	}
}