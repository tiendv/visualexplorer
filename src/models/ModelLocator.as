package models
{
	import mx.collections.ArrayCollection;

	public class ModelLocator
	{
		private static var _instance : ModelLocator;
		public static function getInstance():ModelLocator
		{
			if (_instance == null)
				_instance = new ModelLocator();
			return _instance;
		}
		
		private function ModelLocator()
		{
			searchedAuthors = new ArrayCollection();
			recommendedAuthors = new ArrayCollection();	
		}
		
		public var searchedAuthors:ArrayCollection;
		public var recommendedAuthors:ArrayCollection; 
	}
}