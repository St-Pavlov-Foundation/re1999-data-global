module("modules.logic.turnback.invitation.rpc.TurnBackInvitationRpc", package.seeall)

local var_0_0 = class("TurnBackInvitationRpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGet171InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity171Module_pb.Get171InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet171InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		TurnBackInvitationModel.instance:setActivityInfo(arg_2_2)
		TurnBackInvitationController.instance:dispatchEvent(TurnBackInvitationEvent.OnGetInfoSuccess)
	end
end

return var_0_0
