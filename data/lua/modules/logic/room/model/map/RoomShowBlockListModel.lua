module("modules.logic.room.model.map.RoomShowBlockListModel", package.seeall)

local var_0_0 = class("RoomShowBlockListModel", ListScrollModel)

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
end

function var_0_0.clearMapData(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._selectBlockId = nil
	arg_5_0._packageId = nil
	arg_5_0._selectIndex = 1
end

function var_0_0.addScrollView(arg_6_0, arg_6_1)
	var_0_0.super.addScrollView(arg_6_0, arg_6_1)
end

function var_0_0.setShowBlockList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2
	local var_7_3 = RoomInventoryBlockModel.instance:getSelectInventoryBlockId()
	local var_7_4 = arg_7_0:_getPackageMOList()

	for iter_7_0 = 1, #var_7_4 do
		local var_7_5 = var_7_4[iter_7_0]

		if arg_7_0._isSelectPackage or arg_7_0:_checkTheme(var_7_5.id) then
			local var_7_6 = var_7_5:getUnUseBlockMOList()

			for iter_7_1, iter_7_2 in ipairs(var_7_6) do
				if arg_7_0:_checkBlockMO(iter_7_2) then
					if var_7_3 == iter_7_2.id then
						var_7_2 = var_7_3
					end

					table.insert(var_7_0, iter_7_2)
				end
			end
		end
	end

	table.sort(var_7_0, arg_7_0._sortFunction)

	if var_7_2 == nil then
		var_7_2 = arg_7_0:_findSelectId(var_7_0)
	end

	arg_7_0:setList(var_7_0)
	arg_7_0:setSelect(var_7_2)
end

function var_0_0._getPackageMOList(arg_8_0)
	if arg_8_0._isSelectPackage then
		return {
			RoomInventoryBlockModel.instance:getCurPackageMO()
		}
	end

	return RoomInventoryBlockModel.instance:getInventoryBlockPackageMOList()
end

function var_0_0._findSelectId(arg_9_0, arg_9_1)
	if not arg_9_1 or #arg_9_1 < 1 then
		return nil
	end

	local var_9_0 = arg_9_0._selectIndex and arg_9_1[arg_9_0._selectIndex] or arg_9_1[#arg_9_1]

	return var_9_0 and var_9_0.id or nil
end

function var_0_0._sortFunction(arg_10_0, arg_10_1)
	local var_10_0 = var_0_0._getBirthdayBlockIndex(arg_10_0)
	local var_10_1 = var_0_0._getBirthdayBlockIndex(arg_10_1)

	if var_10_0 ~= var_10_1 then
		return var_10_0 < var_10_1
	end

	local var_10_2 = RoomInventoryBlockModel.instance:getBlockSortIndex(arg_10_0.packageId, arg_10_0.id)
	local var_10_3 = RoomInventoryBlockModel.instance:getBlockSortIndex(arg_10_1.packageId, arg_10_1.id)

	if var_10_2 ~= var_10_3 then
		return var_10_2 < var_10_3
	end

	if arg_10_0.packageId ~= arg_10_1.packageId then
		return arg_10_0.packageId > arg_10_1.packageId
	end

	if arg_10_0.packageOrder ~= arg_10_1.packageOrder then
		return arg_10_0.packageOrder < arg_10_1.packageOrder
	end
end

function var_0_0._getBirthdayBlockIndex(arg_11_0)
	local var_11_0 = RoomConfig.instance:getSpecialBlockConfig(arg_11_0.id)

	if var_11_0 and RoomCharacterModel.instance:isOnBirthday(var_11_0.heroId) then
		return 1
	end

	return 9999
end

function var_0_0.clearSelect(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._scrollViews) do
		iter_12_1:setSelect(nil)
	end

	arg_12_0._selectBlockId = nil
end

function var_0_0._refreshSelect(arg_13_0)
	local var_13_0
	local var_13_1 = arg_13_0:getList()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.id == arg_13_0._selectBlockId then
			arg_13_0._selectIndex = iter_13_0
			var_13_0 = iter_13_1

			break
		end
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0._scrollViews) do
		iter_13_3:setSelect(var_13_0)
	end
end

function var_0_0.setSelect(arg_14_0, arg_14_1)
	arg_14_0._selectBlockId = arg_14_1

	RoomInventoryBlockModel.instance:setSelectInventoryBlockId(arg_14_1)
	arg_14_0:_refreshSelect()
end

function var_0_0.initShowBlock(arg_15_0)
	arg_15_0._packageId = nil
	arg_15_0._selectIndex = 1

	arg_15_0:setShowBlockList()
end

function var_0_0._checkBlockMO(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1:getBlockDefineCfg()

	if not var_16_0 then
		return false
	end

	if not arg_16_0:_isEmptyList(arg_16_0._filterExcludeList) then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._filterExcludeList) do
			if var_16_0.resIdCountDict[iter_16_1] then
				return false
			end
		end
	end

	if not arg_16_0:_isEmptyList(arg_16_0._filterIncludeList) then
		for iter_16_2, iter_16_3 in ipairs(arg_16_0._filterIncludeList) do
			if var_16_0.resIdCountDict[iter_16_3] then
				return true
			end
		end
	else
		return true
	end

	return false
end

function var_0_0._checkTheme(arg_17_0, arg_17_1)
	local var_17_0 = RoomThemeFilterListModel.instance

	if not var_17_0:getIsAll() and var_17_0:getSelectCount() > 0 then
		local var_17_1 = RoomConfig.instance:getThemeIdByItem(arg_17_1, MaterialEnum.MaterialType.BlockPackage)

		if not var_17_0:isSelectById(var_17_1) then
			return false
		end
	end

	return true
end

function var_0_0.setIsPackage(arg_18_0, arg_18_1)
	arg_18_0._isSelectPackage = arg_18_1 == true
end

function var_0_0.getIsPackage(arg_19_0)
	return arg_19_0._isSelectPackage
end

function var_0_0.setFilterResType(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._filterIncludeList = {}
	arg_20_0._filterExcludeList = {}

	arg_20_0:_setList(arg_20_0._filterIncludeList, arg_20_1)
	arg_20_0:_setList(arg_20_0._filterExcludeList, arg_20_2)
end

function var_0_0.isFilterType(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0:_isSameValue(arg_21_0._filterIncludeList, arg_21_1) and arg_21_0:_isSameValue(arg_21_0._filterExcludeList, arg_21_2) then
		return true
	end

	return false
end

function var_0_0.isFilterTypeEmpty(arg_22_0)
	return arg_22_0:_isEmptyList(arg_22_0._filterTypeList)
end

function var_0_0._setList(arg_23_0, arg_23_1, arg_23_2)
	tabletool.addValues(arg_23_1, arg_23_2)
end

function var_0_0._isListValue(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_2 and tabletool.indexOf(arg_24_1, arg_24_2) then
		return true
	end

	return false
end

function var_0_0._isSameValue(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_0:_isEmptyList(arg_25_1) and arg_25_0:_isEmptyList(arg_25_2) then
		return true
	end

	if #arg_25_1 ~= #arg_25_2 then
		return false
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
		if not tabletool.indexOf(arg_25_1, iter_25_1) then
			return false
		end
	end

	for iter_25_2, iter_25_3 in ipairs(arg_25_1) do
		if not tabletool.indexOf(arg_25_2, iter_25_3) then
			return false
		end
	end

	return true
end

function var_0_0._isEmptyList(arg_26_0, arg_26_1)
	return arg_26_1 == nil or #arg_26_1 < 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
