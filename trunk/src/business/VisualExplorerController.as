package business
{
	import business.commands.GetCollaborationCommand;
	import business.commands.SearchAuthorCommand;
	import business.commands.TestCommand;
	import business.commands.ViewCoAuthorGraphCommand;
	import business.events.GetCollaborationEvent;
	import business.events.SearchAuthorEvent;
	import business.events.TestEvent;
	import business.events.ViewCoAuthorGraphEvent;
	
	import com.adobe.cairngorm.control.FrontController;

	public class VisualExplorerController extends FrontController
	{
		public function VisualExplorerController()
		{
			super();
			addCommand(SearchAuthorEvent.EVENT_ID,SearchAuthorCommand);
			addCommand(GetCollaborationEvent.EVENT_ID,GetCollaborationCommand);
			addCommand(ViewCoAuthorGraphEvent.EVENT_ID,ViewCoAuthorGraphCommand);
			addCommand(TestEvent.EVENT_ID,TestCommand);
		}
	}
}