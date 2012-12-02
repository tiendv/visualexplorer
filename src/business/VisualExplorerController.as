package business
{
	import business.commands.GetCollaborationCommand;
	import business.commands.SearchAuthorCommand;
	import business.delegates.GetCollaboration;
	import business.events.GetCollaborationEvent;
	import business.events.SearchAuthorEvent;
	
	import com.adobe.cairngorm.control.FrontController;

	public class VisualExplorerController extends FrontController
	{
		public function VisualExplorerController()
		{
			super();
			addCommand(SearchAuthorEvent.EVENT_ID,SearchAuthorCommand);
			addCommand(GetCollaborationEvent.EVENT_ID,GetCollaborationCommand);
		}
	}
}