package business.commands
{
	import business.delegates.ViewCoPathGraphDelegate;
	import business.events.ViewCoPathGraphEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.GraphLocator;
	
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

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

			GraphLocator.getInstance().waiting = false;
		}
		
		private function onFailed(event:FaultEvent):void
		{
			GraphLocator.getInstance().waiting = false;
		}
	}
}