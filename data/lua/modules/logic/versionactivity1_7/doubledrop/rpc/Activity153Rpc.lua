module("modules.logic.versionactivity1_7.doubledrop.rpc.Activity153Rpc", package.seeall)

local var_0_0 = class("Activity153Rpc", BaseRpc)

function var_0_0.sendGet153InfosRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity153Module_pb.Get153InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet153InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	DoubleDropModel.instance:setActivity153Infos(arg_2_2)
end

function var_0_0.onReceiveAct153CountChangePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	DoubleDropModel.instance:setActivity153Infos(arg_3_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
