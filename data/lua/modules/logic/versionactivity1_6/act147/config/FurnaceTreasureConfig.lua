module("modules.logic.versionactivity1_6.act147.config.FurnaceTreasureConfig", package.seeall)

local var_0_0 = class("FurnaceTreasureConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity147",
		"activity147_goods"
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
	local var_4_0 = lua_activity147 and lua_activity147.configDict[arg_4_0] or nil

	if not var_4_0 and arg_4_1 then
		logError(string.format("FurnaceTreasureConfig.getAct147Cfg error, cfg is nil, id:%s", arg_4_0))
	end

	return var_4_0
end

function var_0_0.getDescList(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = var_0_1(arg_5_1, true)

	if var_5_1 then
		local var_5_2 = var_5_1.descList

		var_5_0 = string.split(var_5_2, "|")
	end

	return var_5_0
end

function var_0_0.getRewardList(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = var_0_1(arg_6_1, true)

	if var_6_1 then
		local var_6_2 = var_6_1.rewardList

		var_6_0 = ItemModel.instance:getItemDataListByConfigStr(var_6_2)
	end

	return var_6_0
end

function var_0_0.getSpineRes(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = var_0_1(arg_7_1, true)

	if var_7_1 then
		var_7_0 = var_7_1.spineRes
	end

	return var_7_0
end

function var_0_0.getDialogList(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = var_0_1(arg_8_1, true)

	if var_8_1 then
		local var_8_2 = var_8_1.dialogs

		var_8_0 = string.split(var_8_2, "|")
	end

	return var_8_0
end

function var_0_0.getJumpId(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = var_0_1(arg_9_1, true)

	if var_9_1 then
		var_9_0 = var_9_1.jumpId
	end

	return var_9_0
end

local function var_0_2(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = FurnaceTreasureModel.instance:getActId()

	if lua_activity147_goods and lua_activity147_goods.configDict[var_10_1] then
		var_10_0 = lua_activity147_goods.configDict[var_10_1][arg_10_0]
	end

	if not var_10_0 and arg_10_1 then
		logError(string.format("FurnaceTreasureConfig.get147GoodCfg error, cfg is nil, actId:%s,goodsId:%s", var_10_1, arg_10_0))
	end

	return var_10_0
end

function var_0_0.get147GoodsCost(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1 = var_0_2(arg_11_1, true)

	if var_11_1 then
		var_11_0 = var_11_1.cost
	end

	return var_11_0
end

function var_0_0.getAct147GoodsShowItem(arg_12_0, arg_12_1)
	local var_12_0 = 0
	local var_12_1 = 0
	local var_12_2 = 0
	local var_12_3 = arg_12_1 and FurnaceTreasureEnum.Pool2GoodsId[arg_12_1] or nil

	if var_12_3 then
		local var_12_4 = string.splitToNumber(var_12_3, "#")

		var_12_0 = var_12_4[1] or 0
		var_12_1 = var_12_4[2] or 0
		var_12_2 = var_12_4[3] or 0
	else
		logError(string.format("FurnaceTreasureConfig:getAct147GoodsShowItem error, can't get strShowItem, poolId:%s", arg_12_1))
	end

	return var_12_0, var_12_1, var_12_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
