package graphLayout.visual
{
	import graphLayout.data.GraphDP;
	
	import mx.events.CollectionEvent;
	
	import org.un.cava.birdeye.ravis.graphLayout.data.IGraph;
	import org.un.cava.birdeye.ravis.graphLayout.data.INode;
	import org.un.cava.birdeye.ravis.graphLayout.visual.VisualGraph;

	public class VisualGraphDP extends VisualGraph
	{

		public function VisualGraphDP()
		{
			super();
		}

		override public function set graph(g:IGraph):void {
			if (g is GraphDP) 
			{
				super.graph = g;
				(graph as GraphDP).dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE,dataProviderChangeHandler);
			}
			else
			{
				throw Error("VisualGraphDP must contain a GraphDP");
			}
		}
		override protected function commitProperties():void{
			super.commitProperties();
			if (graph != null && (graph as GraphDP).dataProviderChanged){

				purgeVGraph();
				graph.purgeGraph();

				for each (var xml:XML in (graph as GraphDP).dataProvider){
					graph.initFromXML(xml);
				}

				initFromGraph();

				if (graph.nodes.length > 0)
				{
					if (graph.nodeByStringId("Root") != null)
						currentRootVNode = graph.nodeByStringId("Root").vnode;
					else
						currentRootVNode = (_graph.nodes[_graph.nodes.length-1] as INode).vnode;

					setDistanceLimitedNodeIds(_graph.getTree(_currentRootVNode.node).
						getLimitedNodes(_maxVisibleDistance));
					updateVisibility();
					draw();
				}
				(graph as GraphDP).dataProviderChanged = false;
			}

		}

		private function dataProviderChangeHandler( e:CollectionEvent): void{

			if (!(graph as GraphDP).dataProvider.hasEventListener(CollectionEvent.COLLECTION_CHANGE))
				(graph as GraphDP).dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE,dataProviderChangeHandler);

			(graph as GraphDP).dataProviderChanged = true;
			this.invalidateProperties();
		}
	}
}

