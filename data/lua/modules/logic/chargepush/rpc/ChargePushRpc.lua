module("modules.logic.chargepush.rpc.ChargePushRpc", package.seeall)

local var_0_0 = class("ChargePushRpc", BaseRpc)

function var_0_0.sendGetChargePushInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ChargePushModule_pb.GetChargePushInfoRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetChargePushInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendRecordchargePushRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = ChargePushModule_pb.RecordChargePushRequest()

	var_3_0.id = arg_3_1

	return arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveRecordChargePushReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	end
end

function var_0_0.onReceiveGetChargePushPush(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		ChargePushModel.instance:onReceivePushInfo(arg_5_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
