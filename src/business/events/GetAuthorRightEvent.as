package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class GetAuthorRightEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getAuthorRight";
		public var authorID:int;
		
		public function GetAuthorRightEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}