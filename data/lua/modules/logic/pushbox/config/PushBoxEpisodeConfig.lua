module("modules.logic.pushbox.config.PushBoxEpisodeConfig", package.seeall)

local var_0_0 = class("PushBoxEpisodeConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"push_box_episode",
		"push_box_activity",
		"push_box_task"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "push_box_episode" then
		-- block empty
	end
end

function var_0_0.getConfig(arg_4_0, arg_4_1)
	return lua_push_box_episode.configDict[arg_4_1]
end

function var_0_0.getEpisodeList(arg_5_0)
	if arg_5_0._episode_list then
		return arg_5_0._episode_list
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(lua_push_box_activity.configDict[PushBoxModel.instance:getCurActivityID()]) do
		table.insert(var_5_0, iter_5_1)
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		return arg_6_0.stageId < arg_6_1.stageId
	end)

	arg_5_0._episode_list = {}
	arg_5_0._episode2stageID = {}

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		for iter_5_4, iter_5_5 in ipairs(iter_5_3.episodeIds) do
			local var_5_1 = arg_5_0:getConfig(iter_5_5)

			table.insert(arg_5_0._episode_list, var_5_1)

			arg_5_0._episode2stageID[iter_5_5] = iter_5_3.stageId
		end
	end

	return arg_5_0._episode_list
end

function var_0_0.getStageIDByEpisodeID(arg_7_0, arg_7_1)
	return arg_7_0._episode2stageID[arg_7_1]
end

function var_0_0.getStageConfig(arg_8_0, arg_8_1)
	return lua_push_box_activity.configDict[PushBoxModel.instance:getCurActivityID()][arg_8_1]
end

function var_0_0.getTaskList(arg_9_0)
	if arg_9_0._task_list then
		return arg_9_0._task_list
	end

	arg_9_0._task_list = {}

	for iter_9_0, iter_9_1 in pairs(lua_push_box_task.configDict[PushBoxModel.instance:getCurActivityID()]) do
		table.insert(arg_9_0._task_list, iter_9_1)
	end

	return arg_9_0._task_list
end

var_0_0.instance = var_0_0.New()

return var_0_0
