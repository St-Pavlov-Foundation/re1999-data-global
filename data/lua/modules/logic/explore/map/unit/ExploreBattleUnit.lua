module("modules.logic.explore.map.unit.ExploreBattleUnit", package.seeall)

local var_0_0 = class("ExploreBattleUnit", ExploreBaseDisplayUnit)

function var_0_0.onResLoaded(arg_1_0)
	var_0_0.super.onResLoaded(arg_1_0)

	if arg_1_0.mo:getInteractInfoMO().statusInfo.success == 1 then
		ExploreRpc.instance:sendExploreInteractRequest(arg_1_0.id)
	end
end

function var_0_0.canTrigger(arg_2_0)
	if not arg_2_0.mo:isInteractActiveState() then
		return false
	end

	if arg_2_0.mo:getInteractInfoMO().statusInfo.success == 1 then
		return false
	end

	return var_0_0.super.canTrigger(arg_2_0)
end

return var_0_0
