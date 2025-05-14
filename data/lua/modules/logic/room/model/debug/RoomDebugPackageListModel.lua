module("modules.logic.room.model.debug.RoomDebugPackageListModel", package.seeall)

local var_0_0 = class("RoomDebugPackageListModel", ListScrollModel)

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
	arg_4_0._selectBlockId = nil
	arg_4_0._filterPackageId = 0
	arg_4_0._filterMainRes = nil
end

function var_0_0.setDebugPackageList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = RoomDebugController.instance:getTempPackageConfig()

	if var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			for iter_5_2, iter_5_3 in ipairs(iter_5_1.infos) do
				if arg_5_0._filterPackageId > 0 and arg_5_0:isFilterPackageId(iter_5_3.packageId) and arg_5_0:isFilterMainRes(iter_5_3.mainRes) then
					local var_5_2 = RoomDebugPackageMO.New()

					var_5_2:init({
						id = iter_5_3.blockId,
						packageId = iter_5_3.packageId,
						packageOrder = iter_5_3.packageOrder,
						defineId = iter_5_3.defineId,
						mainRes = iter_5_3.mainRes
					})
					table.insert(var_5_0, var_5_2)
				end
			end
		end
	end

	table.sort(var_5_0, arg_5_0._sortFunction)
	arg_5_0:setList(var_5_0)
	arg_5_0:_refreshSelect()
end

function var_0_0.getCountByMainRes(arg_6_0, arg_6_1)
	local var_6_0 = 0
	local var_6_1 = RoomDebugController.instance:getTempPackageConfig()

	if var_6_1 then
		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			for iter_6_2, iter_6_3 in ipairs(iter_6_1.infos) do
				if arg_6_0._filterPackageId > 0 and arg_6_0:isFilterPackageId(iter_6_3.packageId) and (arg_6_1 == iter_6_3.mainRes or (not arg_6_1 or arg_6_1 < 0) and (not iter_6_3.mainRes or iter_6_3.mainRes < 0)) then
					var_6_0 = var_6_0 + 1
				end
			end
		end
	end

	return var_6_0
end

function var_0_0._sortFunction(arg_7_0, arg_7_1)
	if arg_7_0.packageOrder ~= arg_7_1.packageOrder then
		return arg_7_0.packageOrder < arg_7_1.packageOrder
	end

	return arg_7_0.id < arg_7_1.id
end

function var_0_0.setFilterPackageId(arg_8_0, arg_8_1)
	arg_8_0._filterPackageId = arg_8_1
end

function var_0_0.isFilterPackageId(arg_9_0, arg_9_1)
	return arg_9_0._filterPackageId == arg_9_1
end

function var_0_0.getFilterPackageId(arg_10_0)
	return arg_10_0._filterPackageId
end

function var_0_0.setFilterMainRes(arg_11_0, arg_11_1)
	arg_11_0._filterMainRes = arg_11_1
end

function var_0_0.isFilterMainRes(arg_12_0, arg_12_1)
	return arg_12_0._filterMainRes == arg_12_1 or not arg_12_0._filterMainRes and (not arg_12_1 or arg_12_1 == -1)
end

function var_0_0.getFilterMainRes(arg_13_0)
	return arg_13_0._filterMainRes
end

function var_0_0.clearSelect(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._scrollViews) do
		iter_14_1:setSelect(nil)
	end

	arg_14_0._selectBlockId = nil
end

function var_0_0._refreshSelect(arg_15_0)
	local var_15_0
	local var_15_1 = arg_15_0:getList()

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		if iter_15_1.id == arg_15_0._selectBlockId then
			var_15_0 = iter_15_1
		end
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._scrollViews) do
		iter_15_3:setSelect(var_15_0)
	end
end

function var_0_0.setSelect(arg_16_0, arg_16_1)
	arg_16_0._selectBlockId = arg_16_1

	arg_16_0:_refreshSelect()
end

function var_0_0.getSelect(arg_17_0)
	return arg_17_0._selectBlockId
end

function var_0_0.initDebugPackage(arg_18_0)
	arg_18_0:setDebugPackageList()
end

var_0_0.instance = var_0_0.New()

return var_0_0
