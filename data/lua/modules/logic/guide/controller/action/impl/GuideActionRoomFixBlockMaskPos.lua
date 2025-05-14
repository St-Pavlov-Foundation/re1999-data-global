module("modules.logic.guide.controller.action.impl.GuideActionRoomFixBlockMaskPos", package.seeall)

local var_0_0 = class("GuideActionRoomFixBlockMaskPos", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = GuideModel.instance:getStepGOPath(arg_1_0.guideId, arg_1_0.stepId)
	local var_1_1 = gohelper.find(var_1_0)

	if gohelper.isNil(var_1_1) then
		logError(arg_1_0.guideId .. "_" .. arg_1_0.stepId .. " blockGO is nil: " .. var_1_0)
		arg_1_0:onDone(true)

		return
	end

	if ViewMgr.instance:isOpenFinish(ViewName.GuideView) then
		arg_1_0:_fixPos()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenView, arg_1_0)
	end
end

function var_0_0._checkOpenView(arg_2_0, arg_2_1)
	if arg_2_1 == ViewName.GuideView then
		arg_2_0:_fixPos()
	end
end

function var_0_0._fixPos(arg_3_0)
	local var_3_0 = GuideModel.instance:getStepGOPath(arg_3_0.guideId, arg_3_0.stepId)
	local var_3_1 = gohelper.find(var_3_0)
	local var_3_2 = ViewMgr.instance:getContainer(ViewName.GuideView)
	local var_3_3 = var_3_2 and var_3_2.viewGO
	local var_3_4 = var_3_3 and var_3_3.transform
	local var_3_5 = var_3_1.transform.position
	local var_3_6 = RoomBendingHelper.worldToBendingSimple(var_3_5)
	local var_3_7 = recthelper.worldPosToAnchorPos(var_3_5, var_3_4)
	local var_3_8 = recthelper.worldPosToAnchorPos(var_3_6, var_3_4) - var_3_7

	GuideController.instance:dispatchEvent(GuideEvent.SetMaskOffset, var_3_8)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._checkOpenView, arg_4_0)
end

function var_0_0.onDestroy(arg_5_0)
	var_0_0.super.onDestroy(arg_5_0)
	GuideController.instance:dispatchEvent(GuideEvent.SetMaskOffset, nil)
end

return var_0_0
