package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class GetAuthorEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "getAuthor";
		public var authorID:int;
		
		public function GetAuthorEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}