module("modules.logic.main.controller.work.SummonNewCustomPickPatFaceWork", package.seeall)

local var_0_0 = class("SummonNewCustomPickPatFaceWork", PatFaceWorkBase)

function var_0_0._viewName(arg_1_0)
	return PatFaceConfig.instance:getPatFaceViewName(arg_1_0._patFaceId)
end

function var_0_0._actId(arg_2_0)
	return PatFaceConfig.instance:getPatFaceActivityId(arg_2_0._patFaceId)
end

function var_0_0.checkCanPat(arg_3_0)
	local var_3_0 = arg_3_0:_actId()
	local var_3_1 = SummonNewCustomPickViewModel.instance:getHaveFirstDayLogin(var_3_0)

	return SummonNewCustomPickViewModel.instance:isActivityOpen(var_3_0) and var_3_1
end

function var_0_0.startPat(arg_4_0)
	arg_4_0:_startBlock()

	local var_4_0 = arg_4_0:_actId()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnGetServerInfoReply, arg_4_0._refreshSummonCustomPickActivity, arg_4_0)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnSummonCustomGet, arg_4_0._revertOpenState, arg_4_0)
	SummonNewCustomPickViewRpc.instance:sendGet169InfoRequest(var_4_0)
end

function var_0_0.clearWork(arg_5_0)
	arg_5_0:_endBlock()

	arg_5_0._needRevert = false

	SummonNewCustomPickViewController.instance:unregisterCallback(SummonNewCustomPickEvent.OnGetServerInfoReply, arg_5_0._refreshSummonCustomPickActivity, arg_5_0)
	SummonNewCustomPickViewController.instance:unregisterCallback(SummonNewCustomPickEvent.OnSummonCustomGet, arg_5_0._revertOpenState, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0.OnGetReward, arg_5_0)
end

function var_0_0._onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0:_viewName() then
		return
	end

	arg_6_0:_endBlock()
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:_viewName()

	if arg_7_1 ~= var_7_0 then
		return
	end

	if ViewMgr.instance:isOpen(var_7_0) then
		return
	end

	if arg_7_0._needRevert then
		arg_7_0._needRevert = false

		return
	end

	arg_7_0:patComplete()
end

function var_0_0._refreshSummonCustomPickActivity(arg_8_0)
	local var_8_0 = arg_8_0:_actId()
	local var_8_1 = arg_8_0:_viewName()

	if arg_8_0:isActivityRewardGet() then
		if ViewMgr.instance:isOpen(var_8_1) then
			return
		end

		arg_8_0:patComplete()

		return
	end

	local var_8_2 = {
		refreshData = false,
		actId = var_8_0
	}

	ViewMgr.instance:openView(var_8_1, var_8_2)
	SummonNewCustomPickViewModel.instance:setHaveFirstDayLogin(var_8_0)
	SummonNewCustomPickViewController.instance:registerCallback(SummonNewCustomPickEvent.OnSummonCustomGet, arg_8_0._revertOpenState, arg_8_0)
end

function var_0_0._revertOpenState(arg_9_0)
	arg_9_0._needRevert = true
end

function var_0_0._endBlock(arg_10_0)
	if not arg_10_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._startBlock(arg_11_0)
	if arg_11_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_0._isBlock(arg_12_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function var_0_0.isActivityRewardGet(arg_13_0)
	local var_13_0 = arg_13_0:_actId()

	return SummonNewCustomPickViewModel.instance:isGetReward(var_13_0)
end

return var_0_0
