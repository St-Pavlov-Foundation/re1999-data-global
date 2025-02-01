module("modules.logic.explore.model.mo.ExploreRuneUnitMO", package.seeall)

slot0 = class("ExploreRuneUnitMO", ExploreBaseUnitMO)

function slot0.activeStateChange(slot0, slot1)
end

function slot0.checkActiveCount(slot0)
	if not slot0._countSource then
		return
	end

	for slot4, slot5 in pairs(slot0._countSource) do
		if slot0:isInteractActiveState() then
			ExploreCounterModel.instance:add(slot5, slot0.id)
		else
			ExploreCounterModel.instance:reduce(slot5, slot0.id)
		end
	end
end

return slot0
