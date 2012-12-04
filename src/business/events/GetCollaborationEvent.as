package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetCollaborationEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getCollaboration";
		public var authorID:int;
		public function GetCollaborationEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}

