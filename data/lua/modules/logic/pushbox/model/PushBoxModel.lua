module("modules.logic.pushbox.model.PushBoxModel", package.seeall)

slot0 = class("PushBoxModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getCurActivityID(slot0)
	return slot0._activity_id
end

function slot0.onReceiveGet111InfosReply(slot0, slot1)
	slot0._activity_id = slot1.activityId
	slot0._pass_data = {}

	for slot5, slot6 in ipairs(slot1.infos) do
		slot0._pass_data[slot6.id] = {
			id = slot6.id,
			state = slot6.state,
			unlock = slot6.unlock
		}
	end

	slot0._stage_ids = {}

	for slot5, slot6 in ipairs(slot1.stageIds) do
		slot0._stage_ids[slot6] = true
	end

	slot0:refreshTaskData(slot1.pushBoxTasks)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.RefreshActivityData)
end

function slot0.onReceiveAct111InfoPush(slot0, slot1)
	slot0._activity_id = slot1.activityId

	for slot5, slot6 in ipairs(slot1.act111Info) do
		slot0._pass_data[slot6.id] = {
			id = slot6.id,
			state = slot6.state,
			unlock = slot6.unlock
		}
	end
end

function slot0.getPassData(slot0, slot1)
	return slot0._pass_data and slot0._pass_data[slot1]
end

function slot0.getStageOpened(slot0, slot1)
	return slot0._stage_ids[PushBoxEpisodeConfig.instance:getStageIDByEpisodeID(slot1)]
end

function slot0.getEpisodeOpenTime(slot0, slot1)
	return ActivityModel.instance:getActivityInfo()[uv0.instance:getCurActivityID()]:getRealStartTimeStamp() + (PushBoxEpisodeConfig.instance:getStageConfig(PushBoxEpisodeConfig.instance:getStageIDByEpisodeID(slot1)).openDay - 1) * 24 * 60 * 60
end

function slot0.refreshTaskData(slot0, slot1)
	slot0._task_data = {}

	slot0:setTaskData(slot1)
end

function slot0.setTaskData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._task_data[slot6.taskId] = {
			taskId = slot6.taskId,
			progress = slot6.progress,
			hasGetBonus = slot6.hasGetBonus
		}
	end
end

function slot0.delTaskData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._task_data[slot6.taskId] = nil
	end
end

function slot0.getTaskData(slot0, slot1)
	return slot0._task_data and slot0._task_data[slot1]
end

function slot0.onReceiveFinishEpisodeReply(slot0, slot1, slot2)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.FinishEpisodeReply, slot1, slot2.episodeId)
end

function slot0.onReceivePushBoxTaskPush(slot0, slot1)
	slot0:setTaskData(slot1.pushBoxTasks)
	slot0:delTaskData(slot1.deleteTasks)
end

function slot0.onReceiveReceiveTaskRewardReply(slot0, slot1)
	PushBoxController.instance:dispatchEvent(PushBoxEvent.DataEvent.ReceiveTaskRewardReply, slot1.taskId)
end

slot0.instance = slot0.New()

return slot0
