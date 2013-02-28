package business.commands
{
	import business.delegates.ViewCoPathGraphDelegate;
	import business.events.ViewCoPathGraphEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.Dictionary;
	
	import models.GraphLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import utils.GraphUtil;

	public class ViewCoPathGraphCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{		
			var authorID:int = (event as ViewCoPathGraphEvent).authorID;
			var authorID1:int = (event as ViewCoPathGraphEvent).authorID1;
			var responder:Responder = new mx.rpc.Responder(onViewCoPath,onFailed);
			var delegate:ViewCoPathGraphDelegate = new ViewCoPathGraphDelegate(responder);
			delegate.viewCoPath(authorID,authorID1);
		}
		
		private function onViewCoPath(event:ResultEvent):void
		{
			var xmldata:XML = <Graph></Graph>;
			var xBegin:int = 450;
			var yBegin:int = 250;
			
			if (event.result.rTBVSAuthors != null)
			{
				var rtbvsAuthorCollection:ArrayCollection = event.result.rTBVSAuthors.rtbvsAuthor as ArrayCollection;
				var nodeRoot:XMLList;
				var nodeRootRight:XMLList;
				var direct:Boolean = false;
				var heso:int = 1;
				var capheso:int = 0;
				var amduong:int = 1;
				
				if(rtbvsAuthorCollection != null && rtbvsAuthorCollection.length>1)
				{//neu la mang (>1 node)
					//--
					//huy hien thong bao path exist
					GraphLocator.getInstance().pathExistMsg = false;

					for(var i:int=0;i<rtbvsAuthorCollection.length;i++)
					{
						var o:Object = rtbvsAuthorCollection.getItemAt(i); 
						
						if(o.authorID==GraphLocator.getInstance().idRoot)
						{//neu la node chinh trai
							var collection:ArrayCollection = o.listSubdomain as ArrayCollection;
							if(collection == null){
								collection = new ArrayCollection();
							}

							var desc:String = "";
							for each (var item:Object in collection) {
								desc += item + ", ";
							}
							desc = GraphUtil.createTooltipDesc(o.authorName,o.imgUrl,o.orgName,o.publicationCount,o.h_Index,o.g_Index,desc);

							nodeRoot = GraphUtil.createNodePath(o.authorID,o.authorName,desc,60,o.imgUrl,150,250);
							
							var simDataRootCollection:ArrayCollection = o.simData.entry as ArrayCollection;
							if(simDataRootCollection == null){
								simDataRootCollection = new ArrayCollection();
								simDataRootCollection.addItem(o.simData.entry);
							}
							//duyet so path
							// kiem tra xem co duong noi truc tiep hay ko
							// tao edge toi node trung gian
							for(var j:int=0;j<simDataRootCollection.length;j++)
							{
								var o1:Object = simDataRootCollection.getItemAt(j);
								if(o1.key == GraphLocator.getInstance().idRootRight)
								{
									direct = true;//co link truc tiep 
								}
								//tao edge tu root toi cac note trung gian
								var xmlEdge:XMLList = GraphUtil.createEdgePath(o.authorID,o1.key,o1.value,false);
								xmldata.prependChild(xmlEdge);
							}
							if(direct == false)
							{
								var xmlEdge1:XMLList = GraphUtil.createEdgePath(o.authorID,GraphLocator.getInstance().idRootRight,0,true);
								xmldata.prependChild(xmlEdge1);
							}
						}
						else if(o.authorID == GraphLocator.getInstance().idRootRight)
						{// neu la node chinh phai
							var collection1:ArrayCollection = o.listSubdomain as ArrayCollection;
							if(collection1 == null){
								collection1 = new ArrayCollection();
							}
							
							var desc1:String = "";
							for each (var item1:Object in collection1) {
								desc1 += item1 + ", ";
							}
							desc1 = GraphUtil.createTooltipDesc(o.authorName,o.imgUrl,o.orgName,o.publicationCount,o.h_Index,o.g_Index,desc1);

							nodeRootRight = GraphUtil.createNodePath(o.authorID,o.authorName,desc1,60,o.imgUrl,750,250);
							//khong co simdata
						}
						else{
							//node trung gian
							//tao node 
							//+tao description
							var collection2:ArrayCollection = o.listSubdomain as ArrayCollection;
							if(collection2 == null){
								collection2 = new ArrayCollection();
							}

							var desc2:String = "";
							for each (var item2:Object in collection2) {
								desc2 += item2 + ", ";
							}
							desc2 = GraphUtil.createTooltipDesc(o.authorName,o.imgUrl,o.orgName,o.publicationCount,o.h_Index,o.g_Index,desc2);

							//--
							var y:int = yBegin + (amduong * 75 * heso);
							amduong = (-1)*amduong;
							capheso++;
							if(capheso > 0 && capheso %2 ==0){
								heso++;
							}
							var xmlNode:XMLList = GraphUtil.createNodePath(o.authorID,o.authorName,desc2,45,o.imgUrl,xBegin,y);
							xmldata.prependChild(xmlNode);

							//tao edge tu node trung gian toi node rootRight
							var o3:Object = o.simData.entry; // chi co 1 entry voi key la rootRight
							var xmlEdge2:XMLList = GraphUtil.createEdgePath(o.authorID,o3.key,o3.value,false);
							xmldata.prependChild(xmlEdge2);
						}
					}
				}
				else
				{//chi co 1 node
					//---
					//thong bao neu khong co link lien ket
					GraphLocator.getInstance().pathExistMsg = true;
					//---
					var obj:Object = event.result.rTBVSAuthors.rtbvsAuthor;
					var c:ArrayCollection = obj.listSubdomain as ArrayCollection;
					if(c == null){
						c = new ArrayCollection();
					}

					var d:String = "";
					for each (var sd1:Object in c) 
					{
						d += sd1 + ", ";
					}
					d = GraphUtil.createTooltipDesc(obj.authorName,obj.imgUrl,obj.orgName,obj.publicationCount,obj.h_Index,obj.g_Index,d);

					nodeRoot = GraphUtil.createNodePath(obj.authorID,obj.authorName,d,60,obj.imgUrl,150,250);
				}

				xmldata.prependChild(nodeRootRight);
				xmldata.prependChild(nodeRoot);
				GraphLocator.getInstance().graph.dataProvider.removeAll();
				GraphLocator.getInstance().graph.dataProvider.addItem(xmldata);
			}	
			//Alert.show(xmldata.toString());
			GraphLocator.getInstance().waiting = false;
			GraphLocator.getInstance().graph.dataProvider.refresh();
			FlexGlobals.topLevelApplication.graphView.visualGraph.redrawNodes();
			FlexGlobals.topLevelApplication.graphView.visualGraph.redrawEdges();
			FlexGlobals.topLevelApplication.graphView.visualGraph.refresh();
		}
		
		private function onFailed(event:FaultEvent):void
		{
			GraphLocator.getInstance().graph.dataProvider.removeAll();
			//GraphLocator.getInstance().graph.dataProvider.addItem(FlexGlobals.topLevelApplication.graphView.graph);
			GraphLocator.getInstance().waiting = false;
		}
	}
}