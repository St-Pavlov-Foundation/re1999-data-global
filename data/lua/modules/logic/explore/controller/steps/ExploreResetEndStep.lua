module("modules.logic.explore.controller.steps.ExploreResetEndStep", package.seeall)

local var_0_0 = class("ExploreResetEndStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	TaskDispatcher.runDelay(arg_1_0.onDone, arg_1_0, 1)
end

function var_0_0.onDestory(arg_2_0)
	var_0_0.super.onDestory(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.onDone, arg_2_0)

	ExploreModel.instance.isReseting = false

	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Reset)
end

return var_0_0
