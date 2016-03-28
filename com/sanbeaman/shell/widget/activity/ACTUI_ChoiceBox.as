package com.sanbeaman.shell.widget.activity
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	
	import flash.display.Bitmap;
	import flash.display.LineScaleMode;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class ACTUI_ChoiceBox extends Sprite
	{
		/*
		[Embed (source="/masterShell/widget/act/cb34_uncheck.png")]
		private var _itemchoice:Class
		public var itemchoice:Bitmap = new _itemchoice;
		
		[Embed (source="/masterShell/widget/act/cb34_check.png")]
		private var _itemchoice_checked:Class
		public var itemchoice_checked:Bitmap = new _itemchoice_checked;
		*/
		private var _shelldir:String;
		
		private var _back:Sprite;
		
		private var _isChecked:Boolean;
		
	//	private var _iconState:String;
		
		private var _cb_uncheck:Sprite;
		private var _cb_check:Sprite;
		
		private var _isVector:Boolean = true;
		
		private var _queLMAX:LoaderMax;
		
		private var _iconwidth:Number;
		private var _iconheight:Number;
		
		
		private var _currentState:String;
		//private var _tl_hover:TweenMax;
		private var _tl_hover:TimelineMax;
		public function ACTUI_ChoiceBox()
		{
			
		super();
		this.mouseEnabled = false;
		this.mouseChildren = false;
		}
		/**
		 * iconType="vector" 
		 * iconShape="circle"  
		 * iconWidth="16" 
		 * iconHeight="16" 
		 * iconFrameSize="2" 
		 * iconFrameColor="black" 
		 * iconFrameAlpha="1" 
		 * iconUncheck="white" 
		 * iconCheck="orange">
		 */
		public function build(icontype:String,iconshape:String,
							  iconwidth:Number,iconheight:Number,
							  iconframesize:Number,iconframecolor:String,iconframealpha:Number,
							  iconuncheck:String,iconcheck:String,shelldir:String):void
		{
			_iconwidth = iconwidth;
			_iconheight = iconheight;
		_back = new Sprite();
		_cb_uncheck = new Sprite();
		_cb_check = new Sprite();
		_shelldir = shelldir;
		
		
		switch (icontype) {
			case 'vector':
				_back = _buildBox_Vector(iconshape,iconwidth,iconheight,iconframesize,iconframecolor, iconframealpha,iconuncheck,iconcheck);
				_back.cacheAsBitmap = true;
				
				break;
			case 'bitmap':
				
				_back = _buildBox_Bitmap(iconshape,iconwidth,iconheight,iconframesize,iconframecolor, iconframealpha,iconuncheck,iconcheck);
				
				break;
			
		}
		_tl_hover = new TimelineMax({paused:true,repeat:-1,yoyo:true});
		
		//smoothChildTiming:true;
		_tl_hover.add(TweenMax.to(_cb_check,.5,{alpha:.5}));
		//_cb_check.alpha = 0;
		this.isChecked = false;
		
		//_back.x = 0;
		//_back.y = 0;
	//	TweenMax.to(_back, 1, {glowFilter:{color:0x666666, alpha:0.8, blurX:2, blurY:2, strength:2}});
		
		trace('_back.height = ' + _back.height + '___backWidth= ' +  _back.width);
		
		this.addChild(_back);
		
	}
	private function _buildBox_Bitmap(ishape:String,iwidth:Number,iheight:Number,
										  iframesize:Number,iframecolor:String,iframealpha:Number,
										  iconuncheck:String,iconcheck:String):Sprite{
		var spr:Sprite = new Sprite();
		//spr.width = iwidth;
	//	spr.height = iheight;
		
		var iconuncheckpath:String = _shelldir +  SHELL_VARS.FOLDER_MEDIA + iconuncheck;
		var iconcheckpath:String = _shelldir +  SHELL_VARS.FOLDER_MEDIA + iconcheck;
		_queLMAX= new LoaderMax({onComplete:_LMAX_completeHandler, onError:_LMAX_errorHandler});
		_queLMAX.append( new ImageLoader(iconuncheckpath, {name:"iconUncheck",centerRegistration:false, smoothing:true, estimatedBytes:1000}) );
		_queLMAX.append( new ImageLoader(iconcheckpath, {name:"iconCheck", centerRegistration:false, smoothing:true, estimatedBytes:1000}) );
		
		
		_queLMAX.load();	
		spr.addChild(_cb_uncheck);
		spr.addChild(_cb_check);
		return spr;
		
	}
	private function _LMAX_completeHandler(event:LoaderEvent):void {
		
		var bmp_uncheck:Bitmap =  _queLMAX.getLoader("iconUncheck").rawContent;
		trace('bmp_uncheck width='+bmp_uncheck.width);
		var bmp_check:Bitmap =  _queLMAX.getLoader("iconCheck").rawContent;
		_cb_uncheck.addChild(bmp_uncheck);
		_cb_check.addChild(bmp_check);
		trace(event.target + " is complete!");
	}
	
	private function _LMAX_errorHandler(event:LoaderEvent):void {
		trace("error occured with " + event.target + ": " + event.text);
	}
	private function _buildBox_Vector(ishape:String,iwidth:Number,iheight:Number,
									  iframesize:Number,iframecolor:String,iframealpha:Number,
									  iconuncheck:String,iconcheck:String):Sprite
	{

		var spr:Sprite = new Sprite();
		if (ishape == 'circle'){
			
			var outerShapeW:Number = iwidth;
			//var outerShapeH:Number = iheight;
			var outerShapeCenter:Number = int(outerShapeW *.5)
			var uncheckW:Number = outerShapeW - iframesize;
			var uncheckRadius:Number = int(uncheckW * .5);
			//var uncheckH:Number = outerShapeH - iframesize;
			var checkW:Number = uncheckW - (iframesize +2);
			var checkRadius:Number = int(checkW * .5);
			//var uncheckShapeRad:Number = iwidth - iframesize;
		//	var checkShapeRad:Number = uncheckShapeRad - (iframesize+2);// *2);
		//	var circleRad:Number = 16;
		//	var circleRad2:Number = 14;
		//	var circleRad3:Number = 11;
	
			var outerShape:Shape = new Shape();
			var outerShapeColorCode:uint = SHELL_COLORS.lookUpColor(iframecolor);
			
			outerShape.graphics.beginFill(outerShapeColorCode,iframealpha);
			outerShape.graphics.drawEllipse(0,0,outerShapeW,outerShapeW);
		//	outerShape.graphics.drawCircle(0,0,outerShapeRad);
			outerShape.graphics.endFill();
			outerShape.cacheAsBitmap = true;
			//outerShape.x = outerShapeRad;
			//outerShape.y = outerShapeRad;
			
			var uncheckShape:Shape = new Shape();
			var uncheckShapeFillColorCode:uint = SHELL_COLORS.lookUpColor(iconuncheck);
			uncheckShape.graphics.beginFill(uncheckShapeFillColorCode,1);
			//cb.graphics.lineStyle(2,0x000000,1,true,"none");
			//uncheckShape.graphics.drawEllipse(0,0,uncheckW,uncheckW);
			uncheckShape.graphics.drawCircle(0,0,uncheckRadius);
			
		
			//cb.graphics.drawCircle(0,0,16);
			uncheckShape.graphics.endFill();
			uncheckShape.x = outerShapeCenter;
			uncheckShape.y = outerShapeCenter;
			uncheckShape.cacheAsBitmap = true;
		
			_cb_uncheck.addChild(outerShape);
			_cb_uncheck.addChild(uncheckShape);
			//TweenMax.to(_cb_uncheck, 0, {glowFilter:{color:outerShapeColorCode, alpha:1, blurX:1, blurY:1, strength:2}});
		//	_cb_check.cacheAsBitmap = true;
			//_cb_uncheck.addChild(cb);
			
			var checkShape:Shape = new Shape();
			var checkShapeFillColorCode:uint = SHELL_COLORS.lookUpColor(iconcheck);
			checkShape.graphics.beginFill(checkShapeFillColorCode,1);
			//checkShape.graphics.drawEllipse(0,0,checkW,checkW);
			
			checkShape.graphics.drawCircle(0,0,checkRadius);
			checkShape.graphics.endFill();
			checkShape.cacheAsBitmap = true;
			checkShape.x=outerShapeCenter;
			checkShape.y = outerShapeCenter;
			//_cb_check.addChild(cbc);
			_cb_check.addChild(checkShape);
			_cb_check.alpha =0;
		//	TweenMax.to(_cb_uncheck, 0, {glowFilter:{color:checkShapeFillColorCode, alpha:1, blurX:1, blurY:1, strength:2}});
		//	_cb_check.cacheAsBitmap = true;

		}else if (ishape == 'square'){
			
			//_cb_uncheck.addChild(itemchoice);
			//_cb_check.addChild(itemchoice_checked);
			
		} else {
			
		}
		
		
		
		
		spr.addChild(_cb_uncheck);
		spr.addChild(_cb_check);
		return spr;
		/*
		_back.addChild(_cb_uncheck);
		_cb_check.visible= false;
		_back.addChild(_cb_check);
		
		_isChecked = false;
		
		_back.x = 0;
		_back.y = 0;
		this.addChild(_back);
		*/
		
	}
	
	public function hover(over:Boolean):void
	{
		if (over && !isChecked){
			_tl_hover.play();
		} else {
			_tl_hover.pause();
			_changeCheckBox();
			
		}
	}
	

		public function get isChecked():Boolean
		{
			return _isChecked;
		}

		public function set isChecked(value:Boolean):void
		{
			_isChecked = value;
			_changeCheckBox();
		}

		private function _changeCheckBox():void
		{
			if (_isChecked) {
				_tl_hover.pause();
				TweenMax.to(_cb_check, .3, {alpha:1});
				//_cb_check.alpha = 1;
				
			} else {
				_tl_hover.pause();
				TweenMax.to(_cb_check, .3, {alpha:0});
				//_cb_check.alpha = 0;
			}
		}
		public function get iconwidth():Number
		{
			return _iconwidth;
		}

		public function set iconwidth(value:Number):void
		{
			_iconwidth = value;
		}

		public function get iconheight():Number
		{
			return _iconheight;
		}

		public function set iconheight(value:Number):void
		{
			_iconheight = value;
		}

		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			_currentState = value;
			
		}

	
}
}