module("modules.logic.explore.controller.steps.ExploreTransferStep", package.seeall)

local var_0_0 = class("ExploreTransferStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreMapModel.instance:updatHeroPos(arg_1_0._data.x, arg_1_0._data.y, 0)
	ExploreHeroTeleportFlow.instance:begin(arg_1_0._data)
	arg_1_0:onDone()
end

return var_0_0
