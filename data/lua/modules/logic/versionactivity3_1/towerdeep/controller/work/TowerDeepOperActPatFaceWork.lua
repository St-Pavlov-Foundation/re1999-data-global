module("modules.logic.versionactivity3_1.towerdeep.controller.work.TowerDeepOperActPatFaceWork", package.seeall)

local var_0_0 = class("TowerDeepOperActPatFaceWork", PatFaceWorkBase)

function var_0_0._viewName(arg_1_0)
	return PatFaceConfig.instance:getPatFaceViewName(arg_1_0._patFaceId)
end

function var_0_0._actId(arg_2_0)
	return PatFaceConfig.instance:getPatFaceActivityId(arg_2_0._patFaceId)
end

function var_0_0.checkCanPat(arg_3_0)
	local var_3_0 = arg_3_0:_actId()

	if not ActivityModel.instance:isActOnLine(var_3_0) then
		return false
	end

	local var_3_1 = ActivityModel.instance:getActMO(var_3_0)

	if not var_3_1 or not var_3_1:isOpen() or var_3_1:isExpired() then
		return false
	end

	local var_3_2 = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.TowerDeepActPat)

	if PlayerPrefsHelper.getNumber(var_3_2, 0) ~= 0 then
		return false
	end

	PlayerPrefsHelper.setNumber(var_3_2, 1)

	return true
end

function var_0_0.startPat(arg_4_0)
	arg_4_0:_startBlock()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.TowerDeep
	}, arg_4_0._onGetTaskInfo, arg_4_0)
end

function var_0_0._onGetTaskInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:_actId()

	Activity209Rpc.instance:sendGetAct209InfoRequest(var_5_0, arg_5_0._onGetInfoFinish, arg_5_0)
end

function var_0_0._onGetInfoFinish(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:_endBlock()

	if arg_6_2 == 0 then
		arg_6_0:_openPanelView()
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_6_0._onCloseViewFinish, arg_6_0)

		return
	end

	arg_6_0:patComplete()
end

function var_0_0.clearWork(arg_7_0)
	arg_7_0:_endBlock()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0.OnGetReward, arg_7_0)
end

function var_0_0._onOpenViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 ~= arg_8_0:_viewName() then
		return
	end

	arg_8_0:_endBlock()
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:_viewName()

	if arg_9_1 ~= var_9_0 then
		return
	end

	if ViewMgr.instance:isOpen(var_9_0) then
		return
	end

	arg_9_0:patComplete()
end

function var_0_0._openPanelView(arg_10_0)
	local var_10_0 = arg_10_0:_actId()
	local var_10_1 = arg_10_0:_viewName()
	local var_10_2 = {
		actId = var_10_0
	}

	ViewMgr.instance:openView(var_10_1, var_10_2)
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

return var_0_0
