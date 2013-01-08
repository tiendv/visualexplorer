package business.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	public class GetCitationGraphEvent extends CairngormEvent 
	{
		static public var EVENT_ID:String = "GetCitationGraph";
		public var authorID:int;
		
		public function GetCitationGraphEvent(authorID:int)
		{
			super(EVENT_ID);
			this.authorID = authorID;
		}
	}
}