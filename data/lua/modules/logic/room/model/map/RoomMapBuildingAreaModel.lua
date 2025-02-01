module("modules.logic.room.model.map.RoomMapBuildingAreaModel", package.seeall)

slot0 = class("RoomMapBuildingAreaModel", BaseModel)

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
	slot0._areaBuildingDict = nil
end

function slot0.init(slot0)
	slot0:clear()
	slot0:refreshBuildingAreaMOList()
end

function slot0.refreshBuildingAreaMOList(slot0)
	slot1 = {}
	slot0._bType2UIdDict = {}

	for slot6, slot7 in ipairs(RoomMapBuildingModel.instance:getBuildingMOList()) do
		if slot7:isBuildingArea() and slot7:isAreaMainBuilding() then
			if not slot0:getById(slot7.uid) then
				RoomMapBuildingAreaMO.New():init(slot7)
			else
				slot8:clearBuildingMOList()
			end

			table.insert(slot1, slot8)

			if slot7.config then
				slot0._bType2UIdDict[slot7.config.buildingType] = slot8.id
			end
		end
	end

	slot0:setList(slot1)
end

function slot0.getTempAreaMO(slot0)
	if not RoomMapBuildingModel.instance:getTempBuildingMO() or not slot1:isBuildingArea() or not slot1:isAreaMainBuilding() then
		return nil
	end

	if not slot0._tempAreaMO then
		slot0._tempAreaMO = RoomMapBuildingAreaMO.New()
	end

	if slot0._tempAreaMO.id ~= slot1.uid or slot0._tempAreaMO.mainBuildingMO ~= slot1 then
		slot0._tempAreaMO:init(slot1)
	end

	return slot0._tempAreaMO
end

function slot0.refreshAreaMOByBType(slot0, slot1)
	slot0:_refreshAreaMOById(slot0._bType2UIdDict[slot1])
end

function slot0.refreshAreaMOByBId(slot0, slot1)
	if RoomConfig.instance:getBuildingConfig(slot1) then
		slot0:refreshAreaMOByBType(slot2.buildingType)
	end
end

function slot0.refreshAreaMOByBUId(slot0, slot1)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot2.config then
		slot0:refreshAreaMOByBType(slot2.config.buildingType)
	end
end

function slot0._refreshAreaMOById(slot0, slot1)
	if slot0:getById(slot1) then
		slot2:clearBuildingMOList()
	end
end

function slot0.getAreaMOByBType(slot0, slot1)
	return slot0:getById(slot0._bType2UIdDict[slot1])
end

function slot0.getAreaMOByBId(slot0, slot1)
	if RoomConfig.instance:getBuildingConfig(slot1) then
		return slot0:getAreaMOByBType(slot2.buildingType)
	end
end

function slot0.getAreaMOByBUId(slot0, slot1)
	if RoomMapBuildingModel.instance:getBuildingMOById(slot1) and slot2.config then
		slot0:getAreaMOByBType(slot2.config.buildingType)
	end
end

function slot0.getBuildingType2AreaMODict(slot0)
	for slot6, slot7 in ipairs(slot0:getList()) do
		-- Nothing
	end

	return {
		[slot7:getBuildingType()] = slot7
	}
end

function slot0.getBuildingUidByType(slot0, slot1)
	return slot0._bType2UIdDict[slot1]
end

function slot0.logTest(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		if slot6.mainBuildingMO then
			slot0:_logByBuildingId(slot7.buildingId, slot6:getRangesHexPointList())
		end
	end
end

function slot0._logByBuildingId(slot0, slot1, slot2)
	if not RoomConfig.instance:getBuildingConfig(slot1) then
		return
	end

	for slot8, slot9 in ipairs(slot2) do
		if slot9 then
			slot4 = string.format("%s (%s,%s)", string.format("name:%s id:%s -->", slot3.name, slot1), slot9.x, slot9.y)
		end
	end

	logNormal(slot4)
end

slot0.instance = slot0.New()

return slot0
