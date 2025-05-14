module("modules.logic.common.rpc.CommonRpc", package.seeall)

local var_0_0 = class("CommonRpc", BaseRpc)

function var_0_0.sendGetServerTimeRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = CommonModule_pb.GetServerTimeRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetServerTimeReply(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = tonumber(arg_2_2.offsetTime)
	local var_2_1 = math.floor(var_2_0 / 1000)

	ServerTime.init(var_2_1)

	local var_2_2 = tonumber(arg_2_2.serverTime)
	local var_2_3 = math.floor(var_2_2 / 1000)

	ServerTime.update(var_2_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
