module("modules.logic.explore.controller.steps.ExploreResetBeginStep", package.seeall)

local var_0_0 = class("ExploreResetBeginStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreModel.instance.isReseting = true

	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Reset)
	ViewMgr.instance:openView(ViewName.ExploreBlackView)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
end

function var_0_0.onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.ExploreBlackView then
		TaskDispatcher.runDelay(arg_2_0.onDone, arg_2_0, 0.2)
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)
	end
end

function var_0_0.onDestory(arg_3_0)
	var_0_0.super.onDestory(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.onDone, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0.onOpenViewFinish, arg_3_0)
end

return var_0_0
