package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetCollaborationAdamicAdarEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getCollaborationAdamicAdar";
		public var authorID:int;
		public function GetCollaborationAdamicAdarEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}

