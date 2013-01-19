package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import mx.controls.Alert;

	public class GetCollaborationEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getCollaboration";
		public var authorID:int;
		public var algorithmType:int;
		public var keyword:String;
		public function GetCollaborationEvent(authorID:int, algorithmType:int, keyword:String)
		{
			super(EVENT_ID);
			this.authorID = authorID;
			this.algorithmType = algorithmType;
			this.keyword = keyword; 
		}
	}
}

