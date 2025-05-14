module("modules.logic.versionactivity2_5.act186.config.Activity186Config", package.seeall)

local var_0_0 = class("Activity186Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity186_const",
		"actvity186_stage",
		"actvity186_daily_group",
		"actvity186_task",
		"actvity186_like",
		"actvity186_mini_game",
		"actvity186_mini_game_reward",
		"actvity186_mini_game_question",
		"actvity186_voice",
		"actvity186_milestone_bonus"
	}
end

function var_0_0.onConfigLoaded(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.format("_on%sLoad", arg_2_1)

	if arg_2_0[var_2_0] then
		arg_2_0[var_2_0](arg_2_0, arg_2_2)
	end
end

function var_0_0._onactvity186_stageLoad(arg_3_0, arg_3_1)
	arg_3_0.stageConfig = arg_3_1
end

function var_0_0._onactvity186_mini_game_rewardLoad(arg_4_0, arg_4_1)
	arg_4_0.gameRewardConfig = arg_4_1
end

function var_0_0._onactvity186_milestone_bonusLoad(arg_5_0, arg_5_1)
	arg_5_0.mileStoneConfig = arg_5_1
end

function var_0_0._onactivity186_constLoad(arg_6_0, arg_6_1)
	arg_6_0.constConfig = arg_6_1
end

function var_0_0._onactvity186_mini_game_questionLoad(arg_7_0, arg_7_1)
	arg_7_0.questionConfig = arg_7_1
end

function var_0_0._onactvity186_taskLoad(arg_8_0, arg_8_1)
	arg_8_0.taskConfig = arg_8_1
end

function var_0_0._onactvity186_voiceLoad(arg_9_0, arg_9_1)
	arg_9_0.voiceConfig = arg_9_1
end

function var_0_0.getStageConfig(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.stageConfig.configDict[arg_10_1]

	return var_10_0 and var_10_0[arg_10_2]
end

function var_0_0.getGameRewardConfig(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.gameRewardConfig.configDict[arg_11_1]

	return var_11_0 and var_11_0[arg_11_2]
end

function var_0_0.getMileStoneList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.mileStoneConfig.configDict[arg_12_1]
	local var_12_1 = {}

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		table.insert(var_12_1, iter_12_1)
	end

	table.sort(var_12_1, SortUtil.keyLower("coinNum"))

	return var_12_1
end

function var_0_0.getMileStoneConfig(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.mileStoneConfig.configDict[arg_13_1]

	return var_13_0 and var_13_0[arg_13_2]
end

function var_0_0.getVoiceConfig(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0.voiceConfig.configList) do
		if iter_14_1.type == arg_14_1 and (not arg_14_2 or arg_14_2(iter_14_1)) then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.getTaskConfig(arg_15_0, arg_15_1)
	return arg_15_0.taskConfig.configDict[arg_15_1]
end

function var_0_0.getNextQuestion(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0.questionConfig.configDict[arg_16_1]
	local var_16_1 = {}

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		table.insert(var_16_1, iter_16_1)
	end

	if #var_16_1 > 1 then
		table.sort(var_16_1, SortUtil.keyLower("sort"))
	end

	local var_16_2

	for iter_16_2, iter_16_3 in ipairs(var_16_1) do
		if iter_16_3.id == arg_16_2 then
			var_16_2 = iter_16_2

			break
		end
	end

	if var_16_2 == nil then
		return var_16_1[math.random(1, #var_16_1)]
	else
		local var_16_3 = var_16_2 + 1

		if var_16_3 > #var_16_1 then
			var_16_3 = 1
		end

		return var_16_1[var_16_3]
	end
end

function var_0_0.getQuestionConfig(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.questionConfig.configDict[arg_17_1]

	return var_17_0 and var_17_0[arg_17_2]
end

function var_0_0.getConstNum(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getConstStr(arg_18_1)

	if string.nilorempty(var_18_0) then
		return 0
	else
		return tonumber(var_18_0)
	end
end

function var_0_0.getConstStr(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.constConfig.configDict[arg_19_1]

	if not var_19_0 then
		return nil
	end

	local var_19_1 = var_19_0.value

	if not string.nilorempty(var_19_1) then
		return var_19_1
	end

	return var_19_0.value2
end

var_0_0.instance = var_0_0.New()

return var_0_0
