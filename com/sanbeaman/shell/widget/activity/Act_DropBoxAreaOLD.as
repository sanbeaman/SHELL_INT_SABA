package com.sanbeaman.shell.widget.activity
{
	
	import com.greensock.TimelineMax;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.data.UIparams;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class Act_DropBoxAreaOLD extends Sprite
	{
		private var _backFull:Sprite;
		
		private var _btnBack:Sprite;
		private var _btnFace:Sprite;
		private var _btnBackActive:Sprite;
		private var _btnEmblem:Sprite;
		
		private var _id:String;
		private var _zindex:int;
		
		private var _btnLabel:String;
		private var _btnType:String;
		private var _btnFillType:String;
		
		private var _backColorCode:uint;
	
		private var _itemAreaWidth:Number;
		private var _itemAreaHeight:Number; 
		
		private var _itemContentBox:Sprite;
		private var _itemContentBoxColor:uint;
		private var _itemContentWidth:Number;
		private var _itemContentHeight:Number;
		
		private var _itemContentText:String;
		
		
		private var _itemLayout:String;
	
		
		private var _isAnswer:String;
		
		
		
		
		private var _tfield:TextField;
		private var _tformat:TextLayoutFormat;
		
		
		private var _tfieldWidth:Number;
		private var _tfieldHeight:Number;
		
		private var _btnWidth:Number;
		private var _btnHeight:Number; 
		private var  _btnColor:uint;
		
		
		private var _tracked:Boolean;
		private var _enabled:Boolean;
		
		
		private var _paddingX:Number;// = 18;
		
		private var _uiParams:UIparams;
		

		private  var _tlf:TLFTextField;
		
		
		private var _btnLocationX:Number;
		
		private var _btnFillColorType:String;
		

		private var  _colorsObject:Object;
		private var _color1grad:uint;// = colors[0];// = 0x04618d;
		private var _color2grad:uint;// = colors[1];// = 0x379EE0;
		private var _tl:TimelineMax;
		
		
		public function Act_DropBoxAreaOLD()
		{
			super();
		}
	
		public function init(bwidth:Number, bheight:Number, bcolorcode:uint, iwidth:Number,iheight:Number,icontent:String,icolor:uint,paddingX:Number = 18,ilayout:String = "default",uiParams:UIparams = null,bfilltype:String="fill"):void
		{
			_itemContentBox = new Sprite();
			
			_itemContentBoxColor = icolor;
			_itemContentText = icontent;
			_itemAreaWidth = iwidth;
			_itemAreaHeight = iheight;
			_btnWidth = bwidth;
			_btnHeight = bheight;
			_backColorCode = bcolorcode;
			_itemLayout = ilayout;
			
			_uiParams = uiParams;
			
			//trace("ITEM_DropBox -> b=" + bwidth + "-" + bheight + "___ i="+iwidth + "-" + iheight + "paddingX= "+paddingX );
			
			_btnBack = new Sprite();
			
			
			_btnFillType = bfilltype;
			_btnFace = new Sprite();
			switch (_btnFillType){
				case 'bitmap':
					var fullpath:String = SHELL_VARS.FOLDER_SHELL_IMGS + 'dragRate_dropItem.png';
					var loader:ImageLoader = new ImageLoader(fullpath, {container:_btnBack,width:_btnWidth,height:_btnHeight});
					loader.load();
					break;
				case 'gradient':
					
					//_btnBack.graphics.beginFill(0xffffff,.3);
					//_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
				//	_btnBack.graphics.endFill();
					
					var colors:Array = _uiParams.uiFillColorArray;
					_color1grad = colors[0];// = 0x04618d;
					_color2grad = colors[1];// = 0x379EE0;
					//define two colors that gradient will consist of
					
					trace('colors'+colors);
					
				
					_colorsObject = {left:0xcc6633, right:0xff9933};
					//_colorsObject = {left:_color1grad, right:_color2grad};
					//set an object sprite and add it to stage
					_btnBack.graphics.lineStyle(_uiParams.uiFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
					var m:Matrix = new Matrix();
					m.createGradientBox(_btnWidth, int(_btnHeight*.5), 1);
					//drawing a gradient box, set last value to 1 if you want vertical gradient or to 0 if you want horizontal gradient
					//m.createGradientBox(buttonWidth, buttonHeight, 1);
					_btnBack.graphics.beginGradientFill(GradientType.LINEAR, [_colorsObject.left, _colorsObject.right], [1, 1], [0x00, 0xFF], m, SpreadMethod.PAD);
					_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnBack.graphics.endFill();
					
					
					//_drawGradient();
					break;
				default:
					_btnBack.graphics.beginFill(_backColorCode,1);
					_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnBack.graphics.endFill();
					_btnFace.graphics.lineStyle(_uiParams.uiFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
					_btnFace.graphics.beginFill(_backColorCode,1);	
					_btnFace.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnFace.graphics.endFill();
			}
			var filter:BitmapFilter = getBitmapFilter();
			var myFilters:Array = new Array();
			myFilters.push(filter);
			var shadowFrameShadow:Sprite = new Sprite();
			shadowFrameShadow.graphics.lineStyle(1,0xffffff,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
			shadowFrameShadow.graphics.beginFill(0xffffff,1);
			shadowFrameShadow.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			shadowFrameShadow.graphics.endFill();
			shadowFrameShadow.filters = myFilters;
			shadowFrameShadow.mouseEnabled = false;
			var shadowFrame:Sprite = new Sprite();
			shadowFrame.graphics.lineStyle(1,0xffffff,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
			shadowFrame.graphics.beginFill(0xffffff,0);
			shadowFrame.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			shadowFrame.graphics.endFill();
			shadowFrame.mouseEnabled = false;
			_btnFace.filters = myFilters;
		
			/*
			this.addChild(_btnBack);
			this.addChild(_btnFace);
			this.addChild(shadowFrameShadow);
			this.addChild(shadowFrame);
			*/
			//this.addChild(_activeFrame);
			
			_itemContentHeight = _itemAreaHeight;
			_paddingX = paddingX;
		
			_itemContentWidth = _itemAreaWidth  -  (_btnWidth + _paddingX);
			
			
			_itemContentBox = new Sprite();
			_itemContentBox.graphics.lineStyle(_uiParams.uiFrameSize,_uiParams.uiFontColorCode,1,true);;//,LineScaleMode.NORMAL, CapsStyle.ROUND,JointStyle.ROUND );
			_itemContentBox.graphics.beginFill(_itemContentBoxColor,1);
			_itemContentBox.graphics.drawRect(0,0,_itemContentWidth,_itemContentHeight);
			_itemContentBox.graphics.endFill();
			
			_tfieldWidth = _itemContentWidth;
			_tfieldHeight = _itemAreaHeight;
			trace('_tfieldWidth==='+_tfieldWidth);
			
			
			if (_uiParams == null) {
				_uiParams = new UIparams();
				_uiParams.uiFontColor = "dkgrey";
				_uiParams.uiFontHAlign = "left";
				_uiParams.uiFontVAlign = "top";
				_uiParams.uiFontSize = 14;
				_uiParams.uiFontStyle = "reg";
				
			}
			///////////////////////////
			
			_tlf = new TLFTextField();
			_tlf.embedFonts = true;
			_tlf.antiAliasType =  AntiAliasType.ADVANCED;
			
			_tlf.height = bheight;
			_tlf.width = _tfieldWidth;//600;// 755;
			_tlf.wordWrap = true;
		//	_tlf.border = true;
			//_tlf.autoSize = TextFieldAutoSize.LEFT;
			
			
			_tlf.verticalAlign = VerticalAlign.MIDDLE;
			_tlf.selectable = false;
			
			
			_tlf.htmlText = _itemContentText;
			
			
			var format:TextLayoutFormat = new TextLayoutFormat();
			format.fontLookup = FontLookup.EMBEDDED_CFF;
			format.renderingMode = RenderingMode.CFF;
			format.cffHinting = CFFHinting.NONE;
			
			
			
			if (_uiParams.uiFontStyle == "bold"){
				format.fontWeight = FontWeight.BOLD;
			} else {
				format.fontWeight = FontWeight.NORMAL;
			}
			format.fontSize = _uiParams.uiFontSize;
			format.color = _uiParams.uiFontColorCode;
			
			
			format.textAlign = _uiParams.uiFontHAlignCONST;
			format.fontFamily = SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			
			
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			
			myTextFlow.hostFormat = format;
			//myTextFlow.paddingLeft = 10;//20;
		//	myTextFlow.paddingRight = 10;//20;
			//myTextFlow.paddingTop = _padding;//10;
			//	myTextFlow.paddingBottom =_padding;// 10;
			//	myTextFlow.direction = Direction.RTL;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			_itemContentBox.addChild(_tlf);
			
			
			if (_itemLayout == "labelfirst"){
				_itemContentBox.x= 0;
				_itemContentBox.y = 0;
				
				_btnBack.x = _itemContentBox.width + _paddingX;
				_btnBack.y = 0;
			} else {
				_itemContentBox.x =  _btnBack.width + _paddingX;
				_itemContentBox.y = 0;
				_btnBack.x = 0;
				_btnBack.y = 0;
			}
			
			_btnLocationX = _btnBack.x;
			
			_btnFace.x = _btnLocationX;
			
			shadowFrameShadow.x =_btnLocationX;
			shadowFrame.x = _btnLocationX;
			
			this.addChild(_btnBack);
			this.addChild(_btnFace);
			this.addChild(shadowFrameShadow);
			this.addChild(shadowFrame);
		
			
			this.addChild(_itemContentBox);
			_btnFace.alpha = 1;
			
			_tracked = false;
			
			this.mouseEnabled = false;
			
			
		}
		//function that will draw a gradient
		private function _drawGradient():void {
			var m:Matrix = new Matrix();
			m.createGradientBox(_btnWidth, int(_btnHeight*.5), 1);
			//drawing a gradient box, set last value to 1 if you want vertical gradient or to 0 if you want horizontal gradient
			//m.createGradientBox(buttonWidth, buttonHeight, 1);
			_btnFace.graphics.beginGradientFill(GradientType.LINEAR, [_colorsObject.left, _colorsObject.right], [1, 1], [0x00, 0xFF], m, SpreadMethod.PAD);
			_btnFace.graphics.drawRect(0,0,_btnWidth,_btnHeight);
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var angle:Number = 45;
			var alpha:Number = 0.6;
			var blurX:Number = 4;
			var blurY:Number = 4;
			var distance:Number = 2;
			var strength:Number = 1;
			var inner:Boolean = true;
			var knockout:Boolean = true;
			var hideobj:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			return new DropShadowFilter(distance,
				angle,
				color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout, hideobj);
		}
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
			
		}
		
		public function get isAnswer():String
		{
			return _isAnswer;
		}
		
		public function set isAnswer(value:String):void
		{
			_isAnswer = value;
		}

		public function get btnLocationX():Number
		{
			return _btnLocationX;
		}
		
		
	}
}
