module("modules.logic.versionactivity1_4.act129.config.Activity129Config", package.seeall)

local var_0_0 = class("Activity129Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.poolDict = {}
	arg_1_0.constDict = {}
	arg_1_0.goodsDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity129_pool",
		"activity129_const",
		"activity129_goods"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("on%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_1, arg_3_2)
	end
end

function var_0_0.onactivity129_poolConfigLoaded(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.poolDict = arg_4_2.configDict
end

function var_0_0.onactivity129_constConfigLoaded(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.constDict = arg_5_2.configDict
end

function var_0_0.onactivity129_goodsConfigLoaded(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.goodsDict = arg_6_2.configDict
end

function var_0_0.getConstValue1(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.constDict[arg_7_1]
	local var_7_1 = var_7_0 and var_7_0[arg_7_2] and var_7_0[arg_7_2].value1

	if not var_7_1 then
		logError(string.format("can not find constvalue! activityId:%s constId:%s", arg_7_1, arg_7_2))
	end

	return var_7_1
end

function var_0_0.getConstValue2(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.constDict[arg_8_1]
	local var_8_1 = var_8_0 and var_8_0[arg_8_2] and var_8_0[arg_8_2].value2

	if not var_8_1 then
		logError(string.format("can not find constvalue! activityId:%s constId:%s", arg_8_1, arg_8_2))
	end

	return var_8_1
end

function var_0_0.getPoolConfig(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.poolDict[arg_9_1]
	local var_9_1 = var_9_0 and var_9_0[arg_9_2]

	if not var_9_1 then
		logError(string.format("can not find pool config! activityId:%s poolId:%s", arg_9_1, arg_9_2))
	end

	return var_9_1
end

function var_0_0.getPoolDict(arg_10_0, arg_10_1)
	return arg_10_0.poolDict[arg_10_1]
end

function var_0_0.getGoodsDict(arg_11_0, arg_11_1)
	return arg_11_0.goodsDict[arg_11_1]
end

function var_0_0.getRewardConfig(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_0.rewardDict then
		arg_12_0.rewardDict = {}

		for iter_12_0, iter_12_1 in pairs(arg_12_0.goodsDict) do
			arg_12_0.rewardDict[iter_12_0] = {}

			for iter_12_2, iter_12_3 in pairs(iter_12_1) do
				arg_12_0.rewardDict[iter_12_0][iter_12_2] = {}

				local var_12_0 = GameUtil.splitString2(iter_12_3.goodsId, true)

				if var_12_0 then
					for iter_12_4, iter_12_5 in ipairs(var_12_0) do
						if not arg_12_0.rewardDict[iter_12_0][iter_12_2][iter_12_5[1]] then
							arg_12_0.rewardDict[iter_12_0][iter_12_2][iter_12_5[1]] = {}
						end

						arg_12_0.rewardDict[iter_12_0][iter_12_2][iter_12_5[1]][iter_12_5[2]] = iter_12_5
					end
				end
			end
		end
	end

	if not arg_12_0.rewardDict[arg_12_1] then
		return
	end

	if not arg_12_0.rewardDict[arg_12_1][arg_12_2] then
		return
	end

	if not arg_12_0.rewardDict[arg_12_1][arg_12_2][arg_12_3] then
		return
	end

	return arg_12_0.rewardDict[arg_12_1][arg_12_2][arg_12_3][arg_12_4]
end

var_0_0.instance = var_0_0.New()

return var_0_0
