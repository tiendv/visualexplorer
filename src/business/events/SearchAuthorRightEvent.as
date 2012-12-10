package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class SearchAuthorRightEvent extends CairngormEvent
	{
		static public var EVENT_ID:String = "searchAuthorRight";
		public var authorName:String;
		
		public function SearchAuthorRightEvent(authorName:String)
		{
			super(EVENT_ID);
			this.authorName = authorName;
		}
	}
}

