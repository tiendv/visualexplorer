package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetCollaborationEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getCollaboration";
		
		public function GetCollaborationEvent()
		{
			super(EVENT_ID);
		}
	}
}

