module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomPlan", package.seeall)

local var_0_0 = class("WaitGuideActionRoomPlan", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	RoomController.instance:registerCallback(RoomEvent.AccelerateGuidePlan, arg_1_0._onAccelerateGuidePlan, arg_1_0)
	RoomRpc.instance:sendAccelerateGuidePlanRequest(arg_1_0.guideId, arg_1_0.stepId)
end

function var_0_0._onAccelerateGuidePlan(arg_2_0, arg_2_1)
	arg_2_0:clearWork()
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	RoomController.instance:unregisterCallback(RoomEvent.AccelerateGuidePlan, arg_3_0._onAccelerateGuidePlan, arg_3_0)
end

return var_0_0
