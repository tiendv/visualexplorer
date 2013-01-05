package business.commands
{
	import business.delegates.ViewCoAuthorGraphDelegate;
	import business.events.ViewCoAuthorGraphEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.Float;
	
	import models.GraphLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import utils.GraphUtil;

	public class ViewCoAuthorGraphCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{		
			var authorID:int = (event as ViewCoAuthorGraphEvent).authorID;
			var responder:Responder = new mx.rpc.Responder(onViewCoAuthor,onFailed);
			var delegate:ViewCoAuthorGraphDelegate = new ViewCoAuthorGraphDelegate(responder);
			delegate.viewCoAuthor(authorID);
		}
		
		private function onViewCoAuthor(event:ResultEvent):void
		{
			var xmldata:XML = <Graph></Graph>;
			var sizeDict:Dictionary = new Dictionary();//id, nodeSize
			var radiusDict:Dictionary = new Dictionary();//id, nodeRadius
			
			if (event.result.rTBVSAuthors != null)
			{
				var rtbvsAuthorCollection:ArrayCollection = event.result.rTBVSAuthors.rtbvsAuthor as ArrayCollection;
				
				if(rtbvsAuthorCollection != null && rtbvsAuthorCollection.length>1)
				{//neu la mang (>1 node)
					GraphLocator.getInstance().idRoot = rtbvsAuthorCollection.getItemAt(0).authorID;
					var nodeRoot:XMLList;
					var percent:Number;
					var maxSimValue:Number = 0.0;
					var minSimValue:Number = int.MAX_VALUE;
					
					for(var i:int=0;i<rtbvsAuthorCollection.length;i++)
					{
						var o:Object = rtbvsAuthorCollection.getItemAt(i); 
						
						if(i==0)
						{//neu la node chinh
							nodeRoot = GraphUtil.createNode(o.authorID,o.authorName,o.orgName,80,o.imgUrl,0);
							var simDataRootCollection:ArrayCollection = o.simData.entry as ArrayCollection;
							if(simDataRootCollection == null){
								simDataRootCollection = new ArrayCollection();
								simDataRootCollection.addItem(o.simData.entry);
							}
							for(var j:int=0;j<simDataRootCollection.length;j++)
							{
								var os:Object = simDataRootCollection.getItemAt(j);
								if(os.value > maxSimValue){
									maxSimValue = os.value;
								}
								if(os.value < minSimValue){
									minSimValue = os.value;
								}
								var xmlEdgeM:XMLList = GraphUtil.createEdge(o.authorID,os.key,"0xFFA500",os.value);
								xmldata.prependChild(xmlEdgeM);
							}
							for(var k:int=0;k<simDataRootCollection.length;k++)
							{
								var s:Object = simDataRootCollection.getItemAt(k);
								percent = (s.value/maxSimValue)*100;
								var id:int = s.key;
								if(percent<34){
									sizeDict[id] = 35;
								}else if(percent < 67){
									sizeDict[id] = 50;
								}else{
									sizeDict[id] = 65;
								}
								//----
								if(maxSimValue == minSimValue)
								{
									radiusDict[id] = 1.0;
								}
								else{
									if(s.value == minSimValue){
										radiusDict[id] = 1.0;
									}else if(s.value == maxSimValue){
										radiusDict[id] = 0.2;
									}else{//khong phai thi nam trong khoan 0.8 con lai
										radiusDict[id] = (maxSimValue-s.value)*0.8/(maxSimValue-minSimValue)+0.2;
									}
								}
							}
						}
						else
						{//co the co hoac khong co simData
							var xmlNode:XMLList;
							var authorID:int = o.authorID;
							xmlNode = GraphUtil.createNode(o.authorID,o.authorName,o.orgName,sizeDict[authorID],o.imgUrl,radiusDict[authorID]);
							xmldata.prependChild(xmlNode);
							//kiem tra simData co hay ko
							var checkData:Object = o.simData as Object;
							if(checkData != null)
							{
								var simDataCollection:ArrayCollection = o.simData as ArrayCollection;
								if(simDataCollection == null){
									simDataCollection = new ArrayCollection();
									simDataCollection.addItem(o.simData.entry);
								}
								for(var l:int;l<simDataCollection.length;l++)
								{
									var osd:Object = simDataCollection.getItemAt(l);
									var xmlEdge:XMLList = GraphUtil.createEdge(o.authorID,osd.key,"",osd.value);
									xmldata.prependChild(xmlEdge);
								}
							}
						}
					}
				}
				else
				{//chi co 1 node
					var obj:Object = event.result.rTBVSAuthors.rtbvsAuthor;
					nodeRoot = GraphUtil.createNode(obj.authorID,obj.authorName,obj.orgName,80,obj.imgUrl,0);
					GraphLocator.getInstance().idRoot = obj.authorID;
				}
				
				xmldata.prependChild(nodeRoot);
				GraphLocator.getInstance().graph.dataProvider.removeAll();
				GraphLocator.getInstance().graph.dataProvider.addItem(xmldata);
			}	
			GraphLocator.getInstance().waiting = false;
		}
		
		private function onFailed(event:FaultEvent):void
		{
			GraphLocator.getInstance().waiting = false;
		}
	}
}