package com.sanbeaman.shell.widget
{
	
	import com.greensock.*;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.*;
	
	import flash.events.Event;
	
	public class BodySndFX extends BodyUI
	{
		private var _filePath:String;
		private var _snd:MP3Loader;
		private var _repeat:int;
		
		public function BodySndFX()
		{
			super();
		}
		public function init(id:String, order:int, time:Number, filepath:String, repeat:int = 0):void
		{
			this.id = id;
			this.order = order;
			this.time = time;
			this.type = "bodysndfx";
			
			_filePath = filepath;
			_repeat = repeat;
			//create a MP3Loader that will begin playing immediately when it loads
			_snd = new MP3Loader(_filePath, {name:"audio", autoPlay:false, repeat:_repeat, estimatedBytes:33843});
			
			//begin loading
			_snd.load();
			
		}
		
		public function playSndfx():void
		{
			_snd.playSound();
			_snd.addEventListener(Event.SOUND_COMPLETE, _sndfxComplete_handler);
			
		}
		
		private function _sndfxComplete_handler(evt:Event):void
		{
			var be:Event = new Event(Event.SOUND_COMPLETE);
			this.dispatchEvent(be);
		}
		public function stopSndfx():void
		{
			_snd.pauseSound();
			
		}
	
	}
}