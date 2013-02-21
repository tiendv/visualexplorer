package utils
{
	import mx.collections.ArrayCollection;
	import mx.collections.Sort;
	
	import spark.collections.SortField;
	
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
				imgUrl= Domain.host + "/images/UnknowAuthor.png";
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
		
		public static function createNodePath(id:int, name:String, desc:String, size:int, imgUrl:String, x:int, y:int):XMLList
		{
			var nodeG:String="Node";
			var nodeID:String="id=";
			var nodeName:String="name=";
			var nodeDesc:String="desc=";
			var nodeSize:String="nodeSize=";
			var nodeImgUrl:String="imgUrl=";
			var nodeX:String="x=";
			var nodeY:String="y=";
			
			if(imgUrl=="images/UnknowAuthor.png")
			{
				imgUrl= Domain.host + "/images/UnknowAuthor.png";
			}
			
			var xmlList:XMLList=XMLList("<"+nodeG+" "
				+nodeID		+"\""+	id			+"\""+" "
				+nodeName	+"\""+	name		+"\""+" "
				+nodeDesc	+"\""+	desc		+"\""+" "
				+nodeSize   +"\""+  size		+"\""+" "
				+nodeImgUrl	+"\""+	imgUrl		+"\""+" "
				+nodeX		+"\""+	x			+"\""+" "
				+nodeY		+"\""+	y			+"\""+" "
				+"/>");
			
			return xmlList;
		}
		
		public static function createEdgePath(fromID:int, toID:int, sim:Number, alpha:Boolean):XMLList
		{
			var edgeG:String="Edge";
			var edgeFromID:String="fromID=";
			var edgeToID:String="toID=";
			var edgeColor:String="color=";
			var edgeSim:String="Sim=";
			var edgeAlpha:String="alpha=";
			
			var xmlList:XMLList;
			
			if(alpha == true)
			{
				xmlList = XMLList("<"+edgeG+" "
					+edgeFromID		+"\""+	fromID		+"\""+" "
					+edgeToID		+"\""+	toID		+"\""+" "
					+edgeColor		+"\""+	"0x727BFC"	+"\""+" "
					+edgeSim		+"\""+	sim			+"\""+" "
					+edgeAlpha		+"\""+	"0"			+"\""+" "
					+"/>");
			}
			else
			{
				xmlList = XMLList("<"+edgeG+" "
					+edgeFromID		+"\""+	fromID		+"\""+" "
					+edgeToID		+"\""+	toID		+"\""+" "
					+edgeColor		+"\""+	"0x727BFC"	+"\""+" "
					+edgeSim		+"\""+	sim			+"\""+" "
					+"/>");
			}
			
			return xmlList;	
		}
		
		public static function createTooltipDesc(authorName:String, imgUrl:String, orgName:String,publicationCount:Object,h_Index:Object,g_Index:Object, desc:String):String
		{
			var tooltipDesc:String = "";

			tooltipDesc += "&#60;img src='"+ imgUrl +"' width='55' height='55' hspace='3' vspace='3'&#47;&#62;";            
			tooltipDesc += "&#60;font color='#D74D4B' size='+4'&#62;&#60;b&#62;"+ authorName +"&#60;&#47;b&#62;&#60;&#47;font&#62;&#13;";
			tooltipDesc += "Org: "+ orgName + "&#13;" + "Publication: " +publicationCount + " | h-index: " + h_Index + " | g-index: " + g_Index + "&#13;&#13;";
			tooltipDesc += "Interested: " + desc;
			
			return tooltipDesc;
		}
		
		public static function arrayCollectionSort(ar:ArrayCollection, fieldName:String, isNumeric:Boolean):void 
		{
			var dataSortField:SortField = new SortField();
			dataSortField.name = fieldName;
			dataSortField.numeric = isNumeric;
			dataSortField.descending = true;
			var numericDataSort:Sort = new Sort();
			numericDataSort.fields = [dataSortField];
			ar.sort = numericDataSort;
			ar.refresh();
		}
	}
}