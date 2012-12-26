package business.commands
{
	import business.delegates.GetAuthorDelegate;
	import business.events.GetAuthorEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.ModelLocator;
	
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueobjects.AuthorOrgObject;
	
	public class GetAuthorRightCommand implements ICommand
	{
		private var _model :models.ModelLocator = models.ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var authorID:int = (event as GetAuthorEvent).authorID;
			var responder:Responder = new mx.rpc.Responder(onGetAuthor,onFailed);
			var delegate:GetAuthorDelegate = new GetAuthorDelegate(responder);
			delegate.getAuthor(authorID);
		}
		
		public function onGetAuthor(event:ResultEvent):void
		{
			_model.searchedAuthorsRight.removeAll();
			
			if (event.result.authorOrgObject != null)
			{
				var authorOrgObject:AuthorOrgObject = new AuthorOrgObject();
				var object:Object = event.result.authorOrgObject;
				
				authorOrgObject.authorID = object.authorID;
				authorOrgObject.authorName = object.authorName;
				authorOrgObject.imgUrl = object.imgUrl;
				authorOrgObject.orgName = object.orgName;
				_model.searchedAuthorsRight.addItem(authorOrgObject);
			}
			ModelLocator.getInstance().waitingSearchLeft = false;
		}
		
		public function onFailed(event:FaultEvent):void
		{
			ModelLocator.getInstance().waitingSearchLeft = false;
		}
	}
}