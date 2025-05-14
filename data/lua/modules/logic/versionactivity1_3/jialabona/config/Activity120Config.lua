module("modules.logic.versionactivity1_3.jialabona.config.Activity120Config", package.seeall)

local var_0_0 = class("Activity120Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act120Objects = nil
	arg_1_0._act120Map = nil
	arg_1_0._act120Episode = nil
	arg_1_0._act120Task = nil
	arg_1_0._act120StroyCfg = nil
	arg_1_0._episodeListDict = {}
	arg_1_0._chapterIdListDict = {}
	arg_1_0._episodeStoryListDict = {}
	arg_1_0._chapterEpisodeListDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity120_map",
		"activity120_interact_object",
		"activity120_episode",
		"activity120_task",
		"activity120_tips",
		"activity120_interact_effect",
		"activity120_story"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity120_interact_object" then
		arg_3_0._act120Objects = arg_3_2
	elseif arg_3_1 == "activity120_map" then
		arg_3_0._act120Map = arg_3_2
	elseif arg_3_1 == "activity120_episode" then
		arg_3_0._act120Episode = arg_3_2
	elseif arg_3_1 == "activity120_task" then
		arg_3_0._act120Task = arg_3_2
	elseif arg_3_1 == "activity120_tips" then
		arg_3_0._act120Tips = arg_3_2
	elseif arg_3_1 == "activity120_interact_effect" then
		arg_3_0._act120EffectCfg = arg_3_2
	elseif arg_3_1 == "activity120_story" then
		arg_3_0._act120StroyCfg = arg_3_2

		arg_3_0:_initStroyCfg()
	end
end

function var_0_0.getTaskByActId(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._act120Task.configList) do
		if iter_4_1.activityId == arg_4_1 then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_0.getInteractObjectCo(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._act120Objects.configDict[arg_5_1] then
		return arg_5_0._act120Objects.configDict[arg_5_1][arg_5_2]
	end

	return nil
end

function var_0_0.getMapCo(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._act120Map.configDict[arg_6_1] then
		return arg_6_0._act120Map.configDict[arg_6_1][arg_6_2]
	end

	return nil
end

function var_0_0.getEpisodeCo(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._act120Episode.configDict[arg_7_1] then
		return arg_7_0._act120Episode.configDict[arg_7_1][arg_7_2]
	end

	return nil
end

function var_0_0.getTipsCo(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._act120Tips.configDict[arg_8_1] then
		return arg_8_0._act120Tips.configDict[arg_8_1][arg_8_2]
	end

	return nil
end

function var_0_0.getEffectCo(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0._act120EffectCfg.configDict[arg_9_2]
end

function var_0_0.getChapterEpisodeId(arg_10_0, arg_10_1)
	return JiaLaBoNaEnum.chapterId, JiaLaBoNaEnum.episodeId
end

function var_0_0.getEpisodeList(arg_11_0, arg_11_1)
	if arg_11_0._episodeListDict[arg_11_1] then
		return arg_11_0._episodeListDict[arg_11_1], arg_11_0._chapterIdListDict[arg_11_1]
	end

	local var_11_0 = {}
	local var_11_1 = {}

	arg_11_0._episodeListDict[arg_11_1] = var_11_0
	arg_11_0._chapterIdListDict[arg_11_1] = var_11_1

	if arg_11_0._act120Episode and arg_11_0._act120Episode.configDict[arg_11_1] then
		for iter_11_0, iter_11_1 in pairs(lua_activity120_episode.configDict[arg_11_1]) do
			table.insert(var_11_0, iter_11_1)

			if not tabletool.indexOf(var_11_1, iter_11_1.chapterId) and iter_11_1.chapterId then
				table.insert(var_11_1, iter_11_1.chapterId)
			end
		end

		table.sort(var_11_0, var_0_0.sortEpisode)
		table.sort(var_11_1, var_0_0.sortChapter)
	end

	return var_11_0, var_11_1
end

function var_0_0.getChapterEpisodeList(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._chapterEpisodeListDict[arg_12_1] then
		return arg_12_0._chapterEpisodeListDict[arg_12_1][arg_12_2]
	end

	local var_12_0 = arg_12_0:getEpisodeList(arg_12_1)

	if not var_12_0 then
		return nil
	end

	local var_12_1 = {}

	arg_12_0._chapterEpisodeListDict[arg_12_1] = var_12_1

	local var_12_2

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_3 = var_12_1[iter_12_1.chapterId]

		if not var_12_3 then
			var_12_3 = {}
			var_12_1[iter_12_1.chapterId] = var_12_3
		end

		table.insert(var_12_3, iter_12_1)
	end

	return var_12_1[arg_12_2]
end

function var_0_0.sortEpisode(arg_13_0, arg_13_1)
	if arg_13_0.chapterId ~= arg_13_1.chapterId then
		return arg_13_0.chapterId < arg_13_1.chapterId
	end

	if arg_13_0.id ~= arg_13_1.id then
		return arg_13_0.id < arg_13_1.id
	end
end

function var_0_0.sortChapter(arg_14_0, arg_14_1)
	if arg_14_0 ~= arg_14_1 then
		return arg_14_0 < arg_14_1
	end
end

function var_0_0.sortStoryCfg(arg_15_0, arg_15_1)
	if arg_15_0.order ~= arg_15_1.order then
		return arg_15_0.order < arg_15_1.order
	end
end

function var_0_0.getTaskList(arg_16_0)
	if arg_16_0._task_list then
		return arg_16_0._task_list
	end

	arg_16_0._task_list = {}

	for iter_16_0, iter_16_1 in pairs(lua_activity120_task.configDict) do
		if Activity120Model.instance:getCurActivityID() == iter_16_1.activityId then
			table.insert(arg_16_0._task_list, iter_16_1)
		end
	end

	return arg_16_0._task_list
end

function var_0_0.getEpisodeStoryList(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0._episodeStoryListDict[arg_17_1] and arg_17_0._episodeStoryListDict[arg_17_1][arg_17_2]
end

function var_0_0._initStroyCfg(arg_18_0)
	arg_18_0._episodeStoryListDict = {}

	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._act120StroyCfg.configList) do
		local var_18_1 = iter_18_1.activityId
		local var_18_2 = arg_18_0._episodeStoryListDict[var_18_1]

		if not var_18_2 then
			var_18_2 = {}
			arg_18_0._episodeStoryListDict[var_18_1] = var_18_2
		end

		local var_18_3 = var_18_2[iter_18_1.episodeId]

		if not var_18_3 then
			var_18_3 = {}
			var_18_2[iter_18_1.episodeId] = var_18_3

			table.insert(var_18_0, var_18_3)
		end

		table.insert(var_18_3, iter_18_1)
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		table.sort(iter_18_3, var_0_0.sortStoryCfg)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
