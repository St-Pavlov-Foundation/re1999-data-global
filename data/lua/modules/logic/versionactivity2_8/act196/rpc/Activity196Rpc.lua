module("modules.logic.versionactivity2_8.act196.rpc.Activity196Rpc", package.seeall)

local var_0_0 = class("Activity196Rpc", BaseRpc)

function var_0_0.sendGet196InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity196Module_pb.Get196InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet196InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.hasGain

	Activity196Model.instance:setActInfo(var_2_0)
end

function var_0_0.sendAct196GainRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity196Module_pb.Act196GainRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct196GainReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.id

	Activity196Model.instance:updateRewardIdList(var_4_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
