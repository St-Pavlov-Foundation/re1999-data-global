module("modules.logic.main.controller.work.ActivityRoleSignWork_1_4", package.seeall)

local var_0_0 = class("ActivityRoleSignWork_1_4", BaseWork)
local var_0_1 = 0
local var_0_2 = {
	ActivityEnum.Activity.RoleSignViewPart1_1_4,
	ActivityEnum.Activity.RoleSignViewPart2_1_4
}

local function var_0_3()
	if not var_0_0.kViewNames then
		local var_1_0 = {
			ViewName.V1a4_Role_PanelSignView_Part1,
			ViewName.V1a4_Role_PanelSignView_Part2
		}

		var_0_0.kViewNames = var_1_0
	end
end

function var_0_0.onStart(arg_2_0)
	var_0_3()

	var_0_1 = 0

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
	local var_3_0 = arg_3_0._actId
	local var_3_1 = arg_3_0._viewName

	if not var_3_0 then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_3_0) then
		if ViewMgr.instance:isOpen(var_3_1) then
			return
		end

		arg_3_0:_work()

		return
	end

	local var_3_2 = {
		actId = var_3_0
	}

	ViewMgr.instance:openView(var_3_1, var_3_2)
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
	arg_6_0:_endBlock()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_6_0._work, arg_6_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_6_0._refreshNorSignActivity, arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)

	arg_6_0._actId = nil
	arg_6_0._viewName = nil
end

function var_0_0._pop(arg_7_0)
	var_0_1 = var_0_1 + 1

	local var_7_0 = var_0_0.kViewNames[var_0_1]

	return var_0_2[var_0_1], var_7_0
end

function var_0_0._work(arg_8_0)
	arg_8_0:_startBlock()

	arg_8_0._actId, arg_8_0._viewName = arg_8_0:_pop()

	local var_8_0 = arg_8_0._actId

	if not var_8_0 then
		arg_8_0:onDone(true)

		return
	end

	if ActivityModel.instance:isActOnLine(var_8_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_8_0)

		return
	end

	arg_8_0:_work()
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
