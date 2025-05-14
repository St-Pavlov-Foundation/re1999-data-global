module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114WaitStoryCloseEndWork", package.seeall)

local var_0_0 = class("Activity114WaitStoryCloseEndWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.StoryHeroView) then
		ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_2_0)
	if ViewMgr.instance:isOpen(ViewName.StoryView) or ViewMgr.instance:isOpen(ViewName.StoryHeroView) then
		return
	end

	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.StoryFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

return var_0_0
