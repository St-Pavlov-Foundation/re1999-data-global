module("framework.network.socket.work.WorkAliveConnectCheck", package.seeall)

local var_0_0 = class("WorkAliveConnectCheck", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0:_addEvents()
end

function var_0_0.onResume(arg_2_0)
	arg_2_0:_addEvents()
end

function var_0_0.clearWork(arg_3_0)
	arg_3_0:_removeEvents()
end

function var_0_0._addEvents(arg_4_0)
	TaskDispatcher.runRepeat(arg_4_0._onSecond, arg_4_0, 1)
end

function var_0_0._removeEvents(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onSecond, arg_5_0)
end

function var_0_0._onSecond(arg_6_0)
	if not LuaSocketMgr.instance:isConnected() then
		logNormal("socket 断开了，检查工作结束，准备发起自动重连")
		arg_6_0:onDone(true)

		return
	end

	local var_6_0 = ConnectAliveMgr.instance:getFirstUnresponsiveMsg()

	if var_6_0 and Time.realtimeSinceStartup - var_6_0.time > NetworkConst.UnresponsiveMsgMaxTime then
		local var_6_1 = "cmd_" .. var_6_0.cmd .. " 超时未响应，主动断开连接，准备发起自动重连, "
		local var_6_2 = string.format("%.2f - %.2f > %.2f", Time.realtimeSinceStartup, var_6_0.time, NetworkConst.UnresponsiveMsgMaxTime)
		local var_6_3 = ConnectAliveMgr.instance:getUnresponsiveMsgList()
		local var_6_4 = ", 未响应包" .. #var_6_3 .. ": "

		for iter_6_0, iter_6_1 in ipairs(var_6_3) do
			var_6_4 = string.format("%s%d(%.2f)", var_6_4, iter_6_1.cmd, iter_6_1.time)
		end

		logNormal(var_6_1 .. var_6_2 .. var_6_4)
		LuaSocketMgr.instance:endConnect()
		ConnectAliveMgr.instance:dispatchEvent(ConnectEvent.OnMsgTimeout)
		arg_6_0:onDone(true)
	end
end

return var_0_0
