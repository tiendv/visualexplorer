package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ViewCoPathGraphEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "viewCoPath";
		public var authorID:int;
		public var authorID1:int;

		public function ViewCoPathGraphEvent(authorID:int, authorID1:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
			this.authorID1 = authorID1;
		}
	}
}