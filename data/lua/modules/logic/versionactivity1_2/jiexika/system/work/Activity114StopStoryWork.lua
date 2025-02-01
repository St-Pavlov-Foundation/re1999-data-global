module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114StopStoryWork", package.seeall)

slot0 = class("Activity114StopStoryWork", Activity114BaseWork)

function slot0.onStart(slot0)
	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		Activity114Controller.instance:markStoryWillFinish()
	end

	StoryController.instance:dispatchEvent(StoryEvent.AllStepFinished, true)
	slot0:onDone(true)
end

return slot0
