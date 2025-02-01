module("modules.logic.explore.map.unit.ExploreLightBallUnit", package.seeall)

slot0 = class("ExploreLightBallUnit", ExploreItemUnit)

function slot0.onEnter(slot0)
	slot0:updateRoundPrism(slot0.nodePos)
	uv0.super.onEnter(slot0)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreLightBallEnterExit)
end

function slot0.onExit(slot0)
	slot0:updateRoundPrism(slot0.nodePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.ExploreLightBallEnterExit)
end

function slot0.onNodeChange(slot0, slot1, slot2)
	if slot1 then
		slot0:updateRoundPrism(slot1)
		slot0:updateRoundPrism(slot2)
	end
end

function slot0.updateRoundPrism(slot0, slot1)
	if not ExploreController.instance:getMapLight():isInitDone() then
		return
	end

	slot2:beginCheckStatusChange()

	for slot7 = 0, 270, 90 do
		slot8 = ExploreHelper.dirToXY(slot7)

		for slot13, slot14 in pairs(ExploreController.instance:getMap():getUnitByPos({
			x = 0,
			y = 0,
			x = slot1.x + slot8.x,
			y = slot1.y + slot8.y
		})) do
			if slot14.mo:isInteractEnabled() and ExploreEnum.PrismTypes[slot14:getUnitType()] then
				slot14:onBallLightChange()
			end
		end
	end

	slot2:endCheckStatus()
end

return slot0
