module("modules.logic.login.controller.work.LogoutOpenLoginWork", package.seeall)

local var_0_0 = class("LogoutOpenLoginWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	LoginController.instance:login({
		userManualLogout = true,
		isModuleLogout = true,
		isSdkLogout = arg_2_1.isSdkLogout
	})
	arg_2_0:onDone(true)
end

return var_0_0
