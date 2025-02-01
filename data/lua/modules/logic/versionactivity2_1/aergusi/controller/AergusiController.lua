module("modules.logic.versionactivity2_1.aergusi.controller.AergusiController", package.seeall)

slot0 = class("AergusiController", BaseController)

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0._delayGetInfo, slot0)
end

function slot0._checkActivityInfo(slot0)
	if ActivityModel.instance:isActOnLine(VersionActivity2_1Enum.ActivityId.Aergusi) then
		TaskDispatcher.cancelTask(slot0._delayGetInfo, slot0)
		TaskDispatcher.runDelay(slot0._delayGetInfo, slot0, 0.2)
	end
end

function slot0._delayGetInfo(slot0)
	Activity163Rpc.instance:sendGet163InfosRequest(VersionActivity2_1Enum.ActivityId.Aergusi)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity163
	})
end

function slot0.openAergusiLevelView(slot0)
	ViewMgr.instance:openView(ViewName.AergusiLevelView)
end

function slot0.openAergusiTaskView(slot0)
	ViewMgr.instance:openView(ViewName.AergusiTaskView)
end

function slot0.openAergusiDialogView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AergusiDialogView, slot1)
end

function slot0.openAergusiClueView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AergusiClueView, slot1)
end

function slot0.openAergusiFailView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.AergusiFailView, slot1)
end

function slot0.openAergusiDialogStartView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.AergusiDialogStartView, {
		groupId = slot1,
		callback = slot2,
		callbackObj = slot3
	})
end

function slot0.openAergusiDialogEndView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:openView(ViewName.AergusiDialogEndView, {
		episodeId = slot1,
		callback = slot2,
		callbackObj = slot3
	})
end

function slot0.delayReward(slot0, slot1, slot2)
	if slot0._actTaskMO == nil and slot2 then
		slot0._actTaskMO = slot2

		TaskDispatcher.runDelay(slot0._onPreFinish, slot0, slot1)

		return true
	end

	return false
end

function slot0._onPreFinish(slot0)
	slot0._actTaskMO = nil

	if slot0._actTaskMO and (slot1.id == AergusiEnum.TaskMOAllFinishId or slot1:alreadyGotReward()) then
		AergusiTaskListModel.instance:preFinish(slot1)

		slot0._actTaskId = slot1.id

		TaskDispatcher.runDelay(slot0._onRewardTask, slot0, AergusiEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function slot0._onRewardTask(slot0)
	slot0._actTaskId = nil

	if slot0._actTaskId then
		if slot1 == AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity163)
		else
			TaskRpc.instance:sendFinishTaskRequest(slot1)
		end
	end
end

function slot0.oneClaimReward(slot0, slot1)
	for slot6, slot7 in pairs(AergusiTaskListModel.instance:getList()) do
		if slot7:alreadyGotReward() and slot7.id ~= AergusiEnum.TaskMOAllFinishId then
			TaskRpc.instance:sendFinishTaskRequest(slot7.id)
		end
	end
end

slot0.instance = slot0.New()

return slot0
