module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114StopStoryWork", package.seeall)

local var_0_0 = class("Activity114StopStoryWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0)
	if ViewMgr.instance:isOpen(ViewName.StoryView) then
		Activity114Controller.instance:markStoryWillFinish()
	end

	StoryController.instance:dispatchEvent(StoryEvent.AllStepFinished, true)
	arg_1_0:onDone(true)
end

return var_0_0
