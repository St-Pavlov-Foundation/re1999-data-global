module("modules.logic.login.controller.work.LogoutSocketWork", package.seeall)

local var_0_0 = class("LogoutSocketWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_1.isConnected then
		-- block empty
	end

	ConnectAliveMgr.instance:logout()
	arg_2_0:onDone(true)
end

return var_0_0
