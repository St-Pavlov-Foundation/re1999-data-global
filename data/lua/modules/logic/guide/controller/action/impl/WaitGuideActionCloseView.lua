module("modules.logic.guide.controller.action.impl.WaitGuideActionCloseView", package.seeall)

local var_0_0 = class("WaitGuideActionCloseView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._viewName = arg_1_0.actionParam

	if ViewMgr.instance:isOpen(arg_1_0._viewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._viewName == arg_2_1 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
		arg_2_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

return var_0_0
