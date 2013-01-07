package business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.core.RuntimeDPIProvider;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class ViewCoPathGraphDelegate
	{
		private var _locator:ServiceLocator = ServiceLocator.getInstance();
		private var _service:HTTPService;
		private var _responder:IResponder;

		public function ViewCoPathGraphDelegate(responder : IResponder)
		{
			_service = _locator.getHTTPService("viewCoPath");
			_responder = responder;
		}
		
		public function viewCoPath(authorID:int, authorID1:int):void
		{
			var params : Object = new Object();
			params["authorid"] = authorID;
			params["authorid1"] = authorID1;
			var token:AsyncToken = _service.send(params);
			token.addResponder(_responder);
		}
	}
}