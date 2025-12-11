module("modules.logic.roomfishing.config.FishingConfig", package.seeall)

local var_0_0 = class("FishingConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"fishing_const",
		"fishing_map_block",
		"fishing_map_building",
		"fishing_pool",
		"fishing_exchange"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0[arg_4_1]

	if not var_4_0 then
		var_4_0 = {}
		arg_4_0[arg_4_1] = var_4_0
	end

	return var_4_0
end

function var_0_0.fishing_map_blockConfigLoaded(arg_5_0, arg_5_1)
	arg_5_0._mapBlockDict = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.configList) do
		local var_5_0 = var_0_1(arg_5_0._mapBlockDict, iter_5_1.mapId)

		var_5_0[#var_5_0 + 1] = iter_5_1
	end
end

function var_0_0.fishing_map_buildingConfigLoaded(arg_6_0, arg_6_1)
	arg_6_0._mapBuildingDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.configList) do
		local var_6_0 = var_0_1(arg_6_0._mapBuildingDict, iter_6_1.mapId)

		var_6_0[#var_6_0 + 1] = iter_6_1
	end
end

function var_0_0.getFishingConstCfg(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lua_fishing_const.configDict[arg_7_1]

	if not var_7_0 and arg_7_2 then
		logError(string.format("FishingConfig:getFishingConstCfg error, cfg is nil, constId:%s", arg_7_1))
	end

	return var_7_0
end

function var_0_0.getFishingConst(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0
	local var_8_1 = arg_8_0:getFishingConstCfg(arg_8_1, true)

	if var_8_1 then
		var_8_0 = var_8_1.value

		if not string.nilorempty(arg_8_3) then
			if arg_8_2 then
				var_8_0 = string.splitToNumber(var_8_0, arg_8_3)
			else
				var_8_0 = string.split(var_8_0, arg_8_3)
			end
		elseif arg_8_2 then
			var_8_0 = tonumber(var_8_0)
		end
	end

	return var_8_0
end

function var_0_0.getFishingMapInfo(arg_9_0)
	local var_9_0 = FishingEnum.Const.DefaultMapId

	return {
		mapId = var_9_0,
		infos = tabletool.copy(arg_9_0._mapBlockDict[var_9_0]),
		buildingInfos = tabletool.copy(arg_9_0._mapBuildingDict[var_9_0])
	}
end

function var_0_0.getMaxBuildingUid(arg_10_0, arg_10_1)
	local var_10_0 = 0

	if arg_10_0._mapBuildingDict and arg_10_0._mapBuildingDict[arg_10_1] then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._mapBuildingDict[arg_10_1]) do
			var_10_0 = math.max(var_10_0, iter_10_1.uid)
		end
	end

	return var_10_0
end

function var_0_0.getFishingPoolCfg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = lua_fishing_pool.configDict[arg_11_1]

	if not var_11_0 and arg_11_2 then
		logError(string.format("FishingConfig:getFishingPoolCfg error, cfg is nil, poolId:%s", arg_11_1))
	end

	return var_11_0
end

function var_0_0.getFishingPoolItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getFishingPoolCfg(arg_12_1, true)

	if var_12_0 then
		return string.splitToNumber(var_12_0.item, "#")
	end
end

function var_0_0.getFishingShareItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getFishingPoolCfg(arg_13_1, true)

	if var_13_0 then
		return string.splitToNumber(var_13_0.share_item, "#")
	end
end

function var_0_0.getFishingTime(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getFishingPoolCfg(arg_14_1, true)

	return var_14_0 and var_14_0.time
end

function var_0_0.getFishingExchangeCfg(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = lua_fishing_exchange.configDict[arg_15_1]

	if not var_15_0 and arg_15_2 then
		logError(string.format("FishingConfig:getFishingExchangeCfg error, cfg is nil, times:%s", arg_15_1))
	end

	return var_15_0
end

function var_0_0.getMaxCostExchangeTimes(arg_16_0)
	if not arg_16_0.maxCostExchangeTimes then
		arg_16_0.maxCostExchangeTimes = 0

		for iter_16_0, iter_16_1 in ipairs(lua_fishing_exchange.configList) do
			arg_16_0.maxCostExchangeTimes = math.max(arg_16_0.maxCostExchangeTimes, iter_16_1.times)
		end
	end

	return arg_16_0.maxCostExchangeTimes
end

function var_0_0.getExchangeCost(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0:getFishingExchangeCfg(arg_17_1)

	if not var_17_0 then
		local var_17_1 = arg_17_0:getMaxCostExchangeTimes()

		var_17_0 = arg_17_0:getFishingExchangeCfg(var_17_1)
	end

	return var_17_0.num
end

var_0_0.instance = var_0_0.New()

return var_0_0
