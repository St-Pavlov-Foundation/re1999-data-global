module("modules.logic.act201.controller.Activity201Controller", package.seeall)

local var_0_0 = class("Activity201Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getInvitationInfo(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	Activity201Rpc.instance:sendGet201InfoRequest(arg_3_1, arg_3_2, arg_3_3)
end

function var_0_0.openMainView(arg_4_0, arg_4_1)
	arg_4_0:getInvitationInfo(arg_4_1, arg_4_0._openMainView, arg_4_0)
end

function var_0_0._openMainView(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == 0 then
		ViewMgr.instance:openView(ViewName.TurnBackFullView, arg_5_2.activityId, true)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
