module("framework.network.socket.work.WorkSocketDispose", package.seeall)

local var_0_0 = class("WorkSocketDispose", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	LuaSocketMgr.instance:reInit()
	arg_1_0:onDone(true)
end

return var_0_0
