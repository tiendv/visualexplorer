package utils
{
	
	public class GraphUtil
	{
		public function GraphUtil()
		{
						
		}
		public static function createNode(id:int, name:String, desc:String, size:int, imgUrl:String, radius:Number):XMLList
		{
			var nodeG:String="Node";
			var nodeID:String="id=";
			var nodeName:String="name=";
			var nodeDesc:String="desc=";
			var nodeSize:String="nodeSize=";
			var nodeImgUrl:String="imgUrl=";
			var nodeRadius:String="r=";
			
			if(imgUrl=="images/UnknowAuthor.png")
			{
				imgUrl="http://localhost:8080/PubGuru/images/UnknowAuthor.png";
			}
			
			var xmlList:XMLList=XMLList("<"+nodeG+" "
				+nodeID		+"\""+	id			+"\""+" "
				+nodeName	+"\""+	name		+"\""+" "
				+nodeDesc	+"\""+	desc		+"\""+" "
				+nodeSize   +"\""+  size		+"\""+" "
				+nodeImgUrl	+"\""+	imgUrl		+"\""+" "
				+nodeRadius	+"\""+	radius		+"\""+" "
				+"/>");
			
			return xmlList;
		}
		
		
		public static function createEdge(fromID:int, toID:int, color:String, sim:Number):XMLList
		{
			var edgeG:String="Edge";
			var edgeFromID:String="fromID=";
			var edgeToID:String="toID=";
			var edgeColor:String="color=";
			var edgeSim:String="Sim=";
			
			color = color.replace(/\s+/g, '');
			var xmlList:XMLList;
			
			if(color != "")
			{
				xmlList = XMLList("<"+edgeG+" "
					+edgeFromID		+"\""+	fromID		+"\""+" "
					+edgeToID		+"\""+	toID		+"\""+" "
					+edgeColor		+"\""+	color		+"\""+" "
					+edgeSim		+"\""+	sim			+"\""+" "
					+"/>");
			}
			else
			{
				xmlList = XMLList("<"+edgeG+" "
					+edgeFromID		+"\""+	fromID		+"\""+" "
					+edgeToID		+"\""+	toID		+"\""+" "
					+edgeSim		+"\""+	sim			+"\""+" "
					+"/>");
			}
			
			return xmlList;	
		}
	}
}