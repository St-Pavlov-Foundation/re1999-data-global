module("modules.logic.explore.controller.steps.ExploreDelUnitStep", package.seeall)

local var_0_0 = class("ExploreDelUnitStep", ExploreStepBase)
local var_0_1 = {
	[ExploreEnum.ItemType.Rock] = true
}

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.interact
	local var_1_1 = ExploreController.instance:getMap():getUnit(var_1_0.id, true)

	if var_1_1 then
		ExploreController.instance:removeUnit(var_1_0.id)

		if not ExploreModel.instance.isReseting and var_0_1[var_1_1:getUnitType()] then
			var_1_1:setExitCallback(arg_1_0.onDone, arg_1_0)
		else
			arg_1_0:onDone()
		end
	else
		arg_1_0:onDone()
	end
end

return var_0_0
