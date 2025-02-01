module("modules.logic.room.model.map.RoomMapInteractionModel", package.seeall)

slot0 = class("RoomMapInteractionModel", BaseModel)

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

function slot0.init(slot0)
	slot0:clear()
end

function slot0._clearData(slot0)
	slot0._buildingInteraction = {}
	slot0._buildingHexpointIndexDic = {}

	if slot0._builidngInteractionModel then
		slot0._builidngInteractionModel:clear()
	else
		slot0._builidngInteractionModel = BaseModel.New()
	end
end

function slot0.initInteraction(slot0)
	slot0:_clearData()

	slot0.hexPointRanges = HexPoint.Zero:getInRanges(2)

	for slot5 = 1, #RoomConfig.instance:getCharacterInteractionConfigList() do
		if slot1[slot5].behaviour == RoomCharacterEnum.InteractionType.Building then
			slot0:_addInteractionBuilding(slot6)
		end
	end
end

function slot0.getBuildingRangeIndexList(slot0, slot1)
	return slot0._buildingHexpointIndexDic[slot1]
end

function slot0._addInteractionBuilding(slot0, slot1)
	if slot0:_getBuildingMOListByBuildingId(slot1.buildingId) and #slot2 > 0 then
		slot0._buildingInteraction[slot1.id] = {}

		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3, slot8.id)

			if not slot0._buildingHexpointIndexDic[slot8.id] then
				slot0._buildingHexpointIndexDic[slot8.id] = slot0:_getBuildingRangeIndex(slot8.buildingId, slot8.hexPoint, slot8.rotate, slot0.hexPointRanges)
			end
		end

		slot4 = RoomInteractionMO.New()

		slot4:init(slot1.id, slot1.id, slot3)
		slot0._builidngInteractionModel:addAtLast(slot4)
	end
end

function slot0._getBuildingMOListByBuildingId(slot0, slot1)
	slot2 = {}

	for slot7 = 1, #RoomMapBuildingModel.instance:getList() do
		if slot3[slot7].buildingId == slot1 then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0._getBuildingRangeIndex(slot0, slot1, slot2, slot3, slot4)
	slot5 = {}
	slot6 = RoomResourceModel.instance

	for slot11, slot12 in pairs(RoomBuildingHelper.getOccupyDict(slot1, slot2, slot3)) do
		for slot16, slot17 in pairs(slot12) do
			for slot21 = 1, #slot4 do
				slot22 = slot4[slot21]

				if not tabletool.indexOf(slot5, slot6:getIndexByXY(slot11 + slot22.x, slot22.y + slot16)) then
					table.insert(slot5, slot25)
				end
			end
		end
	end

	return slot5
end

function slot0.getBuildingInteractionMOList(slot0)
	return slot0._builidngInteractionModel:getList()
end

function slot0.getBuildingInteractionMO(slot0, slot1)
	return slot0._builidngInteractionModel:getById(slot1)
end

slot0.instance = slot0.New()

return slot0
