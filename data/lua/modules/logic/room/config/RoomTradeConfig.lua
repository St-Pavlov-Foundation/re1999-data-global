module("modules.logic.room.config.RoomTradeConfig", package.seeall)

local var_0_0 = class("RoomTradeConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._constConfig = nil
	arg_1_0._qualityConfig = nil
	arg_1_0._refreshConfig = nil
	arg_1_0._barrageConfig = nil
	arg_1_0._taskConfig = nil
	arg_1_0._supportBonusConfig = nil
	arg_1_0._levelUnlockConfig = nil
	arg_1_0._levelConfig = nil
	arg_1_0._qualityDic = nil
	arg_1_0._refreshDic = nil
	arg_1_0._barrageDic = nil
	arg_1_0._taskDic = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"room_order_const",
		"room_order_quality",
		"room_order_refresh",
		"room_trade_barrage",
		"trade_task",
		"trade_support_bonus",
		"trade_level_unlock",
		"trade_level"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "room_order_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "room_order_quality" then
		arg_3_0._qualityConfig = arg_3_2

		arg_3_0:_initOrderQualityCo()
	elseif arg_3_1 == "room_order_refresh" then
		arg_3_0._refreshConfig = arg_3_2

		arg_3_0:_initOrderRefreshCo()
	elseif arg_3_1 == "room_trade_barrage" then
		arg_3_0._barrageConfig = arg_3_2

		arg_3_0:_initBarrageCo()
	elseif arg_3_1 == "trade_task" then
		arg_3_0._taskConfig = arg_3_2

		arg_3_0:_initTaskCo()
	elseif arg_3_1 == "trade_support_bonus" then
		arg_3_0._supportBonusConfig = arg_3_2
	elseif arg_3_1 == "trade_level_unlock" then
		arg_3_0._levelUnlockConfig = arg_3_2
	elseif arg_3_1 == "trade_level" then
		arg_3_0._levelConfig = arg_3_2
	end
end

function var_0_0.getConstValue(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._constConfig and arg_4_0._constConfig.configDict[arg_4_1]

	if var_4_0 then
		if arg_4_2 then
			return tonumber(var_4_0.value)
		end

		return var_4_0.value
	end
end

function var_0_0._initOrderRefreshCo(arg_5_0)
	arg_5_0._refreshDic = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._refreshConfig.configList) do
		local var_5_0 = GameUtil.splitString2(iter_5_1.qualityWeight, true)
		local var_5_1 = GameUtil.splitString2(iter_5_1.wholesaleGoodsWeight, true)
		local var_5_2 = {
			daily = var_5_0,
			wholesale = var_5_1,
			co = iter_5_1
		}

		table.insert(arg_5_0._refreshDic, var_5_2)
	end
end

function var_0_0.getOrderRefreshInfo(arg_6_0, arg_6_1)
	return arg_6_0._refreshDic[arg_6_1]
end

function var_0_0._initOrderQualityCo(arg_7_0)
	arg_7_0._qualityDic = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._qualityConfig.configList) do
		local var_7_0 = GameUtil.splitString2(iter_7_1.goodsWeight, true)
		local var_7_1 = string.split(iter_7_1.typeCount, "|")
		local var_7_2 = {
			co = iter_7_1,
			goodsWeight = var_7_0,
			typeCount = var_7_1
		}

		table.insert(arg_7_0._qualityDic, var_7_2)
	end
end

function var_0_0.getOrderQualityInfo(arg_8_0, arg_8_1)
	return arg_8_0._qualityDic[arg_8_1]
end

function var_0_0._initBarrageCo(arg_9_0)
	if not arg_9_0._barrageDic then
		arg_9_0._barrageDic = {}
	end

	if not arg_9_0._barrageTypeCount then
		arg_9_0._barrageTypeCount = {}
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._barrageConfig.configList) do
		local var_9_0 = iter_9_1.type
		local var_9_1 = arg_9_0._barrageDic[var_9_0]

		if not var_9_1 then
			var_9_1 = {}
			arg_9_0._barrageDic[var_9_0] = var_9_1
		end

		table.insert(var_9_1, iter_9_1)
	end

	for iter_9_2, iter_9_3 in pairs(RoomTradeEnum.BarrageType) do
		arg_9_0._barrageTypeCount[iter_9_3] = arg_9_0._barrageDic[iter_9_3] and #arg_9_0._barrageDic[iter_9_3]
	end
end

function var_0_0.getBarrageCosByType(arg_10_0, arg_10_1)
	local var_10_0 = {}

	if not arg_10_0._barrageDic then
		return var_10_0
	end

	return arg_10_0._barrageDic[arg_10_1]
end

function var_0_0.getBarrageCoByTypeIndex(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._barrageDic or not arg_11_0._barrageDic[arg_11_1] then
		return
	end

	return arg_11_0._barrageDic[arg_11_1][arg_11_2]
end

function var_0_0.getBarrageTypeCount(arg_12_0, arg_12_1)
	return arg_12_0._barrageTypeCount[arg_12_1] or 0
end

function var_0_0._initTaskCo(arg_13_0)
	arg_13_0._taskDic = {}
	arg_13_0._taskMaxLevel = 0

	for iter_13_0, iter_13_1 in ipairs(arg_13_0._taskConfig.configList) do
		local var_13_0 = iter_13_1.tradeLevel
		local var_13_1 = arg_13_0._taskDic[var_13_0]

		if not var_13_1 then
			var_13_1 = {}
			arg_13_0._taskDic[var_13_0] = var_13_1
		end

		arg_13_0._taskMaxLevel = math.max(arg_13_0._taskMaxLevel, var_13_0)

		table.insert(var_13_1, iter_13_1)
	end
end

function var_0_0.getTaskCosByLevel(arg_14_0, arg_14_1)
	return arg_14_0._taskDic[arg_14_1]
end

function var_0_0.getTaskCoById(arg_15_0, arg_15_1)
	return arg_15_0._taskConfig.configDict[arg_15_1]
end

function var_0_0.getSupportBonusById(arg_16_0, arg_16_1)
	return arg_16_0._supportBonusConfig.configDict[arg_16_1]
end

function var_0_0.getSupportBonusConfig(arg_17_0)
	return arg_17_0._supportBonusConfig.configList
end

function var_0_0.getTaskMaxLevel(arg_18_0)
	return arg_18_0._taskMaxLevel
end

function var_0_0.getLevelUnlockCo(arg_19_0, arg_19_1)
	return arg_19_0._levelUnlockConfig.configDict[arg_19_1]
end

function var_0_0.getLevelCo(arg_20_0, arg_20_1)
	return arg_20_0._levelConfig.configDict[arg_20_1]
end

function var_0_0.getMaxLevel(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._levelConfig.configList) do
		var_21_0 = math.max(var_21_0, iter_21_1.level)
	end

	return var_21_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
