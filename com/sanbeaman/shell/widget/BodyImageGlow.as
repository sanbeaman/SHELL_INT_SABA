package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineLite;
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.sanbeaman.shell.data.UIparams;
	
	import flash.display.Sprite;
	import flash.filters.BevelFilter;
	import flash.filters.BitmapFilterQuality;

	public class BodyImageGlow extends BodyUI
	{
		
		private var _back:Sprite;
		private var _imageHolder:Sprite;
		private var _msk:Sprite;
		private var _frame:Sprite;
		
		private var _labelBox:Sprite;
		private var _labeltxt:String;
		
		private var _imgLoader:ImageLoader;
		private var _imgpath:String;
		private var _shapeType:String;
		
		private var _glow_tl:TimelineMax;
		
		private var _glowON:Boolean;
		private var _glowColor:String;// = SHELL_COLORS.CLR_LTBLUE;
		private var _glowColorCode:uint;// = SHELL_COLORS.CLR_LTBLUE;
		private var _glowAlpha:Number = .8;
		private var _glowX:Number = 10;
		private var _glowY:Number = 10;
		private var _glowStrength:Number = 3;
		private var _glowQuality:uint = 3;
		
		private var _uip:UIparams;
		
		
		private var _cornerRadius:int = 8;
		
		
		private var _hasLabel:Boolean;
		
		
		private var _fontFamily:String;
		private var _localeID:String;
		
		public function BodyImageGlow()
		{
			super();
			this.contentReady = false;
		}
		
		public function init(ipath:String,uiparams:UIparams,labeltext:String = "x", fontfamily:String = "Arial", langID:String = null):void
		{
			_imgpath = ipath;
			_uip = new UIparams();
			_uip = uiparams;
			
			//this.id = id;
			//this.order = order;
			//this.time = time;
			this.type = "bodyimageglow";
			
			_back = _buildShape('back',_uip);
			_msk = _buildShape('mask',_uip);
			_frame = _buildShape('frame',_uip);
			_imageHolder = new Sprite();
			
			
			_glowColorCode = SHELL_COLORS.lookUpColor(_uip.uiPulseColor);
			trace('_glowColorCode= ' + _glowColorCode);
			_imgLoader = new ImageLoader(_imgpath, {container:_imageHolder, width:_uip.uiWidth,height:_uip.uiHeight,scaleMode:"proportionalOutside", centerRegistration:false, onComplete:_imgLoadComplete_handler});
			_imgLoader.load();
			
			
			_back.addChild(_imageHolder);
			
			_labeltxt = labeltext;
			_hasLabel = (_labeltxt =="x")?false:true;
			
			_fontFamily = fontfamily;
			_localeID = (langID != null)?langID:"en";
			if (_hasLabel){
			_labelBox = _addLabelBox(_labeltxt,_uip);
			
			_labelBox.y = _uip.uiHeight - 32;
			_back.addChild(_labelBox);
			}
			_back.addChild(_msk);
			_back.mask = _msk;
			this.addChild(_back);
			this.addChild(_frame);
			
			 
			
		}
		private function _buildShape(shapeType:String, uip:UIparams):Sprite
		{
			_shapeType = shapeType;
			
			var sp:Sprite = new Sprite();
			sp.graphics.lineStyle(uip.uiFrameSize,uip.uiFrameColorCode,uip.uiFillAlpha);
			var fillAlpha:Number;
			
			if (_shapeType == 'frame') {
				fillAlpha = 0;
			} else {
				fillAlpha = uip.uiFillAlpha;
			}
			sp.graphics.beginFill(uip.uiFillColorCode,fillAlpha);
			
			
			var uiFrameShape:String = uip.uiFrameShape;
			var frameShape:String = uiFrameShape.toLowerCase();
			
			if (frameShape == 'roundrect'){
				sp.graphics.drawRoundRect(0,0,uip.uiWidth,uip.uiHeight,_cornerRadius,_cornerRadius);
			} else if (frameShape == 'ellipse'){
	
				sp.graphics.drawEllipse(0,0,uip.uiWidth,uip.uiHeight);
			} else if (frameShape == 'rect'){
				sp.graphics.drawRect(0,0,uip.uiWidth,uip.uiHeight);
			} else {
				trace('what shape' + frameShape);
			}
			
			return sp;
			
		}
		
		private function _addLabelBox(str:String,uip:UIparams):Sprite
		{
			
			var fillclr:String = uip.uiFillColor;
			var fontclr:String = uip.uiFontColor;
			trace('fillclr> '+ fillclr + ' <> fontclr> '+ fontclr + '[');
			var fillclrcode:uint = uip.uiFillColorCode;
			var fontclrcode:uint = uip.uiFontColorCode;
			var spr:Sprite = new Sprite();
			spr.graphics.beginFill(fillclrcode,1);
			spr.graphics.drawRoundRect(0,0,uip.uiWidth,36,_cornerRadius,_cornerRadius);
			spr.graphics.endFill();
			
			var bev:Sprite = new Sprite();
			bev.graphics.beginFill(fillclrcode,1);
			var bevW:Number = spr.width - 4;
			
			bev.graphics.drawRoundRect(2,2,bevW,36,_cornerRadius,_cornerRadius);
			bev.graphics.endFill();
			var bF:BevelFilter = new BevelFilter(4,90,0xffffff,.5,0xcccccc,.4,2,4,1,1,"inner");
			//var bF:BevelFilter = new BevelFilter( 0.25 , 45 , 0xFFFFFF , 15 , 10 , 10 , 0.50 , 	BitmapFilterQuality.MEDIUM , 1 , 1 , "inner" );
			bev.filters = [bF];
			spr.addChild(bev);
			var lblCopy:BoxCopy = new BoxCopy();
			var fontalign:String = _uip.uiFontHAlign;
			lblCopy.addText(str,_back.width,uip.uiFontSize,uip.uiFontColorCode,2,2,30,fontalign,_fontFamily,_localeID);
			
			//lblCopy.addText(str,_back.width,uip.uiFontSize,fontclrcode,2,2,30,fontalign,_fontFamily,_localeID);
		//	lblCopy.addText(str,_back.width,14,0xffffff,2,30);
			lblCopy.y = 6 ;
			spr.addChild(lblCopy);
			
		
			
			return spr;
			
		}
		private function _imgLoadComplete_handler(evt:LoaderEvent):void
		{
			trace("imageloadd");
			this.contentReady = true;
		}
		
		public function fullGlow(holdTime:Number = 0):TimelineMax {
			var glowUpTime:Number = 1;;
			var glowDown:Number = 0.5;
			
			if (holdTime > 0) {
				holdTime = holdTime - glowUpTime;
			} else {
				holdTime = 0;
			}
			var tl:TimelineMax = new TimelineMax();
			tl.append(new TweenMax(this,1,{glowFilter:{color:_glowColorCode, alpha:_glowAlpha,blurX:_glowX,blurY:_glowY,quality:_glowQuality,strength:_glowStrength},ease:Bounce.easeOut}));
			tl.append(new TweenMax(this,0.5,{glowFilter:{color:_glowColorCode, alpha:_glowAlpha,blurX:_glowX,blurY:_glowY,quality:_glowQuality,strength:0},delay:holdTime}));
			return tl;
		}
		//you build these functions into your objects (classes, MovieClips, whatever):
		public function addGlow():TimelineLite {
			var tl:TimelineLite = new TimelineLite();
			
			tl.append(new TweenMax(this,1,{glowFilter:{color:_glowColorCode, alpha:_glowAlpha,blurX:_glowX,blurY:_glowY,quality:_glowQuality,strength:_glowStrength},ease:Bounce.easeOut,onComplete:_glowChange_handler}));
			
			return tl;
		}
		
		public function removeGlow():TimelineLite {
			var tl:TimelineLite = new TimelineLite();
			tl.append(new TweenMax(this,1,{glowFilter:{color:_glowColorCode, alpha:_glowAlpha,blurX:_glowX,blurY:_glowY,quality:_glowQuality,strength:0},onComplete:_glowChange_handler}));
	
			return tl;
		}
		
		private function _glowChange_handler():void
		{
			
		}



	}
}