module("modules.logic.versionactivity2_1.activity165.config.Activity165Config", package.seeall)

local var_0_0 = class("Activity165Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._storyCoDic = nil
	arg_1_0._storyEndCoDic = nil
	arg_1_0._keywordsCoDic = nil
	arg_1_0._stepCoDic = nil
	arg_1_0._rewardCoDic = nil
	arg_1_0._storyStepCoDic = nil
	arg_1_0._storyEndingCoDic = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity165_ending",
		"activity165_keyword",
		"activity165_step",
		"activity165_story",
		"activity165_reward"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity165_ending" then
		arg_3_0._storyEndCoDic = arg_3_2

		arg_3_0:initEndingConfig()
	elseif arg_3_1 == "activity165_keyword" then
		arg_3_0._keywordsCoDic = arg_3_2
	elseif arg_3_1 == "activity165_step" then
		arg_3_0._stepCoDic = arg_3_2

		arg_3_0:initStepCofig()
	elseif arg_3_1 == "activity165_story" then
		arg_3_0._storyCoDic = arg_3_2
		arg_3_0._storyCoMap = {}
		arg_3_0._storyElementList = {}
	elseif arg_3_1 == "activity165_reward" then
		arg_3_0._rewardCoDic = arg_3_2
	end
end

function var_0_0.initStepCofig(arg_4_0)
	arg_4_0._storyStepCoDic = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._stepCoDic.configList) do
		local var_4_0 = arg_4_0._storyStepCoDic[iter_4_1.belongStoryId]

		if not var_4_0 then
			var_4_0 = {}
			arg_4_0._storyStepCoDic[iter_4_1.belongStoryId] = var_4_0
		end

		table.insert(var_4_0, iter_4_1)
	end
end

function var_0_0.initEndingConfig(arg_5_0)
	arg_5_0._storyEndingCoDic = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0._storyEndCoDic.configList) do
		local var_5_0 = arg_5_0._storyEndingCoDic[iter_5_1.belongStoryId]

		if not var_5_0 then
			var_5_0 = {}
			arg_5_0._storyEndingCoDic[iter_5_1.belongStoryId] = var_5_0
		end

		var_5_0[tonumber(iter_5_1.finalStepId)] = iter_5_1
	end
end

function var_0_0.getStoryCo(arg_6_0, arg_6_1, arg_6_2)
	return arg_6_0._storyCoDic.configDict[arg_6_1] and arg_6_0._storyCoDic.configDict[arg_6_1][arg_6_2]
end

function var_0_0.getAllStoryCoList(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._storyCoMap[arg_7_1]

	if not var_7_0 then
		var_7_0 = {}

		local var_7_1 = arg_7_0._storyCoDic.configDict[arg_7_1] or {}

		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			table.insert(var_7_0, iter_7_1)
		end

		table.sort(var_7_0, function(arg_8_0, arg_8_1)
			return arg_8_0.storyId < arg_8_1.storyId
		end)

		arg_7_0._storyCoMap[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.getStoryElements(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getStoryCo(arg_9_1, arg_9_2)
	local var_9_1 = arg_9_0._storyElementList[arg_9_2]

	if not var_9_1 then
		var_9_1 = string.splitToNumber(var_9_0.unlockElementIds1, "#") or {}
		arg_9_0._storyElementList[arg_9_2] = var_9_1
	end

	return var_9_1
end

function var_0_0.getStepCo(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._stepCoDic.configDict[arg_10_2]
end

function var_0_0.getStoryStepCoList(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._storyStepCoDic[arg_11_2]
end

function var_0_0.getKeywordCo(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._keywordsCoDic.configDict[arg_12_2]
end

function var_0_0.getEndingCo(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._storyEndCoDic.configDict[arg_13_2]
end

function var_0_0.getStoryKeywordCoList(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0._keywordsCoDic.configList
	local var_14_1 = {}

	if var_14_0 then
		for iter_14_0, iter_14_1 in pairs(var_14_0) do
			if iter_14_1.belongStoryId == arg_14_2 then
				table.insert(var_14_1, iter_14_1)
			end
		end
	end

	return var_14_1
end

function var_0_0.getEndingCoByFinalStep(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_0._storyEndingCoDic and arg_15_0._storyEndingCoDic[arg_15_2] then
		local var_15_0 = arg_15_0._storyEndingCoDic[arg_15_2][arg_15_3]

		if var_15_0 then
			return var_15_0
		end
	end
end

function var_0_0.getEndingCosByStoryId(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._storyEndingCoDic then
		return arg_16_0._storyEndingCoDic[arg_16_2]
	end
end

function var_0_0.getStoryRewardCo(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	return arg_17_0._rewardCoDic.configDict[arg_17_2][arg_17_3]
end

function var_0_0.getStoryRewardCoList(arg_18_0, arg_18_1, arg_18_2)
	return arg_18_0._rewardCoDic.configDict[arg_18_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
