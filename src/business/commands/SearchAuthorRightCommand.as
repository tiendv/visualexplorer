package business.commands
{
	import business.delegates.SearchAuthorDelegate;
	import business.events.SearchAuthorRightEvent;
	
	import com.adobe.cairngorm.business.Responder;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueobjects.AuthorObject;
	
	import views.Graph;
	
	public class SearchAuthorRightCommand implements ICommand
	{
		private var _model :ModelLocator = ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{			
			var authorName:String = (event as SearchAuthorRightEvent).authorName;
			var responder:mx.rpc.Responder = new mx.rpc.Responder(onSearchAuthor,onFailed);
			var delegate:SearchAuthorDelegate = new SearchAuthorDelegate(responder);
			delegate.searchAuthor(authorName);
		}
		
		private function onSearchAuthor(event:ResultEvent):void
		{
			_model.searchedAuthorsRight.removeAll();
			
			if (event.result.authors != null)
			{
				var authorCollection : ArrayCollection = event.result.authors.author;
				for(var i:int=0;i<authorCollection.length;i++)
				{
					var author:AuthorObject = new AuthorObject();
					var object:Object = authorCollection.getItemAt(i); 
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
					author.listSubdomain = collection;
 					_model.searchedAuthorsRight.addItem(author);
				}
				
			}
			ModelLocator.getInstance().waitingSearchRight = false;
		}
		
		private function onFailed(event:FaultEvent):void
		{
			ModelLocator.getInstance().waitingSearchRight = false;
		}
	}
}