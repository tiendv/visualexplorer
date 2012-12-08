package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class TestEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "testEvent";
		public var authorID:int;
		public function TestEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}

