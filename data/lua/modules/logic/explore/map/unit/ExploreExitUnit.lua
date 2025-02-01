module("modules.logic.explore.map.unit.ExploreExitUnit", package.seeall)

slot0 = class("ExploreExitUnit", ExploreBaseDisplayUnit)

function slot0.canTrigger(slot0)
	if not slot0.mo:isInteractActiveState() then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

return slot0
