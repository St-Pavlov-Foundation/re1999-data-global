module("modules.logic.explore.map.ExploreMapFOVComp", package.seeall)

slot0 = class("ExploreMapFOVComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._showRange = 8
	slot0._hideRange = 12
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnCharacterNodeChange, slot0._onCharacterNodeChange, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnUnitNodeChange, slot0._onUnitNodeChange, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.SetFovTargetPos, slot0._setFovTargetPos, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnCharacterNodeChange, slot0._onCharacterNodeChange, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnUnitNodeChange, slot0._onUnitNodeChange, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.SetFovTargetPos, slot0._setFovTargetPos, slot0)
end

function slot0.setMap(slot0, slot1)
	slot0._map = slot1

	slot0:_onCharacterNodeChange()
end

function slot0._onCharacterNodeChange(slot0, slot1, slot2, slot3)
	slot0:_checkFov()
end

function slot0._setFovTargetPos(slot0, slot1)
	slot0._targetPos = slot1

	slot0:_checkFov()
end

function slot0._checkFov(slot0)
	if not slot0._map:getAllUnit() then
		return
	end

	slot2 = slot0._map:getHeroPos()

	if slot0._targetPos then
		slot2 = ExploreHelper.posToTile(slot0._targetPos)
	end

	for slot6, slot7 in pairs(slot1) do
		slot0:_checkUnitInFov(slot7, slot2)
	end
end

function slot0._onUnitNodeChange(slot0, slot1, slot2, slot3)
	slot0:_checkUnitInFov(slot1, slot0._targetPos or slot0._map:getHeroPos())
end

function slot0._checkUnitInFov(slot0, slot1, slot2)
	slot3 = slot1:isInFOV()

	if ExploreModel.instance:isUseItemOrUnit(slot1.id) then
		if not slot3 then
			slot1:setInFOV(true)
		end

		return
	end

	if slot3 then
		if slot0._hideRange <= ExploreHelper.getDistanceRound(slot2, slot1.nodePos) then
			slot1:setInFOV(false)
		end
	elseif slot5 <= slot0._showRange then
		slot1:setInFOV(true)
	end
end

function slot0.onDestroy(slot0)
	slot0._map = nil
	slot0._targetPos = nil
end

return slot0
