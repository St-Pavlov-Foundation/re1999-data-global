module("framework.network.socket.work.WorkGetLostCmdRespRequest", package.seeall)

local var_0_0 = class("WorkGetLostCmdRespRequest", BaseWork)
local var_0_1 = "GetLostCmd"

function var_0_0.onStart(arg_1_0)
	var_0_0.super.onStart(arg_1_0)
	ConnectAliveMgr.instance:ignoreUnimportantCmds()
	UIBlockMgr.instance:startBlock(var_0_1)

	local var_1_0 = ConnectAliveMgr.instance:getCurrDownTag()

	arg_1_0._callbackId = SystemLoginRpc.instance:sendGetLostCmdRespRequest(var_1_0, arg_1_0._onGetLostCmdRespCallback, arg_1_0)

	TaskDispatcher.runDelay(arg_1_0._timeout, arg_1_0, NetworkConst.UnresponsiveMsgMaxTime)
end

function var_0_0.onResume(arg_2_0)
	arg_2_0._callbackId = SystemLoginRpc.instance:addCallback(3, arg_2_0._onGetLostCmdRespCallback, arg_2_0)

	TaskDispatcher.runDelay(arg_2_0._timeout, arg_2_0, NetworkConst.UnresponsiveMsgMaxTime)
end

function var_0_0.clearWork(arg_3_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	SystemLoginRpc.instance:removeCallbackById(arg_3_0._callbackId)
	TaskDispatcher.cancelTask(arg_3_0._timeout, arg_3_0)
end

function var_0_0._onGetLostCmdRespCallback(arg_4_0, arg_4_1, arg_4_2)
	logNormal("后端补包协议成功")
	arg_4_0:onDone(true)
end

function var_0_0._timeout(arg_5_0)
	logNormal("后端补包协议超时")
	arg_5_0:onDone(false)
end

return var_0_0
