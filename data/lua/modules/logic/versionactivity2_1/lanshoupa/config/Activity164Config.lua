module("modules.logic.versionactivity2_1.lanshoupa.config.Activity164Config", package.seeall)

local var_0_0 = class("Activity164Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._act164Episode = nil
	arg_1_0._act164Task = nil
	arg_1_0._episodeListDict = {}
	arg_1_0._chapterIdListDict = {}
	arg_1_0._chapterEpisodeListDict = {}
	arg_1_0._bubbleListDict = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity164_episode",
		"activity164_task",
		"activity164_story",
		"activity164_tips",
		"activity164_bubble"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity164_episode" then
		arg_3_0._act164Episode = arg_3_2

		arg_3_0:_initEpisodeList()
	elseif arg_3_1 == "activity164_task" then
		arg_3_0._act164Task = arg_3_2
	elseif arg_3_1 == "activity164_story" then
		arg_3_0._act164Story = arg_3_2
	elseif arg_3_1 == "activity164_tips" then
		arg_3_0._act164Tips = arg_3_2
	elseif arg_3_1 == "activity164_bubble" then
		arg_3_0._act164Bubble = arg_3_2
	end
end

function var_0_0._initEpisodeList(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._act164Episode.configDict) do
		arg_4_0._episodeListDict[iter_4_0] = arg_4_0._episodeListDict[iter_4_0] or {}

		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			table.insert(arg_4_0._episodeListDict[iter_4_0], iter_4_3)
		end

		table.sort(arg_4_0._episodeListDict[iter_4_0], var_0_0.sortEpisode)
	end
end

function var_0_0.getTaskByActId(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._act164Task.configList) do
		if iter_5_1.activityId == arg_5_1 then
			table.insert(var_5_0, iter_5_1)
		end
	end

	return var_5_0
end

function var_0_0.getEpisodeCo(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._act164Episode.configDict[arg_6_1] then
		return arg_6_0._act164Episode.configDict[arg_6_1][arg_6_2]
	end

	return nil
end

function var_0_0.getEpisodeIndex(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0._episodeListDict[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.id == arg_7_2 then
			return iter_7_0
		end
	end
end

function var_0_0.getEpisodeCoDict(arg_8_0, arg_8_1)
	return arg_8_0._act164Episode.configDict[arg_8_1]
end

function var_0_0.getEpisodeCoList(arg_9_0, arg_9_1)
	return arg_9_0._episodeListDict[arg_9_1]
end

function var_0_0.getTipsCo(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._act164Tips.configDict[arg_10_1] then
		return arg_10_0._act164Tips.configDict[arg_10_1][arg_10_2]
	end

	return nil
end

function var_0_0.getBubbleCo(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._act164Bubble.configDict[arg_11_1] then
		return arg_11_0._act164Bubble.configDict[arg_11_1][arg_11_2]
	end

	return nil
end

function var_0_0.getBubbleCoByGroup(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._act164Bubble.configDict[arg_12_1][arg_12_2]
end

function var_0_0._initBubbleConfig(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._act164Bubble.configDict) do
		arg_13_0._bubbleListDict[iter_13_0] = iter_13_1

		for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
			arg_13_0._bubbleListDict[iter_13_0][iter_13_2] = arg_13_0._bubbleListDict[iter_13_0][iter_13_2] or {}

			table.insert(arg_13_0._bubbleListDict[iter_13_0][iter_13_2], iter_13_3)
		end
	end
end

function var_0_0.sortEpisode(arg_14_0, arg_14_1)
	if arg_14_0.id ~= arg_14_1.id then
		return arg_14_0.id < arg_14_1.id
	end
end

function var_0_0.getStoryList(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = lua_activity164_story.configDict[arg_15_1]

	return var_15_0 and var_15_0[arg_15_2]
end

function var_0_0.getTaskList(arg_16_0)
	if arg_16_0._task_list then
		return arg_16_0._task_list
	end

	arg_16_0._task_list = {}

	for iter_16_0, iter_16_1 in pairs(lua_activity164_task.configDict) do
		if Activity164Model.instance:getCurActivityID() == iter_16_1.activityId then
			table.insert(arg_16_0._task_list, iter_16_1)
		end
	end

	return arg_16_0._task_list
end

var_0_0.instance = var_0_0.New()

return var_0_0
