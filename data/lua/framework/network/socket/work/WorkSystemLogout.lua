module("framework.network.socket.work.WorkSystemLogout", package.seeall)

local var_0_0 = class("WorkSystemLogout", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	LuaSocketMgr.instance:endConnect()
	arg_1_0:onDone(true)
end

return var_0_0
