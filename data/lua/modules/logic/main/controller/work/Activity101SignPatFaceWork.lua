module("modules.logic.main.controller.work.Activity101SignPatFaceWork", package.seeall)

local var_0_0 = class("Activity101SignPatFaceWork", PatFaceWorkBase)

function var_0_0._viewName(arg_1_0)
	return PatFaceConfig.instance:getPatFaceViewName(arg_1_0._patFaceId)
end

function var_0_0._actId(arg_2_0)
	return PatFaceConfig.instance:getPatFaceActivityId(arg_2_0._patFaceId)
end

function var_0_0.checkCanPat(arg_3_0)
	local var_3_0 = arg_3_0:_actId()

	return ActivityType101Model.instance:isOpen(var_3_0)
end

function var_0_0.startPat(arg_4_0)
	arg_4_0:_startBlock()

	local var_4_0 = arg_4_0:_actId()

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_4_0._refreshNorSignActivity, arg_4_0)
	Activity101Rpc.instance:sendGet101InfosRequest(var_4_0)
end

function var_0_0.clearWork(arg_5_0)
	arg_5_0:_endBlock()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_5_0._refreshNorSignActivity, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)
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

	arg_7_0:patComplete()
end

function var_0_0._refreshNorSignActivity(arg_8_0)
	local var_8_0 = arg_8_0:_actId()
	local var_8_1 = arg_8_0:_viewName()

	if not arg_8_0:isType101RewardCouldGetAnyOne() then
		if ViewMgr.instance:isOpen(var_8_1) then
			return
		end

		arg_8_0:patComplete()

		return
	end

	local var_8_2 = {
		actId = var_8_0
	}

	if string.nilorempty(var_8_1) then
		logError(string.format("Error: excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s\n没配 'patFaceViewName' !!", arg_8_0._patFaceId, var_8_0))
		arg_8_0:patComplete()

		return
	end

	if not _G.ViewName[var_8_1] then
		logError(string.format("Error: excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s, patFaceViewName: %s\nerror: modules_views.%s 不存在", arg_8_0._patFaceId, var_8_0, var_8_1, var_8_1))
		arg_8_0:patComplete()

		return
	end

	ViewMgr.instance:openView(var_8_1, var_8_2)
end

function var_0_0._endBlock(arg_9_0)
	if not arg_9_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._startBlock(arg_10_0)
	if arg_10_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_0._isBlock(arg_11_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function var_0_0.isType101RewardCouldGetAnyOne(arg_12_0)
	local var_12_0 = arg_12_0:_actId()

	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_12_0)
end

return var_0_0
