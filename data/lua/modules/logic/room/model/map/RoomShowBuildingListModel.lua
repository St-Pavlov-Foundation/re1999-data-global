module("modules.logic.room.model.map.RoomShowBuildingListModel", package.seeall)

slot0 = class("RoomShowBuildingListModel", ListScrollModel)

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
	slot0:clearMapData()
	slot0:clearFilterData()
end

function slot0.clearMapData(slot0)
	uv0.super.clear(slot0)

	slot0._selectBuildingUid = nil
end

function slot0.clearFilterData(slot0)
	slot0._filterTypeList = {}
	slot0._filterOccupyIdList = {}
	slot0._filerUseList = {}
	slot0._filterResIdList = {}
	slot0._isRareDown = true
end

function slot0.getEmptyCount(slot0)
	if not slot0._emptyCount then
		return 0
	end

	return slot0._emptyCount
end

function slot0.setShowBuildingList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}
	slot4 = {
		[slot11.buildingId or slot11.defineId] = true
	}
	slot6 = RoomMapBuildingModel.instance:getTempBuildingMO()

	for slot10 = 1, #RoomModel.instance:getBuildingInfoList() do
		slot12 = RoomMapBuildingModel.instance:getBuildingMOById(slot5[slot10].uid) and true or false

		if slot6 and slot6.id == slot11.uid then
			slot12 = true

			if RoomInventoryBuildingModel.instance:getBuildingMOById(slot11.uid) then
				slot12 = false
			end
		end

		if slot0:_checkInfoShow(slot13, slot12) then
			if not (slot12 and slot3[slot11.uid] or not slot12 and slot2[slot13]) then
				slot15 = RoomShowBuildingMO.New()

				slot15:init(slot11)
				table.insert(slot1, slot15)

				if not slot12 then
					slot2[slot13] = slot15
				end

				slot3[slot14] = slot15
			end

			slot15.use = slot12

			slot15:add(slot11.uid, slot11.level)
		end
	end

	slot8 = RoomConfig.instance:getBuildingConfigList()
	slot9 = {
		use = false,
		isNeedToBuy = true
	}
	slot10 = ManufactureModel.instance:getTradeLevel()

	for slot14 = 1, #lua_manufacture_building.configList do
		if RoomConfig.instance:getBuildingConfig(slot7[slot14].id) and slot10 and slot15.placeTradeLevel <= slot10 and slot15.placeNoCost ~= 1 and not slot4[slot16] then
			slot4[slot16] = true

			if slot0:_checkInfoShow(slot16, slot9.use) then
				slot9.uid = -slot16
				slot9.buildingId = slot16
				slot18 = RoomShowBuildingMO.New()
				slot9.isBuyNoCost = slot15.placeNoCost == 1

				slot18:init(slot9)
				slot18:add(slot9.uid, 0)
				table.insert(slot1, slot18)
			end
		end
	end

	table.sort(slot1, slot0._sortFunction)

	slot0._emptyCount = 0

	for slot14 = #slot1 + 1, 4 do
		slot15 = RoomShowBuildingMO.New()
		slot15.id = -slot14
		slot0._emptyCount = slot0._emptyCount + 1

		table.insert(slot1, 1, slot15)
	end

	slot0:setList(slot1)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDataChanged)
	slot0:_refreshSelect()
end

function slot0.setItemAnchorX(slot0, slot1)
	slot0._itemAnchorX = slot1 or 0
end

function slot0.getItemAnchorX(slot0)
	return slot0._itemAnchorX or 0
end

function slot0._checkInfoShow(slot0, slot1, slot2)
	if not slot0:isFilterUseEmpty() and not slot0:isFilterUse(slot2 and 1 or 0) then
		return false
	end

	if not RoomConfig.instance:getBuildingConfig(slot1) or slot3.buildingType == RoomBuildingEnum.BuildingType.Transport then
		return false
	end

	if not slot0:isFilterOccupyIdEmpty() then
		if not slot3 or not slot0:isFilterOccupy(RoomConfig.instance:getBuildingAreaConfig(slot3.areaId).occupy) then
			return false
		end
	end

	if not slot0:isFilterTypeEmpty() and (not slot3 or not slot0:isFilterType(slot3.buildingType)) then
		return false
	end

	if not slot0:_isEmptyList(slot0._filterResIdList) and not slot0:_checkResource(slot1) and not slot0:_checkPlaceBuilding(slot1) then
		return false
	end

	if not slot0:_checkTheme(slot1) then
		return false
	end

	return true
end

function slot0._checkTheme(slot0, slot1)
	if not RoomThemeFilterListModel.instance:getIsAll() and slot2:getSelectCount() > 0 and not slot2:isSelectById(RoomConfig.instance:getThemeIdByItem(slot1, MaterialEnum.MaterialType.Building)) then
		return false
	end

	return true
end

function slot0._checkResource(slot0, slot1)
	if RoomBuildingHelper.getCostResource(slot1) then
		for slot6 = 1, #slot2 do
			if slot0:isFilterType(slot2[slot6]) then
				return true
			end
		end
	end

	return false
end

function slot0._checkPlaceBuilding(slot0, slot1)
	if slot0._filterCostResList and #slot2 > 0 then
		for slot7 = 1, #slot2 do
			if RoomConfig.instance:getResourceParam(slot2[slot7]) and slot8.placeBuilding and tabletool.indexOf(slot8.placeBuilding, slot1) then
				return true
			end
		end
	end

	return false
end

function slot0._sortFunction(slot0, slot1)
	if slot0.isNeedToBuy ~= slot1.isNeedToBuy then
		if slot0.isNeedToBuy then
			return true
		end

		return false
	end

	if slot0.use and not slot1.use then
		return false
	elseif not slot0.use and slot1.use then
		return true
	end

	if slot0:isDecoration() and not slot1:isDecoration() then
		return false
	elseif not slot0:isDecoration() and slot1:isDecoration() then
		return true
	end

	if slot0.config.rare ~= slot1.config.rare then
		if uv0.instance:isRareDown() then
			return slot1.config.rare < slot0.config.rare
		else
			return slot0.config.rare < slot1.config.rare
		end
	end

	if slot0.config.id ~= slot1.config.id then
		return slot0.config.id < slot1.config.id
	end

	return slot0.id < slot1.id
end

function slot0.setRareDown(slot0, slot1)
	slot0._isRareDown = slot1
end

function slot0.isRareDown(slot0)
	return slot0._isRareDown
end

function slot0.setFilterType(slot0, slot1)
	slot0._filterTypeList = {}

	slot0:_setList(slot0._filterTypeList, slot1)
end

function slot0.addFilterType(slot0, slot1)
	slot0:_addListValue(slot0._filterTypeList, slot1)
end

function slot0.removeFilterType(slot0, slot1)
	slot0:_removeListValue(slot0._filterTypeList, slot1)
end

function slot0.isFilterType(slot0, slot1)
	return slot0:_isListValue(slot0._filterTypeList, slot1)
end

function slot0.isFilterTypeEmpty(slot0)
	return slot0:_isEmptyList(slot0._filterTypeList)
end

function slot0.setFilterOccupy(slot0, slot1)
	slot0._filterOccupyIdList = {}

	slot0:_setList(slot0._filterOccupyIdList, slot1)
end

function slot0.addFilterOccupy(slot0, slot1)
	slot0:_addListValue(slot0._filterOccupyIdList, slot1)
end

function slot0.removeFilterOccupy(slot0, slot1)
	slot0:_removeListValue(slot0._filterOccupyIdList, slot1)
end

function slot0.isFilterOccupy(slot0, slot1)
	return slot0:_isListValue(slot0._filterOccupyIdList, slot1)
end

function slot0.isFilterOccupyIdEmpty(slot0)
	return slot0:_isEmptyList(slot0._filterOccupyIdList)
end

function slot0.setFilterUse(slot0, slot1)
	slot0._filerUseList = {}

	slot0:_setList(slot0._filerUseList, slot1)
end

function slot0.addFilterUse(slot0, slot1)
	slot0:_addListValue(slot0._filerUseList, slot1)
end

function slot0.removeFilterUse(slot0, slot1)
	slot0:_removeListValue(slot0._filerUseList, slot1)
end

function slot0.isFilterUse(slot0, slot1)
	return slot0:_isListValue(slot0._filerUseList, slot1)
end

function slot0.isFilterUseEmpty(slot0)
	return slot0._filerUseList == nil or #slot0._filerUseList == 0
end

function slot0._setList(slot0, slot1, slot2)
	tabletool.addValues(slot1, slot2)
end

function slot0._isListValue(slot0, slot1, slot2)
	if slot2 and tabletool.indexOf(slot1, slot2) then
		return true
	end

	return false
end

function slot0._addListValue(slot0, slot1, slot2)
	if slot2 == nil then
		return
	end

	if slot1 and not tabletool.indexOf(slot1, slot2) then
		table.insert(slot1, slot2)
	end
end

function slot0._removeListValue(slot0, slot1, slot2)
	if slot2 == nil then
		return
	end

	tabletool.removeValue(slot1, slot2)
end

function slot0._isEmptyList(slot0, slot1)
	return slot1 == nil or #slot1 < 1
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectBuildingUid = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectBuildingUid then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectBuildingUid = slot1

	slot0:_refreshSelect()
end

function slot0.initShowBuilding(slot0)
	slot0:setShowBuildingList()
end

function slot0.initFilter(slot0)
	slot0:setFilterType()
	slot0:setFilterOccupy()
	slot0:setFilterUse()
end

slot0.instance = slot0.New()

return slot0
