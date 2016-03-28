package com.sanbeaman.shell.widget.activity
{
	import com.greensock.TimelineMax;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.data.UIparams;
	import com.sanbeaman.shell.ui.BitmapSprite;
	
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
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
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import fl.text.TLFTextField;
	
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.StringTextLineFactory;
	import flashx.textLayout.formats.Direction;
	import flashx.textLayout.formats.TextLayoutFormat;
	import flashx.textLayout.formats.VerticalAlign;
	
	
	public class ACTUI_DragBtnBox extends Sprite
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
		
		
		
		private var _tfield:TextField;
		private var _tformat:TextLayoutFormat;
		
		
		private var _tfieldWidth:Number = 110;
		private var _tfieldBack:Sprite;
		private var _btnWidth:Number;
		private var _btnHeight:Number; //use height for circle radius
		
		
		
		private var _tracked:Boolean;
		private var _enabled:Boolean;
		
		private var _isanswer:String;
		
		private var _tlf:TLFTextField = new TLFTextField();
		
		private var _uiParams:UIparams;
		
		
		private var _originX:Number;
		private var _originY:Number;
		private var _activeFrame:Sprite;
		
		private var _activeFrameSize:Number;
		
		private var  _colorsObject:Object;
		private var _color1grad:uint;// = colors[0];// = 0x04618d;
		private var _color2grad:uint;// = colors[1];// = 0x379EE0;
		private var _tl:TimelineMax;
		private var _localeID:String;
		private var _txtDirection:String;
		private var _txtFieldASize:String;
		
		private var _fontFamily:String;
		public function ACTUI_DragBtnBox()
		{
			super();
			this.mouseChildren = false;
		}
		
		public function init(blabel:String,bwidth:Number,bheight:Number,bfilltype:String, bcolor:uint,uiParams:UIparams = null, fontfamily:String = "Arial", localeID:String = null):void
		{
			_btnLabel = blabel;
			_tfieldWidth = _btnWidth = bwidth;
			_btnHeight = bheight;
			_backColorCode = bcolor;
			
			_uiParams = uiParams;
			
			
			_localeID = (localeID != null)?localeID:"en";
			_txtDirection = (_localeID == 'ar')?Direction.RTL:Direction.LTR;
			_txtFieldASize = (_localeID == 'ar')?TextFieldAutoSize.RIGHT:TextFieldAutoSize.LEFT;
			
			_fontFamily = fontfamily;
			_btnBack = new Sprite();
			
			
			_btnFillType = bfilltype;
			_btnFace = new Sprite();
			_btnBack = new Sprite();
			
			//this.addChild(_btnBack);
			switch (_btnFillType){
				case 'bitmap':
					var fullpath:String = SHELL_VARS.FOLDER_SHELL_IMGS + 'dragRate_dragItem.png';
					var loader:ImageLoader = new ImageLoader(fullpath, {container:_btnBack,width:_btnWidth,height:_btnHeight});
					loader.load();
					break;
				case 'gradient':
					_backColorCode = 0XFFFFFF;
					_btnBack.graphics.beginFill(_backColorCode,1);
					_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
					_btnBack.graphics.endFill();
					
					var colors:Array = _uiParams.uiFillColorArray;
					_color1grad = colors[0];// = 0x04618d;
					_color2grad = colors[1];// = 0x379EE0;
					//define two colors that gradient will consist of
					_colorsObject = {left:_color1grad, right:_color2grad};
					//set an object sprite and add it to stage
					_btnFace.graphics.lineStyle(_uiParams.uiFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
					_drawGradient();
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
			//_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			//	_btnBack.graphics.endFill();
			_activeFrameSize = _uiParams.uiFrameSize +2;
			_activeFrame = new Sprite();
			_activeFrame.graphics.lineStyle(_activeFrameSize,_uiParams.uiFrameColorCode,1,true,LineScaleMode.NONE, CapsStyle.SQUARE, JointStyle.MITER );
			_activeFrame.graphics.beginFill(0xffffff,0);
			_activeFrame.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			_activeFrame.graphics.endFill();
			_activeFrame.mouseEnabled = false;
			_activeFrame.visible = false;
			//_btnFace.filters = myFilters;
			this.addChild(_btnBack);
			this.addChild(_btnFace);
			this.addChild(shadowFrameShadow);
			this.addChild(shadowFrame);
			this.addChild(_activeFrame);
		//_btnBack.graphics.drawRect(0,0,_btnWidth,_btnHeight);
			
			//_btnBack.graphics.endFill();
			
			
			if (_uiParams == null) {
				_uiParams = new UIparams();
				_uiParams.uiFontColor = "white";
				_uiParams.uiFontHAlign = "center";
				_uiParams.uiFontVAlign = "middle";
				_uiParams.uiFontSize = 16;
				_uiParams.uiFontStyle = "bold";
				
				
			}
			///////////////////////////////////////
		
			
			//_padding = padding;
			
			_tlf = new TLFTextField();
			_tlf.embedFonts = true;
			_tlf.antiAliasType =  AntiAliasType.ADVANCED;
			
			_tlf.height = _btnHeight;
			_tlf.width = _tfieldWidth;//600;// 755;
			_tlf.wordWrap = true;
		//	_tlf.border = true;
		
			//_tlf.autoSize = TextFieldAutoSize.LEFT;
			
			
			_tlf.verticalAlign = VerticalAlign.MIDDLE;
			_tlf.selectable = false;
			
			
			_tlf.htmlText = _btnLabel;
			
			
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
			format.lineHeight = "100%";
			
			if (_uiParams.uiFontHAlign == "center"){
				format.textAlign = _uiParams.uiFontHAlignCONST;
			}
		
			format.fontFamily = _fontFamily;// SHELL_VARS.SHELL_FONT_FAMILY;// "Arial";
			
			
			var myTextFlow:TextFlow = _tlf.textFlow;
			myTextFlow.invalidateAllFormats();
			
			myTextFlow.hostFormat = format;
			myTextFlow.paddingTop = 2;//20;
			myTextFlow.paddingLeft = 4;//20;
			myTextFlow.paddingRight = 4;//20;
			myTextFlow.direction = _txtDirection;
			//myTextFlow.paddingTop = _padding;//10;
		//	myTextFlow.paddingBottom =_padding;// 10;
			//	myTextFlow.direction = Direction.RTL;
			
			myTextFlow.flowComposer.updateAllControllers();
			
			_tlf.mouseEnabled = false;
			_tlf.mouseChildren = false;
			
			this.addChild(_tlf);
			
		//	_btnBack.addChild(_tlf);
			//	this.addChild(_itemContentBox);
			
		//	this.addChild(_btnBack);
			
			//set it to act like a button
			this.buttonMode = true;//making a hand cursor over images
			this.useHandCursor = true;
			this.mouseChildren = false;
			_tracked = false;
			
			
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

		public function get originX():Number
		{
			return _originX;
		}

		public function set originX(value:Number):void
		{
			_originX = value;
		}

		public function get originY():Number
		{
			return _originY;
		}

		public function set originY(value:Number):void
		{
			_originY = value;
		}
		public function get isanswer():String
		{
			return _isanswer;
		}
		
		public function set isAnswer(value:String):void
		{
			_isanswer = value;
		}

		private function _setBtnState(bstate:String):void
		{
			switch (bstate){
				case 'checked':
					_activeFrame.visible = true;
					//	_tl.pause();
					_btnFace.alpha = .8;
					//	this.alpha = 1;
					
					break;
				case 'active':
					_activeFrame.visible = true;
					_btnFace.alpha = 1;
					//	_tl.play();
					break;
				case 'ready':
					_activeFrame.visible = false;
					_btnFace.alpha = 1;
					//	_tl.pause();
					//TweenMax.to(_colorsObject, 0.75, {hexColors:{left:_color2grad, right:_color1grad},easing:Linear.easeNone, onUpdate:_drawGradient});
					//	_tl.seek(0);
					//this.alpha = .6;
					break;
				default:
					
			}
		}
		
	}
}