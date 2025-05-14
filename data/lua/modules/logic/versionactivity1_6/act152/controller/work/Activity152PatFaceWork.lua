module("modules.logic.versionactivity1_6.act152.controller.work.Activity152PatFaceWork", package.seeall)

local var_0_0 = class("Activity152PatFaceWork", PatFaceWorkBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0:_startPatFaceWork()
end

function var_0_0._needWaitShow(arg_2_0)
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	return not MainController.instance:isInMainView()
end

function var_0_0._startCheckShow(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._startPatFaceWork, arg_3_0)
	TaskDispatcher.runRepeat(arg_3_0._startPatFaceWork, arg_3_0, 0.5)
end

function var_0_0._startPatFaceWork(arg_4_0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		arg_4_0:onDone(true)

		return
	end

	if arg_4_0:_needWaitShow() then
		arg_4_0:_startCheckShow()

		return
	end

	TaskDispatcher.cancelTask(arg_4_0._startPatFaceWork, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._checkRewardGet, arg_4_0)

	local var_4_0 = Activity152Model.instance:getPresentUnaccepted()

	if #var_4_0 > 0 then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onGetGift, arg_4_0)
		Activity152Controller.instance:openNewYearGiftView(var_4_0[1])
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0._onGetGift(arg_5_0, arg_5_1)
	if arg_5_1 ~= ViewName.NewYearEveGiftView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onGetGift, arg_5_0)

	local var_5_0 = ActivityEnum.Activity.NewYearEve
	local var_5_1 = Activity152Model.instance:getPresentUnaccepted()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_5_0._checkRewardGet, arg_5_0)
	Activity152Rpc.instance:sendAct152AcceptPresentRequest(var_5_0, var_5_1[1], arg_5_0._enterNext, arg_5_0)
end

function var_0_0._enterNext(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		arg_6_0:onDone(true)

		return
	end

	Activity152Model.instance:setActivity152PresentGet(arg_6_3.present.presentId)
end

function var_0_0._checkRewardGet(arg_7_0, arg_7_1)
	if arg_7_1 ~= ViewName.CommonPropView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0._checkRewardGet, arg_7_0)
	arg_7_0:_startPatFaceWork()
end

function var_0_0.clearWork(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._startPatFaceWork, arg_8_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_8_0._checkRewardGet, arg_8_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_8_0._onGetGift, arg_8_0)
end

return var_0_0
