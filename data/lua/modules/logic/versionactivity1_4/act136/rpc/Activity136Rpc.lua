module("modules.logic.versionactivity1_4.act136.rpc.Activity136Rpc", package.seeall)

local var_0_0 = class("Activity136Rpc", BaseRpc)

function var_0_0.sendGet136InfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity136Module_pb.Get136InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet136InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity136Model.instance:setActivityInfo(arg_2_2)
	end
end

function var_0_0.sendAct136SelectRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity136Module_pb.Act136SelectRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.selectHeroId = arg_3_2

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct136SelectReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity136Model.instance:setActivityInfo(arg_4_2)
		Activity136Controller.instance:confirmReceiveCharacterCallback()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
