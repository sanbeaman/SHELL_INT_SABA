package com.sanbeaman.shell.media
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.VideoLoader;
	import com.sanbeaman.shell.widget.BodyUI;
	
	import flash.errors.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class MediaSync extends EventDispatcher
	{
		
		public static const MEDIA_LOAD_COMPLETE:String = "mediaLoadComplete";
		public static const MEDIA_DONE:String = "mediaDone";
		public static const MEDIA_PLAY:String = "mediaPlay";
		public static const MEDIA_PAUSE:String = "mediaPause";
		
		
		private var _mediaType:String;
		
		private var _mp3:MP3Loader;// = new Loader();
		private var _vid:VideoLoader;// = new Loader();
		
		
		private var _mediaInit:Boolean = false;
		
		private var _mediaDuration:Number;
		
		private var _mediaPauseTime:Number;
	
		//the time in seconds the media playhead is at
		private var _mediaTime:Number;
		
		public var mediaHolder:BodyUI;
		
		public function MediaSync()
		{
			//super(target);
		}
		
		public function init(mtype:String, filepath:String,byteEstimate:Number = 44444, durationEstimate:Number = 20):void
		{
			_mediaType = mtype;

			_mediaInit = true;
			mediaHolder = new BodyUI();
			mediaHolder.id = 'vid';
			mediaHolder.trans = 'fadeon';
			mediaHolder.ease = 'QuintEaseOut';
			mediaHolder.time = 1;
			mediaHolder.timeIn = .5;
			mediaHolder.timeOut = 999;
			
			switch (_mediaType){
				case 'vid':
					_vid = new VideoLoader(filepath,{autoPlay:false,container:mediaHolder, width:655,height:320,  onComplete:_vidLoadComplete});
					_vid.load();
					break;
				case 'mp3':
					_mp3 = new MP3Loader(filepath,{autoPlay:false, onComplete:_mp3LoadComplete});
					_mp3.load();
					break;
				
			}
			
			
			
		}
		
	private function _mp3LoadComplete(event:LoaderEvent):void
	{
		_mp3.addEventListener(MP3Loader.SOUND_COMPLETE, _mediaDone_handler);
		_mp3.addEventListener(MP3Loader.SOUND_PAUSE,_mediaPlayPause_handler);
		_mp3.addEventListener(MP3Loader.SOUND_PLAY,_mediaPlayPause_handler);
		_mediaDuration = _mp3.duration;
		dispatchEvent(new Event(MediaSync.MEDIA_LOAD_COMPLETE));
	}
	
	private function _vidLoadComplete(event:LoaderEvent):void
	{
		_vid.addEventListener(VideoLoader.VIDEO_COMPLETE, _mediaDone_handler);
		_vid.addEventListener(VideoLoader.VIDEO_PLAY, _mediaPlayPause_handler);
		_vid.addEventListener(VideoLoader.VIDEO_PAUSE, _mediaPlayPause_handler);
	
		_mediaDuration = _vid.duration;
		mediaHolder.addChild(_vid.content);
		dispatchEvent(new Event(MediaSync.MEDIA_LOAD_COMPLETE));
	}
	
	public function playMedia():void
	{
		if (_mediaType == 'vid'){
			_vid.playVideo();
		} else if (_mediaType == 'mp3') {
			_mp3.playSound();
		} else {
			
		}
		
		
	}
	public function pauseMedia():void
	{
		if (_mediaType == 'vid'){
			_mediaPauseTime = _vid.videoTime;
			_vid.pauseVideo();
		} else if (_mediaType == 'mp3') {
			_mediaPauseTime = _mp3.soundTime;
			
			_mp3.pauseSound();
		} else {
			
		}
		
	}
	public function resumeMedia():void
	{
		if (_mediaType == 'vid'){
			//trace('resumeMedia========>' + _mediaTime);
			_vid.gotoVideoTime(_mediaTime,true);
		
		} else if (_mediaType == 'mp3') {
			
			_mp3.gotoSoundTime(_mediaTime,true);
	
		} else {
			
		}
		
	}
	
	public function startSrubbing():void
	{
		
		if (_mediaType=='vid'){
			_mediaPauseTime = _vid.videoTime;
			_vid.pauseVideo();
		} else if (_mediaType == 'mp3') {
			_mediaPauseTime = _mp3.soundTime;
			_mp3.pauseSound();
		} else {
			
		}
		
	}
	public function gotoMediaTime(t:Number, forceplay:Boolean = false):void
	{
		if (_mediaType=='vid'){
			_vid.gotoVideoTime(t,forceplay);
		} else if (_mediaType == 'mp3') {
			_mp3.gotoSoundTime(t,forceplay,false);
			
		} else {
			
		}
	
	}
	
	public function killMedia():void
	{
		if (_mediaType=='vid'){
			_killVideo();
		} else if (_mediaType == 'mp3') {
			_killAudio();
			
		} else {
			
		}
	}
	private function _killAudio():void
	{
		try 
		{ 
			_mp3.pauseSound(); 
		} 
		catch (error:IOError) 
		{ 
			// Error #2029: This URLStream object does not have an open stream. 
		}
		
		_mp3.removeEventListener(MP3Loader.SOUND_COMPLETE, _mediaDone_handler);
		_mp3.removeEventListener(MP3Loader.SOUND_PAUSE,_mediaPlayPause_handler);
		_mp3.removeEventListener(MP3Loader.SOUND_PLAY,_mediaPlayPause_handler);
		_mp3.dispose(true);
	}
	private function _killVideo():void
	{
		try 
		{ 
			_vid.pause(); 
		} 
		catch (error:IOError) 
		{ 
			// Error #2029: This URLStream object does not have an open stream. 
		}
		finally  
		{ 
			_vid.clearVideo(); // Perform any necessary cleanup here. 
		}
		
		_vid.removeEventListener(MP3Loader.SOUND_COMPLETE, _mediaDone_handler);
		_vid.removeEventListener(MP3Loader.SOUND_PAUSE,_mediaPlayPause_handler);
		_vid.removeEventListener(MP3Loader.SOUND_PLAY,_mediaPlayPause_handler);
		_vid.dispose(true);
	}
	
	private function _mp3pauseplay_handler(evt:Event):void
	{
		var audioEventType:String = evt.type;
		if (audioEventType == MP3Loader.SOUND_PAUSE) {
		//	dispatchEvent(new Event(SlideAudioSync.AUDIO_PAUSE));
		} else if (audioEventType == MP3Loader.SOUND_PLAY) {
		//	dispatchEvent(new Event(SlideAudioSync.AUDIO_PLAY));
		} else {
			trace("SlideAudioSync.ERROR");
			
		}
		
	}
	
	private function _mediaPlayPause_handler(evt:Event):void
	{
		//trace('_mediaPlayPauseEvent='+ evt.type + 'target' + evt.target);
	}
	private function _mediaDone_handler(evt:Event):void
	{
		dispatchEvent(new Event(MediaSync.MEDIA_DONE));
	}

	
	
	
		public function get mediaType():String
		{
			return _mediaType;
		}

		public function set mediaType(value:String):void
		{
			_mediaType = value;
		}

		public function get mediaDuration():Number
		{
			return _mediaDuration;
		}

		public function set mediaDuration(value:Number):void
		{
			_mediaDuration = value;
		}

		public function get mediaTime():Number
		{
			return _mediaTime;
		}

		public function set mediaTime(value:Number):void
		{
			_mediaTime = value;
			//trace('_mediaTime= '+_mediaTime);
			if (_mediaType=='vid'){
				_vid.videoTime = _mediaTime;
				
			} else if (_mediaType == 'mp3') {
				 _mp3.soundTime = _mediaTime;
				
			} else {
				
			}
			
		}

	
}
}