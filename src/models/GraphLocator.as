package models
{
	import graphLayout.data.GraphDP;
	
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
		[Bindable]
		public var graph:GraphDP;
		public var startRoot : IVisualNode;
		[Bindable]
		public var idRoot:int = 0;
		[Bindable]
		public var idRootRight:int = 1;
		[Bindable]
		public var waiting:Boolean = false;
		[Bindable]
		public var pathExistMsg:Boolean = false;
		public var action:int = 1; // 1,2,3,4 => co-gaph, co-path, citation, recommend
		public static const ALGORITHM_ADAMICADAR:int = 1;
		public static const ALGORITHM_COSINE:int = 2;
		public static const ALGORITHM_JACCARD:int = 3;
		public static const ALGORITHM_RTBVS:int = 4;
		public static const ALGORITHM_KEYWORD:int = 5;
	}
}