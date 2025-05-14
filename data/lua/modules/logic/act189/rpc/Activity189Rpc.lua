module("modules.logic.act189.rpc.Activity189Rpc", package.seeall)

local var_0_0 = class("Activity189Rpc", BaseRpc)

function var_0_0.sendGetAct189InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity189Module_pb.GetAct189InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct189InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity189Model.instance:onReceiveGetAct189InfoReply(arg_2_2)
		Activity189Controller.instance:dispatchEvent(Activity189Event.onReceiveGetAct189InfoReply, arg_2_2)
	end
end

function var_0_0.sendGetAct189OnceBonusRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity189Module_pb.GetAct189OnceBonusRequest()

	var_3_0.activityId = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveGetAct189OnceBonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity189Model.instance:onReceiveGetAct189OnceBonusReply(arg_4_2)
		Activity189Controller.instance:dispatchEvent(Activity189Event.onReceiveGetAct189OnceBonusReply, arg_4_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
