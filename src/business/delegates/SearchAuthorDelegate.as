package business.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.http.HTTPService;

	public class SearchAuthorDelegate
	{
		private var _locator:ServiceLocator = ServiceLocator.getInstance();
		private var _service:HTTPService;
		private var _responder : IResponder;
		
		public function SearchAuthorDelegate(responder : IResponder)
		{
			_service = _locator.getHTTPService("searchAuthor");
			_responder = responder;
		}
		
		public function searchAuthor(authorName:String):void
		{
			var params : Object = new Object();
			params["authorname"] = authorName;
			var token:AsyncToken = _service.send(params);
			token.addResponder(_responder);
		}
	}
}