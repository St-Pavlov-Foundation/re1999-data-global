module("modules.logic.room.model.transport.RoomTransportBuildingListModel", package.seeall)

slot0 = class("RoomTransportBuildingListModel", ListScrollModel)

function slot0.setBuildingList(slot0)
	slot2 = {
		[slot10] = true
	}

	for slot7 = 1, #RoomModel.instance:getBuildingInfoList() do
		if slot0:_checkInfoShow(slot8.buildingId or slot8.defineId, RoomMapBuildingModel.instance:getBuildingMOById(slot3[slot7].uid) and true or false) then
			slot11 = slot9
			slot11 = RoomShowBuildingMO.New()

			slot11:init(slot8)

			slot11.use = slot9

			slot11:add(slot8.uid, slot8.level)
			table.insert({}, slot11)
		end
	end

	slot5 = {
		use = false,
		isNeedToBuy = true,
		uid = -slot11,
		buildingId = slot11
	}

	for slot9 = 1, #RoomConfig.instance:getBuildingConfigList() do
		slot10 = slot4[slot9]
		slot11 = slot10.id

		if slot10.buildingType == RoomBuildingEnum.BuildingType.Transport and not slot2[slot11] then
			slot2[slot11] = true
			slot12 = RoomShowBuildingMO.New()

			slot12:init(slot5)
			slot12:add(slot5.uid, 0)
			table.insert(slot1, slot12)
		end
	end

	slot0:setList(slot1)
	slot0:_refreshSelect()
end

function slot0.getSelect(slot0)
	return slot0._selectId
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._scrollViews) do
		slot6:setSelect(slot0:getById(slot0._selectId))
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectId = slot1

	slot0:_refreshSelect()
end

function slot0.getSelectMO(slot0)
	return slot0:getById(slot0._selectId)
end

function slot0._checkInfoShow(slot0, slot1, slot2)
	if RoomConfig.instance:getBuildingConfig(slot1) and slot3.buildingType == RoomBuildingEnum.BuildingType.Transport then
		return true
	end

	return false
end

slot0.instance = slot0.New()

return slot0
