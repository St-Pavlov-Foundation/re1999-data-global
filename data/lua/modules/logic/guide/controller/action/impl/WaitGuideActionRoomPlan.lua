module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPlan", package.seeall)

slot0 = class("WaitGuideActionRoomPlan", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	RoomController.instance:registerCallback(RoomEvent.AccelerateGuidePlan, slot0._onAccelerateGuidePlan, slot0)
	RoomRpc.instance:sendAccelerateGuidePlanRequest(slot0.guideId, slot0.stepId)
end

function slot0._onAccelerateGuidePlan(slot0, slot1)
	slot0:clearWork()
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	RoomController.instance:unregisterCallback(RoomEvent.AccelerateGuidePlan, slot0._onAccelerateGuidePlan, slot0)
end

return slot0
