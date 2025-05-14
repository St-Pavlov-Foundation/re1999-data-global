module("modules.logic.activity.config.Activity109Config", package.seeall)

local var_0_0 = class("Activity109Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act109Objects = nil
	arg_1_0._act109Map = nil
	arg_1_0._act109Episode = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity109_map",
		"activity109_interact_object",
		"activity109_episode",
		"activity109_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity109_interact_object" then
		arg_3_0._act109Objects = arg_3_2
	elseif arg_3_1 == "activity109_map" then
		arg_3_0._act109Map = arg_3_2
	elseif arg_3_1 == "activity109_episode" then
		arg_3_0._act109Episode = arg_3_2
	end
end

function var_0_0.getInteractObjectCo(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._act109Objects.configDict[arg_4_1] then
		return arg_4_0._act109Objects.configDict[arg_4_1][arg_4_2]
	end

	return nil
end

function var_0_0.getMapCo(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._act109Map.configDict[arg_5_1] then
		return arg_5_0._act109Map.configDict[arg_5_1][arg_5_2]
	end

	return nil
end

function var_0_0.getEpisodeCo(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._act109Episode.configDict[arg_6_1] then
		return arg_6_0._act109Episode.configDict[arg_6_1][arg_6_2]
	end

	return nil
end

function var_0_0.getEpisodeList(arg_7_0, arg_7_1)
	if arg_7_0._episode_list then
		return arg_7_0._episode_list, arg_7_0._chapter_id_list
	end

	arg_7_0._episode_list = {}
	arg_7_0._chapter_id_list = {}

	for iter_7_0, iter_7_1 in pairs(lua_activity109_episode.configDict[arg_7_1]) do
		table.insert(arg_7_0._episode_list, iter_7_1)

		if not tabletool.indexOf(arg_7_0._chapter_id_list, iter_7_1.chapterId) and iter_7_1.chapterId then
			table.insert(arg_7_0._chapter_id_list, iter_7_1.chapterId)
		end
	end

	table.sort(arg_7_0._episode_list, var_0_0.sortEpisode)
	table.sort(arg_7_0._chapter_id_list, var_0_0.sortChapter)

	return arg_7_0._episode_list, arg_7_0._chapter_id_list
end

function var_0_0.sortEpisode(arg_8_0, arg_8_1)
	return arg_8_0.id < arg_8_1.id
end

function var_0_0.sortChapter(arg_9_0, arg_9_1)
	return arg_9_0 < arg_9_1
end

function var_0_0.getTaskList(arg_10_0)
	if arg_10_0._task_list then
		return arg_10_0._task_list
	end

	arg_10_0._task_list = {}

	for iter_10_0, iter_10_1 in pairs(lua_activity109_task.configDict) do
		if Activity109Model.instance:getCurActivityID() == iter_10_1.activityId then
			table.insert(arg_10_0._task_list, iter_10_1)
		end
	end

	return arg_10_0._task_list
end

var_0_0.instance = var_0_0.New()

return var_0_0
