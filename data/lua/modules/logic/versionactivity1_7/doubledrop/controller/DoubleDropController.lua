module("modules.logic.versionactivity1_7.doubledrop.controller.DoubleDropController", package.seeall)

local var_0_0 = class("DoubleDropController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyRefresh, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_2_0._checkActivityInfo, arg_2_0)
end

function var_0_0._checkActivityInfo(arg_3_0, arg_3_1)
	local var_3_0 = DoubleDropModel.instance:getActId()

	if var_3_0 and not arg_3_1 or arg_3_1 == var_3_0 then
		if ActivityModel.instance:isActOnLine(var_3_0) then
			Activity153Rpc.instance:sendGet153InfosRequest(var_3_0)
		else
			ActivityController.instance:dispatchEvent(ActivityEvent.RefreshDoubleDropInfo)
		end
	end
end

function var_0_0.dailyRefresh(arg_4_0)
	local var_4_0 = DoubleDropModel.instance:getActId()

	if var_4_0 and ActivityModel.instance:isActOnLine(var_4_0) then
		Activity153Rpc.instance:sendGet153InfosRequest(var_4_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
