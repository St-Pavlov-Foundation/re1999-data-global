module("modules.logic.room.controller.RoomSceneTaskValidator", package.seeall)

local var_0_0 = {}

function var_0_0.getRoomSceneTaskStatus(arg_1_0)
	local var_1_0 = arg_1_0.config

	if var_1_0 then
		local var_1_1 = var_1_0.listenerType
		local var_1_2 = var_0_0.handleMap[var_1_1]

		if var_1_2 then
			local var_1_3, var_1_4 = var_1_2(arg_1_0)

			if var_1_4 < 0 then
				var_1_4 = 0
			end

			return var_1_3, var_1_4
		end
	end

	return false, 0
end

function var_0_0.canGetByLocal(arg_2_0)
	local var_2_0 = arg_2_0.config

	if var_2_0 then
		local var_2_1 = var_2_0.listenerType

		if var_0_0.handleMap[var_2_1] then
			return true
		end
	end

	return false
end

function var_0_0.handleTotalBlock(arg_3_0)
	local var_3_0 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_3_1 = RoomMapBlockModel.instance:getBackBlockModel()
	local var_3_2 = 0

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1.blockId ~= nil and iter_3_1.blockId < 0 and RoomMapBlockModel.instance:getTempBlockMO() ~= iter_3_1 then
			var_3_2 = var_3_2 + 1
		end
	end

	if var_3_1 then
		var_3_2 = var_3_2 + var_3_1:getCount()
	end

	local var_3_3 = arg_3_0.config.maxProgress
	local var_3_4 = #var_3_0 - var_3_2

	if var_3_3 < var_3_4 then
		var_3_4 = var_3_3
	end

	return var_3_3 <= var_3_4, var_3_4
end

function var_0_0.handleResBlockCount(arg_4_0)
	local var_4_0 = arg_4_0.config
	local var_4_1 = tonumber(var_4_0.listenerParam)
	local var_4_2 = var_4_0.maxProgress
	local var_4_3 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_4_4 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_3) do
		if (iter_4_1.blockId ~= nil and iter_4_1.blockId >= 0 or RoomMapBlockModel.instance:getTempBlockMO() == iter_4_1) and var_0_0.containBlockMOResID(iter_4_1, var_4_1) then
			var_4_4 = var_4_4 + 1
		end
	end

	local var_4_5 = RoomMapBlockModel.instance:getBackBlockModel()

	if var_4_5 then
		local var_4_6 = var_4_5:getList()

		for iter_4_2, iter_4_3 in ipairs(var_4_6) do
			if var_0_0.containBlockMOResID(iter_4_3, var_4_1) then
				var_4_4 = var_4_4 - 1
			end
		end
	end

	if var_4_2 < var_4_4 then
		var_4_4 = var_4_2
	end

	return var_4_2 <= var_4_4, var_4_4
end

function var_0_0.handleSubResBlockCount(arg_5_0)
	local var_5_0 = arg_5_0.config
	local var_5_1 = tonumber(var_5_0.listenerParam)
	local var_5_2 = var_5_0.maxProgress
	local var_5_3 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_5_4 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		if (iter_5_1.blockId ~= nil and iter_5_1.blockId >= 0 or RoomMapBlockModel.instance:getTempBlockMO() == iter_5_1) and var_0_0.containSubMOResID(iter_5_1, var_5_1) then
			var_5_4 = var_5_4 + 1
		end
	end

	local var_5_5 = RoomMapBlockModel.instance:getBackBlockModel()

	if var_5_5 then
		local var_5_6 = var_5_5:getList()

		for iter_5_2, iter_5_3 in ipairs(var_5_6) do
			if var_0_0.containSubMOResID(iter_5_3, var_5_1) then
				var_5_4 = var_5_4 - 1
			end
		end
	end

	if var_5_2 < var_5_4 then
		var_5_4 = var_5_2
	end

	return var_5_2 <= var_5_4, var_5_4
end

function var_0_0.handleBuildingCount(arg_6_0)
	local var_6_0 = arg_6_0.config.maxProgress
	local var_6_1 = 0
	local var_6_2 = var_0_0.getAllBuildingInMap()

	for iter_6_0, iter_6_1 in pairs(var_6_2) do
		var_6_1 = var_6_1 + 1
	end

	if var_6_0 < var_6_1 then
		var_6_1 = var_6_0
	end

	return var_6_0 <= var_6_1, var_6_1
end

function var_0_0.handleBuildingPower(arg_7_0)
	local var_7_0 = arg_7_0.config.maxProgress
	local var_7_1 = 0
	local var_7_2 = 0
	local var_7_3 = var_0_0.getAllBuildingInMap()

	for iter_7_0, iter_7_1 in pairs(var_7_3) do
		var_7_1 = var_7_1 + iter_7_1.config.buildDegree
		var_7_2 = var_7_2 + 1
	end

	if var_7_0 < var_7_1 then
		var_7_1 = var_7_0
	end

	return var_7_0 <= var_7_1, var_7_2
end

function var_0_0.getAllBuildingInMap()
	local var_8_0 = {}
	local var_8_1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_8_0, iter_8_1 in pairs(var_8_1) do
		if not (iter_8_1 == RoomMapBuildingModel.instance:getTempBuildingMO() and iter_8_1.use) and iter_8_1.config then
			var_8_0[iter_8_1.uid] = iter_8_1
		end
	end

	local var_8_2 = {}
	local var_8_3 = RoomMapBlockModel.instance:getBackBlockModel()

	if var_8_3 then
		local var_8_4 = var_8_3:getList()

		for iter_8_2, iter_8_3 in ipairs(var_8_4) do
			local var_8_5 = iter_8_3.hexPoint
			local var_8_6 = RoomMapBuildingModel.instance:getBuildingParam(var_8_5.x, var_8_5.y)

			if var_8_6 and var_8_6.buildingUid ~= nil then
				var_8_0[var_8_6.buildingUid] = nil
			end
		end
	end

	return var_8_0
end

function var_0_0.containBlockMOResID(arg_9_0, arg_9_1)
	return arg_9_0.mainRes == arg_9_1
end

function var_0_0.containSubMOResID(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getResourceList()

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		if iter_10_1 == arg_10_1 then
			return true
		end
	end

	return false
end

var_0_0.handleMap = {
	[RoomSceneTaskEnum.ListenerType.EditResArea] = var_0_0.handleTotalBlock,
	[RoomSceneTaskEnum.ListenerType.EditResTypeReach] = var_0_0.handleResBlockCount,
	[RoomSceneTaskEnum.ListenerType.EditHasResBlockCount] = var_0_0.handleSubResBlockCount,
	[RoomSceneTaskEnum.ListenerType.BuildingUseCount] = var_0_0.handleBuildingCount,
	[RoomSceneTaskEnum.ListenerType.BuildingDegree] = var_0_0.handleBuildingPower
}

return var_0_0
