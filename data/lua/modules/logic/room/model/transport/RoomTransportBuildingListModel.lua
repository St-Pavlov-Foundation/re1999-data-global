module("modules.logic.room.model.transport.RoomTransportBuildingListModel", package.seeall)

local var_0_0 = class("RoomTransportBuildingListModel", ListScrollModel)

function var_0_0.setBuildingList(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}
	local var_1_2 = RoomModel.instance:getBuildingInfoList()

	for iter_1_0 = 1, #var_1_2 do
		local var_1_3 = var_1_2[iter_1_0]
		local var_1_4 = RoomMapBuildingModel.instance:getBuildingMOById(var_1_3.uid) and true or false
		local var_1_5 = var_1_3.buildingId or var_1_3.defineId

		if arg_1_0:_checkInfoShow(var_1_5, var_1_4) then
			local var_1_6 = var_1_4

			var_1_1[var_1_5] = true

			local var_1_7 = RoomShowBuildingMO.New()

			var_1_7:init(var_1_3)

			var_1_7.use = var_1_4

			var_1_7:add(var_1_3.uid, var_1_3.level)
			table.insert(var_1_0, var_1_7)
		end
	end

	local var_1_8 = RoomConfig.instance:getBuildingConfigList()
	local var_1_9 = {
		use = false,
		isNeedToBuy = true
	}

	for iter_1_1 = 1, #var_1_8 do
		local var_1_10 = var_1_8[iter_1_1]
		local var_1_11 = var_1_10.id

		if var_1_10.buildingType == RoomBuildingEnum.BuildingType.Transport and not var_1_1[var_1_11] then
			var_1_1[var_1_11] = true
			var_1_9.uid = -var_1_11
			var_1_9.buildingId = var_1_11

			local var_1_12 = RoomShowBuildingMO.New()

			var_1_12:init(var_1_9)
			var_1_12:add(var_1_9.uid, 0)
			table.insert(var_1_0, var_1_12)
		end
	end

	arg_1_0:setList(var_1_0)
	arg_1_0:_refreshSelect()
end

function var_0_0.getSelect(arg_2_0)
	return arg_2_0._selectId
end

function var_0_0._refreshSelect(arg_3_0)
	local var_3_0 = arg_3_0:getById(arg_3_0._selectId)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scrollViews) do
		iter_3_1:setSelect(var_3_0)
	end
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	arg_4_0._selectId = arg_4_1

	arg_4_0:_refreshSelect()
end

function var_0_0.getSelectMO(arg_5_0)
	return arg_5_0:getById(arg_5_0._selectId)
end

function var_0_0._checkInfoShow(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = RoomConfig.instance:getBuildingConfig(arg_6_1)

	if var_6_0 and var_6_0.buildingType == RoomBuildingEnum.BuildingType.Transport then
		return true
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
