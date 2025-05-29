module("modules.logic.main.controller.work.WeekwalkHeart_PanelViewPatFaceWork", package.seeall)

local var_0_0 = class("WeekwalkHeart_PanelViewPatFaceWork", PatFaceWorkBase)

var_0_0.SigninId = 530007

function var_0_0._viewName(arg_1_0)
	return PatFaceConfig.instance:getPatFaceViewName(arg_1_0._patFaceId)
end

function var_0_0._actId(arg_2_0)
	return PatFaceConfig.instance:getPatFaceActivityId(arg_2_0._patFaceId)
end

function var_0_0.checkCanPat(arg_3_0)
	local var_3_0 = arg_3_0:_actId()
	local var_3_1 = false

	if ActivityHelper.getActivityStatus(var_3_0, true) == ActivityEnum.ActivityStatus.Normal then
		local var_3_2 = TaskModel.instance:getTaskById(var_0_0.SigninId)

		if var_3_2 and not (var_3_2.finishCount > 0) then
			var_3_1 = true
		end
	end

	return var_3_1
end

function var_0_0.startPat(arg_4_0)
	arg_4_0:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_4_0._onOpenViewFinish, arg_4_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, arg_4_0._onReceiveGetAct189InfoReply, arg_4_0)
	Activity189Controller.instance:sendGetAct189InfoRequest(arg_4_0:_actId())
end

function var_0_0.clearWork(arg_5_0)
	arg_5_0:_endBlock()
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, arg_5_0._onReceiveGetAct189InfoReply, arg_5_0)
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

function var_0_0._onReceiveGetAct189InfoReply(arg_8_0)
	local var_8_0 = arg_8_0:_viewName()

	if not arg_8_0:_isClaimable() then
		arg_8_0:patComplete()

		return
	end

	ViewMgr.instance:openView(var_8_0)
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

function var_0_0._isClaimable(arg_12_0)
	return Activity189Model.instance:isClaimable(arg_12_0:_actId())
end

return var_0_0
