module("modules.logic.versionactivity1_6.act152.rpc.Activity152Rpc", package.seeall)

local var_0_0 = class("Activity152Rpc", BaseRpc)

function var_0_0.sendGet152InfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity152Module_pb.Get152InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet152InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity152Model.instance:setActivity152Infos(arg_2_2.presentIds)
end

function var_0_0.sendAct152AcceptPresentRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity152Module_pb.Act152AcceptPresentRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.presentId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct152AcceptPresentReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
