module("modules.logic.signin.controller.work.ActivityStarLightSignWork_1_3", package.seeall)

local var_0_0 = class("ActivityStarLightSignWork_1_3", BaseWork)
local var_0_1 = 0
local var_0_2 = {
	ActivityEnum.Activity.StarLightSignPart1_1_3,
	ActivityEnum.Activity.StarLightSignPart2_1_3
}

local function var_0_3()
	if not var_0_0.kViewNames then
		local var_1_0 = {
			ViewName.ActivityStarLightSignPart1PaiLianView_1_3,
			ViewName.ActivityStarLightSignPart2PaiLianView_1_3
		}

		var_0_0.kViewNames = var_1_0
	end
end

function var_0_0.onStart(arg_2_0)
	var_0_3()

	if arg_2_0:_isExistGuide() then
		arg_2_0:_endBlock()
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_2_0._work, arg_2_0)
	else
		arg_2_0:_work()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_2_0._onOpenViewFinish, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0._refreshNorSignActivity, arg_2_0)
end

function var_0_0._refreshNorSignActivity(arg_3_0)
	if not arg_3_0._actId then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(arg_3_0._actId) then
		if ViewMgr.instance:isOpen(arg_3_0._viewName) then
			return
		end

		arg_3_0:_work()

		return
	end

	ViewMgr.instance:openView(arg_3_0._viewName)
end

function var_0_0._onCloseViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 ~= arg_4_0._viewName then
		return
	end

	if ViewMgr.instance:isOpen(arg_4_0._viewName) then
		return
	end

	arg_4_0:_work()
end

function var_0_0._onOpenViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 ~= arg_5_0._viewName then
		return
	end

	arg_5_0:_endBlock()
end

function var_0_0.clearWork(arg_6_0)
	if not arg_6_0.isSuccess then
		arg_6_0:_endBlock()
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_6_0._work, arg_6_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_6_0._refreshNorSignActivity, arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)

	arg_6_0._actId = nil
	arg_6_0._viewName = nil
	var_0_1 = 0
end

function var_0_0._pop(arg_7_0)
	var_0_1 = var_0_1 + 1

	local var_7_0 = var_0_0.kViewNames[var_0_1]

	return var_0_2[var_0_1], var_7_0
end

function var_0_0._work(arg_8_0)
	arg_8_0:_startBlock()

	arg_8_0._actId, arg_8_0._viewName = arg_8_0:_pop()

	if not arg_8_0._actId then
		arg_8_0:onDone(true)

		return
	end

	local var_8_0 = arg_8_0._actId

	if ActivityModel.instance:isActOnLine(var_8_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_8_0)
	else
		return arg_8_0:_work()
	end
end

function var_0_0._isExistGuide(arg_9_0)
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
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

return var_0_0
