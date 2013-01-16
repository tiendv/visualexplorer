package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetCollaborationJaccardEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getCollaborationJaccard";
		public var authorID:int;
		public function GetCollaborationJaccardEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}

