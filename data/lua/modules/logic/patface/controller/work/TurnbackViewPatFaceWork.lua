module("modules.logic.patface.controller.work.TurnbackViewPatFaceWork", package.seeall)

local var_0_0 = class("TurnbackViewPatFaceWork", PatFaceWorkBase)

function var_0_0.checkCanPat(arg_1_0)
	local var_1_0 = TurnbackModel.instance:canShowTurnbackPop()
	local var_1_1 = TurnbackModel.instance:isInOpenTime()

	return var_1_0 and var_1_1
end

function var_0_0.startPat(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)

	arg_2_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()

	arg_2_0:_openView()
	TurnbackRpc.instance:sendTurnbackFirstShowRequest(arg_2_0.turnbackId)
end

function var_0_0._openView(arg_3_0)
	if TurnbackModel.instance:isNewType() then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView)
	else
		ViewMgr.instance:openView(arg_3_0._patViewName)
	end
end

function var_0_0.onCloseViewFinish(arg_4_0, arg_4_1)
	if string.nilorempty(arg_4_0._patViewName) or arg_4_0._patViewName == arg_4_1 or arg_4_1 == ViewName.TurnbackNewLatterView then
		arg_4_0:patComplete()
		TurnbackRpc.instance:sendTurnbackFirstShowRequest(arg_4_0.turnbackId)
	end
end

function var_0_0.customerClearWork(arg_5_0)
	arg_5_0.turnbackId = nil
end

return var_0_0
