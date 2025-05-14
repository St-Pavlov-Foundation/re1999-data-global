module("modules.logic.explore.controller.trigger.ExploreTriggerAward", package.seeall)

local var_0_0 = class("ExploreTriggerAward", ExploreTriggerBase)

function var_0_0.handle(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = tonumber(arg_1_1) or 0

	ExploreSimpleModel.instance:setBonusIsGet(ExploreModel.instance:getMapId(), var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
