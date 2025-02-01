module("modules.logic.room.model.transport.RoomTransportBuildingSkinListModel", package.seeall)

slot0 = class("RoomTransportBuildingSkinListModel", ListScrollModel)

function slot0.setBuildingUid(slot0, slot1)
	if RoomModel.instance:getBuildingInfoByBuildingUid(slot1) then
		slot0:setBuildingId(slot2.buildingId or slot2.defineId)
	else
		slot0:setList({})
	end
end

function slot0.setBuildingId(slot0, slot1)
	slot2 = {}
	slot3 = RoomConfig.instance:getBuildingConfig(slot1)

	if RoomConfig.instance:getBuildingSkinList(slot1) then
		for slot8, slot9 in ipairs(slot4) do
			slot11 = true

			if ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot9.itemId) > 0 then
				slot11 = false
			end

			table.insert(slot2, {
				id = slot9.id,
				buildingId = slot1,
				config = slot9,
				buildingCfg = slot3,
				isLock = slot11
			})
		end
	end

	table.insert(slot2, {
		isLock = false,
		id = 0,
		buildingId = slot1,
		buildingCfg = slot3
	})
	table.sort(slot2, slot0:_getSortFunc())
	slot0:setList(slot2)
end

function slot0._getSortFunc(slot0)
	if slot0._sortFunc_ then
		return slot0._sortFunc_
	end

	function slot0._sortFunc_(slot0, slot1)
		if slot0.isLock ~= slot1.isLock then
			if slot1.isLock then
				return true
			end

			return false
		end

		if slot0.id ~= slot1.id then
			if slot0.id == 0 or slot1.id < slot0.id then
				return true
			end

			return false
		end
	end

	return slot0._sortFunc_
end

function slot0.getBuildingUid(slot0)
	return slot0._buildingUid
end

function slot0.getSelectMO(slot0)
	return slot0:getById(slot0._selectId)
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

slot0.instance = slot0.New()

return slot0
