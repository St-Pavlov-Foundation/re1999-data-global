module("modules.logic.versionactivity1_2.trade.controller.Activity117Controller", package.seeall)

local var_0_0 = class("Activity117Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openView(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0, var_3_1, var_3_2 = ActivityHelper.getActivityStatusAndToast(arg_3_1)

	if var_3_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_1 then
			GameFacade.showToastWithTableParam(var_3_1, var_3_2)
		end

		return
	end

	arg_3_0:initAct(arg_3_1)

	local var_3_3 = {
		actId = arg_3_1,
		tabIndex = arg_3_2
	}

	arg_3_0:openTradeBargainView(var_3_3)
end

function var_0_0.initAct(arg_4_0, arg_4_1)
	Activity117Model.instance:initAct(arg_4_1)
	Activity117Rpc.instance:sendAct117InfoRequest(arg_4_1)
end

function var_0_0.openTradeBargainView(arg_5_0, arg_5_1)
	ViewMgr.instance:openView(ViewName.ActivityTradeBargain, arg_5_1)
end

function var_0_0.openTradeSuccessView(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.ActivityTradeSuccessView, arg_6_1)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
