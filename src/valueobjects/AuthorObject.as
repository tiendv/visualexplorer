package valueobjects
{
	import mx.collections.ArrayCollection;

	public class AuthorObject
	{
		public var authorID:int;
		public var authorName:String;
		public var orgName:String;
		public var imgUrl:String;	
		public var g_Index:int;
		public var h_Index:int;
		public var listSubdomain:ArrayCollection;
		public var publicationCount:int;
		
		
		public function AuthorObject()
		{
		}
	}
}