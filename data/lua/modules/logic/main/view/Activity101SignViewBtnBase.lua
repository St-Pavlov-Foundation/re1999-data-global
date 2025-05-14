module("modules.logic.main.view.Activity101SignViewBtnBase", package.seeall)

local var_0_0 = class("Activity101SignViewBtnBase", ActCenterItemBase)

function var_0_0.onAddEvent(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_1_0._refreshRedDot, arg_1_0)
end

function var_0_0.onRemoveEvent(arg_2_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0._refreshRedDot, arg_2_0)
end

function var_0_0.onClick(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(var_3_0) then
		return
	end

	local var_3_2 = arg_3_0:onGetActId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_3_2, arg_3_0._onReceiveGet101InfosReply, arg_3_0)
end

function var_0_0._onReceiveGet101InfosReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 0 then
		local var_4_0, var_4_1 = arg_4_0:onGetViewNameAndParam()

		ViewMgr.instance:openView(var_4_0, var_4_1)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function var_0_0._tryInit(arg_5_0)
	local var_5_0 = arg_5_0:onGetActId()

	if not ActivityType101Model.instance:isInit(var_5_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_5_0)
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_tryInit()
	arg_6_0:_addNotEventRedDot(arg_6_0._checkRed, arg_6_0)
end

function var_0_0._checkRed(arg_7_0)
	local var_7_0 = arg_7_0:onGetActId()

	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_7_0) and true or false
end

function var_0_0.onRefresh(arg_8_0)
	assert(false, "please override this function")
end

function var_0_0.onGetViewNameAndParam(arg_9_0)
	local var_9_0 = arg_9_0:getCustomData()
	local var_9_1 = var_9_0.viewParam

	return var_9_0.viewName, var_9_1
end

function var_0_0.onGetActId(arg_10_0)
	return arg_10_0:getCustomData().viewParam.actId
end

return var_0_0
