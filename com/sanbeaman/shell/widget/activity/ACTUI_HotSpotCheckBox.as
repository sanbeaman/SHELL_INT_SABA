package com.sanbeaman.shell.widget.activity
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.events.LoaderEvent;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ACTUI_HotSpotCheckBox extends MovieClip
	{
		/*
		[Embed (source="/masterShell/widget/act/hs_checkBox0.png")]
		private var _hs_checkbox00:Class
		private var _hs_checkbox0:Bitmap = new _hs_checkbox00;
		
		[Embed (source="/masterShell/widget/act/hs_checkBox1.png")]
		private var _hs_checkbox01:Class
		private var _hs_checkbox1:Bitmap = new _hs_checkbox01;
		
		[Embed (source="/masterShell/widget/act/hs_checkBox1chkd.png")]
		private var _hs_checkbox01chkd:Class
		private var _hs_checkbox1chkd:Bitmap = new _hs_checkbox01chkd;
		*/
		
		private var _checkBack:Sprite;
		
		private var _iconReady:Sprite;
		private var _iconActive:Sprite;
		private var _iconChecked:Sprite;
		
		private var _pulseState:MovieClip;
		private var _currentState:String;
		
		private var _pulseStateTL:TimelineMax;
		
		private var _tracked:Boolean;

		private var _isVector:Boolean = true;
		
		private var _queLMAX:LoaderMax;
		
		private var _iconwidth:Number;
		private var _iconheight:Number;
		
		
		private var _shelldir:String;
		public function ACTUI_HotSpotCheckBox()
		{
			super();
			
			
		}
		
		public function build(icontype:String,iconshape:String,
				iconwidth:Number,iconheight:Number,
				iconframesize:Number,iconframecolor:String,iconframealpha:Number,iconready:String,
				iconuncheck:String,iconcheck:String,shelldir:String):void
			{
			_iconReady = new Sprite();
			_iconActive= new Sprite();
			_iconChecked= new Sprite();
		
			_iconwidth = iconwidth;
			_iconheight = iconheight;
		
			_shelldir = shelldir;
			
			
			switch (icontype) {
				case 'vector':
				//	_back = _buildBox_Vector(iconshape,iconwidth,iconheight,iconframesize,iconframecolor, iconframealpha,iconuncheck,iconcheck);
					//_back.cacheAsBitmap = true;
					
					break;
				case 'bitmap':
					
					_checkBack = _buildBox_Bitmap(iconshape,iconwidth,iconheight,iconframesize,iconframecolor, iconframealpha,iconready,iconuncheck,iconcheck);
					
					break;
				
			}
		
			
			this.addChild(_checkBack);
			
			_pulseStateTL = new TimelineMax({paused:true,repeat:-1,yoyo:true,delay:1});
			//_pulse_tl.append( new TweenMax(_btnEmblem,.5, {alpha:1}));
			_pulseStateTL.append( TweenMax.to(_iconReady, 0.5,{scaleX:1.1, scaleY:1.1, alpha:0.4}));
			//spr.addChild(_iconActive);
			//	spr.addChild(_iconChecked);
			/*
			_normalState = new Sprite();
			_normalState.addChild(_hs_checkbox0);
			_checkBack.addChild(_normalState);
		
			
			_activeState = new Sprite();
			_activeState.addChild(_hs_checkbox1);
			//_addRemoveCheckedState(true);
			
			
			_checkedState = new Sprite();
			_checkedState.addChild(_hs_checkbox1chkd);
			//_addRemoveCheckedState(true);
			
			//	this.addChild(_checkBack);
			//	this.tracked = false;
			
			*/
			
			
		}
		private function _buildBox_Bitmap(ishape:String,iwidth:Number,iheight:Number,
										  iframesize:Number,iframecolor:String,iframealpha:Number,iconready:String,
										  iconuncheck:String,iconcheck:String):Sprite
		{
			var spr:Sprite = new Sprite();
			//spr.width = iwidth;
			//	spr.height = iheight;
			
			var iconreadypath:String = _shelldir +  SHELL_VARS.FOLDER_MEDIA + iconready;
			var iconuncheckpath:String = _shelldir +  SHELL_VARS.FOLDER_MEDIA + iconuncheck;
			var iconcheckpath:String = _shelldir +  SHELL_VARS.FOLDER_MEDIA + iconcheck;
			_queLMAX= new LoaderMax({onComplete:_LMAX_completeHandler, onError:_LMAX_errorHandler});
			_queLMAX.append( new ImageLoader(iconreadypath, {name:"icon_ready",container:_iconReady, centerRegistration:false, smoothing:true, estimatedBytes:1000}) );
			_queLMAX.append( new ImageLoader(iconuncheckpath, {name:"icon_unchecked",container:_iconActive, centerRegistration:false, smoothing:true, estimatedBytes:1000}) );
			_queLMAX.append( new ImageLoader(iconcheckpath, {name:"icon_checked",container:_iconChecked,  centerRegistration:false, smoothing:true, estimatedBytes:1000}) );
			
			
			_queLMAX.load();	
			spr.addChild(_iconReady);
			
			return spr;
			
		}
		private function _LMAX_completeHandler(event:LoaderEvent):void {
			
			//var bmp_uncheck:Bitmap =  _queLMAX.getLoader("iconUncheck").rawContent;
			//trace('bmp_uncheck width='+bmp_uncheck.width);
		//	var bmp_check:Bitmap =  _queLMAX.getLoader("iconCheck").rawContent;
			//_cb_uncheck.addChild(bmp_uncheck);
		//	_cb_check.addChild(bmp_check);
			trace(event.target + " is complete!");
		}
		
		private function _LMAX_errorHandler(event:LoaderEvent):void {
			trace("error occured with " + event.target + ": " + event.text);
		}
			
		/*
		private function _addRemoveCheckedState(addit:Boolean):void
		{
			if (addit){
				_checkBack.addChild(_iconChecked);
			} else {
				_checkBack.removeChild(_iconChecked);
			}
		}
		*/
		public function get currentState():String
		{
			return _currentState;
		}

		public function set currentState(value:String):void
		{
			_currentState = value;
			
			switch (_currentState){
				case "normal":
					if (!_tracked) {
						//_pulseStateTL.pause();
						_pulseStateTL.gotoAndStop(0);
						
					}
					break;
				case "pulse":
					if (!_tracked) {
						//_pulseStateTL.pause();
						_pulseStateTL.play();
						
					}
					
					break;
				case "active":
					if (!_tracked) {
						//_pulseStateTL.pause();
						_pulseStateTL.stop();
						_checkBack.removeChildAt(0);
						_checkBack.addChild(_iconActive);
						
					}
					break;
		
			}
		}

		public function get tracked():Boolean
		{
			return _tracked;
		}

		public function set tracked(value:Boolean):void
		{
			_tracked = value;
			if (_tracked){
				_checkBack.removeChildAt(0);
				_checkBack.addChild(_iconChecked);
			}
			//_addRemoveCheckedState(_tracked);
			
		}


	}
}