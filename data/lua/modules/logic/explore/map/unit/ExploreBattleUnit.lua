module("modules.logic.explore.map.unit.ExploreBattleUnit", package.seeall)

slot0 = class("ExploreBattleUnit", ExploreBaseDisplayUnit)

function slot0.onResLoaded(slot0)
	uv0.super.onResLoaded(slot0)

	if slot0.mo:getInteractInfoMO().statusInfo.success == 1 then
		ExploreRpc.instance:sendExploreInteractRequest(slot0.id)
	end
end

function slot0.canTrigger(slot0)
	if not slot0.mo:isInteractActiveState() then
		return false
	end

	if slot0.mo:getInteractInfoMO().statusInfo.success == 1 then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

return slot0
