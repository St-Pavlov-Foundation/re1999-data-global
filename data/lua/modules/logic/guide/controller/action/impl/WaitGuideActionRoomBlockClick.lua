module("modules.logic.guide.controller.action.impl.WaitGuideActionRoomBlockClick", package.seeall)

local var_0_0 = class("WaitGuideActionRoomBlockClick", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	GuideViewMgr.instance:enableHoleClick()
	GuideViewMgr.instance:setHoleClickCallback(arg_2_0._onClickTarget, arg_2_0)
end

function var_0_0.clearWork(arg_3_0)
	GuideViewMgr.instance:setHoleClickCallback(nil, nil)
	TaskDispatcher.cancelTask(arg_3_0._onDelayDone, arg_3_0)
end

function var_0_0._onClickTarget(arg_4_0, arg_4_1)
	if arg_4_1 then
		GuideViewMgr.instance:disableHoleClick()
		GuideViewMgr.instance:setHoleClickCallback(nil, nil)
		TaskDispatcher.runDelay(arg_4_0._onDelayDone, arg_4_0, 0.01)

		local var_4_0 = GuideModel.instance:getStepGOPath(arg_4_0.guideId, arg_4_0.stepId)
		local var_4_1 = gohelper.find(var_4_0).transform.position
		local var_4_2 = RoomBendingHelper.worldToBendingSimple(var_4_1)
		local var_4_3 = CameraMgr.instance:getMainCamera():WorldToScreenPoint(var_4_2)

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchClickScene, var_4_3)
	end
end

function var_0_0._onDelayDone(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0
