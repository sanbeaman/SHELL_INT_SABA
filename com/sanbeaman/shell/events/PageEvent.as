package com.sanbeaman.shell.events
{
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		public static const PAGE_OPEN:String = "pageOpen";
		public static const PAGE_CLOSED:String = "pageClosed";
		public static const PAGES_START:String = "pagesStart";
		public static const PAGES_COMPLETE:String = "pagesComplete";
		
		private var _eventAction:String;
		
		public function get eventAction():String {
			return _eventAction;
		}
		
		public function set eventAction(value:String):void {
			_eventAction = value;
		}
		
		private var _eventInfo:String;
		
		public function get eventInfo():String
		{
			return _eventInfo;
		}
		
		public function set eventInfo(value:String):void
		{
			_eventInfo = value;
		}
		
		
		/**
		 * Constructor
		 * @param	type			(String) the event type
		 * @param	eventAction			(String) the specific event action
		 *  @param	eventInfo			(String) additional info related to eventAcion
		 * @param	bubbles		(Boolean) does the event bubble? Defaults to false
		 * @param	cancelable	(Boolean) can the event be canceled? Defaults to false
		 * @return	PageEvent
		 */
		public function PageEvent(type:String,eventAction:String = null,eventInfo:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_eventAction = eventAction;
			_eventInfo = eventInfo;
		}
		
		override public function toString():String {
			return formatToString("PageEvent", "type","eventAction","eventInfo", "bubbles", "cancelable");
		}
		
		/**
		 * Clones the event
		 * 
		 * @return	Event
		 */
		override public function clone():Event
		{
			return new PageEvent( type,eventAction,eventInfo, bubbles, cancelable );
		}
	}
}

