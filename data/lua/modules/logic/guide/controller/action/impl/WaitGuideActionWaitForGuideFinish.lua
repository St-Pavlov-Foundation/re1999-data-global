module("modules.logic.guide.controller.action.impl.WaitGuideActionWaitForGuideFinish", package.seeall)

local var_0_0 = class("WaitGuideActionWaitForGuideFinish", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._waitForGuides = string.splitToNumber(arg_1_0.actionParam, "#")

	if not arg_1_0:_hasDoingGuide() then
		arg_1_0:onDone(true)
	else
		GuideController.instance:registerCallback(GuideEvent.FinishGuide, arg_1_0._onFinishGuide, arg_1_0)
	end
end

function var_0_0._hasDoingGuide(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._waitForGuides) do
		if GuideModel.instance:isGuideRunning(iter_2_1) then
			return true
		end
	end

	return false
end

function var_0_0._onFinishGuide(arg_3_0)
	if not arg_3_0:_hasDoingGuide() then
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuide, arg_4_0._onFinishGuide, arg_4_0)
end

return var_0_0
