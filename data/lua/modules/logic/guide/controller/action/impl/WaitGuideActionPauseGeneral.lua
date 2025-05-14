module("modules.logic.guide.controller.action.impl.WaitGuideActionPauseGeneral", package.seeall)

local var_0_0 = class("WaitGuideActionPauseGeneral", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")[1]

	arg_1_0._pauseName = var_1_0
	arg_1_0._pauseEvent = GuideEvent[var_1_0]

	GuideController.instance:registerCallback(arg_1_0._pauseEvent, arg_1_0._triggerPause, arg_1_0)
end

function var_0_0._triggerPause(arg_2_0, arg_2_1)
	arg_2_1[arg_2_0._pauseName] = true

	GuideController.instance:unregisterCallback(arg_2_0._pauseEvent, arg_2_0._triggerPause, arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	GuideController.instance:unregisterCallback(arg_3_0._pauseEvent, arg_3_0._triggerPause, arg_3_0)
end

return var_0_0
