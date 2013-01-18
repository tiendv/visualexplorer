package business.commands
{
	import business.delegates.GetAuthorDelegate;
	import business.events.GetAuthorEvent;
	
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.external.ExternalInterface;
	
	import models.ModelLocator;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import valueobjects.AuthorObject;

	public class GetAuthorCommand implements ICommand
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
			_model.searchedAuthors.removeAll();
			
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
				
				_model.searchedAuthors.addItem(author);
				
				//set title
				var title:Object = new Object();
				title.authorID = author.authorID;
				title.authorName = author.authorName;
				setTitle(title);
			}
			ModelLocator.getInstance().waitingSearchLeft = false;
		}
		
		public function onFailed(event:FaultEvent):void
		{
			ModelLocator.getInstance().waitingSearchLeft = false;
		}
		
		public function setTitle(data:Object):void{				
			var s:String;
			if(ExternalInterface.available){
				var wrapperFunction:String = "receiveComplexDataTypes";
				s = ExternalInterface.call(wrapperFunction,data);
			}else{
				s = "wrapper not available";
			}
			trace(s);
		}
	}
}