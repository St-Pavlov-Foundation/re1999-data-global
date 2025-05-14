module("modules.logic.activitywelfare.rpc.Activity160Rpc", package.seeall)

local var_0_0 = class("Activity160Rpc", BaseRpc)

function var_0_0.sendGetAct160InfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity160Module_pb.Act160GetInfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveAct160GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity160Model.instance:setInfo(arg_2_2)
	end
end

function var_0_0.onReceiveAct160UpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		Activity160Model.instance:updateInfo(arg_3_2)
	end
end

function var_0_0.sendGetAct160FinishMissionRequest(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Activity160Module_pb.Act160FinishMissionRequest()

	var_4_0.activityId = arg_4_1
	var_4_0.id = arg_4_2

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveAct160FinishMissionReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		Activity160Model.instance:finishMissionReply(arg_5_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
