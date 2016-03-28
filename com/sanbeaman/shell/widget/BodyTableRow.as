package com.sanbeaman.shell.widget
{
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextAlign;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	public class BodyTableRow extends BodyUI
	{
		
		
		private  var _tHeight:Number;
		private  var _tWidth:Number;
		private var myTLFTextField:TLFTextField;
		
		private var _fontSize:Number;
	//	private var _tWidth:Number;
		
		private var _rowWidth:Number;
		private var _rowHeight:Number;
		
		private var _rowContent:XML;
		private var _rowType:String
		private var _rowAlign:String
		private var _cellBack:Sprite;
		private var _rowBack:Sprite;
		
		private var _fontFamily:String;
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		public function BodyTableRow()
		{
			super();
	
		}

		

		public function init(id:String, order:int, time:Number, rowwidth:Number, rowContent:XML, rowtype:String = "norm", rowalign:String="left",fontsize:Number = 16, fontfamily:String = "Arial", langID:String = null):void
		{
			this.id = id;
			this.order = order;
			this.time = time;
			this.type = "bodytablerow";
			_rowType = rowtype;
			_rowWidth = rowwidth;
			_rowAlign = rowalign;
			_fontSize = fontsize;
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			var colsXML:XMLList = rowContent.*;
			var cellArray:Array = new Array();
			for each (var child:XML in rowContent.*) 
			{ 
				cellArray.push(child);
			}
			var numCols:Number = cellArray.length;
			trace("cellArray Length = " + cellArray.length);
			
			var xHolder:Number = 0;
			var cellHeight:Number = 0;
			var cellWidth:Number = _rowWidth / numCols;
			
			_rowBack = new Sprite();
			
			for (var i:int = 0; i < cellArray.length ; i++) {
				var txt:String = cellArray[i];
				var colBlock:Sprite = _addCell(txt,cellWidth);
				colBlock.x = xHolder;
				colBlock.y = 0;
				
				_rowBack.addChild(colBlock);
				trace("colBack Height= " + colBlock.height);
				
				if (colBlock.height > cellHeight) {
					cellHeight = colBlock.height;
				}
				xHolder = colBlock.x + cellWidth;
			}
			
			_rowHeight = int(cellHeight) + 4;
			trace("rowheight = " + _rowHeight);
			_rowBack.graphics.lineStyle(3,0x000000,1,true,LineScaleMode.NONE,CapsStyle.SQUARE);

			//_rowBack.graphics.lineStyle(2,0x000000,1,true,);
			var centerLineX:Number = cellWidth + 1;
			_rowBack.graphics.moveTo(centerLineX,0);
			_rowBack.graphics.lineTo(centerLineX,_rowHeight);
			
			_rowBack.graphics.moveTo(0,_rowHeight);
			_rowBack.graphics.lineTo(_rowWidth,_rowHeight);
			
			this.addChild(_rowBack);
		}
		private function _addCell(str:String, twidth:Number):Sprite
		{
			var col:Sprite = new Sprite();
			var tlf:TLFTextField = new TLFTextField();
			tlf.embedFonts = true;
			tlf.antiAliasType =  AntiAliasType.ADVANCED;
		//	tlf.border = true;
			tlf.width = twidth;
			tlf.wordWrap = true;
			tlf.selectable = false;
			tlf.autoSize = _txtFieldASize;
			
			tlf.htmlText = str;
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			
			format.fontSize = _fontSize;
			format.color = 0x666666;
		/*	format.paddingLeft = 20;
			format.paddingRight = 4;
			format.paddingTop = 4;
			format.paddingBottom = 4;
			*/
			format.fontFamily =_fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			
			
			if (_rowType == 'head') {
				format.fontWeight = FontWeight.BOLD;
			}
			if (_rowAlign == "center"){
				format.textAlign = TextAlign.CENTER;
			}
			
		//	format.listAutoPadding = 50;
		//	format.listStylePosition =  ListStylePosition.OUTSIDE;
		//	format.listStyleType = ListStyleType.DISC;
			
			
			var myTextFlow:TextFlow = tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			myTextFlow.paddingLeft = 16;
			myTextFlow.paddingRight = 8;
			myTextFlow.paddingTop = 4;
			myTextFlow.paddingBottom = 8;
			myTextFlow.direction = _txtDirection;
			myTextFlow.hostFormat = format;
			myTextFlow.flowComposer.updateAllControllers();
			col.addChild(tlf);
			
			return col;
			
		}
		
		public function get rowType():String
		{
			return _rowType;
		}
		
		
		public function get rowHeight():Number
		{
			
			return _rowHeight;
		}
		
		
	}
}