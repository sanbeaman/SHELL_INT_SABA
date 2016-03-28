package com.sanbeaman.shell.ui
{
	
	import com.greensock.loading.LoaderMax;
	import com.sanbeaman.shell.widget.StaticImage;
	
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class MainShellHeader extends Sprite
	{
		/*
		[Embed (source="/masterShell/logos/CALogoINT_EN.png")]
		private var _logoCA:Class
		public var logoCA:Bitmap = new _logoCA;
		*/
		private var _blockBack:Sprite;
		private var _blockWidth:Number = SHELL_VARS.HEADER_WIDTH;
		private var _blockHeight:Number = SHELL_VARS.HEADER_HEIGHT;
		
		private var _blockFillColorCode:uint;// = SHELL_COLORS.CLR_HEADER;
		private var _blockAlpha:Number;// = 1;
		
		private var _txt:String;
		
		private var _tlf_txt:TLFTextField;
		private var _tlf_tformat:TextLayoutFormat;
		private var _tlf_flow:TextFlow;
		
		private var _logoCA:Bitmap;
		
		/*
		[Embed(source='/masterShell/fonts/CAFont_CourseTitle.swf', symbol="CAFont_CourseTitle")]
		public var cafont_coursetitle:Class;
		public var cafont_ctitle:Font = new cafont_coursetitle();
		*/
		
		public static const COURSE_HEADER_FONT_NAME:String = "Myriad Pro";
		
		public function MainShellHeader(title:String,blockfillcolor:String = "black", blockAlpha:Number = 1)
		{
			super();
			
			_txt = title;
			_blockFillColorCode = SHELL_COLORS.lookUpColor(blockfillcolor);
			_blockAlpha = blockAlpha;
			_blockBack = new Sprite();
			_blockBack.graphics.beginFill(_blockFillColorCode,_blockAlpha);
			_blockBack.graphics.drawRect(0,0,_blockWidth,_blockHeight);
			_blockBack.graphics.endFill();
			
			this.addChild(_blockBack);
			
			_logoCA = LoaderMax.getLoader("calogo").rawContent;
			_logoCA.x = 555;
			_logoCA.y = 0;
			
			this.addChild(_logoCA);
			
			_tlf_txt  = new TLFTextField();
			_tlf_txt.embedFonts = true;
			_tlf_txt.antiAliasType =  AntiAliasType.ADVANCED;
			
			
			_tlf_txt.width = 550;// 755;
			_tlf_txt.height = 30;//SHELL_VARS.HEADER_HEIGHT;// 50;
		//	_tlf_txt.verticalAlign = VerticalAlign.MIDDLE;
			_tlf_txt.multiline = false;
			_tlf_txt.wordWrap = false;
			_tlf_txt.selectable = false;
			//_tlf_txt.border = true;
			_tlf_txt.borderColor = 0xffffff;
			
			
			_tlf_txt.htmlText = _txt.toUpperCase();
			// TEXTLAYOUT FORMAT
			_tlf_tformat = new TextLayoutFormat();
			
			_tlf_tformat.fontLookup = FontLookup.EMBEDDED_CFF;
			_tlf_tformat.renderingMode = RenderingMode.CFF;
			_tlf_tformat.cffHinting = CFFHinting.NONE;
			
			_tlf_tformat.fontSize = 20;
			_tlf_tformat.color =  0xffffff;
			
			_tlf_tformat.textAlign = TextAlign.LEFT;
			//_tlf_tformat.verticalAlign = VerticalAlign.MIDDLE;
			_tlf_tformat.lineHeight = "100%";
			//_tlf_tformat.paddingLeft = 10;
			//_tlf_tformat.paddingTop = 8;
			_tlf_tformat.fontWeight = "bold";
			_tlf_tformat.fontFamily = COURSE_HEADER_FONT_NAME;//cafont_ctitle.fontName;  //Font.enumerateFonts(false)[0].fontName;//"Arial";
		
			
			/////// _tlf_flow ||||||| TEXTFLOW 
			_tlf_flow = _tlf_txt.textFlow;
			
			_tlf_flow.invalidateAllFormats();
			_tlf_flow.hostFormat = _tlf_tformat ;
			_tlf_flow.paddingTop = 5;
			_tlf_flow.flowComposer.updateAllControllers();
			_tlf_txt.x = 10;
		
		
			var mybounds:Rectangle = _tlf_txt.getBounds(_blockBack);
		//	trace('mybounds= ' + mybounds.toString());
			var newy:Number = ((_blockBack.height - mybounds.height)*.5);
			_tlf_txt.y = int(newy);
			_blockBack.addChild(_tlf_txt);
		}
		
		
	}
}