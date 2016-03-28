package
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class ResourceLoader extends EventDispatcher
	{
		public function ResourceLoader(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}