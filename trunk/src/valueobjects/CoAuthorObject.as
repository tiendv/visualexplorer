package valueobjects
{
	import flash.utils.Dictionary;

	public class CoAuthorObject
	{
		public var authorID:int;
		public var authorName:String;
		public var orgName:String;
		public var imgUrl:String;	

		//toID , sim
		public var simData:Dictionary;
		
		public function CoAuthorObject()
		{
			authorID = 0;
			authorName = "";
			orgName = "";
			imgUrl = "";
			simData = new Dictionary();
		}
	}
}