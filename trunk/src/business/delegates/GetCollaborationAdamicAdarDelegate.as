package business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class GetCollaborationAdamicAdarDelegate
	{
		private var _locator:ServiceLocator = ServiceLocator.getInstance();
		private var _service:HTTPService;
		private var _responder:IResponder;
		
		public function GetCollaborationAdamicAdarDelegate(responder : IResponder)
		{
			_service = _locator.getHTTPService("getCollaborationAdamicAdar");
			_responder = responder;
		}
		
		public function getCollaboration(authorID:int):void
		{
			var params : Object = new Object();
			params["authorid"] = authorID;
			var token:AsyncToken = _service.send(params);
			token.addResponder(_responder);
		}
	}
}