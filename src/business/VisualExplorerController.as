package business
{
	import business.commands.GetAuthorCommand;
	import business.commands.GetAuthorRightCommand;
	import business.commands.GetCitationGraphCommand;
	import business.commands.GetCollaborationAdamicAdarCommand;
	import business.commands.GetCollaborationCommand;
	import business.commands.GetCollaborationCosineCommand;
	import business.commands.GetCollaborationJaccardCommand;
	import business.commands.SearchAuthorCommand;
	import business.commands.SearchAuthorRightCommand;
	import business.commands.ViewCoAuthorGraphCommand;
	import business.commands.ViewCoPathGraphCommand;
	import business.events.GetAuthorEvent;
	import business.events.GetAuthorRightEvent;
	import business.events.GetCitationGraphEvent;
	import business.events.GetCollaborationAdamicAdarEvent;
	import business.events.GetCollaborationCosineEvent;
	import business.events.GetCollaborationEvent;
	import business.events.GetCollaborationJaccardEvent;
	import business.events.SearchAuthorEvent;
	import business.events.SearchAuthorRightEvent;
	import business.events.ViewCoAuthorGraphEvent;
	import business.events.ViewCoPathGraphEvent;
	
	import com.adobe.cairngorm.control.FrontController;

	public class VisualExplorerController extends FrontController
	{
		public function VisualExplorerController()
		{
			super();
			addCommand(SearchAuthorEvent.EVENT_ID,SearchAuthorCommand);
			addCommand(GetCollaborationEvent.EVENT_ID,GetCollaborationCommand);
			addCommand(GetCollaborationJaccardEvent.EVENT_ID,GetCollaborationJaccardCommand);
			addCommand(GetCollaborationCosineEvent.EVENT_ID,GetCollaborationCosineCommand);
			addCommand(GetCollaborationAdamicAdarEvent.EVENT_ID,GetCollaborationAdamicAdarCommand);
			addCommand(ViewCoAuthorGraphEvent.EVENT_ID,ViewCoAuthorGraphCommand);
 			addCommand(SearchAuthorRightEvent.EVENT_ID,SearchAuthorRightCommand);
			addCommand(GetAuthorEvent.EVENT_ID,GetAuthorCommand);
			addCommand(GetAuthorRightEvent.EVENT_ID,GetAuthorRightCommand);
			addCommand(ViewCoPathGraphEvent.EVENT_ID,ViewCoPathGraphCommand);
			addCommand(GetCitationGraphEvent.EVENT_ID,GetCitationGraphCommand);
		}
	}
}