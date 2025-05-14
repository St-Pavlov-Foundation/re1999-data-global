module("modules.logic.guide.controller.action.impl.WaitGuideActionWaitSeconds", package.seeall)

local var_0_0 = class("WaitGuideActionWaitSeconds", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	logNormal(string.format("<color=#EA00B3>start guide_%d_%d WaitGuideActionWaitSeconds second:%s</color>", arg_1_0.guideId, arg_1_0.stepId, arg_1_0.actionParam))

	local var_1_0 = tonumber(arg_1_0.actionParam)

	GuideBlockMgr.instance:startBlock((var_1_0 or 0) + GuideBlockMgr.BlockTime)

	arg_1_0.context = arg_1_1
	arg_1_0.status = WorkStatus.Running

	local var_1_1 = var_1_0 or 0.01

	TaskDispatcher.runDelay(arg_1_0._onTimeEnd, arg_1_0, var_1_1)
end

function var_0_0._onTimeEnd(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onTimeEnd, arg_3_0)
end

return var_0_0
