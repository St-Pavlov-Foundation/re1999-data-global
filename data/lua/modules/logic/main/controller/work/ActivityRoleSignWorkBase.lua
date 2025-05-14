module("modules.logic.main.controller.work.ActivityRoleSignWorkBase", package.seeall)

local var_0_0 = class("ActivityRoleSignWorkBase", BaseWork)
local var_0_1 = 0

local function var_0_2(arg_1_0)
	if not arg_1_0._viewNames then
		arg_1_0._viewNames = assert(arg_1_0:onGetViewNames())
	end
end

local function var_0_3(arg_2_0)
	if not arg_2_0._actIds then
		arg_2_0._actIds = assert(arg_2_0:onGetActIds())
	end
end

function var_0_0.onStart(arg_3_0)
	var_0_2(arg_3_0)
	var_0_3(arg_3_0)

	var_0_1 = 0

	if arg_3_0:_isExistGuide() then
		arg_3_0:_endBlock()
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_3_0._work, arg_3_0)
	else
		arg_3_0:_work()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_3_0._onOpenViewFinish, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0._refreshNorSignActivity, arg_3_0)
end

function var_0_0._refreshNorSignActivity(arg_4_0)
	local var_4_0 = arg_4_0._actId
	local var_4_1 = arg_4_0._viewName

	if not var_4_0 then
		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_4_0) then
		if ViewMgr.instance:isOpen(var_4_1) then
			return
		end

		arg_4_0:_work()

		return
	end

	local var_4_2 = {
		actId = var_4_0
	}

	ViewMgr.instance:openView(var_4_1, var_4_2)
end

function var_0_0._onCloseViewFinish(arg_5_0, arg_5_1)
	if arg_5_1 ~= arg_5_0._viewName then
		return
	end

	if ViewMgr.instance:isOpen(arg_5_0._viewName) then
		return
	end

	arg_5_0:_work()
end

function var_0_0._onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0._viewName then
		return
	end

	arg_6_0:_endBlock()
end

function var_0_0.clearWork(arg_7_0)
	arg_7_0:_endBlock()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_7_0._work, arg_7_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_7_0._refreshNorSignActivity, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0._onOpenViewFinish, arg_7_0)

	arg_7_0._actId = nil
	arg_7_0._viewName = nil
end

function var_0_0._pop(arg_8_0)
	var_0_1 = var_0_1 + 1

	local var_8_0 = arg_8_0._viewNames[var_0_1]

	return arg_8_0._actIds[var_0_1], var_8_0
end

function var_0_0._work(arg_9_0)
	arg_9_0:_startBlock()

	arg_9_0._actId, arg_9_0._viewName = arg_9_0:_pop()

	local var_9_0 = arg_9_0._actId

	if not var_9_0 then
		arg_9_0:onDone(true)

		return
	end

	if ActivityType101Model.instance:isOpen(var_9_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_9_0)

		return
	end

	arg_9_0:_work()
end

function var_0_0._isExistGuide(arg_10_0)
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
end

function var_0_0._endBlock(arg_11_0)
	if not arg_11_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._startBlock(arg_12_0)
	if arg_12_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_0._isBlock(arg_13_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function var_0_0.onGetViewNames(arg_14_0)
	assert(false, "please override this function")
end

function var_0_0.onGetActIds(arg_15_0)
	assert(false, "please override this function")
end

return var_0_0
