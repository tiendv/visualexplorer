package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetCollaborationCosineEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getCollaborationCosine";
		public var authorID:int;
		public function GetCollaborationCosineEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}

