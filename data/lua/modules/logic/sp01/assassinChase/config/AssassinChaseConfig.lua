module("modules.logic.sp01.assassinChase.config.AssassinChaseConfig", package.seeall)

local var_0_0 = class("AssassinChaseConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity206_const",
		"activity206_reward_direction",
		"activity206_reward_group",
		"activity206_reward",
		"activity206_dialogue",
		"activity206_desc"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._dialogueConfigListDic = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity206_const" then
		arg_3_0._constConfig = arg_3_2
	elseif arg_3_1 == "activity206_reward_direction" then
		arg_3_0._rewardDirectionConfig = arg_3_2
	elseif arg_3_1 == "activity206_reward_group" then
		arg_3_0._rewardGroupConfig = arg_3_2
	elseif arg_3_1 == "activity206_reward" then
		arg_3_0._rewardConfig = arg_3_2
	elseif arg_3_1 == "activity206_dialogue" then
		arg_3_0._dialogueConfig = arg_3_2
	elseif arg_3_1 == "activity206_desc" then
		arg_3_0._descConfig = arg_3_2
	end
end

function var_0_0.getDescConfig(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._descConfig == nil or arg_4_0._descConfig.configDict[arg_4_1] == nil then
		return nil
	end

	return arg_4_0._descConfig.configDict[arg_4_1][arg_4_2]
end

function var_0_0.getConstConfig(arg_5_0, arg_5_1)
	if not arg_5_0._constConfig then
		return nil
	end

	return arg_5_0._constConfig.configDict[arg_5_1]
end

function var_0_0.getRewardConfig(arg_6_0, arg_6_1)
	if not arg_6_0._rewardConfig then
		return nil
	end

	return arg_6_0._rewardConfig.configDict[arg_6_1]
end

function var_0_0.getDirectionConfig(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._rewardDirectionConfig == nil or arg_7_0._rewardDirectionConfig.configDict[arg_7_1] == nil then
		return nil
	end

	return arg_7_0._rewardDirectionConfig.configDict[arg_7_1][arg_7_2]
end

function var_0_0.getDialogueConfigList(arg_8_0, arg_8_1)
	if not arg_8_0._dialogueConfigListDic or not arg_8_0._dialogueConfig.configDict[arg_8_1] then
		return nil
	end

	if not arg_8_0._dialogueConfigListDic[arg_8_1] then
		local var_8_0 = {}
		local var_8_1 = arg_8_0._dialogueConfig.configDict[arg_8_1]

		for iter_8_0, iter_8_1 in pairs(var_8_1) do
			table.insert(var_8_0, iter_8_1)
		end

		table.sort(var_8_0, arg_8_0.sortDialogueConfigList)

		arg_8_0._dialogueConfigListDic[arg_8_1] = var_8_0
	end

	return arg_8_0._dialogueConfigListDic[arg_8_1]
end

function var_0_0.sortDialogueConfigList(arg_9_0, arg_9_1)
	return arg_9_0.chaseId < arg_9_1.chaseId
end

var_0_0.instance = var_0_0.New()

return var_0_0
