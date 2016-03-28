package com.sanbeaman.shell.events
{
	import flash.events.Event;
	
	public class WidgetBtnEvent extends Event
	{
		
		public static const WIDGETBTN_CLICK:String = "WidgetBTn_ClicK";
		public var caller:*;
		public function WidgetBtnEvent(caller:*, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.caller = caller;
			super(type, bubbles, cancelable);
		}
	}
}
