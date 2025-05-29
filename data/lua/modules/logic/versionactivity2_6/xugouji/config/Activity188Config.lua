module("modules.logic.versionactivity2_6.xugouji.config.Activity188Config", package.seeall)

local var_0_0 = class("Activity188Config", BaseConfig)

function var_0_0.onInit(arg_1_0)
	arg_1_0._episodeCfg = nil
	arg_1_0._gameCfg = nil
	arg_1_0._aiCfg = nil
	arg_1_0._abilityCfg = nil
	arg_1_0._skillCfg = nil
	arg_1_0._taskCfg = nil
	arg_1_0._buffCfg = nil
	arg_1_0._cardCfg = nil
	arg_1_0._constCfg = nil
	arg_1_0._episodeDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity188_episode",
		"activity188_game",
		"activity188_ai",
		"activity188_ability",
		"activity188_skill",
		"activity188_buff",
		"activity188_task",
		"activity188_card",
		"activity188_const"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity188_episode" then
		arg_3_0._episodeCfg = arg_3_2
		arg_3_0._episodeDict = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_0._episodeCfg.configList) do
			arg_3_0._episodeDict[iter_3_1.activityId] = arg_3_0._episodeDict[iter_3_1.activityId] or {}

			table.insert(arg_3_0._episodeDict[iter_3_1.activityId], iter_3_1)
		end
	elseif arg_3_1 == "activity188_game" then
		arg_3_0._gameCfg = arg_3_2
	elseif arg_3_1 == "activity188_ai" then
		arg_3_0._aiCfg = arg_3_2
	elseif arg_3_1 == "activity188_ability" then
		arg_3_0._abilityCfg = arg_3_2
	elseif arg_3_1 == "activity188_skill" then
		arg_3_0._skillCfg = arg_3_2
	elseif arg_3_1 == "activity188_task" then
		arg_3_0._taskCfg = arg_3_2
	elseif arg_3_1 == "activity188_buff" then
		arg_3_0._buffCfg = arg_3_2
	elseif arg_3_1 == "activity188_card" then
		arg_3_0._cardCfg = arg_3_2
	elseif arg_3_1 == "activity188_const" then
		arg_3_0._constCfg = arg_3_2
	end
end

function var_0_0.getEpisodeCfgList(arg_4_0, arg_4_1)
	return arg_4_0._episodeDict[arg_4_1] or {}
end

function var_0_0.getEpisodeCfg(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0._episodeDict[arg_5_1]

	if not var_5_0 then
		return nil
	end

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.episodeId == arg_5_2 then
			return iter_5_1
		end
	end
end

function var_0_0.getEpisodeCfgByEpisodeId(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._episodeDict) do
		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			if iter_6_3.episodeId == arg_6_1 then
				return iter_6_3
			end
		end
	end
end

function var_0_0.getEpisodeCfgByPreEpisodeId(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._episodeDict) do
		for iter_7_2, iter_7_3 in ipairs(iter_7_1) do
			if iter_7_3.preEpisodeId == arg_7_1 then
				return iter_7_3
			end
		end
	end
end

function var_0_0.getEventCfg(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._eventConfig.configDict[arg_8_1]

	return var_8_0 and var_8_0[arg_8_2]
end

function var_0_0.getCardCfg(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0._cardCfg.configDict[arg_9_1][arg_9_2]
end

function var_0_0.getCardSkillCfg(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0._skillCfg.configDict[arg_10_1][arg_10_2]
end

function var_0_0.getGameCfg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0._gameCfg.configDict[arg_11_1]

	return var_11_0 and var_11_0[arg_11_2]
end

function var_0_0.getAbilityCfg(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._abilityCfg.configDict[arg_12_1][arg_12_2]
end

function var_0_0.getGameItemListCfg(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = arg_13_0._itemConfig.configDict[arg_13_1]

	for iter_13_0, iter_13_1 in pairs(var_13_1) do
		if arg_13_2 == nil or iter_13_1.compostType == arg_13_2 then
			var_13_0[#var_13_0 + 1] = iter_13_1
		end
	end

	return var_13_0
end

function var_0_0.getTaskList(arg_14_0, arg_14_1)
	if arg_14_0._task_list then
		return arg_14_0._task_list
	end

	arg_14_0._task_list = {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0._taskCfg.configDict) do
		if arg_14_1 == iter_14_1.activityId then
			arg_14_0._task_list[#arg_14_0._task_list + 1] = iter_14_1
		end
	end

	return arg_14_0._task_list
end

function var_0_0.getConstCfg(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0._constCfg.configDict[arg_15_1]

	if not var_15_0 then
		return
	end

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		if arg_15_2 == iter_15_1.id then
			return iter_15_1
		end
	end
end

function var_0_0.getConstValueCfg(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._constCfg.configDict[arg_16_1]

	if not var_16_0 then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if arg_16_2 == iter_16_1.value1 then
			return iter_16_1
		end
	end
end

function var_0_0.getBuffCfg(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._buffCfg.configDict[arg_17_1]

	return var_17_0 and var_17_0[arg_17_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
