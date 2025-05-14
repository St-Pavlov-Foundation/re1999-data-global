module("modules.logic.dispatch.rpc.DispatchRpc", package.seeall)

local var_0_0 = class("DispatchRpc", BaseRpc)

function var_0_0.sendGetDispatchInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = DispatchModule_pb.GetDispatchInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetDispatchInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	DispatchModel.instance:initDispatchInfos(arg_2_2.dispatchInfos)
end

function var_0_0.sendDispatchRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = DispatchModule_pb.DispatchRequest()

	var_3_0.elementId = arg_3_1
	var_3_0.dispatchId = arg_3_2

	if arg_3_3 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_3) do
			var_3_0.heroIds:append(iter_3_1)
		end
	end

	return arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveDispatchReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = tonumber(arg_4_2.startTime)
	local var_4_1 = math.floor(var_4_0 / 1000)

	ServerTime.update(var_4_1)
	DispatchModel.instance:addDispatch(arg_4_2)
end

function var_0_0.sendInterruptDispatchRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = DispatchModule_pb.InterruptDispatchRequest()

	var_5_0.elementId = arg_5_1
	var_5_0.dispatchId = arg_5_2

	return arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveInterruptDispatchReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	DispatchModel.instance:removeDispatch(arg_6_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
