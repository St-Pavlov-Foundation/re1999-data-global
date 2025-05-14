module("modules.logic.room.model.map.RoomShowBuildingListModel", package.seeall)

local var_0_0 = class("RoomShowBuildingListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0:clearMapData()
	arg_4_0:clearFilterData()
end

function var_0_0.clearMapData(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._selectBuildingUid = nil
end

function var_0_0.clearFilterData(arg_6_0)
	arg_6_0._filterTypeList = {}
	arg_6_0._filterOccupyIdList = {}
	arg_6_0._filerUseList = {}
	arg_6_0._filterResIdList = {}
	arg_6_0._isRareDown = true
end

function var_0_0.getEmptyCount(arg_7_0)
	if not arg_7_0._emptyCount then
		return 0
	end

	return arg_7_0._emptyCount
end

function var_0_0.setShowBuildingList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = {}
	local var_8_3 = {}
	local var_8_4 = RoomModel.instance:getBuildingInfoList()
	local var_8_5 = RoomMapBuildingModel.instance:getTempBuildingMO()

	for iter_8_0 = 1, #var_8_4 do
		local var_8_6 = var_8_4[iter_8_0]
		local var_8_7 = RoomMapBuildingModel.instance:getBuildingMOById(var_8_6.uid) and true or false
		local var_8_8 = var_8_6.buildingId or var_8_6.defineId

		var_8_3[var_8_8] = true

		if var_8_5 and var_8_5.id == var_8_6.uid then
			var_8_7 = true

			if RoomInventoryBuildingModel.instance:getBuildingMOById(var_8_6.uid) then
				var_8_7 = false
			end
		end

		if arg_8_0:_checkInfoShow(var_8_8, var_8_7) then
			local var_8_9 = var_8_6.uid
			local var_8_10 = var_8_7 and var_8_2[var_8_9] or not var_8_7 and var_8_1[var_8_8]

			if not var_8_10 then
				var_8_10 = RoomShowBuildingMO.New()

				var_8_10:init(var_8_6)
				table.insert(var_8_0, var_8_10)

				if not var_8_7 then
					var_8_1[var_8_8] = var_8_10
				end

				var_8_2[var_8_9] = var_8_10
			end

			var_8_10.use = var_8_7

			var_8_10:add(var_8_6.uid, var_8_6.level)
		end
	end

	local var_8_11 = lua_manufacture_building.configList
	local var_8_12 = RoomConfig.instance:getBuildingConfigList()
	local var_8_13 = {
		use = false,
		isNeedToBuy = true
	}
	local var_8_14 = ManufactureModel.instance:getTradeLevel()

	for iter_8_1 = 1, #var_8_11 do
		local var_8_15 = var_8_11[iter_8_1]
		local var_8_16 = var_8_15.id

		if RoomConfig.instance:getBuildingConfig(var_8_16) and var_8_14 and var_8_14 >= var_8_15.placeTradeLevel and var_8_15.placeNoCost ~= 1 and not var_8_3[var_8_16] then
			var_8_3[var_8_16] = true

			if arg_8_0:_checkInfoShow(var_8_16, var_8_13.use) then
				var_8_13.uid = -var_8_16
				var_8_13.buildingId = var_8_16

				local var_8_17 = RoomShowBuildingMO.New()

				var_8_13.isBuyNoCost = var_8_15.placeNoCost == 1

				var_8_17:init(var_8_13)
				var_8_17:add(var_8_13.uid, 0)
				table.insert(var_8_0, var_8_17)
			end
		end
	end

	table.sort(var_8_0, arg_8_0._sortFunction)

	arg_8_0._emptyCount = 0

	for iter_8_2 = #var_8_0 + 1, 4 do
		local var_8_18 = RoomShowBuildingMO.New()

		var_8_18.id = -iter_8_2
		arg_8_0._emptyCount = arg_8_0._emptyCount + 1

		table.insert(var_8_0, 1, var_8_18)
	end

	arg_8_0:setList(var_8_0)
	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDataChanged)
	arg_8_0:_refreshSelect()
end

function var_0_0.setItemAnchorX(arg_9_0, arg_9_1)
	arg_9_0._itemAnchorX = arg_9_1 or 0
end

function var_0_0.getItemAnchorX(arg_10_0)
	return arg_10_0._itemAnchorX or 0
end

function var_0_0._checkInfoShow(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0:isFilterUseEmpty() and not arg_11_0:isFilterUse(arg_11_2 and 1 or 0) then
		return false
	end

	local var_11_0 = RoomConfig.instance:getBuildingConfig(arg_11_1)

	if not var_11_0 or var_11_0.buildingType == RoomBuildingEnum.BuildingType.Transport then
		return false
	end

	if not arg_11_0:isFilterOccupyIdEmpty() then
		local var_11_1 = RoomConfig.instance:getBuildingAreaConfig(var_11_0.areaId)

		if not var_11_0 or not arg_11_0:isFilterOccupy(var_11_1.occupy) then
			return false
		end
	end

	if not arg_11_0:isFilterTypeEmpty() and (not var_11_0 or not arg_11_0:isFilterType(var_11_0.buildingType)) then
		return false
	end

	if not arg_11_0:_isEmptyList(arg_11_0._filterResIdList) and not arg_11_0:_checkResource(arg_11_1) and not arg_11_0:_checkPlaceBuilding(arg_11_1) then
		return false
	end

	if not arg_11_0:_checkTheme(arg_11_1) then
		return false
	end

	return true
end

function var_0_0._checkTheme(arg_12_0, arg_12_1)
	local var_12_0 = RoomThemeFilterListModel.instance

	if not var_12_0:getIsAll() and var_12_0:getSelectCount() > 0 then
		local var_12_1 = RoomConfig.instance:getThemeIdByItem(arg_12_1, MaterialEnum.MaterialType.Building)

		if not var_12_0:isSelectById(var_12_1) then
			return false
		end
	end

	return true
end

function var_0_0._checkResource(arg_13_0, arg_13_1)
	local var_13_0 = RoomBuildingHelper.getCostResource(arg_13_1)

	if var_13_0 then
		for iter_13_0 = 1, #var_13_0 do
			if arg_13_0:isFilterType(var_13_0[iter_13_0]) then
				return true
			end
		end
	end

	return false
end

function var_0_0._checkPlaceBuilding(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._filterCostResList

	if var_14_0 and #var_14_0 > 0 then
		local var_14_1 = RoomConfig.instance

		for iter_14_0 = 1, #var_14_0 do
			local var_14_2 = var_14_1:getResourceParam(var_14_0[iter_14_0])

			if var_14_2 and var_14_2.placeBuilding and tabletool.indexOf(var_14_2.placeBuilding, arg_14_1) then
				return true
			end
		end
	end

	return false
end

function var_0_0._sortFunction(arg_15_0, arg_15_1)
	if arg_15_0.isNeedToBuy ~= arg_15_1.isNeedToBuy then
		if arg_15_0.isNeedToBuy then
			return true
		end

		return false
	end

	if arg_15_0.use and not arg_15_1.use then
		return false
	elseif not arg_15_0.use and arg_15_1.use then
		return true
	end

	if arg_15_0:isDecoration() and not arg_15_1:isDecoration() then
		return false
	elseif not arg_15_0:isDecoration() and arg_15_1:isDecoration() then
		return true
	end

	if arg_15_0.config.rare ~= arg_15_1.config.rare then
		if var_0_0.instance:isRareDown() then
			return arg_15_0.config.rare > arg_15_1.config.rare
		else
			return arg_15_0.config.rare < arg_15_1.config.rare
		end
	end

	if arg_15_0.config.id ~= arg_15_1.config.id then
		return arg_15_0.config.id < arg_15_1.config.id
	end

	return arg_15_0.id < arg_15_1.id
end

function var_0_0.setRareDown(arg_16_0, arg_16_1)
	arg_16_0._isRareDown = arg_16_1
end

function var_0_0.isRareDown(arg_17_0)
	return arg_17_0._isRareDown
end

function var_0_0.setFilterType(arg_18_0, arg_18_1)
	arg_18_0._filterTypeList = {}

	arg_18_0:_setList(arg_18_0._filterTypeList, arg_18_1)
end

function var_0_0.addFilterType(arg_19_0, arg_19_1)
	arg_19_0:_addListValue(arg_19_0._filterTypeList, arg_19_1)
end

function var_0_0.removeFilterType(arg_20_0, arg_20_1)
	arg_20_0:_removeListValue(arg_20_0._filterTypeList, arg_20_1)
end

function var_0_0.isFilterType(arg_21_0, arg_21_1)
	return arg_21_0:_isListValue(arg_21_0._filterTypeList, arg_21_1)
end

function var_0_0.isFilterTypeEmpty(arg_22_0)
	return arg_22_0:_isEmptyList(arg_22_0._filterTypeList)
end

function var_0_0.setFilterOccupy(arg_23_0, arg_23_1)
	arg_23_0._filterOccupyIdList = {}

	arg_23_0:_setList(arg_23_0._filterOccupyIdList, arg_23_1)
end

function var_0_0.addFilterOccupy(arg_24_0, arg_24_1)
	arg_24_0:_addListValue(arg_24_0._filterOccupyIdList, arg_24_1)
end

function var_0_0.removeFilterOccupy(arg_25_0, arg_25_1)
	arg_25_0:_removeListValue(arg_25_0._filterOccupyIdList, arg_25_1)
end

function var_0_0.isFilterOccupy(arg_26_0, arg_26_1)
	return arg_26_0:_isListValue(arg_26_0._filterOccupyIdList, arg_26_1)
end

function var_0_0.isFilterOccupyIdEmpty(arg_27_0)
	return arg_27_0:_isEmptyList(arg_27_0._filterOccupyIdList)
end

function var_0_0.setFilterUse(arg_28_0, arg_28_1)
	arg_28_0._filerUseList = {}

	arg_28_0:_setList(arg_28_0._filerUseList, arg_28_1)
end

function var_0_0.addFilterUse(arg_29_0, arg_29_1)
	arg_29_0:_addListValue(arg_29_0._filerUseList, arg_29_1)
end

function var_0_0.removeFilterUse(arg_30_0, arg_30_1)
	arg_30_0:_removeListValue(arg_30_0._filerUseList, arg_30_1)
end

function var_0_0.isFilterUse(arg_31_0, arg_31_1)
	return arg_31_0:_isListValue(arg_31_0._filerUseList, arg_31_1)
end

function var_0_0.isFilterUseEmpty(arg_32_0)
	return arg_32_0._filerUseList == nil or #arg_32_0._filerUseList == 0
end

function var_0_0._setList(arg_33_0, arg_33_1, arg_33_2)
	tabletool.addValues(arg_33_1, arg_33_2)
end

function var_0_0._isListValue(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_2 and tabletool.indexOf(arg_34_1, arg_34_2) then
		return true
	end

	return false
end

function var_0_0._addListValue(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_2 == nil then
		return
	end

	if arg_35_1 and not tabletool.indexOf(arg_35_1, arg_35_2) then
		table.insert(arg_35_1, arg_35_2)
	end
end

function var_0_0._removeListValue(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_2 == nil then
		return
	end

	tabletool.removeValue(arg_36_1, arg_36_2)
end

function var_0_0._isEmptyList(arg_37_0, arg_37_1)
	return arg_37_1 == nil or #arg_37_1 < 1
end

function var_0_0.clearSelect(arg_38_0)
	for iter_38_0, iter_38_1 in ipairs(arg_38_0._scrollViews) do
		iter_38_1:setSelect(nil)
	end

	arg_38_0._selectBuildingUid = nil
end

function var_0_0._refreshSelect(arg_39_0)
	local var_39_0
	local var_39_1 = arg_39_0:getList()

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		if iter_39_1.id == arg_39_0._selectBuildingUid then
			var_39_0 = iter_39_1
		end
	end

	for iter_39_2, iter_39_3 in ipairs(arg_39_0._scrollViews) do
		iter_39_3:setSelect(var_39_0)
	end
end

function var_0_0.setSelect(arg_40_0, arg_40_1)
	arg_40_0._selectBuildingUid = arg_40_1

	arg_40_0:_refreshSelect()
end

function var_0_0.initShowBuilding(arg_41_0)
	arg_41_0:setShowBuildingList()
end

function var_0_0.initFilter(arg_42_0)
	arg_42_0:setFilterType()
	arg_42_0:setFilterOccupy()
	arg_42_0:setFilterUse()
end

var_0_0.instance = var_0_0.New()

return var_0_0
