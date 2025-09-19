module("modules.logic.versionactivity2_8.act199.controller.Activity199Controller", package.seeall)

local var_0_0 = class("Activity199Controller", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_1_0._checkActivityInfo, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0._checkActivityInfo, arg_1_0)
end

function var_0_0._checkActivityInfo(arg_2_0)
	arg_2_0:getActivity199Info()
end

function var_0_0.getActivity199Info(arg_3_0, arg_3_1, arg_3_2)
	if not Activity199Model.instance:isActivity199Open() then
		return
	end

	local var_3_0 = Activity199Model.instance:getActivity199Id()

	Activity199Rpc.instance:sendGet199InfoRequest(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.openV2a8_SelfSelectCharacterView(arg_4_0)
	arg_4_0:getActivity199Info(arg_4_0._realV2a8_SelfSelectCharacterView, arg_4_0)
end

function var_0_0._realV2a8_SelfSelectCharacterView(arg_5_0)
	ViewMgr.instance:openView(ViewName.V2a8_SelfSelectCharacterView, {
		actId = Activity199Model.instance:getActivity199Id()
	})
end

var_0_0.instance = var_0_0.New()

return var_0_0
