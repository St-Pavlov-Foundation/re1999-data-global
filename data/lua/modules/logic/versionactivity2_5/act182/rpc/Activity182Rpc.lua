module("modules.logic.versionactivity2_5.act182.rpc.Activity182Rpc", package.seeall)

local var_0_0 = class("Activity182Rpc", BaseRpc)

function var_0_0.sendGetAct182InfoRequest(arg_1_0, arg_1_1)
	local var_1_0 = Activity182Module_pb.GetAct182InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetAct182InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(arg_2_2.act182Info)
end

function var_0_0.onReceiveAct182InfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(arg_3_2.act182Info)
end

function var_0_0.sendGetAct182RandomMasterRequest(arg_4_0, arg_4_1)
	local var_4_0 = Activity182Module_pb.GetAct182RandomMasterRequest()

	var_4_0.activityId = arg_4_1

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveGetAct182RandomMasterReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(arg_5_2.activityId):updateMasterIdBox(arg_5_2.masterId)
	Activity182Controller.instance:dispatchEvent(Activity182Event.RandomMasterReply)
end

function var_0_0.sendAct182RefreshMasterRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = Activity182Module_pb.Act182RefreshMasterRequest()

	var_6_0.activityId = arg_6_1

	arg_6_0:sendMsg(var_6_0, arg_6_2, arg_6_3)
end

function var_0_0.onReceiveAct182RefreshMasterReply(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(arg_7_2.activityId):updateMasterIdBox(arg_7_2.masterId, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
