module("modules.logic.versionactivity1_4.act134.rpc.Activity134Rpc", package.seeall)

local var_0_0 = class("Activity134Rpc", BaseRpc)

function var_0_0.sendGet134InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity134Module_pb.Get134InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet134InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity134Model.instance:onInitMo(arg_2_2)
	Activity134Controller.instance:dispatchEvent(Activity134Event.OnUpdateInfo, arg_2_2)
end

function var_0_0.sendGet134BonusRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity134Module_pb.Act134BonusRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct134BonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	Activity134Model.instance:onReceiveBonus(arg_4_2.id)
	Activity134Controller.instance:dispatchEvent(Activity134Event.OnGetBonus, arg_4_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
