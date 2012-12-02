package business.commands
{
	import business.delegates.SearchAuthorDelegate;
	import business.events.SearchAuthorEvent;
	
	import com.adobe.cairngorm.business.Responder;
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import models.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueobjects.AuthorOrgObject;

	public class SearchAuthorCommand implements ICommand
	{
		private var _model :ModelLocator = ModelLocator.getInstance();
		
		public function execute(event:CairngormEvent):void
		{			
			var authorName:String = (event as SearchAuthorEvent).authorName;
			var responder:mx.rpc.Responder = new mx.rpc.Responder(onSearchAuthor,onFailed);
			var delegate:SearchAuthorDelegate = new SearchAuthorDelegate(responder);
			delegate.searchAuthor(authorName);
		}
		
		private function onSearchAuthor(event:ResultEvent):void
		{
			Alert.show("ResultEvent Callback","Alert");
			_model.searchedAuthors.removeAll();
			if (event.result.authorOrgObjects != null)
			{
				var authorCollection : ArrayCollection = event.result.authorOrgObjects.authorOrgObject;
				for(var i:int=0;i<authorCollection.length;i++)
				{
					var authorOrgObject:AuthorOrgObject = new AuthorOrgObject();
					var object:Object = authorCollection.getItemAt(i); 
					authorOrgObject.authorID = object.authorID;
					authorOrgObject.authorName = object.authorName;
					authorOrgObject.imgUrl = object.imgUrl;
					authorOrgObject.orgName = object.orgName;
					_model.searchedAuthors.addItem(authorOrgObject);
				}
			}
		}
		
		private function onFailed(event:FaultEvent):void
		{
			Alert.show("FaultEvent Callback","Alert");
		}
	}
}