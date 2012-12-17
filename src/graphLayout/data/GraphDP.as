package graphLayout.data
{

	import mx.collections.XMLListCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	
	import org.un.cava.birdeye.ravis.graphLayout.data.Graph;

	public class GraphDP extends Graph
	{
		private var _dataProvider:XMLListCollection;
		public var dataProviderChanged:Boolean;

		public function GraphDP(id:String, directional:Boolean=false, xmlsource:XML=null)
		{
			super(id, directional, null);

			if (xmlsource != null)
			{
				this.dataProvider=new XMLListCollection(new XMLList(xmlsource));

				for each (var data:XML in dataProvider)
				{
					initFromXML(data);
				}
			}
		}

		public function set dataProvider(value:XMLListCollection):void
		{
			this._dataProvider=value;
			this.dataProviderChanged=true;
			dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, false, CollectionEventKind.RESET));
		}

		public function get dataProvider():XMLListCollection
		{
			return _dataProvider;
		}
	}
}