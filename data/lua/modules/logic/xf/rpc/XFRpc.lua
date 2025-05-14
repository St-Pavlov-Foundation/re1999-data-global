module("modules.logic.xf.rpc.XFRpc", package.seeall)

local var_0_0 = class("XFRpc", BaseRpc)

function var_0_0.onReceiveGuestTimeOutPush(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 ~= 0 then
		return
	end

	SDKMgr.instance:showVistorPlayTimeOutDialog()
end

function var_0_0.onReceiveMinorPlayTimeOutPush(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.timeOutHour / 60
	local var_2_1 = string.format("%.1f", var_2_0)

	SDKMgr.instance:showMinorPlayTimeOutDialog(var_2_1)
end

function var_0_0.onReceiveMinorLimitLoginTimePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	local var_3_0 = arg_3_2.limitLoginTime

	if arg_3_2.isLogin then
		SDKMgr.instance:showMinorLimitLoginTimeDialog()
	else
		SDKMgr.instance:showMinorPlayTimeOutDialog()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
