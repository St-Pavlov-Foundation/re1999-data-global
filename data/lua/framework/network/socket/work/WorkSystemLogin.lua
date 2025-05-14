module("framework.network.socket.work.WorkSystemLogin", package.seeall)

local var_0_0 = class("WorkSystemLogin", BaseWork)
local var_0_1 = "SystemLogin"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._connectWay = arg_1_1.connectWay
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	UIBlockMgr.instance:startBlock(var_0_1)

	arg_2_0._account = arg_2_1.account
	arg_2_0._password = arg_2_1.password
	arg_2_0._callbackId = SystemLoginRpc.instance:sendLoginRequest(arg_2_0._account, arg_2_0._password, arg_2_0._connectWay, arg_2_0._onLoginCallback, arg_2_0)

	TaskDispatcher.runDelay(arg_2_0._onSystemLoginTimeout, arg_2_0, NetworkConst.SystemLoginTimeout)
end

function var_0_0.clearWork(arg_3_0)
	UIBlockMgr.instance:endBlock(var_0_1)
	SystemLoginRpc.instance:removeCallbackById(arg_3_0._callbackId)
	TaskDispatcher.cancelTask(arg_3_0._onSystemLoginTimeout, arg_3_0)
end

function var_0_0._onLoginCallback(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 == 0 then
		arg_4_0:onDone(true)
	else
		arg_4_0.context.dontReconnect = true
		arg_4_0.context.systemLoginFail = true
		arg_4_0.context.msg = arg_4_3.reason

		arg_4_0:onDone(false)
	end
end

function var_0_0._onSystemLoginTimeout(arg_5_0)
	arg_5_0:onDone(false)
end

return var_0_0
