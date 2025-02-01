module("modules.logic.room.model.map.RoomInventoryBuildingModel", package.seeall)

slot0 = class("RoomInventoryBuildingModel", BaseModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0._hasBuildingDict = {}
end

function slot0.initInventory(slot0, slot1)
	slot0:clear()
	slot0:addBuilding(slot1)

	slot3 = RoomConfig.instance:getBuildingConfigList()

	for slot8 = 1, #lua_manufacture_building.configList do
		if RoomConfig.instance:getBuildingConfig(slot2[slot8].id) and not slot0._hasBuildingDict[slot10] then
			slot0._hasBuildingDict[slot10] = true
			slot12 = RoomBuildingMO.New()

			slot12:init({
				use = false,
				uid = -slot10,
				buildingId = slot10,
				buildingState = RoomBuildingEnum.BuildingState.Inventory
			})
			slot0:_addBuildingMO(slot12)
		end
	end
end

function slot0.checkBuildingPut(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getBuildingMOList()) do
		if slot7.buildingId == tonumber(slot1) then
			return RoomBuildingHelper.getRecommendHexPoint(slot7.buildingId) and slot8.hexPoint ~= nil
		end
	end

	return false
end

function slot0.addBuilding(slot0, slot1)
	if not slot1 or #slot1 <= 0 then
		return
	end

	slot0._hasBuildingDict = slot0._hasBuildingDict or {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._hasBuildingDict[slot6.defineId] = true

		if not slot6.use then
			slot8 = RoomBuildingMO.New()

			slot8:init(RoomInfoHelper.serverInfoToBuildingInfo(slot6))

			if slot8.config then
				slot0:_addBuildingMO(slot8)
			end
		end

		slot0:_removeBuildingMOByUId(-slot6.defineId)
	end
end

function slot0._addBuildingMO(slot0, slot1)
	if slot0:getById(slot1.id) then
		slot0:remove(slot2)
	end

	slot0:addAtLast(slot1)
end

function slot0._removeBuildingMO(slot0, slot1)
	slot0:remove(slot1)
end

function slot0._removeBuildingMOByUId(slot0, slot1)
	if slot0:getById(slot1) then
		slot0:remove(slot2)
	end
end

function slot0.placeBuilding(slot0, slot1)
	slot0:_removeBuildingMOByUId(slot1.uid)
end

function slot0.unUseBuilding(slot0, slot1)
	if slot0:getById(slot1.uid) then
		slot2.use = false

		return
	end

	if slot1.use then
		return
	end

	slot4 = RoomBuildingMO.New()

	slot4:init(RoomInfoHelper.serverInfoToBuildingInfo(slot1))
	slot0:_addBuildingMO(slot4)
end

function slot0.getBuildingMOList(slot0)
	return slot0:getList()
end

function slot0.getBuildingMOById(slot0, slot1)
	return slot0:getById(slot1)
end

function slot0.getCount(slot0)
	return slot0:getCount()
end

slot0.instance = slot0.New()

return slot0
