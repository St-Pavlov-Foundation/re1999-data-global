module("modules.logic.room.model.map.RoomMapBuildingAreaModel", package.seeall)

local var_0_0 = class("RoomMapBuildingAreaModel", BaseModel)

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
	arg_4_0._areaBuildingDict = nil
end

function var_0_0.init(arg_5_0)
	arg_5_0:clear()
	arg_5_0:refreshBuildingAreaMOList()
end

function var_0_0.refreshBuildingAreaMOList(arg_6_0)
	local var_6_0 = {}

	arg_6_0._bType2UIdDict = {}

	local var_6_1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		if iter_6_1:isBuildingArea() and iter_6_1:isAreaMainBuilding() then
			local var_6_2 = arg_6_0:getById(iter_6_1.uid)

			if not var_6_2 then
				var_6_2 = RoomMapBuildingAreaMO.New()

				var_6_2:init(iter_6_1)
			else
				var_6_2:clearBuildingMOList()
			end

			table.insert(var_6_0, var_6_2)

			if iter_6_1.config then
				arg_6_0._bType2UIdDict[iter_6_1.config.buildingType] = var_6_2.id
			end
		end
	end

	arg_6_0:setList(var_6_0)
end

function var_0_0.getTempAreaMO(arg_7_0)
	local var_7_0 = RoomMapBuildingModel.instance:getTempBuildingMO()

	if not var_7_0 or not var_7_0:isBuildingArea() or not var_7_0:isAreaMainBuilding() then
		return nil
	end

	if not arg_7_0._tempAreaMO then
		arg_7_0._tempAreaMO = RoomMapBuildingAreaMO.New()
	end

	if arg_7_0._tempAreaMO.id ~= var_7_0.uid or arg_7_0._tempAreaMO.mainBuildingMO ~= var_7_0 then
		arg_7_0._tempAreaMO:init(var_7_0)
	end

	return arg_7_0._tempAreaMO
end

function var_0_0.refreshAreaMOByBType(arg_8_0, arg_8_1)
	arg_8_0:_refreshAreaMOById(arg_8_0._bType2UIdDict[arg_8_1])
end

function var_0_0.refreshAreaMOByBId(arg_9_0, arg_9_1)
	local var_9_0 = RoomConfig.instance:getBuildingConfig(arg_9_1)

	if var_9_0 then
		arg_9_0:refreshAreaMOByBType(var_9_0.buildingType)
	end
end

function var_0_0.refreshAreaMOByBUId(arg_10_0, arg_10_1)
	local var_10_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_10_1)

	if var_10_0 and var_10_0.config then
		arg_10_0:refreshAreaMOByBType(var_10_0.config.buildingType)
	end
end

function var_0_0._refreshAreaMOById(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getById(arg_11_1)

	if var_11_0 then
		var_11_0:clearBuildingMOList()
	end
end

function var_0_0.getAreaMOByBType(arg_12_0, arg_12_1)
	return arg_12_0:getById(arg_12_0._bType2UIdDict[arg_12_1])
end

function var_0_0.getAreaMOByBId(arg_13_0, arg_13_1)
	local var_13_0 = RoomConfig.instance:getBuildingConfig(arg_13_1)

	if var_13_0 then
		return arg_13_0:getAreaMOByBType(var_13_0.buildingType)
	end
end

function var_0_0.getAreaMOByBUId(arg_14_0, arg_14_1)
	local var_14_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_14_1)

	if var_14_0 and var_14_0.config then
		arg_14_0:getAreaMOByBType(var_14_0.config.buildingType)
	end
end

function var_0_0.getBuildingType2AreaMODict(arg_15_0)
	local var_15_0 = {}
	local var_15_1 = arg_15_0:getList()

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		var_15_0[iter_15_1:getBuildingType()] = iter_15_1
	end

	return var_15_0
end

function var_0_0.getBuildingUidByType(arg_16_0, arg_16_1)
	return arg_16_0._bType2UIdDict[arg_16_1]
end

function var_0_0.logTest(arg_17_0)
	local var_17_0 = arg_17_0:getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_1 = iter_17_1.mainBuildingMO

		if var_17_1 then
			arg_17_0:_logByBuildingId(var_17_1.buildingId, iter_17_1:getRangesHexPointList())
		end
	end
end

function var_0_0._logByBuildingId(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = RoomConfig.instance:getBuildingConfig(arg_18_1)

	if not var_18_0 then
		return
	end

	local var_18_1 = string.format("name:%s id:%s -->", var_18_0.name, arg_18_1)

	for iter_18_0, iter_18_1 in ipairs(arg_18_2) do
		if iter_18_1 then
			var_18_1 = string.format("%s (%s,%s)", var_18_1, iter_18_1.x, iter_18_1.y)
		end
	end

	logNormal(var_18_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
