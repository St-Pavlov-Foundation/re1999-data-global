module("modules.logic.versionactivity1_4.act133.rpc.Activity133Rpc", package.seeall)

local var_0_0 = class("Activity133Rpc", BaseRpc)

function var_0_0.sendGet133InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity133Module_pb.Get133InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet133InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity133Model.instance:setActivityInfo(arg_2_2)
	Activity133Controller.instance:dispatchEvent(Activity133Event.OnUpdateInfo)
end

function var_0_0.sendAct133BonusRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity133Module_pb.Act133BonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct133BonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local function var_4_0()
		Activity133Controller.instance:dispatchEvent(Activity133Event.OnGetBonus, arg_4_2)
	end

	arg_4_0:sendGet133InfosRequest(VersionActivity1_4Enum.ActivityId.ShipRepair, var_4_0, arg_4_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
