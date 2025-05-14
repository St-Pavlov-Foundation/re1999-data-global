module("modules.logic.pushbox.model.PushBoxModel", package.seeall)

local var_0_0 = class("PushBoxModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getCurActivityID(arg_3_0)
	return arg_3_0._activity_id
end

function var_0_0.onReceiveGet111InfosReply(arg_4_0, arg_4_1)
	arg_4_0._activity_id = arg_4_1.activityId
	arg_4_0._pass_data = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.infos) do
		local var_4_0 = {
			id = iter_4_1.id,
			state = iter_4_1.state,
			unlock = iter_4_1.unlock
		}

		arg_4_0._pass_data[iter_4_1.id] = var_4_0
	end

	arg_4_0._stage_ids = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.stageIds) do
		arg_4_0._stage_ids[iter_4_3] = true
	end

	arg_4_0:refreshTaskData(arg_4_1.pushBoxTasks)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.RefreshActivityData)
end

function var_0_0.onReceiveAct111InfoPush(arg_5_0, arg_5_1)
	arg_5_0._activity_id = arg_5_1.activityId

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.act111Info) do
		local var_5_0 = {
			id = iter_5_1.id,
			state = iter_5_1.state,
			unlock = iter_5_1.unlock
		}

		arg_5_0._pass_data[iter_5_1.id] = var_5_0
	end
end

function var_0_0.getPassData(arg_6_0, arg_6_1)
	return arg_6_0._pass_data and arg_6_0._pass_data[arg_6_1]
end

function var_0_0.getStageOpened(arg_7_0, arg_7_1)
	return arg_7_0._stage_ids[PushBoxEpisodeConfig.instance:getStageIDByEpisodeID(arg_7_1)]
end

function var_0_0.getEpisodeOpenTime(arg_8_0, arg_8_1)
	local var_8_0 = PushBoxEpisodeConfig.instance:getStageConfig(PushBoxEpisodeConfig.instance:getStageIDByEpisodeID(arg_8_1))

	return ActivityModel.instance:getActivityInfo()[var_0_0.instance:getCurActivityID()]:getRealStartTimeStamp() + (var_8_0.openDay - 1) * 24 * 60 * 60
end

function var_0_0.refreshTaskData(arg_9_0, arg_9_1)
	arg_9_0._task_data = {}

	arg_9_0:setTaskData(arg_9_1)
end

function var_0_0.setTaskData(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_0 = {
			taskId = iter_10_1.taskId,
			progress = iter_10_1.progress,
			hasGetBonus = iter_10_1.hasGetBonus
		}

		arg_10_0._task_data[iter_10_1.taskId] = var_10_0
	end
end

function var_0_0.delTaskData(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		arg_11_0._task_data[iter_11_1.taskId] = nil
	end
end

function var_0_0.getTaskData(arg_12_0, arg_12_1)
	return arg_12_0._task_data and arg_12_0._task_data[arg_12_1]
end

function var_0_0.onReceiveFinishEpisodeReply(arg_13_0, arg_13_1, arg_13_2)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.FinishEpisodeReply, arg_13_1, arg_13_2.episodeId)
end

function var_0_0.onReceivePushBoxTaskPush(arg_14_0, arg_14_1)
	arg_14_0:setTaskData(arg_14_1.pushBoxTasks)
	arg_14_0:delTaskData(arg_14_1.deleteTasks)
end

function var_0_0.onReceiveReceiveTaskRewardReply(arg_15_0, arg_15_1)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.ReceiveTaskRewardReply, arg_15_1.taskId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
