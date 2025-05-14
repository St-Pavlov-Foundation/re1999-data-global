module("modules.logic.explore.model.mo.unit.ExploreWaitActiveAnimUnitMO", package.seeall)

local var_0_0 = class("ExploreWaitActiveAnimUnitMO", ExploreBaseUnitMO)

function var_0_0.activeStateChange(arg_1_0, arg_1_1)
	return
end

function var_0_0.checkActiveCount(arg_2_0)
	if not arg_2_0._countSource then
		return
	end

	for iter_2_0, iter_2_1 in pairs(arg_2_0._countSource) do
		if arg_2_0:isInteractActiveState() then
			ExploreCounterModel.instance:add(iter_2_1, arg_2_0.id)
		else
			ExploreCounterModel.instance:reduce(iter_2_1, arg_2_0.id)
		end
	end
end

return var_0_0
