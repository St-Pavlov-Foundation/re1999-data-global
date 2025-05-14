module("modules.logic.versionactivity2_1.aergusi.config.AergusiConfig", package.seeall)

local var_0_0 = class("AergusiConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._episodeConfig = nil
	arg_1_0._evidenceConfig = nil
	arg_1_0._dialogConfig = nil
	arg_1_0._bubbleConfig = nil
	arg_1_0._clueConfig = nil
	arg_1_0._taskConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity163_episode",
		"activity163_evidence",
		"activity163_dialog",
		"activity163_bubble",
		"activity163_clue",
		"activity163_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity163_episode" then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == "activity163_evidence" then
		arg_3_0._evidenceConfig = arg_3_2
	elseif arg_3_1 == "activity163_dialog" then
		arg_3_0._dialogConfig = arg_3_2
	elseif arg_3_1 == "activity163_bubble" then
		arg_3_0._bubbleConfig = arg_3_2
	elseif arg_3_1 == "activity163_clue" then
		arg_3_0._clueConfig = arg_3_2
	elseif arg_3_1 == "activity163_task" then
		arg_3_0._taskConfig = arg_3_2
	end
end

function var_0_0.getEpisodeConfigs(arg_4_0, arg_4_1)
	arg_4_1 = arg_4_1 or VersionActivity2_1Enum.ActivityId.Aergusi

	return arg_4_0._episodeConfig.configDict[arg_4_1]
end

function var_0_0.getEpisodeConfig(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1 = arg_5_1 or VersionActivity2_1Enum.ActivityId.Aergusi

	return arg_5_0._episodeConfig.configDict[arg_5_1][arg_5_2]
end

function var_0_0.getEvidenceConfig(arg_6_0, arg_6_1)
	return arg_6_0._evidenceConfig.configDict[arg_6_1]
end

function var_0_0.getDialogConfigs(arg_7_0, arg_7_1)
	return arg_7_0._dialogConfig.configDict[arg_7_1]
end

function var_0_0.getDialogConfig(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._dialogConfig.configDict[arg_8_1][arg_8_2]
end

function var_0_0.getEvidenceDialogConfigs(arg_9_0, arg_9_1)
	return arg_9_0._dialogConfig.configDict[arg_9_1]
end

function var_0_0.getBubbleConfigs(arg_10_0, arg_10_1)
	return arg_10_0._bubbleConfig.configDict[arg_10_1]
end

function var_0_0.getBubbleConfig(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._bubbleConfig.configDict[arg_11_1][arg_11_2]
end

function var_0_0.getClueConfigs(arg_12_0)
	return arg_12_0._clueConfig.configDict
end

function var_0_0.getClueConfig(arg_13_0, arg_13_1)
	return arg_13_0._clueConfig.configDict[arg_13_1]
end

function var_0_0.getTaskConfig(arg_14_0, arg_14_1)
	return arg_14_0._taskConfig.configDict[arg_14_1]
end

function var_0_0.getTaskByActId(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(arg_15_0._taskConfig.configList) do
		if iter_15_1.activityId == arg_15_1 then
			table.insert(var_15_0, iter_15_1)
		end
	end

	return var_15_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
