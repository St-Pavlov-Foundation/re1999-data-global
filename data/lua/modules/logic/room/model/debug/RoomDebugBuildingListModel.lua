module("modules.logic.room.model.debug.RoomDebugBuildingListModel", package.seeall)

local var_0_0 = class("RoomDebugBuildingListModel", ListScrollModel)

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
	arg_4_0._selectBuildingId = nil
end

function var_0_0.setDebugBuildingList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = RoomConfig.instance:getBuildingConfigList()

	for iter_5_0, iter_5_1 in pairs(var_5_1) do
		local var_5_2 = RoomDebugBuildingMO.New()

		var_5_2:init({
			id = iter_5_1.id
		})
		table.insert(var_5_0, var_5_2)
	end

	table.sort(var_5_0, arg_5_0._sortFunction)
	arg_5_0:setList(var_5_0)
	arg_5_0:_refreshSelect()
end

function var_0_0._sortFunction(arg_6_0, arg_6_1)
	return arg_6_0.id < arg_6_1.id
end

function var_0_0.clearSelect(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._scrollViews) do
		iter_7_1:setSelect(nil)
	end

	arg_7_0._selectBuildingId = nil
end

function var_0_0._refreshSelect(arg_8_0)
	local var_8_0
	local var_8_1 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1.id == arg_8_0._selectBuildingId then
			var_8_0 = iter_8_1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_0._scrollViews) do
		iter_8_3:setSelect(var_8_0)
	end
end

function var_0_0.setSelect(arg_9_0, arg_9_1)
	arg_9_0._selectBuildingId = arg_9_1

	arg_9_0:_refreshSelect()
end

function var_0_0.getSelect(arg_10_0)
	return arg_10_0._selectBuildingId
end

function var_0_0.initDebugBuilding(arg_11_0)
	arg_11_0:setDebugBuildingList()
end

var_0_0.instance = var_0_0.New()

return var_0_0
