package business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.core.RuntimeDPIProvider;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;
	
	public class GetCitationGraphDelegate
	{
		private var _locator:ServiceLocator = ServiceLocator.getInstance();
		private var _service:HTTPService;
		private var _responder:IResponder;
		
		public function GetCitationGraphDelegate(responder : IResponder)
		{
			_service = _locator.getHTTPService("citationGraph");
			_responder = responder;
		}
		
		public function viewCitation(authorID:int):void
		{
			var params : Object = new Object();
			params["id"] = authorID;
			var token:AsyncToken = _service.send(params);
			token.addResponder(_responder);
		}
	}
}