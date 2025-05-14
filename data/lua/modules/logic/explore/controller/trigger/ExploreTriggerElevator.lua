module("modules.logic.explore.controller.trigger.ExploreTriggerElevator", package.seeall)

local var_0_0 = class("ExploreTriggerElevator", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = string.splitToNumber(arg_1_1, "#")
	local var_1_1 = var_1_0[1]

	if var_1_1 ~= 0 then
		ExploreMapTriggerController.instance:getMap():getUnit(var_1_1):movingElevator(var_1_0[2], var_1_0[3])
	end

	arg_1_0:onStepDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
