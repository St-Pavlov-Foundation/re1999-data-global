module("modules.logic.battlepass.flow.BpOpenAndWaitCloseWork", package.seeall)

local var_0_0 = class("BpOpenAndWaitCloseWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._viewName = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	UIBlockMgr.instance:endBlock("BpChargeFlow")
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	ViewMgr.instance:openView(arg_2_0._viewName)
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == arg_3_0._viewName then
		UIBlockMgr.instance:startBlock("BpChargeFlow")
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._onCloseViewFinish, arg_4_0)
end

return var_0_0
