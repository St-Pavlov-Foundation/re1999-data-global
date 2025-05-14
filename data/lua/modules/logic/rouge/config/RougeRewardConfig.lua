module("modules.logic.rouge.config.RougeRewardConfig", package.seeall)

local var_0_0 = class("RougeRewardConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"rouge_reward",
		"rouge_reward_stage"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._rewardDict = {}
	arg_2_0._rewardList = {}
	arg_2_0._stageRewardDict = nil
	arg_2_0._bigRewardToStage = {}
	arg_2_0._stageToLayout = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "rouge_reward_stage" then
		arg_3_0._stageRewardDict = arg_3_2.configDict

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			if iter_3_1.bigRewardId then
				if arg_3_0._bigRewardToStage[iter_3_1.bigRewardId] == nil then
					arg_3_0._bigRewardToStage[iter_3_1.bigRewardId] = {}
				end

				table.insert(arg_3_0._bigRewardToStage[iter_3_1.bigRewardId], iter_3_1)
			end
		end
	end

	if arg_3_1 == "rouge_reward" then
		for iter_3_2, iter_3_3 in ipairs(arg_3_2.configList) do
			if iter_3_3.stage then
				if arg_3_0._rewardDict[iter_3_3.stage] == nil then
					arg_3_0._rewardDict[iter_3_3.stage] = {}
				end

				table.insert(arg_3_0._rewardDict[iter_3_3.stage], iter_3_3)
			end
		end

		arg_3_0._rewardList = arg_3_2.configDict
	end

	arg_3_0:_buildRewardByLayout()
end

function var_0_0._buildRewardByLayout(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._rewardDict) do
		if #iter_4_1 ~= 0 then
			if arg_4_0._stageToLayout[iter_4_0] == nil then
				arg_4_0._stageToLayout[iter_4_0] = {}
			end

			for iter_4_2, iter_4_3 in ipairs(iter_4_1) do
				if iter_4_3.pos and iter_4_3.pos ~= "" then
					local var_4_0 = string.split(iter_4_3.pos, "#")
					local var_4_1 = tonumber(var_4_0[1])

					if arg_4_0._stageToLayout[iter_4_0][var_4_1] == nil then
						arg_4_0._stageToLayout[iter_4_0][var_4_1] = {}
					end

					if not tabletool.indexOf(arg_4_0._stageToLayout[iter_4_0][var_4_1], iter_4_3) then
						table.insert(arg_4_0._stageToLayout[iter_4_0][var_4_1], iter_4_3)
					end
				end
			end
		end
	end
end

function var_0_0.getStageToLayourConfig(arg_5_0, arg_5_1, arg_5_2)
	return arg_5_0._stageToLayout[arg_5_1][arg_5_2]
end

function var_0_0.getRewardDict(arg_6_0)
	return arg_6_0._rewardDict
end

function var_0_0.getConfigById(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._rewardList[arg_7_1][arg_7_2]
end

function var_0_0.getRewardStageDictNum(arg_8_0, arg_8_1)
	return #arg_8_0._rewardDict[arg_8_1]
end

function var_0_0.getConfigByStage(arg_9_0, arg_9_1)
	if arg_9_0._rewardDict and arg_9_0._rewardDict[arg_9_1] then
		return arg_9_0._rewardDict[arg_9_1]
	end
end

function var_0_0.getConfigByStageAndId(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._rewardDict and arg_10_0._rewardDict[arg_10_1] then
		return arg_10_0._rewardDict[arg_10_1][arg_10_2]
	end
end

function var_0_0.getBigRewardConfigByStage(arg_11_0, arg_11_1)
	if arg_11_0._rewardDict and arg_11_0._rewardDict[arg_11_1] then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._rewardDict[arg_11_1]) do
			if iter_11_1 and iter_11_1.type == 1 then
				return iter_11_1
			end
		end
	end
end

function var_0_0.getStageCount(arg_12_0)
	return #arg_12_0._rewardDict
end

function var_0_0.getStageLayoutCount(arg_13_0, arg_13_1)
	return #arg_13_0._stageToLayout[arg_13_1]
end

function var_0_0.getPointLimitByStage(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:getStageRewardConfigById(arg_14_1, arg_14_2).pointLimit
end

function var_0_0.getNeedUnlockNum(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getConfigByStage(arg_15_1)
	local var_15_1 = 0

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if iter_15_1.type and iter_15_1.type == 2 then
				var_15_1 = var_15_1 + 1
			end
		end
	end

	return var_15_1
end

function var_0_0.getCurStageBigRewardConfig(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getConfigByStage(arg_16_1)

	if not var_16_0 then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1 and iter_16_1.type == 1 then
			return iter_16_1
		end
	end
end

function var_0_0.getStageRewardCount(arg_17_0, arg_17_1)
	return #arg_17_0._stageRewardDict[arg_17_1]
end

function var_0_0.getStageRewardConfig(arg_18_0, arg_18_1)
	return arg_18_0._stageRewardDict[arg_18_1]
end

function var_0_0.getStageRewardConfigById(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_0._stageRewardDict[arg_19_1][arg_19_2]
end

function var_0_0.getBigRewardToStageConfigById(arg_20_0, arg_20_1)
	return arg_20_0._bigRewardToStage[arg_20_1]
end

function var_0_0.getBigRewardToStage(arg_21_0)
	return arg_21_0._bigRewardToStage
end

var_0_0.instance = var_0_0.New()

return var_0_0
