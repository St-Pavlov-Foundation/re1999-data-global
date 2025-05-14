module("modules.logic.task.rpc.TaskRpc", package.seeall)

local var_0_0 = class("TaskRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	arg_1_0._sendTypeDict = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._sendTypeDict = nil

	TaskDispatcher.cancelTask(arg_2_0._delaySendGetTask, arg_2_0)
end

function var_0_0.sendGetTaskInfoRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_2 then
		if not arg_3_0._sendTypeDict then
			arg_3_0._sendTypeDict = {}

			TaskDispatcher.runDelay(arg_3_0._delaySendGetTask, arg_3_0, 0.5)
		end

		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			arg_3_0._sendTypeDict[iter_3_1] = true
		end

		return
	end

	logNormal("send Get TaskInfo Request" .. arg_3_1[1])

	local var_3_0 = TaskModule_pb.GetTaskInfoRequest()

	for iter_3_2, iter_3_3 in pairs(arg_3_1) do
		table.insert(var_3_0.typeIds, iter_3_3)
	end

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0._delaySendGetTask(arg_4_0)
	if arg_4_0._sendTypeDict then
		local var_4_0 = TaskModule_pb.GetTaskInfoRequest()

		for iter_4_0 in pairs(arg_4_0._sendTypeDict) do
			table.insert(var_4_0.typeIds, iter_4_0)
		end

		arg_4_0:sendMsg(var_4_0)

		arg_4_0._sendTypeDict = nil
	end
end

function var_0_0.onReceiveGetTaskInfoReply(arg_5_0, arg_5_1, arg_5_2)
	logNormal("Receive Get TaskInfo Reply" .. arg_5_1)

	if arg_5_1 == 0 then
		TaskModel.instance:setTaskMOList(arg_5_2.taskInfo, arg_5_2.typeIds)
		TaskModel.instance:setTaskActivityMOList(arg_5_2.activityInfo)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList, arg_5_2.typeIds)
	end
end

function var_0_0.sendFinishTaskRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	logNormal("send Finish Task Request" .. arg_6_1)

	local var_6_0 = TaskModule_pb.FinishTaskRequest()

	var_6_0.id = arg_6_1

	arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveFinishTaskReply(arg_7_0, arg_7_1, arg_7_2)
	logNormal("Receive Finish Task Reply" .. arg_7_1)

	if arg_7_1 == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnFinishTask, arg_7_2.id)

		if TaskConfig.instance:gettaskdailyCO(arg_7_2.id) then
			SDKChannelEventModel.instance:updateDailyTaskActive()
		end
	end
end

function var_0_0.sendGetTaskActivityBonusRequest(arg_8_0, arg_8_1, arg_8_2)
	logNormal("send Get TaskActivityBonus Request" .. arg_8_2)

	local var_8_0 = TaskModule_pb.GetTaskActivityBonusRequest()

	var_8_0.typeId = arg_8_1
	var_8_0.defineId = arg_8_2

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveGetTaskActivityBonusReply(arg_9_0, arg_9_1, arg_9_2)
	logNormal("Receive Get TaskActivityBonus Reply" .. arg_9_1)

	if arg_9_1 == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.SuccessGetBonus)
	end
end

function var_0_0.onReceiveUpdateTaskPush(arg_10_0, arg_10_1, arg_10_2)
	logNormal("Receive Update Task Push" .. arg_10_1)

	if arg_10_1 == 0 then
		TaskModel.instance:onTaskMOChange(arg_10_2.taskInfo)
		TaskModel.instance:onTaskActivityMOChange(arg_10_2.activityInfo)
		TaskController.instance:dispatchEvent(TaskEvent.UpdateTaskList, arg_10_2)
	end
end

function var_0_0.onReceiveDeleteTaskPush(arg_11_0, arg_11_1, arg_11_2)
	logNormal("Receive Delete Task Push" .. arg_11_1)

	if arg_11_1 == 0 then
		TaskModel.instance:deleteTask(arg_11_2.taskIds)
		TaskController.instance:dispatchEvent(TaskEvent.OnDeleteTask, arg_11_2)
	end
end

function var_0_0.sendFinishAllTaskRequest(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5, arg_12_6)
	local var_12_0 = TaskModule_pb.FinishAllTaskRequest()

	var_12_0.typeId = arg_12_1

	if arg_12_2 then
		var_12_0.minTypeId = arg_12_2
	end

	if arg_12_6 then
		var_12_0.activityId = arg_12_6
	end

	if arg_12_3 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_3) do
			table.insert(var_12_0.taskIds, iter_12_1)
		end
	end

	arg_12_0:sendMsg(var_12_0, arg_12_4, arg_12_5)
end

function var_0_0.onReceiveFinishAllTaskReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		logNormal("一键领取任务奖励成功")
		TaskController.instance:dispatchEvent(TaskEvent.SuccessGetBonus)

		if arg_13_2.typeId == TaskEnum.TaskType.Daily then
			SDKChannelEventModel.instance:updateDailyTaskActive()
		end
	end
end

function var_0_0.sendFinishReadTaskRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = TaskModule_pb.FinishReadTaskRequest()

	var_14_0.taskId = arg_14_1

	return arg_14_0:sendMsg(var_14_0, arg_14_2, arg_14_3)
end

function var_0_0.onReceiveFinishReadTaskReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.onReceiveFinishReadTaskReply, arg_15_2.taskId)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnReadEnd, arg_15_2.taskId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
