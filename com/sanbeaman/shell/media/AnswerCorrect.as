package com.sanbeaman.shell.media
{
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class AnswerCorrect extends Sound
	{
		public function AnswerCorrect(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
		}
	}
}