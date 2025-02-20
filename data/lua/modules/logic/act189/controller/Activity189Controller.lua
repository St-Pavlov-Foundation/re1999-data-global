module("modules.logic.act189.controller.Activity189Controller", package.seeall)

slot0 = class("Activity189Controller", BaseController)

function slot0.dispatchEventUpdateActTag(slot0)
	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
		[tonumber(RedDotConfig.instance:getParentRedDotId(ActivityConfig.instance:getActivityCenterRedDotId(ActivityEnum.ActivityType.Beginner)))] = true,
		[tonumber(ActivityConfig.instance:getActivityRedDotId(slot0))] = true
	})
end

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.sendGetTaskInfoRequest(slot0, slot1, slot2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		Activity189Config.instance:getTaskType()
	}, slot1, slot2)
end

function slot0.sendFinishAllTaskRequest(slot0, slot1, slot2, slot3)
	TaskRpc.instance:sendFinishAllTaskRequest(Activity189Config.instance:getTaskType(), nil, , slot2, slot3, slot1)
end

function slot0.sendGetAct189OnceBonusRequest(slot0, slot1)
	return Activity189Rpc.instance:sendGetAct189OnceBonusRequest(slot1, uv0.dispatchEventUpdateActTag, slot1)
end

function slot0.sendGetAct189InfoRequest(slot0, slot1, slot2, slot3)
	return Activity189Rpc.instance:sendGetAct189InfoRequest(slot1, slot2, slot3)
end

function slot0.sendFinishReadTaskRequest(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	if not Activity189Config.instance:getTaskCO(slot1) then
		return
	end

	TaskRpc.instance:sendFinishReadTaskRequest(slot1, uv0.dispatchEventUpdateActTag, slot2.activityId)
end

slot1 = "ReadTask"

function slot0.trySendFinishReadTaskRequest_jump(slot0, slot1)
	if not Activity189Config.instance:getTaskCO(slot1) then
		return
	end

	if slot2.listenerType ~= uv0 then
		return
	end

	slot0:sendFinishReadTaskRequest(slot1)
end

function slot0.checkRed_Task(slot0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Activity189Task, 0)
end

function slot0.checkActRed(slot0, slot1)
	if ActivityBeginnerController.instance:checkRedDot(slot1) then
		return true
	end

	return slot0:checkRed_Task()
end

slot0.instance = slot0.New()

return slot0
