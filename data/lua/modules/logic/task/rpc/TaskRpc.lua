module("modules.logic.task.rpc.TaskRpc", package.seeall)

slot0 = class("TaskRpc", BaseRpc)

function slot0.onInit(slot0)
	slot0._sendTypeDict = nil
end

function slot0.reInit(slot0)
	slot0._sendTypeDict = nil

	TaskDispatcher.cancelTask(slot0._delaySendGetTask, slot0)
end

function slot0.sendGetTaskInfoRequest(slot0, slot1, slot2, slot3)
	if not slot2 then
		if not slot0._sendTypeDict then
			slot0._sendTypeDict = {}

			TaskDispatcher.runDelay(slot0._delaySendGetTask, slot0, 0.5)
		end

		for slot7, slot8 in pairs(slot1) do
			slot0._sendTypeDict[slot8] = true
		end

		return
	end

	logNormal("send Get TaskInfo Request" .. slot1[1])

	slot4 = TaskModule_pb.GetTaskInfoRequest()

	for slot8, slot9 in pairs(slot1) do
		table.insert(slot4.typeIds, slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0._delaySendGetTask(slot0)
	if slot0._sendTypeDict then
		slot1 = TaskModule_pb.GetTaskInfoRequest()

		for slot5 in pairs(slot0._sendTypeDict) do
			table.insert(slot1.typeIds, slot5)
		end

		slot0:sendMsg(slot1)

		slot0._sendTypeDict = nil
	end
end

function slot0.onReceiveGetTaskInfoReply(slot0, slot1, slot2)
	logNormal("Receive Get TaskInfo Reply" .. slot1)

	if slot1 == 0 then
		TaskModel.instance:setTaskMOList(slot2.taskInfo, slot2.typeIds)
		TaskModel.instance:setTaskActivityMOList(slot2.activityInfo)
		TaskController.instance:dispatchEvent(TaskEvent.SetTaskList, slot2.typeIds)
	end
end

function slot0.sendFinishTaskRequest(slot0, slot1, slot2, slot3)
	logNormal("send Finish Task Request" .. slot1)

	slot4 = TaskModule_pb.FinishTaskRequest()
	slot4.id = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveFinishTaskReply(slot0, slot1, slot2)
	logNormal("Receive Finish Task Reply" .. slot1)

	if slot1 == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.OnFinishTask, slot2.id)

		if TaskConfig.instance:gettaskdailyCO(slot2.id) then
			SDKChannelEventModel.instance:updateDailyTaskActive()
		end
	end
end

function slot0.sendGetTaskActivityBonusRequest(slot0, slot1, slot2)
	logNormal("send Get TaskActivityBonus Request" .. slot2)

	slot3 = TaskModule_pb.GetTaskActivityBonusRequest()
	slot3.typeId = slot1
	slot3.defineId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveGetTaskActivityBonusReply(slot0, slot1, slot2)
	logNormal("Receive Get TaskActivityBonus Reply" .. slot1)

	if slot1 == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.SuccessGetBonus)
	end
end

function slot0.onReceiveUpdateTaskPush(slot0, slot1, slot2)
	logNormal("Receive Update Task Push" .. slot1)

	if slot1 == 0 then
		TaskModel.instance:onTaskMOChange(slot2.taskInfo)
		TaskModel.instance:onTaskActivityMOChange(slot2.activityInfo)
		TaskController.instance:dispatchEvent(TaskEvent.UpdateTaskList, slot2)
	end
end

function slot0.onReceiveDeleteTaskPush(slot0, slot1, slot2)
	logNormal("Receive Delete Task Push" .. slot1)

	if slot1 == 0 then
		TaskModel.instance:deleteTask(slot2.taskIds)
		TaskController.instance:dispatchEvent(TaskEvent.OnDeleteTask, slot2)
	end
end

function slot0.sendFinishAllTaskRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	TaskModule_pb.FinishAllTaskRequest().typeId = slot1

	if slot2 then
		slot7.minTypeId = slot2
	end

	if slot6 then
		slot7.activityId = slot6
	end

	if slot3 then
		for slot11, slot12 in ipairs(slot3) do
			table.insert(slot7.taskIds, slot12)
		end
	end

	slot0:sendMsg(slot7, slot4, slot5)
end

function slot0.onReceiveFinishAllTaskReply(slot0, slot1, slot2)
	if slot1 == 0 then
		logNormal("一键领取任务奖励成功")
		TaskController.instance:dispatchEvent(TaskEvent.SuccessGetBonus)

		if slot2.typeId == TaskEnum.TaskType.Daily then
			SDKChannelEventModel.instance:updateDailyTaskActive()
		end
	end
end

function slot0.sendFinishReadTaskRequest(slot0, slot1, slot2, slot3)
	slot4 = TaskModule_pb.FinishReadTaskRequest()
	slot4.taskId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveFinishReadTaskReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TaskController.instance:dispatchEvent(TaskEvent.onReceiveFinishReadTaskReply, slot2.taskId)
		SportsNewsController.instance:dispatchEvent(SportsNewsEvent.OnReadEnd, slot2.taskId)
	end
end

slot0.instance = slot0.New()

return slot0
