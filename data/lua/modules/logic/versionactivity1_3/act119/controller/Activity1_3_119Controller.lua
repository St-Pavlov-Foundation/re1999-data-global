module("modules.logic.versionactivity1_3.act119.controller.Activity1_3_119Controller", package.seeall)

slot0 = class("Activity1_3_119Controller", BaseController)

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
	if slot1 and ActivityConfig.instance:getActivityCo(slot1) and slot2.typeId ~= VersionActivity1_3Enum.ActivityId.Act307 then
		return
	end

	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity119
	})
end

function slot0.openView(slot0)
	ViewMgr.instance:openView(ViewName.Activity1_3_119View)
end

slot0.instance = slot0.New()

return slot0
