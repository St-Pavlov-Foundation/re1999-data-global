module("modules.logic.guide.controller.action.GuideActionFlow", package.seeall)

local var_0_0 = class("GuideActionFlow", FlowSequence)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.guideId = arg_1_1
	arg_1_0.stepId = arg_1_2
	arg_1_0.againGuideId = arg_1_3

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_1)
	GuideController.instance:startStep(arg_2_0.guideId, arg_2_0.stepId, arg_2_0.againGuideId)
end

function var_0_0.onDone(arg_3_0, arg_3_1)
	var_0_0.super.onDone(arg_3_0, arg_3_1)
	GuideController.instance:finishStep(arg_3_0.guideId, arg_3_0.stepId, false, false, arg_3_0.againGuideId)
end

return var_0_0
