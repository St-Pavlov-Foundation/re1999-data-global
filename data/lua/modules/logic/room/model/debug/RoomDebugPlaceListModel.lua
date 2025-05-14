module("modules.logic.room.model.debug.RoomDebugPlaceListModel", package.seeall)

local var_0_0 = class("RoomDebugPlaceListModel", ListScrollModel)

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
	arg_4_0._selectDefineId = nil
	arg_4_0._filterCategory = nil
	arg_4_0._filterPackageId = nil
	arg_4_0._defineIdToBlockId = nil
end

function var_0_0.setFilterPackageId(arg_5_0, arg_5_1)
	if arg_5_0._filterPackageId == arg_5_1 then
		arg_5_0._filterPackageId = nil
	else
		arg_5_0._filterPackageId = arg_5_1
	end
end

function var_0_0.isFilterPackageId(arg_6_0, arg_6_1)
	return arg_6_0._filterPackageId == arg_6_1
end

function var_0_0.setDebugPlaceList(arg_7_0)
	local var_7_0 = {}
	local var_7_1

	if arg_7_0._filterPackageId then
		var_7_1 = {}

		local var_7_2 = lua_block_package_data.packageDict[arg_7_0._filterPackageId]

		if var_7_2 then
			for iter_7_0, iter_7_1 in pairs(var_7_2) do
				var_7_1[iter_7_1.defineId] = true
			end
		end
	end

	if not arg_7_0._defineIdToBlockId then
		arg_7_0._defineIdToBlockId = {}

		local var_7_3 = {}

		for iter_7_2, iter_7_3 in pairs(lua_block_package_data.packageDict) do
			for iter_7_4, iter_7_5 in pairs(iter_7_3) do
				arg_7_0._defineIdToBlockId[iter_7_5.defineId] = iter_7_5.blockId

				table.insert(var_7_3, iter_7_5.blockId)
			end
		end

		RoomInventoryBlockModel.instance:addSpecialBlockIds(var_7_3)
	end

	local var_7_4 = RoomConfig.instance:getBlockDefineConfigDict()

	for iter_7_6, iter_7_7 in pairs(var_7_4) do
		if arg_7_0:isFilterCategory(iter_7_7.category) and (not var_7_1 or var_7_1[iter_7_6]) then
			local var_7_5 = RoomDebugPlaceMO.New()

			var_7_5:init({
				id = iter_7_6,
				blockId = arg_7_0._defineIdToBlockId[iter_7_6]
			})
			table.insert(var_7_0, var_7_5)
		end
	end

	table.sort(var_7_0, arg_7_0._sortFunction)
	arg_7_0:setList(var_7_0)
	arg_7_0:_refreshSelect()
end

function var_0_0._sortFunction(arg_8_0, arg_8_1)
	return arg_8_0.config.defineId < arg_8_1.config.defineId
end

function var_0_0.setFilterCategory(arg_9_0, arg_9_1)
	arg_9_0._filterCategory = arg_9_1
end

function var_0_0.isFilterCategory(arg_10_0, arg_10_1)
	if string.nilorempty(arg_10_1) and string.nilorempty(arg_10_0._filterCategory) then
		return true
	end

	return arg_10_0._filterCategory == arg_10_1
end

function var_0_0.getFilterCategory(arg_11_0)
	return arg_11_0._filterCategory
end

function var_0_0.clearSelect(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._scrollViews) do
		iter_12_1:setSelect(nil)
	end

	arg_12_0._selectDefineId = nil
end

function var_0_0._refreshSelect(arg_13_0)
	local var_13_0
	local var_13_1 = arg_13_0:getList()

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.id == arg_13_0._selectDefineId then
			var_13_0 = iter_13_1
		end
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_0._scrollViews) do
		iter_13_3:setSelect(var_13_0)
	end
end

function var_0_0.setSelect(arg_14_0, arg_14_1)
	arg_14_0._selectDefineId = arg_14_1

	arg_14_0:_refreshSelect()
end

function var_0_0.getSelect(arg_15_0)
	return arg_15_0._selectDefineId
end

function var_0_0.initDebugPlace(arg_16_0)
	arg_16_0:setDebugPlaceList()
	arg_16_0:setFilterCategory(nil)
end

var_0_0.instance = var_0_0.New()

return var_0_0
