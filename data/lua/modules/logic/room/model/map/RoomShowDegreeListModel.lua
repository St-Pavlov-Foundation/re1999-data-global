module("modules.logic.room.model.map.RoomShowDegreeListModel", package.seeall)

slot0 = class("RoomShowDegreeListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.setShowDegreeList(slot0, slot1)
	slot3 = {}
	slot4 = {
		count = 0,
		degree = 0
	}
	slot6 = slot0:getById(-1001) or RoomShowDegreeMO.New()

	slot6:init(slot5, 1)
	table.insert({}, slot6)

	for slot12, slot13 in ipairs(RoomMapBlockModel.instance:getFullBlockMOList()) do
		if slot13.blockState == RoomBlockEnum.BlockState.Map or slot13.blockState == RoomBlockEnum.BlockState.Revert or slot1 and slot13.blockState == RoomBlockEnum.BlockState.Temp then
			slot6.degree = slot6.degree + (RoomConfig.instance:getPackageConfigByBlockId(slot13.blockId) and slot14.blockBuildDegree or 0)
			slot6.count = slot6.count + (slot14 and 1 or 0)
		end
	end

	slot6.degree = slot6.degree + RoomBlockEnum.InitBlockDegreeValue

	for slot13, slot14 in ipairs(RoomMapBuildingModel.instance:getList()) do
		if slot14.buildingState == RoomBuildingEnum.BuildingState.Map or slot14.buildingState == RoomBuildingEnum.BuildingState.Revert or slot1 and slot14.buildingState == RoomBuildingEnum.BuildingState.Temp then
			if not slot3[slot14.buildingId] then
				slot15 = slot0:getById(slot14.buildingId) or RoomShowDegreeMO.New()

				slot15:init(slot14.buildingId, 2, slot14.config.name)

				slot3[slot14.buildingId] = slot15

				table.insert(slot2, slot15)
			end

			slot15.count = slot15.count + 1
			slot15.degree = slot15.degree + slot14.config.buildDegree
		end
	end

	table.sort(slot2, slot0._sortFunction)
	slot0:setList(slot2)
end

function slot0._sortFunction(slot0, slot1)
	if slot0.degreeType ~= slot1.degreeType then
		return slot0.degreeType < slot1.degreeType
	end

	if slot0.degree ~= slot1.degree then
		return slot1.degree < slot0.degree
	end
end

slot0.instance = slot0.New()

return slot0
