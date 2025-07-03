module("modules.logic.guide.controller.trigger.GuideTriggerStoryStep", package.seeall)

local var_0_0 = class("GuideTriggerStoryStep", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, arg_1_0._onStep, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.splitToNumber(arg_2_2, "_")

	if not arg_2_1 then
		return false
	end

	if #var_2_0 == 1 then
		return var_2_0[1] == arg_2_1.storyId
	elseif #var_2_0 > 1 then
		return var_2_0[1] == arg_2_1.storyId and var_2_0[2] == arg_2_1.stepId
	end
end

function var_0_0._onStep(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.storyId
	local var_3_1 = arg_3_1.stepId

	if var_3_0 and var_3_1 then
		arg_3_0:checkStartGuide(arg_3_1)
	end
end

return var_0_0
