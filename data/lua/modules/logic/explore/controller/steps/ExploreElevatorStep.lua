module("modules.logic.explore.controller.steps.ExploreElevatorStep", package.seeall)

local var_0_0 = class("ExploreElevatorStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = ExploreModel.instance:getInteractInfo(arg_1_0._data.interactId)

	if var_1_0 then
		var_1_0.statusInfo.height = arg_1_0._data.height
	end

	arg_1_0:onDone()
end

return var_0_0
