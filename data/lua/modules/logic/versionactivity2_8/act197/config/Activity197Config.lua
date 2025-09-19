module("modules.logic.versionactivity2_8.act197.config.Activity197Config", package.seeall)

local var_0_0 = class("Activity197Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity197",
		"activity197_pool",
		"actvity197_stage"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._poolList = {}
	arg_2_0._poolDict = {}
	arg_2_0._stageConfig = {}
	arg_2_0._rummageConsume = 1
	arg_2_0._exploreConsume = 1
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity197_pool" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			arg_3_0._poolDict[iter_3_1.poolId] = arg_3_0._poolDict[iter_3_1.poolId] or {}

			table.insert(arg_3_0._poolDict[iter_3_1.poolId], iter_3_1)
		end

		for iter_3_2, iter_3_3 in pairs(arg_3_0._poolDict) do
			table.insert(arg_3_0._poolList, iter_3_2)
		end
	elseif arg_3_1 == "activity197" then
		local var_3_0 = arg_3_2.configList[1]
		local var_3_1 = string.split(var_3_0.rummageConsume, "#")
		local var_3_2 = string.split(var_3_0.exploreConsume, "#")
		local var_3_3 = string.split(var_3_0.exploreItem, "#")

		arg_3_0._rummageConsume = var_3_1[3]
		arg_3_0._exploreConsume = var_3_2[3]
		arg_3_0._exploreGetCount = var_3_3[3]
	elseif arg_3_1 == "actvity197_stage" then
		arg_3_0._stageConfig = arg_3_2
	end
end

function var_0_0.getPoolList(arg_4_0)
	return arg_4_0._poolList
end

function var_0_0.getPoolCount(arg_5_0)
	return #arg_5_0._poolList
end

function var_0_0.getPoolConfigById(arg_6_0, arg_6_1)
	return arg_6_0._poolDict[arg_6_1]
end

function var_0_0.getPoolRewardCount(arg_7_0, arg_7_1)
	return #arg_7_0._poolDict[arg_7_1]
end

function var_0_0.getRummageConsume(arg_8_0)
	return arg_8_0._rummageConsume
end

function var_0_0.getExploreConsume(arg_9_0)
	return arg_9_0._exploreConsume
end

function var_0_0.getExploreGetCount(arg_10_0)
	return arg_10_0._exploreGetCount
end

function var_0_0.getStageConfig(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._stageConfig.configDict[arg_11_1]

	return var_11_0 and var_11_0[arg_11_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
