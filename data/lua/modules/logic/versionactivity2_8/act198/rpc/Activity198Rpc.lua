module("modules.logic.versionactivity2_8.act198.rpc.Activity198Rpc", package.seeall)

local var_0_0 = class("Activity198Rpc", BaseRpc)

function var_0_0.sendAct198GainRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity198Module_pb.Act198GainRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAct198GainReply(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return
end

function var_0_0.onReceiveAct198CanGetPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	arg_3_0._actId = arg_3_2.activityId

	arg_3_0:sendAct198GainRequest(arg_3_0._actId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
