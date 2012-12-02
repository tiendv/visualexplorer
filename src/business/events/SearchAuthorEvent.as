package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;

	public class SearchAuthorEvent extends CairngormEvent 
	{
		static public var EVENT_ID:String = "searchAuthor";
		public var authorName:String;
		
		public function SearchAuthorEvent(authorName:String)
		{
			super(EVENT_ID);
			this.authorName = authorName;
		}
	}
}