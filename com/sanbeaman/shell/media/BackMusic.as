package com.sanbeaman.shell.media
{
	import com.greensock.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	
	import flash.events.*;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.media.*;
	import flash.net.*;
	

	import com.greensock.*; 
	import com.greensock.easing.*;
	
	public class BackMusic extends EventDispatcher
	{
		private var _musicduration:Number;
		private var _isLooping:Boolean;
		private var _musicsound:MP3Loader 
		public function BackMusic()
		{
		
			trace("Player initialized...");
		}
		public function init(musicpath:String, dur:Number,estBytes:Number,loops:int):void
		{
			_musicduration = dur;
			_isLooping = (loops >=0)? false:true
			//create a MP3Loader that will begin playing immediately when it loads
			_musicsound = new MP3Loader(musicpath, {name:"audio", autoPlay:false, repeat:loops, estimatedBytes:estBytes,onComplete:_onMusicLoaded});
			
			//begin loading
			_musicsound.load();
			
			
		}
		
		private function _onMusicLoaded(evt:LoaderEvent):void
		{
			
			_musicsound.volume = 0;	
			_musicsound.playSound();			
			TweenLite.to(_musicsound, 2, {volume:0.7});
		}
		public function killMusic():void
		{
			
		}
		
	}
}