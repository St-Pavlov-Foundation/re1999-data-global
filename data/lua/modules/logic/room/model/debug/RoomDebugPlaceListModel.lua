module("modules.logic.room.model.debug.RoomDebugPlaceListModel", package.seeall)

slot0 = class("RoomDebugPlaceListModel", ListScrollModel)

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
	slot0._selectDefineId = nil
	slot0._filterCategory = nil
	slot0._filterPackageId = nil
	slot0._defineIdToBlockId = nil
end

function slot0.setFilterPackageId(slot0, slot1)
	if slot0._filterPackageId == slot1 then
		slot0._filterPackageId = nil
	else
		slot0._filterPackageId = slot1
	end
end

function slot0.isFilterPackageId(slot0, slot1)
	return slot0._filterPackageId == slot1
end

function slot0.setDebugPlaceList(slot0)
	slot1 = {}
	slot2 = nil

	if slot0._filterPackageId then
		slot2 = {}

		if lua_block_package_data.packageDict[slot0._filterPackageId] then
			for slot7, slot8 in pairs(slot3) do
				slot2[slot8.defineId] = true
			end
		end
	end

	if not slot0._defineIdToBlockId then
		slot0._defineIdToBlockId = {}
		slot3 = {}

		for slot7, slot8 in pairs(lua_block_package_data.packageDict) do
			for slot12, slot13 in pairs(slot8) do
				slot0._defineIdToBlockId[slot13.defineId] = slot13.blockId

				table.insert(slot3, slot13.blockId)
			end
		end

		RoomInventoryBlockModel.instance:addSpecialBlockIds(slot3)
	end

	for slot7, slot8 in pairs(RoomConfig.instance:getBlockDefineConfigDict()) do
		if slot0:isFilterCategory(slot8.category) and (not slot2 or slot2[slot7]) then
			slot9 = RoomDebugPlaceMO.New()

			slot9:init({
				id = slot7,
				blockId = slot0._defineIdToBlockId[slot7]
			})
			table.insert(slot1, slot9)
		end
	end

	table.sort(slot1, slot0._sortFunction)
	slot0:setList(slot1)
	slot0:_refreshSelect()
end

function slot0._sortFunction(slot0, slot1)
	return slot0.config.defineId < slot1.config.defineId
end

function slot0.setFilterCategory(slot0, slot1)
	slot0._filterCategory = slot1
end

function slot0.isFilterCategory(slot0, slot1)
	if string.nilorempty(slot1) and string.nilorempty(slot0._filterCategory) then
		return true
	end

	return slot0._filterCategory == slot1
end

function slot0.getFilterCategory(slot0)
	return slot0._filterCategory
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectDefineId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectDefineId then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectDefineId = slot1

	slot0:_refreshSelect()
end

function slot0.getSelect(slot0)
	return slot0._selectDefineId
end

function slot0.initDebugPlace(slot0)
	slot0:setDebugPlaceList()
	slot0:setFilterCategory(nil)
end

slot0.instance = slot0.New()

return slot0
