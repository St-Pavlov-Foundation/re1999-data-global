module("modules.logic.activity.rpc.Activity113Rpc", package.seeall)

local var_0_0 = class("Activity113Rpc", BaseRpc)

function var_0_0.sendGetAct113InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity113Module_pb.GetAct113InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct113InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
