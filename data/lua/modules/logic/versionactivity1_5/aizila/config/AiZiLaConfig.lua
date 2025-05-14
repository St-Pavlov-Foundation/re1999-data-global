module("modules.logic.versionactivity1_5.aizila.config.AiZiLaConfig", package.seeall)

local var_0_0 = class("AiZiLaConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._actMap = nil
	arg_1_0._episodeConfig = nil
	arg_1_0._episodeListDict = {}
	arg_1_0._storyConfig = nil
	arg_1_0._storyListDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity144_episode",
		"activity144_story",
		"activity144_task",
		"activity144_equip",
		"activity144_round",
		"activity144_event",
		"activity144_item",
		"activity144_episode_showtarget",
		"activity144_option",
		"activity144_option_result",
		"activity144_record_event",
		"activity144_buff"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity144_episode" then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == "activity144_story" then
		arg_3_0._storyConfig = arg_3_2
	elseif arg_3_1 == "activity144_task" then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == "activity144_equip" then
		arg_3_0._equipConfig = arg_3_2

		arg_3_0:_initEquipCfg()
	elseif arg_3_1 == "activity144_round" then
		arg_3_0._roundConfig = arg_3_2
	elseif arg_3_1 == "activity144_event" then
		arg_3_0._eventConfig = arg_3_2
	elseif arg_3_1 == "activity144_item" then
		arg_3_0._itemConfig = arg_3_2
	elseif arg_3_1 == "activity144_episode_showtarget" then
		arg_3_0._eqisodeShowTargetConfig = arg_3_2
	elseif arg_3_1 == "activity144_option" then
		arg_3_0._optionConfig = arg_3_2
	elseif arg_3_1 == "activity144_option_result" then
		arg_3_0._optionResultConfig = arg_3_2
	elseif arg_3_1 == "activity144_buff" then
		arg_3_0._buffConfig = arg_3_2
	elseif arg_3_1 == "activity144_record_event" then
		arg_3_0._recordEventConfig = arg_3_2
	end
end

function var_0_0._get2PrimarykeyCo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 and arg_4_1.configDict then
		local var_4_0 = arg_4_1.configDict[arg_4_2]

		return var_4_0 and var_4_0[arg_4_3]
	end

	return nil
end

function var_0_0._findListByActId(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 and arg_5_1.configList then
		local var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_1.configList) do
			if iter_5_1.activityId == arg_5_2 then
				table.insert(var_5_0, iter_5_1)
			end
		end

		return var_5_0
	end

	return nil
end

function var_0_0.getTaskList(arg_6_0, arg_6_1)
	return arg_6_0:_findListByActId(arg_6_0._taskConfig, arg_6_1)
end

function var_0_0.getItemList(arg_7_0)
	return arg_7_0._itemConfig and arg_7_0._itemConfig.configList
end

function var_0_0._initEquipCfg(arg_8_0)
	arg_8_0._equipUpLevelDict = {}
	arg_8_0._equipTypeListDict = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._equipConfig.configList) do
		if iter_8_1.preEquipId == 0 then
			local var_8_0 = iter_8_1.activityId

			if not arg_8_0._equipTypeListDict[var_8_0] then
				arg_8_0._equipTypeListDict[var_8_0] = {}
			end

			table.insert(arg_8_0._equipTypeListDict[var_8_0], iter_8_1)
		end
	end
end

function var_0_0.getEquipCo(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:_get2PrimarykeyCo(arg_9_0._equipConfig, arg_9_1, arg_9_2)
end

function var_0_0.getEquipCoByPreId(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._equipConfig.configList) do
		if iter_10_1.activityId == arg_10_1 and iter_10_1.preEquipId == arg_10_2 and (arg_10_3 == nil or arg_10_3 == iter_10_1.typeId) then
			return iter_10_1
		end
	end
end

function var_0_0.getEquipCoTypeList(arg_11_0, arg_11_1)
	return arg_11_0._equipTypeListDict and arg_11_0._equipTypeListDict[arg_11_1]
end

function var_0_0.getItemCo(arg_12_0, arg_12_1)
	return arg_12_0._itemConfig and arg_12_0._itemConfig.configDict[arg_12_1]
end

function var_0_0.getEpisodeShowTargetCo(arg_13_0, arg_13_1)
	return arg_13_0._eqisodeShowTargetConfig and arg_13_0._eqisodeShowTargetConfig.configDict[arg_13_1]
end

function var_0_0.getEpisodeCo(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0:_get2PrimarykeyCo(arg_14_0._episodeConfig, arg_14_1, arg_14_2)
end

function var_0_0.getRoundCo(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0._roundConfig.configList

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		if iter_15_1.activityId == arg_15_1 and iter_15_1.episodeId == arg_15_2 and iter_15_1.round == arg_15_3 then
			return iter_15_1
		end
	end
end

function var_0_0.getPassRoundCo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._roundConfig.configList
	local var_16_1

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1.activityId == arg_16_1 and iter_16_1.episodeId == arg_16_2 and iter_16_1.isPass == 1 and (not var_16_1 or var_16_1.round < iter_16_1.round) then
			var_16_1 = iter_16_1
		end
	end

	return var_16_1
end

function var_0_0.getRoundList(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._roundConfig.configList
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.activityId == arg_17_1 and iter_17_1.episodeId == arg_17_2 then
			table.insert(var_17_1, iter_17_1)
		end
	end

	return var_17_1
end

function var_0_0.getBuffCo(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._buffConfig then
		logError("AiZiLaConfig:getBuffCo(actId, buffId)")
	end

	return arg_18_0:_get2PrimarykeyCo(arg_18_0._buffConfig, arg_18_1, arg_18_2)
end

function var_0_0.getRecordEventCo(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_0:_get2PrimarykeyCo(arg_19_0._recordEventConfig, arg_19_1, arg_19_2)
end

function var_0_0.getRecordEventList(arg_20_0, arg_20_1)
	return arg_20_0:_findListByActId(arg_20_0._recordEventConfig, arg_20_1)
end

function var_0_0.getEventCo(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_0:_get2PrimarykeyCo(arg_21_0._eventConfig, arg_21_1, arg_21_2)
end

function var_0_0.getOptionCo(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0:_get2PrimarykeyCo(arg_22_0._optionConfig, arg_22_1, arg_22_2)
end

function var_0_0.getOptionResultCo(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_0:_get2PrimarykeyCo(arg_23_0._optionResultConfig, arg_23_1, arg_23_2)
end

function var_0_0.getEpisodeList(arg_24_0, arg_24_1)
	if arg_24_0._episodeListDict[arg_24_1] then
		return arg_24_0._episodeListDict[arg_24_1]
	end

	local var_24_0 = {}

	arg_24_0._episodeListDict[arg_24_1] = var_24_0

	if arg_24_0._episodeConfig and arg_24_0._episodeConfig.configDict[arg_24_1] then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._episodeConfig.configDict[arg_24_1]) do
			table.insert(var_24_0, iter_24_1)
		end

		table.sort(var_24_0, var_0_0.sortEpisode)
	end

	return var_24_0
end

function var_0_0.sortEpisode(arg_25_0, arg_25_1)
	if arg_25_0.episodeId ~= arg_25_1.episodeId then
		return arg_25_0.episodeId < arg_25_1.episodeId
	end
end

function var_0_0.getStoryList(arg_26_0, arg_26_1)
	if arg_26_0._storyListDict[arg_26_1] then
		return arg_26_0._storyListDict[arg_26_1]
	end

	local var_26_0 = {}

	arg_26_0._storyListDict[arg_26_1] = var_26_0

	if arg_26_0._storyConfig and arg_26_0._storyConfig.configDict[arg_26_1] then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._storyConfig.configDict[arg_26_1]) do
			table.insert(var_26_0, iter_26_1)
		end

		table.sort(var_26_0, var_0_0.sortStory)
	end

	return var_26_0
end

function var_0_0.sortStory(arg_27_0, arg_27_1)
	if arg_27_0.order ~= arg_27_1.order then
		return arg_27_0.order < arg_27_1.order
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
