module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_ActCenterItemBtn", package.seeall)

local var_0_0 = class("V1a6_Role_PanelSignView_ActCenterItemBtn", ActCenterItemBase)

function var_0_0.onInit(arg_1_0, arg_1_1)
	return
end

function var_0_0.onAddEvent(arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0._refreshRedDot, arg_2_0)
end

function var_0_0.onRemoveEvent(arg_3_0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0._refreshRedDot, arg_3_0)
end

function var_0_0.onClick(arg_4_0)
	local var_4_0 = arg_4_0:_viewNameAndParam()

	if ViewMgr.instance:isOpen(var_4_0) then
		return
	end

	local var_4_1 = arg_4_0:_actId()

	Activity101Rpc.instance:sendGet101InfosRequest(var_4_1, arg_4_0._onReceiveGet101InfosReply, arg_4_0)
end

function var_0_0._onReceiveGet101InfosReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == 0 then
		local var_5_0, var_5_1 = arg_5_0:_viewNameAndParam()

		ViewMgr.instance:openView(var_5_0, var_5_1)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function var_0_0._viewNameAndParam(arg_6_0)
	local var_6_0 = arg_6_0:getCustomData()
	local var_6_1 = var_6_0.viewParam

	return var_6_0.viewName, var_6_1
end

function var_0_0._actId(arg_7_0)
	return arg_7_0:getCustomData().viewParam.actId
end

function var_0_0._tryInit(arg_8_0)
	local var_8_0 = arg_8_0:_actId()

	if not ActivityType101Model.instance:isInit(var_8_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_8_0)
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:_tryInit()
	arg_9_0:_addNotEventRedDot(arg_9_0._checkRed, arg_9_0)
end

function var_0_0.onRefresh(arg_10_0)
	arg_10_0:_setMainSprite("v1a6_act_icon3")
end

function var_0_0._checkRed(arg_11_0)
	local var_11_0 = arg_11_0:_actId()

	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(var_11_0) and true or false
end

return var_0_0
