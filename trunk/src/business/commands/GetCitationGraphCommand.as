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
				if(citationCollection.length >= 1) {
					// Note gốc
					var root:Object = citationCollection.getItemAt(0);
					nodeRoot = createNode(root, "0x8F8FFF", 60, "earth", "center", 40, 20);
					xmldata.prependChild(nodeRoot);
					for(var i:int=1;i<citationCollection.length;i++){
						var node:Object = citationCollection.getItemAt(i);
						var y:int;
						var x:int;					
						var cos:Number = Math.random();
						var sin:Number = Math.sqrt(1-(cos*cos));
						var length: int = 90*citationCollection.getItemAt(1).citationCount;					
						if(i==1) {
							x=90*sin;
							y=90*cos;
						} else {
							var rightLength:Number = length/citationCollection.getItemAt(i).citationCount;
							x=rightLength*cos;
							y=rightLength*sin;
						}					
						var xmlNode:XMLList = createNode(node, "0x8F8FFF", 45, "leaf", node.authorID, x+40, y+20);
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
			Alert.show("FaultEvent Callback","Alert");
			GraphLocator.getInstance().waiting = false;
		}

		private function createNode(node:Object, nodeColor:String, nodeSize:int, nodeClass:String, nodeIcon:String, x:int, y:int):XMLList
		{			
			var xmlList:XMLList=XMLList("<Node"
				+" id=\""		+	node.authorID	+"\""
				+" name=\""		+	node.authorName	+"\""
				+" desc=\""		+	node.orgName	+"\""
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