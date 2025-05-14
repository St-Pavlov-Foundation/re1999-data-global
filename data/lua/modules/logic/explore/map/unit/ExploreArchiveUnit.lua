module("modules.logic.explore.map.unit.ExploreArchiveUnit", package.seeall)

local var_0_0 = class("ExploreArchiveUnit", ExploreBaseMoveUnit)

function var_0_0.needInteractAnim(arg_1_0)
	return true
end

function var_0_0.canTrigger(arg_2_0)
	if arg_2_0.mo:isInteractActiveState() then
		return false
	end

	return var_0_0.super.canTrigger(arg_2_0)
end

return var_0_0
