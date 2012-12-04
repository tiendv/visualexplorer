package utils
{
	import valueobjects.AuthorOrgObject;

	public class GraphUtil
	{
		public function GraphUtil()
		{
			public static function createNodeAuthor(node:AuthorOrgObject,x:int,y:int,index:int):XMLList
			{
				var nodeG:String="Node";
				var nodeID:String="id=";
				var nodeName:String="name=";
				var nodeDesc:String="desc=";
				var nodeColor:String="nodeColor=";
				var nodeSize:String="nodeSize=";
				var nodeClass:String="nodeClass=";
				var nodeIcon:String="nodeIcon=";
				var nodeclass="tree";
				var nodeSizeValue:int=60;
				var xAxis:String = "x";
				var yAxis:String = "y";
				var nodeColorValue:String="0x333333";
				if(index==0)
				{
					nodeclass="earth";
					nodeSizeValue=80;
					nodeColorValue="0x8F8FFF";
				}
				var xmlList:XMLList=XMLList("<"+nodeG+" "
												+nodeID		+"\""+	node.authorID	+"\""+" "
												+nodeName	+"\""+	node.authorName	+"\""+" "
												+nodeDesc	+"\""+	node.orgName	+"\""+" "
												+nodeColor	+"\""+	nodeColorValue	+"\""+" "
												+nodeSize	+"\""+	nodeSizeValue	+"\""+" "
												+nodeClass	+"\""+	nodeclass		+"\""+" "
												+nodeIcon	+"\""+	node.imgUrl		+"\""+" "
												+xAxis		+"\""+	x.toString()	+"\""+" "
												+yAxis		+"\""+	y.toString()	+"\""+" "
												+"/>");
				return xmlList;
			}
		
			/*
			public static function createEdgeAuthor(edge:PaperView,root:PaperView,flows:int):XMLList
			{
				var edgeG:String="Edge";
				var fromID:String="fromID=";
				var toID:String="toID=";
				var edgeColor:String="color=";
				var edgeLabel:String="edgeLabel=";
				var flow:String="flow=";
				var edgeClass:String="edgeClass=";
				var edgeIcon:String="edgeIcon=";
				
				var xmlList:XMLList = XMLList("<"+edgeG+" "+fromID+"\""+root.idPaper+"\""+" "+toID+"\""+edge.idPaper+"\""+" "+edgeColor+"\""+"0x333333"+"\""+" "+edgeLabel+"\""+edge.title+"\""+" "+flow+"\""+flows.toString()+"\""+" "+edgeClass+"\""+"earth"+"\""+" "+edgeIcon+"\""+edge.titleview+"\""+" "+" />");
				return xmlList;	
			}
			*/
		}
	}
}