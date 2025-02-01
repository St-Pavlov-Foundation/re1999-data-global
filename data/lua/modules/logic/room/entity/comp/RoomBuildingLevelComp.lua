module("modules.logic.room.entity.comp.RoomBuildingLevelComp", package.seeall)

slot0 = class("RoomBuildingLevelComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
	slot0._levelPathDict = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._level = slot0:_getLevel()
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUpPush, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUpPush, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

function slot0._onBuildingLevelUpPush(slot0)
	slot0:refreshLevel()
end

function slot0.refreshLevel(slot0)
	if slot0._level ~= slot0:_getLevel() then
		slot0._level = slot1

		slot0.entity:refreshBuilding()
		slot0:_updateLevel()
	end
end

function slot0._updateLevel(slot0)
	if not slot0:getMO() then
		return
	end

	if not slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) then
		return
	end

	for slot7, slot8 in pairs(RoomConfig.instance:getLevelGroupLevelDict(slot1.buildingId)) do
		if not slot0._levelPathDict[slot7] then
			slot0._levelPathDict[slot7] = string.format(RoomEnum.EffectPath.BuildingLevelPath, slot7)
		end

		if slot2:getGameObjectByPath(slot0._effectKey, slot0._levelPathDict[slot7]) then
			gohelper.setActive(slot9, slot7 <= slot0._level)
		end
	end
end

function slot0._getLevel(slot0)
	return slot0:getMO().level or 0
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)
		slot0._level = slot0:_getLevel()

		slot0:_updateLevel()
	end
end

return slot0
