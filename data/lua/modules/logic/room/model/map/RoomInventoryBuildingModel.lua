module("modules.logic.room.model.map.RoomInventoryBuildingModel", package.seeall)

local var_0_0 = class("RoomInventoryBuildingModel", BaseModel)

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
	arg_4_0._hasBuildingDict = {}
end

function var_0_0.initInventory(arg_5_0, arg_5_1)
	arg_5_0:clear()
	arg_5_0:addBuilding(arg_5_1)

	local var_5_0 = lua_manufacture_building.configList
	local var_5_1 = RoomConfig.instance:getBuildingConfigList()
	local var_5_2 = {
		use = false
	}

	for iter_5_0 = 1, #var_5_0 do
		local var_5_3 = var_5_0[iter_5_0].id

		if RoomConfig.instance:getBuildingConfig(var_5_3) and not arg_5_0._hasBuildingDict[var_5_3] then
			arg_5_0._hasBuildingDict[var_5_3] = true
			var_5_2.uid = -var_5_3
			var_5_2.buildingId = var_5_3
			var_5_2.buildingState = RoomBuildingEnum.BuildingState.Inventory

			local var_5_4 = RoomBuildingMO.New()

			var_5_4:init(var_5_2)
			arg_5_0:_addBuildingMO(var_5_4)
		end
	end
end

function var_0_0.checkBuildingPut(arg_6_0, arg_6_1)
	arg_6_1 = tonumber(arg_6_1)

	local var_6_0 = arg_6_0:getBuildingMOList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.buildingId == arg_6_1 then
			local var_6_1 = RoomBuildingHelper.getRecommendHexPoint(iter_6_1.buildingId)

			return var_6_1 and var_6_1.hexPoint ~= nil
		end
	end

	return false
end

function var_0_0.addBuilding(arg_7_0, arg_7_1)
	if not arg_7_1 or #arg_7_1 <= 0 then
		return
	end

	arg_7_0._hasBuildingDict = arg_7_0._hasBuildingDict or {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		arg_7_0._hasBuildingDict[iter_7_1.defineId] = true

		if not iter_7_1.use then
			local var_7_0 = RoomInfoHelper.serverInfoToBuildingInfo(iter_7_1)
			local var_7_1 = RoomBuildingMO.New()

			var_7_1:init(var_7_0)

			if var_7_1.config then
				arg_7_0:_addBuildingMO(var_7_1)
			end
		end

		arg_7_0:_removeBuildingMOByUId(-iter_7_1.defineId)
	end
end

function var_0_0._addBuildingMO(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getById(arg_8_1.id)

	if var_8_0 then
		arg_8_0:remove(var_8_0)
	end

	arg_8_0:addAtLast(arg_8_1)
end

function var_0_0._removeBuildingMO(arg_9_0, arg_9_1)
	arg_9_0:remove(arg_9_1)
end

function var_0_0._removeBuildingMOByUId(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getById(arg_10_1)

	if var_10_0 then
		arg_10_0:remove(var_10_0)
	end
end

function var_0_0.placeBuilding(arg_11_0, arg_11_1)
	arg_11_0:_removeBuildingMOByUId(arg_11_1.uid)
end

function var_0_0.unUseBuilding(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getById(arg_12_1.uid)

	if var_12_0 then
		var_12_0.use = false

		return
	end

	if arg_12_1.use then
		return
	end

	local var_12_1 = RoomInfoHelper.serverInfoToBuildingInfo(arg_12_1)
	local var_12_2 = RoomBuildingMO.New()

	var_12_2:init(var_12_1)
	arg_12_0:_addBuildingMO(var_12_2)
end

function var_0_0.getBuildingMOList(arg_13_0)
	return arg_13_0:getList()
end

function var_0_0.getBuildingMOById(arg_14_0, arg_14_1)
	return arg_14_0:getById(arg_14_1)
end

function var_0_0.getCount(arg_15_0)
	return arg_15_0:getCount()
end

var_0_0.instance = var_0_0.New()

return var_0_0
