module("modules.logic.turnback.invitation.controller.TurnBackInvitationController", package.seeall)

local var_0_0 = class("TurnBackInvitationController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.getInvitationInfo(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	TurnBackInvitationRpc.instance:sendGet171InfoRequest(arg_5_1, arg_5_2, arg_5_3)
end

function var_0_0.openMainView(arg_6_0, arg_6_1)
	arg_6_0:getInvitationInfo(arg_6_1, arg_6_0.onReceiveMsg, arg_6_0)
end

function var_0_0.onReceiveMsg(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		ViewMgr.instance:openView(ViewName.TurnBackInvitationMainView, arg_7_2.activityId, true)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
