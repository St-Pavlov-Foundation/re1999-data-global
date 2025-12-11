module("modules.logic.versionactivity3_1.gaosiniao.model.Activity210Model", package.seeall)

local var_0_0 = class("Activity210Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.__config = false
	arg_2_0.__taskType = false
	arg_2_0.__episodeId2Act210EpisodeRecord = {}
	arg_2_0.__episodeId2UnlockBranchIds = {}
end

function var_0_0._internal_set_taskType(arg_3_0, arg_3_1)
	arg_3_0.__taskType = arg_3_1 or TaskEnum.TaskType.Activity210
end

function var_0_0._internal_set_config(arg_4_0, arg_4_1)
	assert(isTypeOf(arg_4_1, Activity210Config), debug.traceback())

	arg_4_0.__config = arg_4_1
end

function var_0_0.actId(arg_5_0)
	assert(arg_5_0.__config, "pleaes call self:_internal_set_config(config) first")

	return arg_5_0.__config:actId()
end

function var_0_0.taskType(arg_6_0)
	return assert(arg_6_0.__taskType, "pleaes call self:_internal_set_taskType(taskType) first")
end

function var_0_0.config(arg_7_0)
	return assert(arg_7_0.__config, "pleaes call self:_internal_set_config(config) first")
end

function var_0_0.getTaskMoList(arg_8_0)
	return TaskModel.instance:getTaskMoList(arg_8_0:taskType(), arg_8_0:actId())
end

function var_0_0.getActMO(arg_9_0)
	return ActivityModel.instance:getActMO(arg_9_0:actId())
end

function var_0_0.isActOnLine(arg_10_0)
	return ActivityHelper.getActivityStatus(arg_10_0:actId(), true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_0.getRealStartTimeStamp(arg_11_0)
	return arg_11_0:getActMO():getRealStartTimeStamp()
end

function var_0_0.getRealEndTimeStamp(arg_12_0)
	return arg_12_0:getActMO():getRealEndTimeStamp()
end

function var_0_0.getRemainTimeStr(arg_13_0)
	local var_13_0 = ActivityModel.instance:getRemainTimeSec(arg_13_0:actId())

	return TimeUtil.SecondToActivityTimeFormat(var_13_0)
end

function var_0_0.isEpisodeOpen(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.__config:getPreEpisodeId(arg_14_1)

	if not var_14_0 or var_14_0 == 0 then
		return true
	end

	return arg_14_0:hasPassLevelAndStory(var_14_0)
end

function var_0_0.hasPassEpisode(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.__episodeId2Act210EpisodeRecord[arg_15_1]

	if not var_15_0 then
		return false
	end

	return var_15_0.isFinished
end

function var_0_0.hasPassPreStory(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.__config:getPreStoryId(arg_16_1)

	if var_16_0 > 0 then
		return StoryModel.instance:isStoryFinished(var_16_0)
	end

	return true
end

function var_0_0.hasPassPostStory(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.__config:getPostStoryId(arg_17_1)

	if var_17_0 > 0 then
		return StoryModel.instance:isStoryFinished(var_17_0)
	end

	return true
end

function var_0_0.hasPassPrePostStory(arg_18_0, arg_18_1)
	local var_18_0 = true
	local var_18_1, var_18_2 = arg_18_0.__config:getStoryIdPrePost(arg_18_1)

	if var_18_1 > 0 then
		var_18_0 = var_18_0 and StoryModel.instance:isStoryFinished(var_18_1)
	end

	if var_18_2 > 0 then
		var_18_0 = var_18_0 and StoryModel.instance:isStoryFinished(var_18_2)
	end

	return var_18_0
end

function var_0_0.hasPassLevelAndStory(arg_19_0, arg_19_1)
	if not arg_19_0:hasPassEpisode(arg_19_1) then
		return false
	end

	return arg_19_0:hasPassPrePostStory(arg_19_1)
end

function var_0_0._internal_hasPassEpisode(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_2 then
		return arg_20_0:hasPassEpisode(arg_20_1)
	else
		return arg_20_0:hasPassLevelAndStory(arg_20_1)
	end
end

function var_0_0._updateUnlockBranchIds(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0.__episodeId2UnlockBranchIds[arg_21_1] = {}

	local var_21_0 = arg_21_0.__episodeId2UnlockBranchIds[arg_21_1]

	for iter_21_0, iter_21_1 in ipairs(arg_21_2 or {}) do
		var_21_0[iter_21_1] = true
	end
end

function var_0_0._dirtyEpisodesUpdate(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		local var_22_0 = iter_22_1.episodeId

		arg_22_0.__episodeId2Act210EpisodeRecord[var_22_0] = iter_22_1

		arg_22_0:_updateUnlockBranchIds(var_22_0, iter_22_1.unlockBranchIds)
	end
end

function var_0_0._updateAll(arg_23_0, arg_23_1)
	arg_23_0.__episodeId2Act210EpisodeRecord = {}
	arg_23_0.__episodeId2UnlockBranchIds = {}

	arg_23_0:_dirtyEpisodesUpdate(arg_23_1.episodes)
end

function var_0_0.onReceiveGetAct210InfoReply(arg_24_0, arg_24_1)
	arg_24_0:_updateAll(arg_24_1)
	arg_24_0:_onReceiveGetAct210InfoReply(arg_24_1)
end

function var_0_0._onReceiveGetAct210InfoReply(arg_25_0, arg_25_1)
	return
end

function var_0_0.onReceiveAct210SaveEpisodeProgressReply(arg_26_0, arg_26_1)
	arg_26_0:_onReceiveAct210SaveEpisodeProgressReply(arg_26_1)
end

function var_0_0._onReceiveAct210SaveEpisodeProgressReply(arg_27_0, arg_27_1)
	return
end

function var_0_0.onReceiveAct210FinishEpisodeReply(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_1.episodeId
	local var_28_1 = arg_28_0.__episodeId2Act210EpisodeRecord[var_28_0]

	if not var_28_1 then
		return
	end

	rawset(var_28_1, "isFinished", true)
	arg_28_0:_onReceiveAct210FinishEpisodeReply(arg_28_1)
end

function var_0_0._onReceiveAct210FinishEpisodeReply(arg_29_0, arg_29_1)
	return
end

function var_0_0.onReceiveAct210ChooseEpisodeBranchReply(arg_30_0, arg_30_1)
	arg_30_0:_onReceiveAct210ChooseEpisodeBranchReply(arg_30_1)
end

function var_0_0._onReceiveAct210ChooseEpisodeBranchReply(arg_31_0, arg_31_1)
	return
end

function var_0_0.onReceiveAct210EpisodePush(arg_32_0, arg_32_1)
	if arg_32_1.episodes then
		arg_32_0:_dirtyEpisodesUpdate(arg_32_1.episodes)
	end

	arg_32_0:_onReceiveAct210EpisodePush(arg_32_1)
end

function var_0_0._onReceiveAct210EpisodePush(arg_33_0, arg_33_1)
	return
end

return var_0_0
