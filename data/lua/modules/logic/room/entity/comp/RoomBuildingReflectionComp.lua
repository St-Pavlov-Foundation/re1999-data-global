module("modules.logic.room.entity.comp.RoomBuildingReflectionComp", package.seeall)

slot0 = class("RoomBuildingReflectionComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot2 = slot0:getMO()
	slot0._isReflection = slot0:_checkReflection()
end

function slot0.addEventListeners(slot0)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, slot0._onDropBuildingDown, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, slot0._onDropBuildingDown, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

function slot0._onDropBuildingDown(slot0)
	slot0:refreshReflection()
end

function slot0.refreshReflection(slot0)
	if slot0._isReflection ~= slot0:_checkReflection() then
		slot0._isReflection = slot1

		slot0:_updateReflection()
	end
end

function slot0._updateReflection(slot0)
	if slot0.entity.effect:getGameObjectsByName(slot0._effectKey, RoomEnum.EntityChildKey.ReflerctionGOKey) and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			gohelper.setActive(slot6, slot0._isReflection)
		end
	end
end

function slot0._checkReflection(slot0)
	if slot0.entity.id == RoomBuildingController.instance:isPressBuilding() then
		return false
	end

	slot1, slot2 = slot0:_getOccupyDict()

	if not slot1 then
		return false
	end

	for slot7, slot8 in ipairs(slot2) do
		if RoomMapBlockModel.instance:getBlockMO(slot8.x, slot8.y) and slot9:isInMapBlock() and slot9:hasRiver() then
			return true
		end
	end

	return false
end

function slot0._getOccupyDict(slot0)
	return slot0.entity:getOccupyDict()
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)

		slot0:_updateReflection()
	end
end

return slot0
