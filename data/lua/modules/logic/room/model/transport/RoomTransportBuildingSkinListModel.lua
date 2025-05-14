module("modules.logic.room.model.transport.RoomTransportBuildingSkinListModel", package.seeall)

local var_0_0 = class("RoomTransportBuildingSkinListModel", ListScrollModel)

function var_0_0.setBuildingUid(arg_1_0, arg_1_1)
	local var_1_0 = RoomModel.instance:getBuildingInfoByBuildingUid(arg_1_1)

	if var_1_0 then
		local var_1_1 = var_1_0.buildingId or var_1_0.defineId

		arg_1_0:setBuildingId(var_1_1)
	else
		arg_1_0:setList({})
	end
end

function var_0_0.setBuildingId(arg_2_0, arg_2_1)
	local var_2_0 = {}
	local var_2_1 = RoomConfig.instance:getBuildingConfig(arg_2_1)
	local var_2_2 = RoomConfig.instance:getBuildingSkinList(arg_2_1)

	if var_2_2 then
		for iter_2_0, iter_2_1 in ipairs(var_2_2) do
			local var_2_3 = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, iter_2_1.itemId)
			local var_2_4 = true

			if var_2_3 > 0 then
				var_2_4 = false
			end

			local var_2_5 = {
				id = iter_2_1.id,
				buildingId = arg_2_1,
				config = iter_2_1,
				buildingCfg = var_2_1,
				isLock = var_2_4
			}

			table.insert(var_2_0, var_2_5)
		end
	end

	local var_2_6 = {
		isLock = false,
		id = 0,
		buildingId = arg_2_1,
		buildingCfg = var_2_1
	}

	table.insert(var_2_0, var_2_6)
	table.sort(var_2_0, arg_2_0:_getSortFunc())
	arg_2_0:setList(var_2_0)
end

function var_0_0._getSortFunc(arg_3_0)
	if arg_3_0._sortFunc_ then
		return arg_3_0._sortFunc_
	end

	function arg_3_0._sortFunc_(arg_4_0, arg_4_1)
		if arg_4_0.isLock ~= arg_4_1.isLock then
			if arg_4_1.isLock then
				return true
			end

			return false
		end

		if arg_4_0.id ~= arg_4_1.id then
			if arg_4_0.id == 0 or arg_4_0.id > arg_4_1.id then
				return true
			end

			return false
		end
	end

	return arg_3_0._sortFunc_
end

function var_0_0.getBuildingUid(arg_5_0)
	return arg_5_0._buildingUid
end

function var_0_0.getSelectMO(arg_6_0)
	return arg_6_0:getById(arg_6_0._selectId)
end

function var_0_0.getSelect(arg_7_0)
	return arg_7_0._selectId
end

function var_0_0._refreshSelect(arg_8_0)
	local var_8_0 = arg_8_0:getById(arg_8_0._selectId)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._scrollViews) do
		iter_8_1:setSelect(var_8_0)
	end
end

function var_0_0.setSelect(arg_9_0, arg_9_1)
	arg_9_0._selectId = arg_9_1

	arg_9_0:_refreshSelect()
end

var_0_0.instance = var_0_0.New()

return var_0_0
