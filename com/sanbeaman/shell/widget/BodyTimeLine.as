package com.sanbeaman.shell.widget
{
	import com.greensock.TimelineMax;

	public class BodyTimeLine extends BodyUI
	{
		
		private var _tlmax:TimelineMax;
		
		public function BodyTimeLine()
		{
			super();
		}
		
		public function init(id:String,order:Number,type:String):void
		{
			this.id = id;
			this.order = order;
			this.time = time;
			this.type = type;
		}
		

		public function get tlmax():TimelineMax
		{
			return _tlmax;
		}

		public function set tlmax(value:TimelineMax):void
		{
			_tlmax = value;
		}

	}
}