module("modules.logic.versionactivity1_4.act132.rpc.Activity132Rpc", package.seeall)

local var_0_0 = class("Activity132Rpc", BaseRpc)

function var_0_0.sendGet132InfosRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity132Module_pb.Get132InfosRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet132InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity132Model.instance:setActivityInfo(arg_2_2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnUpdateInfo)
end

function var_0_0.onReceiveAct132InfoUpdatePush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	Activity132Model.instance:setActivityInfo(arg_3_2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnUpdateInfo)
end

function var_0_0.sendAct132UnlockRequest(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = Activity132Module_pb.Act132UnlockRequest()

	var_4_0.activityId = arg_4_1

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		table.insert(var_4_0.contentId, iter_4_1)
	end

	arg_4_0:sendMsg(var_4_0)
end

function var_0_0.onReceiveAct132UnlockReply(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 ~= 0 then
		return
	end

	Activity132Model.instance:setContentUnlock(arg_5_2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnContentUnlock, arg_5_2.contentId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
