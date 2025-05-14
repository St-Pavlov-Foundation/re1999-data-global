module("modules.logic.turnback.config.TurnbackConfig", package.seeall)

local var_0_0 = class("TurnbackConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._turnbackConfig = nil
	arg_1_0._turnbackSigninConfig = nil
	arg_1_0._turnbackTaskConfig = nil
	arg_1_0._turnbackSubModuleConfig = nil
	arg_1_0._turnbackTaskBonusConfig = nil
	arg_1_0._turnbackRecommendConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"turnback",
		"turnback_sign_in",
		"turnback_task",
		"turnback_submodule",
		"turnback_task_bonus",
		"turnback_recommend",
		"turnback_drop"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "turnback" then
		arg_3_0:initTurnbackConfig(arg_3_2)
	elseif arg_3_1 == "turnback_sign_in" then
		arg_3_0._turnbackSigninConfig = arg_3_2
	elseif arg_3_1 == "turnback_task" then
		arg_3_0._turnbackTaskConfig = arg_3_2
	elseif arg_3_1 == "turnback_submodule" then
		arg_3_0._turnbackSubModuleConfig = arg_3_2
	elseif arg_3_1 == "turnback_task_bonus" then
		arg_3_0._turnbackTaskBonusConfig = arg_3_2
	elseif arg_3_1 == "turnback_recommend" then
		arg_3_0._turnbackRecommendConfig = arg_3_2
	elseif arg_3_1 == "turnback_drop" then
		arg_3_0._turnbackDropConfig = arg_3_2
	end
end

function var_0_0.initTurnbackConfig(arg_4_0, arg_4_1)
	arg_4_0._turnbackConfig = arg_4_1
	arg_4_0.turnBackAdditionChapterId = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1.configDict) do
		local var_4_0 = {}
		local var_4_1 = string.splitToNumber(iter_4_1.additionChapterIds, "#")

		for iter_4_2, iter_4_3 in ipairs(var_4_1) do
			var_4_0[iter_4_3] = true
		end

		arg_4_0.turnBackAdditionChapterId[iter_4_0] = var_4_0
	end
end

function var_0_0.isTurnBackAdditionToChapter(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false

	if arg_5_1 and arg_5_2 and arg_5_0.turnBackAdditionChapterId and arg_5_0.turnBackAdditionChapterId[arg_5_1] then
		var_5_0 = arg_5_0.turnBackAdditionChapterId[arg_5_1][arg_5_2]
	end

	return var_5_0
end

function var_0_0.getTurnbackCo(arg_6_0, arg_6_1)
	return arg_6_0._turnbackConfig.configDict[arg_6_1]
end

function var_0_0.getTurnbackSignInCo(arg_7_0, arg_7_1)
	return arg_7_0._turnbackSigninConfig.configDict[arg_7_1]
end

function var_0_0.getTurnbackSignInDayCo(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._turnbackSigninConfig.configDict[arg_8_1][arg_8_2]
end

function var_0_0.getTurnbackTaskCo(arg_9_0, arg_9_1)
	return arg_9_0._turnbackTaskConfig.configDict[arg_9_1]
end

function var_0_0.getTurnbackSubModuleCo(arg_10_0, arg_10_1)
	return arg_10_0._turnbackSubModuleConfig.configDict[arg_10_1]
end

function var_0_0.getAllTurnbackTaskBonusCo(arg_11_0, arg_11_1)
	return arg_11_0._turnbackTaskBonusConfig.configDict[arg_11_1]
end

function var_0_0.getTurnbackTaskBonusCo(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._turnbackTaskBonusConfig.configDict[arg_12_1][arg_12_2]
end

function var_0_0.getTurnbackLastBounsPoint(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._turnbackTaskBonusConfig.configDict[arg_13_1]

	if var_13_0 then
		return var_13_0[#var_13_0].needPoint
	end

	return 0
end

function var_0_0.getAllTurnbackTaskBonusCoCount(arg_14_0, arg_14_1)
	return #arg_14_0._turnbackTaskBonusConfig.configList[arg_14_1]
end

function var_0_0.getAllTurnbackSubModules(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getTurnbackCo(arg_15_1)

	return (string.splitToNumber(var_15_0.subModuleIds, "#"))
end

function var_0_0.getTurnbackSubViewCo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0:getAllTurnbackSubModules(arg_16_1)
	local var_16_1

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1 == arg_16_2 then
			var_16_1 = arg_16_0:getTurnbackSubModuleCo(iter_16_1)

			break
		end
	end

	return var_16_1
end

function var_0_0.getAdditionTotalCount(arg_17_0, arg_17_1)
	local var_17_0 = 0
	local var_17_1 = arg_17_0:getTurnbackCo(arg_17_1)

	if var_17_1 then
		var_17_0 = string.splitToNumber(var_17_1.additionType, "#")[2] or 0
	end

	return var_17_0
end

function var_0_0.getAdditionRate(arg_18_0, arg_18_1)
	local var_18_0 = 0
	local var_18_1 = arg_18_0:getTurnbackCo(arg_18_1)

	if var_18_1 then
		var_18_0 = var_18_1.additionRate
	end

	return var_18_0
end

function var_0_0.getAdditionDurationDays(arg_19_0, arg_19_1)
	local var_19_0 = 0
	local var_19_1 = arg_19_0:getTurnbackCo(arg_19_1)

	if var_19_1 then
		var_19_0 = var_19_1.additionDurationDays
	end

	return var_19_0
end

function var_0_0.getOnlineDurationDays(arg_20_0, arg_20_1)
	local var_20_0 = 0
	local var_20_1 = arg_20_0:getTurnbackCo(arg_20_1)

	if var_20_1 then
		var_20_0 = var_20_1.onlineDurationDays
	end

	return var_20_0
end

function var_0_0.getTaskItemBonusPoint(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1 = arg_21_0:getBonusPointCo(arg_21_1)
	local var_21_2 = arg_21_0:getTurnbackTaskCo(arg_21_2)
	local var_21_3 = string.split(var_21_2.bonus, "|")

	for iter_21_0, iter_21_1 in ipairs(var_21_3) do
		local var_21_4 = string.split(iter_21_1, "#")

		if tonumber(var_21_4[1]) == var_21_0 and tonumber(var_21_4[2]) == var_21_1 then
			return tonumber(var_21_4[3]) or 0
		end
	end
end

function var_0_0.getBonusPointCo(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getTurnbackCo(arg_22_1)
	local var_22_1 = string.split(var_22_0.bonusPointMaterial, "#")
	local var_22_2 = tonumber(var_22_1[1])
	local var_22_3 = tonumber(var_22_1[2])

	return var_22_2, var_22_3
end

function var_0_0.getAllRecommendCo(arg_23_0, arg_23_1)
	return arg_23_0._turnbackRecommendConfig.configDict[arg_23_1]
end

function var_0_0.getAllRecommendList(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._turnbackRecommendConfig.configList
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.turnbackId == arg_24_1 then
			table.insert(var_24_1, iter_24_1)
		end
	end

	return var_24_1
end

function var_0_0.getRecommendCo(arg_25_0, arg_25_1, arg_25_2)
	return arg_25_0._turnbackRecommendConfig.configDict[arg_25_1][arg_25_2]
end

function var_0_0.getSearchTaskCoList(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0._turnbackTaskConfig.configList) do
		if iter_26_1.listenerType == "TodayOnlineSeconds" then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function var_0_0.getDropCoList(arg_27_0)
	return arg_27_0._turnbackDropConfig.configList
end

function var_0_0.getDropCoById(arg_28_0, arg_28_1)
	return arg_28_0._turnbackDropConfig.configDict[arg_28_1]
end

function var_0_0.getDropCoCount(arg_29_0)
	return #arg_29_0._turnbackDropConfig.configList
end

var_0_0.instance = var_0_0.New()

return var_0_0
