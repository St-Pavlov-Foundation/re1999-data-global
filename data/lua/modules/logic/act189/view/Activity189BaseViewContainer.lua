module("modules.logic.act189.view.Activity189BaseViewContainer", package.seeall)

slot0 = class("Activity189BaseViewContainer", BaseViewContainer)

function slot0.getActivityRemainTimeStr(slot0)
	return ActivityHelper.getActivityRemainTimeStr(slot0:actId())
end

function slot0.sendGetTaskInfoRequest(slot0, slot1, slot2)
	Activity189Controller.instance:sendGetTaskInfoRequest(slot1, slot2)
end

function slot0.sendFinishAllTaskRequest(slot0, slot1, slot2)
	Activity189Controller.instance:sendFinishAllTaskRequest(slot0:actId(), slot1, slot2)
end

function slot0.sendFinishTaskRequest(slot0, slot1, slot2, slot3)
	TaskRpc.instance:sendFinishTaskRequest(slot1, slot2, slot3)
end

function slot0.actId(slot0)
	assert(false, "please override this function")
end

return slot0
