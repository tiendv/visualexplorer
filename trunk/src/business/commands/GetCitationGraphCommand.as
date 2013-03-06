package business.commands
{
	
	import business.delegates.GetCitationGraphDelegate;
	import business.events.GetCitationGraphEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flashx.textLayout.formats.Float;
	
	import models.GraphLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.formatters.NumberBase;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import utils.GraphUtil;
	
	public class GetCitationGraphCommand implements ICommand
	{
		public function GetCitationGraphCommand()
		{
		}
		
		public function execute(event:CairngormEvent):void
		{		
			var authorID:int = (event as GetCitationGraphEvent).authorID;
			var responder:Responder = new mx.rpc.Responder(onViewCitation,onFailed);
			var delegate:GetCitationGraphDelegate = new GetCitationGraphDelegate(responder);
			delegate.viewCitation(authorID);
		}
		
		private function onViewCitation(event:ResultEvent):void
		{
			var xmldata:XML = <Graph></Graph>;
			if (event.result.authorCitationObjects != null)
			{
				var nodeRoot:XMLList;
				var percent:Number;
				var maxSimValue:Number = 0.0;
				var minSimValue:Number = int.MAX_VALUE;
				
				// Get data				
				var citationCollection:ArrayCollection = event.result.authorCitationObjects.authorCitationObject as ArrayCollection;
				
				if(citationCollection.length > 1) {
					
					// Note gốc
					var root:Object = citationCollection.getItemAt(0);					
					
					// Description for root
					var collectionRoot:ArrayCollection = root.listSubdomain as ArrayCollection;
					if(collectionRoot == null){
						collectionRoot = new ArrayCollection();
					}						
					var descRoot:String = "";
					for each (var item:Object in collectionRoot) {
						descRoot += item + ", ";
					}						
					descRoot = GraphUtil.createTooltipDesc(root.authorName, root.imgUrl, root.orgName, root.publicationCount, root.h_Index, root.g_Index, descRoot);
					
					// Add Root
					nodeRoot = createNode(root, "0x8F8FFF", 60, "earth", "center", descRoot, 40, 60);
					xmldata.prependChild(nodeRoot);
					var corner:Number = Math.PI/(2*(citationCollection.length - 2));
					var max:int = citationCollection.getItemAt(1).citationCount;
					var min:int = citationCollection.getItemAt(citationCollection.length-1).citationCount;
					var base:int = (min*700)/max;
					var length:int = base*citationCollection.getItemAt(1).citationCount;
					
					//RandomSort element array
					for(var k:int=1;k<citationCollection.length-1;k++){
							var random:Number = (Math.floor(Math.random() * (citationCollection.length-1)))+1;
							var nodeTemp:Object = citationCollection.getItemAt(k);
							citationCollection.setItemAt(citationCollection.getItemAt(random),k);
							citationCollection.setItemAt(nodeTemp,random);							
					}
					
					//Draw node in graph
					for(var i:int=1;i<citationCollection.length;i++){
						var node:Object = citationCollection.getItemAt(i);
						var y:Number;
						var x:Number;					
						var cos:Number = Math.cos(corner*(i-1));
						var sin:Number = Math.sqrt(1-(cos*cos));
						
						var rightLength:Number = length/citationCollection.getItemAt(i).citationCount;
						
						x=rightLength*cos;
						y=rightLength*sin;
						
						// Description for node
						var collectionNode:ArrayCollection = node.listSubdomain as ArrayCollection;
						if(collectionNode == null){
							collectionNode = new ArrayCollection();
						}						
						var descNode:String = "";
						for each (var temp:Object in collectionNode) {
							descNode += temp + ", ";
						}						
						descNode = GraphUtil.createTooltipDesc(node.authorName, node.imgUrl, node.orgName, node.publicationCount, node.h_Index, node.g_Index, descNode);
						
						// Add node
						var xmlNode:XMLList = createNode(node, "0x8F8FFF", 45, "leaf", node.authorID, descNode, x+40, y+60);
						var xmlEdge:XMLList = createEdge(root, node, "0x727BFC");
						xmldata.appendChild(xmlNode);
						xmldata.appendChild(xmlEdge);
					}
				}
				
				//Alert.show(xmldata,"Alert");
				GraphLocator.getInstance().idRoot = root.authorID;
				GraphLocator.getInstance().graph.dataProvider.removeAll();
				GraphLocator.getInstance().graph.dataProvider.addItem(xmldata);
				GraphLocator.getInstance().waiting = false;
			}
			else {
				Alert.show("Don't have Citation Author with this author!","Alert");
			}
		}
		private function onFailed(event:FaultEvent):void
		{
			//Alert.show("FaultEvent Callback","Alert");
			GraphLocator.getInstance().waiting = false;
		}

		private function createNode(node:Object, nodeColor:String, nodeSize:int, nodeClass:String, nodeIcon:String, desc:String, x:int, y:int):XMLList
		{			
			var xmlList:XMLList=XMLList("<Node"
				+" id=\""		+	node.authorID	+"\""
				+" name=\""		+	node.authorName	+"\""
				+" desc=\""		+	desc			+"\""
				+" nodeColor=\""+	nodeColor		+"\""
				+" nodeSize=\""	+  	nodeSize		+"\""
				+" nodeClass=\""+  	nodeClass		+"\""
				+" nodeIcon=\""	+	nodeIcon		+"\""
				+" x=\""		+	x				+"\""
				+" y=\""		+	y				+"\""
				+" imgUrl=\""	+	node.imgUrl		+"\""
				+" />");
			return xmlList;
		}
		
		private function createEdge(root:Object, edge:Object, color:String):XMLList
		{						
			var xmlList:XMLList = XMLList("<Edge"
				+" fromID=\""	+	root.authorID		+"\""
				+" toID=\""		+	edge.authorID		+"\""
				+" color=\""	+	color				+"\""
				+" Sim=\""		+	edge.citationCount	+"\""				
				+" />");			
			return xmlList;	
		}
	}
}