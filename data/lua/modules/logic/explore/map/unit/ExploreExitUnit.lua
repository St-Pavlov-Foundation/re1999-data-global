module("modules.logic.explore.map.unit.ExploreExitUnit", package.seeall)

local var_0_0 = class("ExploreExitUnit", ExploreBaseDisplayUnit)

function var_0_0.canTrigger(arg_1_0)
	if not arg_1_0.mo:isInteractActiveState() then
		return false
	end

	return var_0_0.super.canTrigger(arg_1_0)
end

return var_0_0
