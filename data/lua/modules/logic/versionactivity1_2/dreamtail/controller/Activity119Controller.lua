module("modules.logic.versionactivity1_2.dreamtail.controller.Activity119Controller", package.seeall)

slot0 = class("Activity119Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._get119TaskInfo, slot0)
end

function slot0._get119TaskInfo(slot0, slot1)
	if slot1 and ActivityConfig.instance:getActivityCo(slot1) and slot2.typeId ~= ActivityEnum.ActivityTypeID.DreamTail then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity119
	})
end

function slot0.openAct119View(slot0)
	ViewMgr.instance:openView(ViewName.Activity119View)
end

slot0.instance = slot0.New()

return slot0
