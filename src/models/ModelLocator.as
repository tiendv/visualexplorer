package models
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ModelLocator
	{
		private static var _instance : ModelLocator;
		public static function getInstance():ModelLocator
		{
			if (_instance == null)
				_instance = new ModelLocator();
			return _instance;
		}
		
		public var searchedAuthors:ArrayCollection = new ArrayCollection();
		public var searchedAuthorsRight:ArrayCollection = new ArrayCollection();
		public var recommendedAuthors:ArrayCollection = new ArrayCollection(); 
		
		public var waitingSearchLeft:Boolean = false;
		public var waitingSearchRight:Boolean = false;
	}
}