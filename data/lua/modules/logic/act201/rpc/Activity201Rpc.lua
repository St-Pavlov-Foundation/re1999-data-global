module("modules.logic.act201.rpc.Activity201Rpc", package.seeall)

local var_0_0 = class("Activity201Rpc", BaseRpc)

function var_0_0.sendGet201InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity201Module_pb.Get201InfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet201InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity201Model.instance:setActivityInfo(arg_2_2)
		Activity201Controller.instance:dispatchEvent(Activity201Event.OnGetInfoSuccess)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
