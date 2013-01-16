package business.commands
{
	import business.delegates.GetCollaborationJaccardDelegate;
	import business.events.GetCollaborationJaccardEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.utils.Dictionary;
	
	import models.GraphLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import utils.GraphUtil;

	public class GetCollaborationJaccardCommand implements ICommand
	{
		public function execute(event:CairngormEvent):void
		{
			var authorID:int = (event as GetCollaborationJaccardEvent).authorID;
			var responder:Responder = new mx.rpc.Responder(onGetCollaboration,onFailed);
			var delegate:GetCollaborationJaccardDelegate = new GetCollaborationJaccardDelegate(responder);
			delegate.getCollaboration(authorID);
		}
		
		private function onGetCollaboration(event:ResultEvent):void
		{//recommend
			var xmldata:XML = <Graph></Graph>;
			var sizeDict:Dictionary = new Dictionary();//id, nodeSize
			var radiusDict:Dictionary = new Dictionary();//id, nodeRadius
			
			
			GraphLocator.getInstance().waiting = false;
		}
		
		private function onFailed(event:FaultEvent):void
		{
			GraphLocator.getInstance().waiting = false;
		}
	}
}