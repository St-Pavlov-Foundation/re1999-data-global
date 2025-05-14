module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenView", package.seeall)

local var_0_0 = class("WaitGuideActionOpenView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._viewName = var_1_0[1]

	local var_1_1 = #var_1_0 >= 2 and tonumber(var_1_0[2])

	if ViewMgr.instance:isOpen(arg_1_0._viewName) then
		arg_1_0:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._checkOpenView, arg_1_0)

	if var_1_1 and var_1_1 > 0 then
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_1_1)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:clearWork()
	arg_2_0:onDone(true)
end

function var_0_0._checkOpenView(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._viewName == arg_3_1 then
		arg_3_0:clearWork()
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_4_0._checkOpenView, arg_4_0)
end

return var_0_0
