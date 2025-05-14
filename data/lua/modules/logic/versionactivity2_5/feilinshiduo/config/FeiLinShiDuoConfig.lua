module("modules.logic.versionactivity2_5.feilinshiduo.config.FeiLinShiDuoConfig", package.seeall)

local var_0_0 = class("FeiLinShiDuoConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.taskDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity185_episode",
		"activity185_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity185_episode" then
		arg_3_0._episodeConfig = arg_3_2

		arg_3_0:buildStageMap()
	elseif arg_3_1 == "activity185_task" then
		arg_3_0._taskConfig = arg_3_2
	end
end

function var_0_0.buildStageMap(arg_4_0)
	arg_4_0.stageMap = {}

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._episodeConfig.configList) do
		if var_4_0 ~= iter_4_1.stage then
			var_4_0 = iter_4_1.stage
			arg_4_0.stageMap[var_4_0] = {}
		end

		arg_4_0.stageMap[var_4_0][iter_4_1.episodeId] = iter_4_1
	end
end

function var_0_0.getEpisodeConfig(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._episodeConfig.configDict[arg_5_1] and not arg_5_0._episodeConfig.configDict[arg_5_1][arg_5_2] then
		logError(arg_5_1 .. " 活动没有该关卡id信息: " .. arg_5_2)

		return nil
	end

	return arg_5_0._episodeConfig.configDict[arg_5_1][arg_5_2]
end

function var_0_0.getEpisodeConfigList(arg_6_0)
	return arg_6_0._episodeConfig.configList
end

function var_0_0.getNoGameEpisodeList(arg_7_0, arg_7_1)
	arg_7_0.noGameEpisodeList = arg_7_0.noGameEpisodeList or {}

	if not arg_7_0.noGameEpisodeList[arg_7_1] then
		arg_7_0.noGameEpisodeList[arg_7_1] = {}

		local var_7_0 = arg_7_0:getEpisodeConfigList(arg_7_1) or {}

		for iter_7_0, iter_7_1 in ipairs(var_7_0) do
			if iter_7_1.storyId > 0 then
				table.insert(arg_7_0.noGameEpisodeList[arg_7_1], iter_7_1)
			end
		end

		table.sort(arg_7_0.noGameEpisodeList, arg_7_0.sortEpisode)
	end

	return arg_7_0.noGameEpisodeList[arg_7_1]
end

function var_0_0.sortEpisode(arg_8_0, arg_8_1)
	return arg_8_0.stage <= arg_8_1.stage
end

function var_0_0.getGameEpisode(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getEpisodeConfigList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if iter_9_1.preEpisodeId == arg_9_1 and iter_9_1.mapId > 0 then
			return iter_9_1
		end
	end

	return nil
end

function var_0_0.getStageEpisodes(arg_10_0, arg_10_1)
	if not arg_10_0.stageMap[arg_10_1] then
		logError("当前关卡阶段的配置不存在，请检查" .. arg_10_1)

		return {}
	end

	return arg_10_0.stageMap[arg_10_1]
end

function var_0_0.getTaskConfig(arg_11_0, arg_11_1)
	return arg_11_0._taskConfig.configDict[arg_11_1]
end

function var_0_0.getTaskByActId(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.taskDict[arg_12_1]

	if not var_12_0 then
		var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(lua_activity185_task.configList) do
			if iter_12_1.activityId == arg_12_1 then
				table.insert(var_12_0, iter_12_1)
			end
		end

		arg_12_0.taskDict[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0.getNextEpisode(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getEpisodeConfigList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.preEpisodeId == arg_13_1 then
			return iter_13_1
		end
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
