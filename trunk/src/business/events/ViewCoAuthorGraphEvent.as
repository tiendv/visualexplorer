package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class ViewCoAuthorGraphEvent extends CairngormEvent 
	{
		static public var EVENT_ID:String = "viewCoAuhorGraph";
		public var authorID:int;
		
		public function ViewCoAuthorGraphEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}