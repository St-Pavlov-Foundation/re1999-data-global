module("modules.logic.versionactivity2_4.act181.rpc.Activity181Rpc", package.seeall)

local var_0_0 = class("Activity181Rpc", BaseRpc)

function var_0_0.SendGet181InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity181Module_pb.Get181InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet181InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity181Model.instance:setActInfo(arg_2_2.activityId, arg_2_2)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetInfo)
	end
end

function var_0_0.SendGet181BonusRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity181Module_pb.Get181BonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.pos = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveGet181BonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity181Model.instance:setBonusInfo(arg_4_2.activityId, arg_4_2)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetBonus, arg_4_2.activityId, arg_4_2.id, arg_4_2.pos)
	end
end

function var_0_0.SendGet181SpBonusRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity181Module_pb.Get181SpBonusRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveGet181SpBonusReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity181Model.instance:setSPBonusInfo(arg_6_2.activityId, arg_6_2)
		Activity181Controller.instance:dispatchEvent(Activity181Event.OnGetSPBonus, arg_6_2.activityId)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
