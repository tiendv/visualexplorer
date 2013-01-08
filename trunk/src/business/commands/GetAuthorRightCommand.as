package business.commands
{
	import business.delegates.GetAuthorDelegate;
	import business.events.GetAuthorEvent;
	import business.events.GetAuthorRightEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueobjects.AuthorObject;
	
	public class GetAuthorRightCommand implements ICommand
	{
		private var _model :models.ModelLocator = models.ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{
			var authorID:int = (event as GetAuthorRightEvent).authorID;
			var responder:Responder = new mx.rpc.Responder(onGetAuthor,onFailed);
			var delegate:GetAuthorDelegate = new GetAuthorDelegate(responder);
			delegate.getAuthor(authorID);
		}
		
		public function onGetAuthor(event:ResultEvent):void
		{
			_model.searchedAuthorsRight.removeAll();
			
			if (event.result.author != null)
			{
				var author:AuthorObject = new AuthorObject();
				var object:Object = event.result.author;
				
				author.authorID = object.authorID;
				author.authorName = object.authorName;
				author.imgUrl = object.imgUrl;
				author.orgName = object.orgName;
				author.g_Index = object.g_Index;
				author.h_Index = object.h_Index;
				author.publicationCount = object.publicationCount;
				var collection:ArrayCollection = object.listSubdomain as ArrayCollection;
				if(collection == null){
					collection = new ArrayCollection();
					collection.addItem(object.listSubdomain);
				}
				_model.searchedAuthorsRight.addItem(author);
			}
			ModelLocator.getInstance().waitingSearchRight = false;
		}
		
		public function onFailed(event:FaultEvent):void
		{
			ModelLocator.getInstance().waitingSearchRight = false;
		}
	}
}