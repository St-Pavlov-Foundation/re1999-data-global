module("modules.logic.explore.map.unit.ExploreIlluminantUnit", package.seeall)

slot0 = class("ExploreIlluminantUnit", ExploreBaseDisplayUnit)

function slot0.onEnter(slot0)
	slot0:updatePrism()
	uv0.super.onEnter(slot0)
end

function slot0.onExit(slot0)
	slot0:updatePrism()
end

function slot0.updatePrism(slot0)
	if not ExploreController.instance:getMapLight():isInitDone() then
		return
	end

	slot1:beginCheckStatusChange()

	for slot6, slot7 in pairs(ExploreController.instance:getMap():getUnitByPos(slot0.nodePos)) do
		if slot7.mo:isInteractEnabled() and ExploreEnum.PrismTypes[slot7:getUnitType()] then
			slot7:onBallLightChange()
		end
	end

	slot1:endCheckStatus()
end

return slot0
