module("modules.logic.guide.controller.action.impl.WaitGuideActionOpenFinishView", package.seeall)

local var_0_0 = class("WaitGuideActionOpenFinishView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._viewName = var_1_0[1]

	local var_1_1 = #var_1_0 >= 2 and tonumber(var_1_0[2])

	if ViewMgr.instance:isOpenFinish(arg_1_0._viewName) then
		arg_1_0:onDone(true)

		return
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkOpenView, arg_1_0)
	end

	if var_1_1 and var_1_1 > 0 then
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, var_1_1)
	end
end

function var_0_0._delayDone(arg_2_0)
	if arg_2_0:checkGuideLock() then
		return
	end

	arg_2_0:onDone(true)
end

function var_0_0._checkOpenView(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0._viewName == arg_3_1 then
		if arg_3_0:checkGuideLock() then
			return
		end

		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0._checkOpenView, arg_3_0)
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._checkOpenView, arg_4_0)
end

return var_0_0
