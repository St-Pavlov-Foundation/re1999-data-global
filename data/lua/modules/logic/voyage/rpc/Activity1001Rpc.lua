module("modules.logic.voyage.rpc.Activity1001Rpc", package.seeall)

local var_0_0 = class("Activity1001Rpc", BaseRpc)

function var_0_0.sendAct1001GetInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = Activity1001Module_pb.Act1001GetInfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3, arg_1_4)
end

function var_0_0.onReceiveAct1001GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	VoyageController.instance:_onReceiveAct1001GetInfoReply(arg_2_2)
end

function var_0_0.onReceiveAct1001UpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	VoyageController.instance:_onReceiveAct1001UpdatePush(arg_3_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
