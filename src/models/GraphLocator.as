package models
{
	import mx.collections.ArrayCollection;
	
	import org.un.cava.birdeye.ravis.graphLayout.data.IGraph;
	import org.un.cava.birdeye.ravis.graphLayout.layout.ILayoutAlgorithm;
	import org.un.cava.birdeye.ravis.graphLayout.visual.IVisualGraph;
	import org.un.cava.birdeye.ravis.graphLayout.visual.IVisualNode;

	public class GraphLocator
	{
		private static var _instance:GraphLocator;
		public static function getInstance():GraphLocator
		{
			if (_instance == null)
				_instance = new GraphLocator();
			return _instance;
		}
		
		public var nodes:ArrayCollection;
		public var edges:ArrayCollection;
		public var xml:XML;
		public var layouter:ILayoutAlgorithm;
		public var graph:IGraph;
		public var startRoot : IVisualNode;
	}
}