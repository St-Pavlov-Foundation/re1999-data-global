module("modules.logic.explore.controller.steps.ExploreCheckCounterStep", package.seeall)

local var_0_0 = class("ExploreCheckCounterStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreController.instance:getMap():getUnit(arg_1_0._data.id).mo:checkActiveCount()
	arg_1_0:onDone()
end

return var_0_0
