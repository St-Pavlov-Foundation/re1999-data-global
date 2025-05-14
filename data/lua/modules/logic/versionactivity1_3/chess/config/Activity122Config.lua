module("modules.logic.versionactivity1_3.chess.config.Activity122Config", package.seeall)

local var_0_0 = class("Activity122Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act122Objects = nil
	arg_1_0._act122Map = nil
	arg_1_0._act122Episode = nil
	arg_1_0._act122Task = nil
	arg_1_0._act122StroyCfg = nil
	arg_1_0._act122Tips = nil
	arg_1_0._act122EffectCfg = nil
	arg_1_0._episodeListDict = {}
	arg_1_0._chapterIdListDict = {}
	arg_1_0._chapterEpisodeListDict = {}
	arg_1_0._mapStoryListDict = {}
	arg_1_0._chapterEpisodeListDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity122_map",
		"activity122_interact",
		"activity122_episode",
		"activity122_task",
		"activity122_tips",
		"activity122_interact_effect",
		"activity122_story"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity122_interact" then
		arg_3_0._act122Objects = arg_3_2
	elseif arg_3_1 == "activity122_map" then
		arg_3_0._act122Map = arg_3_2
	elseif arg_3_1 == "activity122_episode" then
		arg_3_0._act122Episode = arg_3_2
	elseif arg_3_1 == "activity122_task" then
		arg_3_0._act122Task = arg_3_2
	elseif arg_3_1 == "activity122_tips" then
		arg_3_0._act122Tips = arg_3_2
	elseif arg_3_1 == "activity122_interact_effect" then
		arg_3_0._act122EffectCfg = arg_3_2
	elseif arg_3_1 == "activity122_story" then
		arg_3_0._act122StroyCfg = arg_3_2
	end
end

function var_0_0.getTaskByActId(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._act122Task.configList) do
		if iter_4_1.activityId == arg_4_1 then
			table.insert(var_4_0, iter_4_1)
		end
	end

	return var_4_0
end

function var_0_0.getInteractObjectCo(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._act122Objects.configDict[arg_5_1] then
		return arg_5_0._act122Objects.configDict[arg_5_1][arg_5_2]
	end

	return nil
end

function var_0_0.getMapCo(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._act122Map.configDict[arg_6_1] then
		return arg_6_0._act122Map.configDict[arg_6_1][arg_6_2]
	end

	return nil
end

function var_0_0.getEpisodeCo(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._act122Episode.configDict[arg_7_1] then
		return arg_7_0._act122Episode.configDict[arg_7_1][arg_7_2]
	end

	return nil
end

function var_0_0.getChapterEpisodeList(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._chapterEpisodeListDict[arg_8_1] then
		return arg_8_0._chapterEpisodeListDict[arg_8_1][arg_8_2]
	end

	local var_8_0 = arg_8_0:getEpisodeList(arg_8_1)

	if not var_8_0 then
		return nil
	end

	local var_8_1 = {}

	arg_8_0._chapterEpisodeListDict[arg_8_1] = var_8_1

	local var_8_2

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_3 = var_8_1[iter_8_1.chapterId]

		if not var_8_3 then
			var_8_3 = {}
			var_8_1[iter_8_1.chapterId] = var_8_3
		end

		table.insert(var_8_3, iter_8_1)
	end

	return var_8_1[arg_8_2]
end

function var_0_0.getEffectCo(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0._act122EffectCfg and arg_9_0._act122EffectCfg.configDict[arg_9_2]
end

function var_0_0.getTipsCfg(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._act122Tips.configDict[arg_10_1] then
		return arg_10_0._act122Tips.configDict[arg_10_1][arg_10_2]
	end

	return nil
end

function var_0_0.getChapterEpisodeId(arg_11_0, arg_11_1)
	return Activity1_3ChessEnum.chapterId, Activity1_3ChessEnum.episodeId
end

function var_0_0.getEpisodeList(arg_12_0, arg_12_1)
	if arg_12_0._episodeListDict[arg_12_1] then
		return arg_12_0._episodeListDict[arg_12_1], arg_12_0._chapterIdListDict[arg_12_1]
	end

	local var_12_0 = {}
	local var_12_1 = {}

	arg_12_0._episodeListDict[arg_12_1] = var_12_0
	arg_12_0._chapterIdListDict[arg_12_1] = var_12_1

	if arg_12_0._act122Episode and arg_12_0._act122Episode.configDict[arg_12_1] then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._act122Episode.configDict[arg_12_1]) do
			var_12_0[#var_12_0 + 1] = iter_12_1

			if not tabletool.indexOf(var_12_1, iter_12_1.chapterId) and iter_12_1.chapterId then
				var_12_1[#var_12_1 + 1] = iter_12_1.chapterId
			end
		end

		table.sort(var_12_0, var_0_0.sortEpisode)
		table.sort(var_12_1, var_0_0.sortChapter)
	end

	return var_12_0, var_12_1
end

function var_0_0.sortEpisode(arg_13_0, arg_13_1)
	if arg_13_0.id ~= arg_13_1.id then
		return arg_13_0.id < arg_13_1.id
	end
end

function var_0_0.sortChapter(arg_14_0, arg_14_1)
	if arg_14_0 ~= arg_14_1 then
		return arg_14_0 < arg_14_1
	end
end

function var_0_0.getTaskList(arg_15_0)
	if arg_15_0._task_list then
		return arg_15_0._task_list
	end

	arg_15_0._task_list = {}

	for iter_15_0, iter_15_1 in pairs(lua_activity122_task.configDict) do
		if Activity122Model.instance:getCurActivityID() == iter_15_1.activityId then
			table.insert(arg_15_0._task_list, iter_15_1)
		end
	end

	return arg_15_0._task_list
end

function var_0_0._createStoryCo(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	return {
		storyId = arg_16_1,
		typeId = arg_16_3,
		config = arg_16_2
	}
end

function var_0_0._isChessTipsCfg(arg_17_0, arg_17_1)
	local var_17_0 = VersionActivity1_3Enum.ActivityId.Act304

	return arg_17_0:getTipsCfg(var_17_0, arg_17_1) ~= nil
end

function var_0_0.getEpisodeStoryList(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._episodeStoryListDict then
		arg_18_0:_initStroyCfg()
	end

	return arg_18_0._episodeStoryListDict[arg_18_1] and arg_18_0._episodeStoryListDict[arg_18_1][arg_18_2]
end

function var_0_0._initStroyCfg(arg_19_0)
	arg_19_0._episodeStoryListDict = {}

	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._act122StroyCfg.configList) do
		local var_19_1 = iter_19_1.activityId
		local var_19_2 = arg_19_0._episodeStoryListDict[var_19_1]

		if not var_19_2 then
			var_19_2 = {}
			arg_19_0._episodeStoryListDict[var_19_1] = var_19_2
		end

		local var_19_3 = var_19_2[iter_19_1.episodeId]

		if not var_19_3 then
			var_19_3 = {}
			var_19_2[iter_19_1.episodeId] = var_19_3
			var_19_0[#var_19_0 + 1] = var_19_3
		end

		table.insert(var_19_3, iter_19_1)
	end

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		table.sort(iter_19_3, var_0_0.sortStory)
	end
end

function var_0_0.sortStory(arg_20_0, arg_20_1)
	if arg_20_0.order ~= arg_20_1.order then
		return arg_20_0.order < arg_20_1.order
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
