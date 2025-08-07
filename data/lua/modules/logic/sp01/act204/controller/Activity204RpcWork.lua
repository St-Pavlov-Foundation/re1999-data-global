module("modules.logic.sp01.act204.controller.Activity204RpcWork", package.seeall)

local var_0_0 = class("Activity204RpcWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0._activityId = arg_1_1
	arg_1_0._rpcFunc = arg_1_2
	arg_1_0._rpcInst = arg_1_3
	arg_1_0._params = arg_1_4
	arg_1_0._callback = arg_1_5
	arg_1_0._callbackObj = arg_1_6
end

function var_0_0.onStart(arg_2_0)
	if not ActivityHelper.isOpen(arg_2_0._activityId) then
		arg_2_0:onDone(true)

		return
	end

	if not arg_2_0._rpcFunc or not arg_2_0._rpcInst then
		logError(string.format("Activity204RpcWork Error ! RpcFun or RpcInst is nil ! activityId = %s", arg_2_0._activityId))
		arg_2_0:onDone(false)

		return
	end

	if arg_2_0._params then
		arg_2_0._callbackId = arg_2_0._rpcFunc(arg_2_0._rpcInst, arg_2_0._params, arg_2_0._onGetRpcInfo, arg_2_0)
	else
		arg_2_0._callbackId = arg_2_0._rpcFunc(arg_2_0._rpcInst, arg_2_0._onGetRpcInfo, arg_2_0)
	end
end

function var_0_0._onGetRpcInfo(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._callback then
		if arg_3_0._callbackObj then
			arg_3_0._callback(arg_3_0._callbackObj, arg_3_1, arg_3_2)
		else
			arg_3_0._callback(arg_3_1, arg_3_2)
		end
	end

	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._callbackId and arg_4_0._rpcInst then
		arg_4_0._rpcInst:removeCallbackById(arg_4_0._callbackId)

		arg_4_0.callbackId = nil
	end

	var_0_0.super.clearWork(arg_4_0)
end

return var_0_0
