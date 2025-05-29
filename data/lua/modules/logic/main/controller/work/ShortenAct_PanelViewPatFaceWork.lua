module("modules.logic.main.controller.work.ShortenAct_PanelViewPatFaceWork", package.seeall)

local var_0_0 = string.format
local var_0_1 = class("ShortenAct_PanelViewPatFaceWork", PatFaceWorkBase)

function var_0_1._viewName(arg_1_0)
	return PatFaceConfig.instance:getPatFaceViewName(arg_1_0._patFaceId)
end

function var_0_1._actId(arg_2_0)
	return PatFaceConfig.instance:getPatFaceActivityId(arg_2_0._patFaceId)
end

function var_0_1.checkCanPat(arg_3_0)
	local var_3_0 = arg_3_0:_actId()

	return ActivityHelper.getActivityStatus(var_3_0, true) == ActivityEnum.ActivityStatus.Normal
end

function var_0_1.startPat(arg_4_0)
	arg_4_0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, arg_4_0._onReceiveGetAct189InfoReply, arg_4_0)
	Activity189Controller.instance:sendGetAct189InfoRequest(arg_4_0:_actId())
end

function var_0_1.clearWork(arg_5_0)
	arg_5_0:_endBlock()
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, arg_5_0._onReceiveGetAct189InfoReply, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)
end

function var_0_1._onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0:_viewName() then
		return
	end

	arg_6_0:_endBlock()
end

function var_0_1._onCloseViewFinish(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:_viewName()

	if arg_7_1 ~= var_7_0 then
		return
	end

	if ViewMgr.instance:isOpen(var_7_0) then
		return
	end

	arg_7_0:patComplete()
end

function var_0_1._onReceiveGetAct189InfoReply(arg_8_0)
	local var_8_0 = arg_8_0:_viewName()

	if not arg_8_0:_isClaimable() then
		arg_8_0:patComplete()

		return
	end

	if string.nilorempty(var_8_0) then
		logError(var_0_0("excel:P拍脸表.xlsx - sheet:export_拍脸 error id: %s, patFaceActivityId: %s, 没配 'patFaceViewName' !!", arg_8_0._patFaceId, arg_8_0:_actId()))
		arg_8_0:patComplete()

		return
	end

	if not ViewName[var_8_0] then
		logError(var_0_0("excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s, patFaceViewName: %s, error: modules_views.%s 不存在", arg_8_0._patFaceId, arg_8_0:_actId(), var_8_0, var_8_0))
		arg_8_0:patComplete()

		return
	end

	ViewMgr.instance:openView(var_8_0)
end

function var_0_1._endBlock(arg_9_0)
	if not arg_9_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_1._startBlock(arg_10_0)
	if arg_10_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_1._isBlock(arg_11_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function var_0_1._isClaimable(arg_12_0)
	return Activity189Model.instance:isClaimable(arg_12_0:_actId())
end

return var_0_1
